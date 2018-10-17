Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA1DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862E92148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXRtgWs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862E92148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJQIFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:05:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46098 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQIFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:05:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id r64-v6so12237972pfb.13;
        Tue, 16 Oct 2018 17:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xc98xZ3wxK88HwcWAyLuulxNVJ6Io/hEpycx9DaznUs=;
        b=UXRtgWs2tL3YHec6Csmk5gdL1nUuS/M9zzOeYCrRyMMT+1qMysWjO52YjY8HZzoerb
         5CKAshpVQVpCeALsZGix0/dtoA0IGDtzt+DpoBgxpGug34FLnL2rpSfM3+rxYKFglH8w
         P3cwaZ07+rN+jGJyMugqN8IIR2es4DJMkVZWUFtkQJtFg9D2Og3JwCyIm3xoFxWCjwYq
         3qiFltJdedwZ91wOcRf+9da0juM+4/j4J9wRuemJUFeDW1TnrqpUGrSLDABMPCjaVYoq
         SqW/1ICIeuHbRnmEluiHd/56qNWht6UTbHZKdRQ41ViNaRDC9zAphth50p4gRah7/P7J
         FRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xc98xZ3wxK88HwcWAyLuulxNVJ6Io/hEpycx9DaznUs=;
        b=bHz1qJE64iPbkwcLq+hFMgmxTUTxLjc3G1pX9LrZePdjF4CnkwN0Hi1GClPVhe7MW9
         Zc16kyEqQRIAwKxaq+MpxvEUZFreWm7Xr9a0bVtIroxRO1HTAfMz/jqZLUu02IbeyhSY
         C5GS3Krgkn2hoqJS1VnH8JUwXPX359NNfkpgl/Wy61soGglT01z3Xw3H90mjZAOX7DJw
         Havy2tNBlWG/oqHhscjUKlyz/GPDMp5d4q8QX4xwbzh4ua8hGEQBobpFl0+/ZjMK0MZw
         jXrgWgiN5ZmR5mWngfIgC4OObSHvQIxDglWxmZK7RMkmhYTmNsa3w3MM3LRIozcN1/9z
         cLJg==
X-Gm-Message-State: ABuFfoimBBOGIwtHHKSp6D5eAhQimWqhMI4Aw/VwUOpeQxzRwp7c7c4+
        Yp7jptpsFCCBw1oFfpDXN2c=
X-Google-Smtp-Source: ACcGV603Ld/8yYskVHFAxLKQgpZKECrHehs4qAHtGH1U6kRccyjtEnIuUfZ6cCVxHYt1OVQVT9Q3/w==
X-Received: by 2002:a63:d502:: with SMTP id c2-v6mr22338198pgg.324.1539735130077;
        Tue, 16 Oct 2018 17:12:10 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d124-v6sm16295163pfa.163.2018.10.16.17.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:12:08 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:12:06 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xen-kbdfront - mark expected switch fall-through
Message-ID: <20181017001206.GH230131@dtor-ws>
References: <20181008140748.GA10114@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008140748.GA10114@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:07:48PM +0200, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case, I placed the "fall through"
> part at the beginning of the code comment, which is what GCC is
> expecting to find.
> 
> Addresses-Coverity-ID: 114757 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/misc/xen-kbdfront.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 594f72e..24bc5c5 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -524,7 +524,7 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
>  	case XenbusStateClosed:
>  		if (dev->state == XenbusStateClosed)
>  			break;
> -		/* Missed the backend's CLOSING state -- fallthrough */
> +		/* fall through - Missed the backend's CLOSING state */
>  	case XenbusStateClosing:
>  		xenbus_frontend_closed(dev);
>  		break;
> -- 
> 2.7.4
> 

-- 
Dmitry
