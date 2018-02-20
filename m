Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBTSnI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:43:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49854 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeBTSmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:42:54 -0500
Subject: Re: [PATCH] rds: send: mark expected switch fall-through in
 rds_rm_size
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20180219181020.GA19154@embeddedgus>
 <9b385269-7f13-983c-caf1-72e050acc6d9@oracle.com>
 <56eff85f-852b-0123-ae57-7cf9baedbae6@embeddedor.com>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <6015aae5-d598-54e6-52d3-91bb63b37c3d@oracle.com>
Date: Tue, 20 Feb 2018 10:42:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <56eff85f-852b-0123-ae57-7cf9baedbae6@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8810 signatures=668675
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802200224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/2018 10:05 AM, Gustavo A. R. Silva wrote:
> Hi Santosh,
> 
> On 02/20/2018 11:54 AM, Santosh Shilimkar wrote:
>> Hi,
>>
>> 2/19/2018 10:10 AM, Gustavo A. R. Silva wrote:
>>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>>> where we are expecting to fall through.
>>>
>>> Addresses-Coverity-ID: 1465362 ("Missing break in switch")
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>   net/rds/send.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/rds/send.c b/net/rds/send.c
>>> index 028ab59..79d158b 100644
>>> --- a/net/rds/send.c
>>> +++ b/net/rds/send.c
>>> @@ -902,6 +902,8 @@ static int rds_rm_size(struct msghdr *msg, int 
>>> num_sgs)
>>>           case RDS_CMSG_ZCOPY_COOKIE:
>>>               zcopy_cookie = true;
>>> +            /* fall through */
>>> +
>>>           case RDS_CMSG_RDMA_DEST:
>>>           case RDS_CMSG_RDMA_MAP:
>>>               cmsg_groups |= 2;
>>>
>> So coverity greps for commet as "fall through" for
>> -Wimplicit-fallthrough build ?
>>
> 
> No. Basically, Coverity only reports cases in which a break, return or 
> continue statement is missing.
> 
> Now, if the statements I mention above are missing and if you add the 
> following line to your Makefile:
> 
> KBUILD_CFLAGS  += $(call cc-option,-Wimplicit-fallthrough)
>
> You will get a warning if a fall-through comment is missing.
>
That make sense.

>> Adding that comments itself if fine but was curious
>> about it if some one makes a spell error in this
>> comment what happens ;-)
>>
> 
> In this case, Coverity would still report the same "Missing break in 
> switch" error, but you'll get a GCC warning.
> 
Got it. Thanks !!
