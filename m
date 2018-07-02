Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC27C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11FC25471
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F64Ns4HY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11FC25471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeGBQMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:12:53 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44188 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeGBQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:12:51 -0400
Received: by mail-yb0-f196.google.com with SMTP id a2-v6so5281977ybe.11;
        Mon, 02 Jul 2018 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BeOym/X0eW2zhuAmx2p3zkQtPQUt6tvuBgE0tx9T5Xo=;
        b=F64Ns4HYy4arQveBhZr1Vyv+6LBvEPedW/5iti/pfwUWc4ZCggh9aPuw88UkJ+UMdX
         2gMMkLI3IJhbUmVdt2bEj5kI8B9qrhNAsXlOH03bvAq0IW1K+nDcuY4ObKfpJfzRo1Lb
         XlaBJK1WlPBqob9pNImAYN5ymYcYFVGjhWPyT4pC8XStLok7aSMZAuAzvWrUPMWqmTIN
         FS95dDZ6EtMv/XKUYqIGrKu0O8FcQhxa3CKauvLNCBuVP3lJxYfNFZuffR979lMU5agP
         8ApR5IckV5QqZeT/mqyNBZ+B4GWvM2nZeIspKUIt5HkBpKbnVCQQuKvZY9Mep66uyt7o
         9MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BeOym/X0eW2zhuAmx2p3zkQtPQUt6tvuBgE0tx9T5Xo=;
        b=gpdFZdBkRH+9CQHxoK1JDc5217rjAbn1m578mQZwVaMlKKo9uaKqFj+6N3+Nu61geT
         +T9PLq7IXN88402tagvT+4MSPwbz1/ptwox5KF6ZDVzkRFW6RvGoV/2yHaHk7p63BMq9
         hDYFdAK5FVwf3nrkFLq/bh4Eo+nU2bHYmDzptkGPq+dXQ8IzAQYdEr5naZQwK461WWOc
         c8mLF81aPDBLbEYj7anVmC3sUIZVIyUESDPrisKIakZ9356emJEp2Iw1MV7v06VUgZNT
         +LN0sfpl3p6OymHosfd8Dicnvwz4OR3WU0C9tVIzjjGzkiadHDlBWtrY+5f8TMEwdAAR
         f+8w==
X-Gm-Message-State: APt69E3CTJRoZxOqxi43SSI8srnv7RgQcm1ebmSiPQSxLDknBvWTSkFz
        SWgMYIwPniHCvnoXfPexyNs=
X-Google-Smtp-Source: ADUXVKIPtyUPG/htUnDB0vXtO+hnrSnioEKzo1ISQgMYwUjJAI8AaUkGfsTLM3zMYd9Fda/WSaLmMQ==
X-Received: by 2002:a25:a321:: with SMTP id d30-v6mr14085246ybi.519.1530547970622;
        Mon, 02 Jul 2018 09:12:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id p15-v6sm6895363ywg.40.2018.07.02.09.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 09:12:49 -0700 (PDT)
Date:   Mon, 2 Jul 2018 09:12:48 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ata: Remove depends on HAS_DMA in case of platform
 dependency
Message-ID: <20180702161248.GG533219@devbig577.frc2.facebook.com>
References: <20180622110307.31523-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622110307.31523-1-geert@linux-m68k.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:03:07PM +0200, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

This looks fine to me but how do you wanna route it?  Should I apply
it to for-4.18-fixes or should it go with arch changes in some other
tree?

Thanks.

-- 
tejun
