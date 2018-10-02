Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE64C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B887920878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="ql59054b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B887920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeJBQ1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:27:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41398 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJBQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:27:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id q39-v6so922364lfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjq5vWWP75JBdyMHowJCdcN1+neBEqxqzw8zhuVWKWM=;
        b=ql59054b29jA1bnCT/fOwtWmkovAGFIOmMVgQTrIHb0tiFmZYsB8n529Pvglz+wyby
         xfd6FKQGFVh8E+nirH9RzeKHJUM6C0wYH9zzvJZl83OvO0snW8bfZSvu1DVn4V7v88AT
         tCprO/JNWC7tTl3QHJtbIRK5BTDlr4uPPQ+AzOG3k++LypPJzHbh4NIhR7+6nt/ioOeR
         IkQn/LKt1dlWUm35OtYzoomsf+cQwCwdLzKOQpey8tSDPcKUrdo2eyTmSjIknRcK9Nd2
         dp+P9Ovmrxxahlt2gwJWC+ReNG1sRagb9l5ozJTbbSUfZ5Tkz6MckaD9OWpc0q0VJjaU
         R/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjq5vWWP75JBdyMHowJCdcN1+neBEqxqzw8zhuVWKWM=;
        b=NU4bccyWUBVf3EAnzqpj3h/aGohhEppRqT8NfbBCQ4Nxj8U9aZCL17TBa1Z7lbEuuX
         W9kA1EYDho7IrbzM1UG4/OMfHd2yvit68DexFGMUrkKwqRBzd4g+GlyBS0nef+FkIaY9
         D2tlZMOXWqtY5OXNz+21R7WHPBl9cfUEa6ev87+b4ZaPBbLhNM+dL/MKg3qkgzJXLt+e
         0rV1z61G7zc/RtXaopCzF3cYOfppYakd1gW2veWUVqHuy8muEeblvoi+B63AyLwsRkHG
         hwotihn3MeqvjzQwci6dnS5xsdyidYUtraGQPZN/ZEdATEy0LRrygu9ymaDjmyDyLZnb
         OJtg==
X-Gm-Message-State: ABuFfoiBI76Wj9en6BWxGi9HKt9rXHm4sC15kWZIWw4QvoeyyV8ADZbs
        eMkBWCtdOBL7Asjluhk10Ld9p3353fM=
X-Google-Smtp-Source: ACcGV626GR+aWccV/VR7OwimSFiPWtU79Bm9f+C7wE3M8NMU+1+xrTj8EyryF9UdGNMe/bFCxezdNw==
X-Received: by 2002:a19:2b11:: with SMTP id r17-v6mr1486481lfr.128.1538473507617;
        Tue, 02 Oct 2018 02:45:07 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.81.238])
        by smtp.gmail.com with ESMTPSA id m66-v6sm3149734lfi.79.2018.10.02.02.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 02:45:06 -0700 (PDT)
Subject: Re: [PATCH 3/4] usbnet: smsc95xx: check for csum being in last four
 bytes
To:     Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk
References: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
 <20181002092645.1115-4-ben.dooks@codethink.co.uk>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1aeea157-7890-42c2-1f84-85e9cc9d91a5@cogentembedded.com>
Date:   Tue, 2 Oct 2018 12:45:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002092645.1115-4-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/2/2018 12:26 PM, Ben Dooks wrote:

> The manual states that the checksum cannot lie in the last DWORD of the
> transmission, so add a basic check for this and fall back to software
> checksumming the packet.
> 
> This only seems to trigger for ACK packets with no options or data to
> return to the other end, and the use of the tx-alignment option makes
> it more likely to happen.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/net/usb/smsc95xx.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
> index d244357bf1ad..46385a4b8b98 100644
> --- a/drivers/net/usb/smsc95xx.c
> +++ b/drivers/net/usb/smsc95xx.c
> @@ -2003,6 +2003,20 @@ static u32 smsc95xx_calc_csum_preamble(struct sk_buff *skb)
>   	return (high_16 << 16) | low_16;
>   }
>   
> +/* The CSUM won't work if the checksum lies in the last 4 bytes of the
> + * transmission. This is fairly unlikely, only seems to trigger with some
> + * short TCP ACK packets sent.
> + *
> + * Note, this calculation should probably check for the alignment of the
> + * data as well, but a straight chec for csum being in the last four bytes

    s/chec/check/?

> + * of the packet should be ok for now.
> +*/
> +static bool smsc95xx_can_checksum(struct sk_buff *skb)
> +{
> +       unsigned int len = skb->len - skb_checksum_start_offset(skb);
> +       return skb->csum_offset < (len - (4 + 1));
> +}
> +
>   static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
>   					 struct sk_buff *skb, gfp_t flags)
>   {
[...]

MBR, Sergei
