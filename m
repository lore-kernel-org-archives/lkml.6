Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88795C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4EA208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4EA208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754246AbeFQW7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 18:59:44 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41124 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752915AbeFQW7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 18:59:43 -0400
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w5HMxg0C006680
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 18:59:42 -0400
Received: from mail-qk0-f200.google.com (mail-qk0-f200.google.com [209.85.220.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w5HMxbOA017938
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 18:59:42 -0400
Received: by mail-qk0-f200.google.com with SMTP id w74-v6so13355192qka.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 15:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Qml89vVaYb8jJ2wNT2FwAVEIz9TvN0FmcLaRHniq8ZA=;
        b=k65yRGXMwkHoqYatfAgoA3RtTvuL07sXRZSBz6cweTQTXA+CffKYV6k5QAsItvLp8y
         EzWwn4Z91tpcyY/rVUMsAKbTvtyPTkU5spDdE12c8GrHFL9A2Qbu6fnBIJaMk55ceVca
         /nSfiWFNpIU8mBkWUtt77sOTKv0KVq8GHwRU3uipDrXE64LQ22X5Ost5yzF9Pp+KoQaV
         8NWyqLO42QWwEury/aYCgqD1AUrkTKI7Q6kW9Byt4qjkBkOb4h0geHZAXuuiVAQZLVtC
         pVtAZTsuLoC9L+I3DucuPEMWUSe3Ug5JnWsL4xcrkwrILk3OH1TLvx8wCEorD6GsTeeg
         SnCA==
X-Gm-Message-State: APt69E3eN81rzGKX9BvFCfpKKi6Dm1o/L9kwthESVAgaVbtPJ0BZMCBi
        qOGUMjHsvlJHytYowQT0gwh1i+xqk/obziMjYYabYBhDHKD9wy64XExKN6tkniliynHDuoqzhHj
        II63YrDVnXRpTzsthUYop1n1QbMallDeI/74=
X-Received: by 2002:a0c:964e:: with SMTP id 14-v6mr8798169qvy.98.1529276377374;
        Sun, 17 Jun 2018 15:59:37 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKKykizX8ndOvUr6YYH4V9FNr7ciUNrV59bZAej36spcW0kg4DhiqPiQKBdzOhDETU4A37S8Kg==
X-Received: by 2002:a0c:964e:: with SMTP id 14-v6mr8798165qvy.98.1529276377124;
        Sun, 17 Jun 2018 15:59:37 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341:2116:22ff:b17b:7cd6])
        by smtp.gmail.com with ESMTPSA id g56-v6sm12961705qta.83.2018.06.17.15.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 15:59:34 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] vt: preserve unicode values corresponding to screen characters
In-Reply-To: <20180617190706.14614-2-nicolas.pitre@linaro.org>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
 <20180617190706.14614-2-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1529276384_2593P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Jun 2018 18:59:44 -0400
Message-ID: <117799.1529276384@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1529276384_2593P
Content-Type: text/plain; charset=us-ascii

On Sun, 17 Jun 2018 15:07:03 -0400, Nicolas Pitre said:

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 1eb1a376a0..7b636638b3 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -317,6 +317,171 @@ void schedule_console_callback(void)
>  	schedule_work(&console_work);
>  }
>
> +/*
> + * Code to manage unicode-based screen buffers
> + */
> +
> +#ifdef NO_VC_UNI_SCREEN

This preprocessor variable seems to be dangling in the breeze, with
no way for it to get set?  As a result, we pick up the #else define by
default.

--==_Exmh_1529276384_2593P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWybn4I0DS38y7CIcAQI9hgf+KaUp8bw6OLI3BroIso2q62HSKJZJSImI
bkhkcR5hEODpXgfJfRnIkDhVZ7SgMWxmyHQyF6qWz0eR/5rPCaOo9by9Vyc187LH
AVidMis4qgQTWYIPGVFICfjNBMSHU2Rya590Tf8B6Cld5SgirKsqQy1ELXwlKJ/4
b9txVlkYd4pkoi3CTVydFgQ4hu99hfNS5qOFwQIKDPl+nMDLG5JMUCjmjv1JrYnZ
2s1P5I/wUtqyOBoUrJmaRdcjoyBo1BJ/opdyH5Nz8m6WGMO9vTMcXN2BDrO1fUzt
qoyIQg7YvO/yN9Hb8tfENoCLYbHndVlt8UXf01vkd3t8dn7G+zy46Q==
=Gzaz
-----END PGP SIGNATURE-----

--==_Exmh_1529276384_2593P--
