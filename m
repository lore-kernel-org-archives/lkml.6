Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40496C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6E520671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Weq9mcyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6E520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389028AbeG0T6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:58:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34847 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbeG0T6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:58:47 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so2667073plq.2;
        Fri, 27 Jul 2018 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UB004HQSO3gYnGWIKDYrA5JVPKrH5SPmEO71VpgLfLk=;
        b=Weq9mcyFpSCbbREZ4HZqOMdqxLTSvKBwm180rVXV9fN67zjqohBeS0y5wBlvRi+SmD
         ueau8Foc6lITx0BOgWJgQsOM8nYYDAiqVIu1wt4yZMtD61cMoB9H8oqG6hft96VVDsxr
         /xxuzjdBwyZputPbDpxDbDrp0R65y5cTW+iR0fKIGXhOQYy4bksftLeUuuRmXizGfi09
         rv08+OqYwofeL8wgqKQUWxe2RNEFVx+Cw9c1OFXPMjQPtg9XUBBj9ZQ+92cIWz8bVMtk
         YqQp7/i/vFv9SEGi9dyyABgWEvLi5f3V7TW2t3Y4ekomnRl3v7AL0wz/WG9iZbQnfvO8
         TSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UB004HQSO3gYnGWIKDYrA5JVPKrH5SPmEO71VpgLfLk=;
        b=G3rbWRjIlj9m5y/CW9Yz0As6dqK6B2BwO84LYUNsT2mCCCsHyuxhuHmsvQL5orP7hm
         1WDUqX+ch5saOLOgJqsslDyViX+hTkZkzTa8vz4G+33y0VRwDB6v/7Asp6deUe4g1+R0
         gq5WM2anBeDqyibe3nVH86JIVPmgsKPjXtyLr/kSVZTPpv5oPZ9p6bOcUiLDpC9JVdh6
         C3oI1JTLCbxLj3DNYpM5Cv8weBF8sA+FrrUMDkZFryo2mzzuUAVnEu/bFiW8kh28J4MF
         Dqvlcz5DOeUaTqS17Rl6RvGypRn7Nq3UKnSXmDNi87FjkM/Oo0QrfAzz2Lh/GvvKqd+F
         8rMA==
X-Gm-Message-State: AOUpUlGLNatomNBkQZ1gxig14wWBqIZmNMHtOqFX8h7xK6KM08URGxs2
        FOkwfTWBL4JrWUzAtBQCrps=
X-Google-Smtp-Source: AAOMgpd/hSomhDr8gZ06YP3w7vkBIFMucWQqo5eTyXfE/8WuSNEHGX/tgeJuPSXDe514IaPOy7qPiw==
X-Received: by 2002:a17:902:bd44:: with SMTP id b4-v6mr7155530plx.144.1532716540094;
        Fri, 27 Jul 2018 11:35:40 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id b73-v6sm7287869pfl.152.2018.07.27.11.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 11:35:38 -0700 (PDT)
Date:   Fri, 27 Jul 2018 11:35:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: tablet: aiptek: Replace GFP_ATOMIC with
 GFP_KERNEL in aiptek_probe()
Message-ID: <20180727183537.GD72640@dtor-ws>
References: <20180727022920.1233-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727022920.1233-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:29:20AM +0800, Jia-Ju Bai wrote:
> aiptek_probe() is never called in atomic context.
> It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/tablet/aiptek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index 545fa6e89035..c82cd5079d0e 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c
> @@ -1712,7 +1712,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
>          }
>  
>  	aiptek->data = usb_alloc_coherent(usbdev, AIPTEK_PACKET_LENGTH,
> -					  GFP_ATOMIC, &aiptek->data_dma);
> +					  GFP_KERNEL, &aiptek->data_dma);
>          if (!aiptek->data) {
>  		dev_warn(&intf->dev, "cannot allocate usb buffer\n");
>  		goto fail1;
> -- 
> 2.17.0
> 

-- 
Dmitry
