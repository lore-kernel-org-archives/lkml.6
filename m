Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeAaCzo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:55:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49174 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeAaCzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:55:42 -0500
Subject: Re: KASAN: stack-out-of-bounds Read in rds_sendmsg
To: Eric Biggers <ebiggers3@gmail.com>
Cc: syzkaller-bugs@googlegroups.com,
        Avinash Repaka <avinash.repaka@oracle.com>,
        syzbot
        <bot+9461c9b9d340854a404b46c42cbfc91ded1232d8@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com
References: <089e08263e589121d90560d610a5@google.com>
 <9deaf3c4-227f-f6f0-9ccb-3ad05fc32a0c@oracle.com>
 <20180131021638.6h5fukvzzakzu5g2@gmail.com>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <5db55967-3608-d9cc-768a-e75dc61ed311@oracle.com>
Date: Tue, 30 Jan 2018 18:55:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180131021638.6h5fukvzzakzu5g2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310034
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2018 6:16 PM, Eric Biggers wrote:
> On Thu, Dec 21, 2017 at 08:44:32AM -0800, Santosh Shilimkar wrote:
>> +Avinash
>>
>> On 12/21/2017 1:10 AM, syzbot wrote:
>>> syzkaller has found reproducer for the following crash on
>>
>> [..]
>>
>>>
>>> audit: type=1400 audit(1513847224.110:7): avc:  denied  { map } for
>>> pid=3157 comm="syzkaller455006" path="/root/syzkaller455006870"
>>> dev="sda1" ino=16481
>>> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
>>> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
>>> ==================================================================
>>> BUG: KASAN: stack-out-of-bounds in rds_rdma_bytes net/rds/send.c:1013
>>> [inline]
>>
>> Could you please post the discussed fix if you are ready with it ?
>> This new report is same as last one and cmesg length check should
>> address it.
>>

[...]

> 
> This crash seems to have stopped occurring.  I assume it was fixed by commit
> 14e138a86f63 (thanks Avinash!), so let's tell syzbot so that it can start
> reporting crashes in the same place again:
> 
> #syz fix: RDS: Check cmsg_len before dereferencing CMSG_DATA
> 
Thanks Eric for confirmation !!

Regards,
Santosh
