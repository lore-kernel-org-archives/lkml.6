Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B593DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629F7253E9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=opensourcefoundries-com.20150623.gappssmtp.com header.i=@opensourcefoundries-com.20150623.gappssmtp.com header.b="h7c2pGbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629F7253E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opensourcefoundries.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeGBTpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:45:47 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45001 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752893AbeGBTpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:45:44 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so14748582oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opensourcefoundries-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tZmwouYozNc+8c04ym3LmTVvUYeGPhSISwyA93IHVYs=;
        b=h7c2pGbl+GJnGUh9IHT0RJZFKpOltHb7mzSVmNG5e1QbBeR4qtXD3Fu68zfjW/UtBw
         YLE1FqJ8FOxhXR5BwMFHU3df3hTdzYjVHqa0LJN2FygGqW7oHEvw8/HB6B3+GuOdW5Ab
         goOBbqGNwB5El8Gf/SlmwG7iKr153wwGMsUQUsleosYSHO+d0X76C+W7GvyIFg2uq9gn
         qIMd3zJbCWdEqVq00O9rBVGaJKDF6kMlY3Uxt9F9F05xiK5eeeZiUZ9jW2u61XzAwmr7
         eXqEmBQ1x1igtCZTOGksZ7OzAENIqkoGsUjtqsLOaAOBGcQIpX9bU9P7UAcPzV+D2McC
         +CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tZmwouYozNc+8c04ym3LmTVvUYeGPhSISwyA93IHVYs=;
        b=KRJCKb8dvpvmKUdWOujd5hBcZ5tqxG3voMBpFla5joiJRdoyf1BEzyrOne8md6c4nw
         TnltgfFfP4OSr3s6bGJnJaydJiMAy0QfaSOHLjqf3ccUw+bz554wybsARb4W6TWcrRVw
         rL/KeiJb07cym2w2aDRcKj0wky65BKOnL8V8M3+xjX9plFlCEr3L2I9qIZcA7c9KJp5R
         TDfBWOybNiulk0ARQQI99oFVaEoKy8npYR7L2WVUfFN6A3sb2GomK/rvV5EzWKM1hh2I
         VvczN3TY6HUefTbM2wCTuFnEbTij0BrFjcFD+1wrEh5AibDPUP8u8nirOAhepLO62rry
         unsw==
X-Gm-Message-State: APt69E3j1F7vK0KmxjvzRWE1HCdOY+Wbe0wytvG4N7cpvvU2QnPUaq42
        k7p7AvA+41/frrfCLFErmskW3Wd59nI=
X-Google-Smtp-Source: AAOMgpf8UunJ/RqvdLi7k6cUrXPCbgifRjhgk4/sTU+7/ofF6p0UefehENS4PoPKyYSs5xwtpT+fgA==
X-Received: by 2002:aca:f516:: with SMTP id t22-v6mr18391296oih.56.1530560743426;
        Mon, 02 Jul 2018 12:45:43 -0700 (PDT)
Received: from [192.168.69.121] (107-198-5-8.lightspeed.irvnca.sbcglobal.net. [107.198.5.8])
        by smtp.gmail.com with ESMTPSA id d38-v6sm9856340otc.44.2018.07.02.12.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 12:45:42 -0700 (PDT)
Subject: Re: [PATCH] 6lowpan: iphc: reset mac_header after decompress to fix
 panic
To:     Alexander Aring <aring@mojatatu.com>
Cc:     Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180619234406.8217-1-michael@opensourcefoundries.com>
 <20180702185438.dqqjg6k45iefj5is@x220t>
From:   Michael Scott <michael@opensourcefoundries.com>
Message-ID: <516fbc65-cc4b-8016-de5a-e2240b779d15@opensourcefoundries.com>
Date:   Mon, 2 Jul 2018 12:45:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702185438.dqqjg6k45iefj5is@x220t>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander,


On 07/02/2018 11:54 AM, Alexander Aring wrote:
> Hi,
>
> On Tue, Jun 19, 2018 at 04:44:06PM -0700, Michael Scott wrote:
>> After decompression of 6lowpan socket data, an IPv6 header is inserted
>> before the existing socket payload.  After this, we reset the
>> network_header value of the skb to account for the difference in payload
>> size from prior to decompression + the addition of the IPv6 header.
>>
>> However, we fail to reset the mac_header value.
>>
>> Leaving the mac_header value untouched here, can cause a calculation
>> error in net/packet/af_packet.c packet_rcv() function when an
>> AF_PACKET socket is opened in SOCK_RAW mode for use on a 6lowpan
>> interface.
>>
>> On line 2088, the data pointer is moved backward by the value returned
>> from skb_mac_header().  If skb->data is adjusted so that it is before
>> the skb->head pointer (which can happen when an old value of mac_header
>> is left in place) the kernel generates a panic in net/core/skbuff.c
>> line 1717.
>>
>> This panic can be generated by BLE 6lowpan interfaces (such as bt0) and
>> 802.15.4 interfaces (such as lowpan0) as they both use the same 6lowpan
>> sources for compression and decompression.
>>
>> Signed-off-by: Michael Scott <michael@opensourcefoundries.com>
>> ---
>>   net/6lowpan/iphc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
>> index 6b1042e21656..52fad5dad9f7 100644
>> --- a/net/6lowpan/iphc.c
>> +++ b/net/6lowpan/iphc.c
>> @@ -770,6 +770,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
>>   		hdr.hop_limit, &hdr.daddr);
>>   
>>   	skb_push(skb, sizeof(hdr));
>> +	skb_reset_mac_header(skb);
>>   	skb_reset_network_header(skb);
>>   	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
>>   
> I think it's good to make that if the mac_header gets a dangled pointer.
> But we don't have a mac header at this point anymore...
>
> There exists also some functionality that the MAC header is not set, I
> suppose this can be usefuly for tun like interfaces e.g. RAW IP what we
> have here.
>
> skb_mac_header_was_set
>
> which does:
>
> return skb->mac_header != (typeof(skb->mac_header))~0U;
>
> maybe we can set it as (typeof(skb->mac_header))~0U and then everything
> will run as far the kernel will not crash anymore.
>
> Question is for me: which upper layer wants access MAC header here on
> receive path?
> It cannot parsed anyhow because so far I know no upper layer can parse
> at the moment 802.15.4 frames (which is a complex format). Maybe over
> some header_ops callback?

I was testing a C program which performs NAT64 handling on packets
destined to a certain IPv6 subnet (64:ff9b::). To do this, the 
application opens a RAW socket like this: sniff_sock = socket(PF_PACKET, 
SOCK_RAW, htons(ETH_P_ALL)); It then sets promiscuous mode and enters a 
looping call of:
length = recv(sniff_sock, buffer, PACKET_BUFFER, MSG_TRUNC); My host PC 
kernel would then promptly crash on me. (I'm going to purposely avoid 
the obvious point of: this probably isn't the best way to parse packets 
for NAT64 translation as you will get every single packet incoming or 
outgoing on the host.) Turns out, testing the program on an 802.15.4 
6lowpan interface exposed some of the issues which this mailing list 
(but not myself) is well aware of (no L2 data in the RAW packets) and 
also led me to debugging this patch to stop the kernel crash. TL;DR: To 
summarize, any PF_PACKET SOCK_RAW socket which recv()'s IPv6 data from a 
6lowpan node will cause this kernel crash eventually (checked on kernel 
4.15, 4.16, 4.17 and 4.18-rc1). - Mike
>
> - Alex

