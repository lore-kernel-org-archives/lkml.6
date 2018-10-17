Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A637C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBF0214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBF0214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeJQNGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:06:07 -0400
Received: from gateway36.websitewelcome.com ([192.185.198.13]:11561 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbeJQNGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:06:07 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id D905B400C8434
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 23:19:16 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ce7hg4f2otz4jCe7rgCHqY; Wed, 17 Oct 2018 00:12:13 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:52936 helo=[192.168.1.41])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gCe7g-002TVD-BF; Wed, 17 Oct 2018 00:11:56 -0500
Subject: Re: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused by
 incorrect clean-up
To:     Greg KH <gregkh@linuxfoundation.org>, kys@microsoft.com
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com, Haiyang Zhang <haiyangz@microsoft.com>,
        Stable@vger.kernel.org
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-3-kys@linuxonhyperv.com>
 <20181017050705.GE22447@kroah.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <79b91529-7c20-a0ad-7dc9-9b7ca89f4792@embeddedor.com>
Date:   Wed, 17 Oct 2018 07:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017050705.GE22447@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 86.245.173.13
X-Source-L: No
X-Exim-ID: 1gCe7g-002TVD-BF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr ([192.168.1.41]) [86.245.173.13]:52936
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/18 7:07 AM, Greg KH wrote:
> On Wed, Oct 17, 2018 at 03:14:04AM +0000, kys@linuxonhyperv.com wrote:
>> From: Dexuan Cui <decui@microsoft.com>
>>
>> In kvp_send_key(), we do need call process_ib_ipinfo() if
>> message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it turns out
>> the userland hv_kvp_daemon needs the info of operation, adapter_id and
>> addr_family. With the incorrect fc62c3b1977d, the host can't get the
>> VM's IP via KVP.
>>
>> And, fc62c3b1977d added a "break;", but actually forgot to initialize
>> the key_size/value in the case of KVP_OP_SET, so the default key_size of
>> 0 is passed to the kvp daemon, and the pool files
>> /var/lib/hyperv/.kvp_pool_* can't be updated.
>>
>> This patch effectively rolls back the previous fc62c3b1977d, and
>> correctly fixes the "this statement may fall through" warnings.
>>
>> This patch is tested on WS 2012 R2 and 2016.
>>
>> Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may fall through" warnings")
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> Cc: K. Y. Srinivasan <kys@microsoft.com>
>> Cc: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: Stephen Hemminger <sthemmin@microsoft.com>
>> Cc: <Stable@vger.kernel.org>
>> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
>> ---
>>  drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
>> index a7513a8a8e37..9fbb15c62c6c 100644
>> --- a/drivers/hv/hv_kvp.c
>> +++ b/drivers/hv/hv_kvp.c
>> @@ -353,6 +353,9 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
>>  
>>  		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
>>  
>> +		__attribute__ ((fallthrough));
> 
> The comment should be sufficient for this, right?  I haven't seen many
> uses of this attribute before, how common is it?
> 

It's not common at all.

Dexuan, please use a comment instead: /* fall through */

Thanks
--
Gustavo

> 
>> +
>> +	case KVP_OP_GET_IP_INFO:
>>  		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
>>  				MAX_ADAPTER_ID_SIZE,
>>  				UTF16_LITTLE_ENDIAN,
>> @@ -405,7 +408,11 @@ kvp_send_key(struct work_struct *dummy)
>>  		process_ib_ipinfo(in_msg, message, KVP_OP_SET_IP_INFO);
>>  		break;
>>  	case KVP_OP_GET_IP_INFO:
>> -		/* We only need to pass on message->kvp_hdr.operation.  */
>> +		/*
>> +		 * We only need to pass on the info of operation, adapter_id
>> +		 * and addr_family to the userland kvp daemon.
>> +		 */
>> +		process_ib_ipinfo(in_msg, message, KVP_OP_GET_IP_INFO);
>>  		break;
>>  	case KVP_OP_SET:
>>  		switch (in_msg->body.kvp_set.data.value_type) {
>> @@ -446,9 +453,9 @@ kvp_send_key(struct work_struct *dummy)
>>  
>>  		}
>>  
>> -		break;
>> -
>> -	case KVP_OP_GET:
>> +		/*
>> +		 * The key is always a string - utf16 encoding.
>> +		 */
>>  		message->body.kvp_set.data.key_size =
>>  			utf16s_to_utf8s(
>>  			(wchar_t *)in_msg->body.kvp_set.data.key,
>> @@ -456,6 +463,17 @@ kvp_send_key(struct work_struct *dummy)
>>  			UTF16_LITTLE_ENDIAN,
>>  			message->body.kvp_set.data.key,
>>  			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
>> +
>> +		break;
>> +
>> +	case KVP_OP_GET:
>> +		message->body.kvp_get.data.key_size =
>> +			utf16s_to_utf8s(
>> +			(wchar_t *)in_msg->body.kvp_get.data.key,
>> +			in_msg->body.kvp_get.data.key_size,
>> +			UTF16_LITTLE_ENDIAN,
>> +			message->body.kvp_get.data.key,
>> +			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
> 
> Worst indentation ever :(
> 
> Yeah, I know it follows the others above it, but you should reconsider
> it in the future...
> 
> thanks,
> 
> greg k-h
> 
