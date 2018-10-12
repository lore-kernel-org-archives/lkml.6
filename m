Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732F3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E6021470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="rzyiDRf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E6021470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJLQUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:20:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34639 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeJLQUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:20:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10-v6so8786036lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 01:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=6ZOYUDAZSi1TMvENS472MIUKsIMRneTkCHMkzr7+w4w=;
        b=rzyiDRf7LMNRE3no779C14INkslsaavGT2rjCIrY/PysgEmTM839pwxTcBAWTJdQwI
         FbFg/ADCSDqVcopPNMrrVIh0bsSjDM8QDpIHAt5EO9DkVj23bhKyFgsyZDedazro139e
         +7q17+1YHBJJhdlWYkj0f4yikAWTbk9cxqVGrhXtrusbxXPi+cMI3PCY16SzieZcQxD7
         21BUa21rIzBNfyx6wU7YfiDCRAgTNAIlqDKLQ16Sp/xNEDKDZQIfZQ1xFk2SA4f9VINf
         sZ0flr9brMzbxjRdzlU9sIP+UoNUfZOdWKCtPndsrO92yl7cjNCO+DF1u6zsbdh01qm7
         QlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=6ZOYUDAZSi1TMvENS472MIUKsIMRneTkCHMkzr7+w4w=;
        b=pOlAPOXuhQlPR5FbrT2xPu3FPI2SO9WiFk6BWhQ/x7/UN+ZdZgirbOiJh6t3RpKjEY
         apNMiU8dhx8uMMIfJ3a9mmnVVuEz8Kst6YRrQzK8fbm2BC9kK63+RpWgnoqDA/ZJXZAu
         0tfAqllzEKgfMVa7yC19yQRcSwue6IKaZhyrcWjlBzmO+V1MLEqGnF0WrngO5rq/V7dS
         G+X8/7QoRutce6AcSrqBkLn30Mz1peNIbZuVjgC6sXzama5rpi14fnlo8AklPdbXr6in
         1Yom32qoCb6eI5/nHJd3dhVExQRisE0a6V/R5nYKWLVWELgoJxKVx2qRffkdeagqmGWF
         2aJw==
X-Gm-Message-State: ABuFfojiYmdBX6osDfd3bEAI2AucAilm/KQD5+s0Zxsut7UK1T1FzBAM
        YQQYjZlTGjjuP5x50mY/YpxWRg==
X-Google-Smtp-Source: ACcGV62UWHm49uqft7Ib7nKOCa43A0jwgXt0CSsDbCQ1GYDpX6jzGYRkAh4xiHtih2i8pjBLRO87Yg==
X-Received: by 2002:a19:2102:: with SMTP id h2-v6mr3108822lfh.119.1539334136584;
        Fri, 12 Oct 2018 01:48:56 -0700 (PDT)
Received: from [192.168.0.200] ([31.173.87.27])
        by smtp.gmail.com with ESMTPSA id o19-v6sm119372lff.36.2018.10.12.01.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 01:48:55 -0700 (PDT)
Subject: Re: [PATCH 6/8] usbnet: smsc95xx: fix memcpy for accessing rx-data
To:     Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org
References: <20181012083405.19246-1-ben.dooks@codethink.co.uk>
 <20181012083405.19246-7-ben.dooks@codethink.co.uk>
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <58f8a006-6ede-8bf0-4f89-8ddc0674575e@cogentembedded.com>
Date:   Fri, 12 Oct 2018 11:48:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20181012083405.19246-7-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12.10.2018 11:34, Ben Dooks wrote:

> Change the RX code to use get_unaligned_le32() instead of the combo
> of memcpy and cpu_to_le32s(&var).

    le32_to_cpus(), actually.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/net/usb/smsc95xx.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
> index 8ce190da8be0..03c3c02b569c 100644
> --- a/drivers/net/usb/smsc95xx.c
> +++ b/drivers/net/usb/smsc95xx.c
> @@ -618,9 +618,7 @@ static void smsc95xx_status(struct usbnet *dev, struct urb *urb)
>  		return;
>  	}
>
> -	memcpy(&intdata, urb->transfer_buffer, 4);
> -	le32_to_cpus(&intdata);
> -
> +	intdata = get_unaligned_le32(urb->transfer_buffer);
>  	netif_dbg(dev, link, dev->net, "intdata: 0x%08X\n", intdata);
>
>  	if (intdata & INT_ENP_PHY_INT_)
> @@ -1922,8 +1920,7 @@ static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
>  		unsigned char *packet;
>  		u16 size;
>
> -		memcpy(&header, skb->data, sizeof(header));
> -		le32_to_cpus(&header);
> +		header = get_unaligned_le32(skb->data);
>  		skb_pull(skb, 4 + NET_IP_ALIGN);
>  		packet = skb->data;
>

MBR, Sergei


