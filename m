Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeB0XEc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:04:32 -0500
Received: from gateway23.websitewelcome.com ([192.185.48.104]:15890 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751853AbeB0XEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:04:31 -0500
Subject: Re: [PATCH] nbd: fix return value in error handling path
To: Omar Sandoval <osandov@osandov.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
References: <20180212171450.GA31668@embeddedgus>
 <20180226230133.GA12208@vader.DHCP.thefacebook.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <5abe2722-6f74-04cb-d417-fc960cb1997f@embeddedor.com>
Date: Tue, 27 Feb 2018 15:43:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226230133.GA12208@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.175.32
X-Source-L: No
X-Exim-ID: 1eqn1f-003s81-Bo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.75]) [189.152.175.32]:46932
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/26/2018 05:01 PM, Omar Sandoval wrote:
> On Mon, Feb 12, 2018 at 11:14:55AM -0600, Gustavo A. R. Silva wrote:
>> It seems that the proper value to return in this particular case is the
>> one contained into variable new_index instead of ret.
>>
>> Addresses-Coverity-ID: 1465148 ("Copy-paste error")
>> Fixes: e46c7287b1c2 ("nbd: add a basic netlink interface")
> Reviewed-by: Omar Sandoval <osandov@fb.com>

Thanks, Omar.
--
Gustavo

>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/block/nbd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 5f2a424..86258b0 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1591,7 +1591,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>>   			if (new_index < 0) {
>>   				mutex_unlock(&nbd_index_mutex);
>>   				printk(KERN_ERR "nbd: failed to add new device\n");
>> -				return ret;
>> +				return new_index;
>>   			}
>>   			nbd = idr_find(&nbd_index_idr, new_index);
>>   		}
>> -- 
>> 2.7.4
>>
