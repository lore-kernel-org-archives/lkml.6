Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724B3C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2179A2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vIP8Bwnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2179A2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeGZKEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:04:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37958 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbeGZKEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:04:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so1136913wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoJ2I3DC32SYhrBKLVnfySpcMC8X5ZJXhAPeDfTegZ0=;
        b=vIP8BwnmHHkkrEgCvyhNT7G493oUFXd1ZUm9NOBe8CwKR32wtDRR6VGLx/uP5Mc0Sn
         1uywz60pi7LXaLjxQiNA3DzRXJN5jsiIEDJNxzVEEsu0rO/7pLXsq/9ZnHeL5TUfZjkc
         qLRNv32uVQI8wD1Lxw2O+720XutkkP+lAPFfoiLjmSBnvTZckR31W4eAR0tZCWndDTeM
         ZxaZ3ssA7Av3maz8uomMv36BzDP/hH06CCbhHOxj6bS63mRyqJk6GdhpV6SllnNxzo+Z
         gFUpuh86EHEP5GEZ97x8gx4mg4lIZDgkvQ3PTL0x2Z7nLt7q+kRJOM3opzu4AzvP/BfC
         G+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoJ2I3DC32SYhrBKLVnfySpcMC8X5ZJXhAPeDfTegZ0=;
        b=rlShfhc44FKTxhaKdQYH/C+WPHmfqsD+zCwpLVUuRcwbREI4h9fYvi9pu/Ug6EmT2T
         yc8YQBjZtXCEhpbUeOYKjrPJNev7xxTvt+pTUvXZFV/o+ZYM/HwObzRFxOyQk8wnk2ru
         6x6y2iEti0BidiP1tqM82e9vzalunF0vqsvX6MWpRyPunIWjR2qwFD3FKYh9zgFlT0QB
         HEtjUA4bt/rXjAGv4enxaoEgCCxtGa194smbAxg7kTxgkwd1yHsrEINweUQaqInGTMrk
         2zbl3wMEmoXYGyv+44DomRWkbyCxeyf2f0yan+cuZ+Jtvmm4Qz/Hr4qeIFi3hwfwpkfk
         61Cg==
X-Gm-Message-State: AOUpUlGUfZpGctD0D9e84zym2t3RkP6/fM0HXItFcUVYjpwovnr1aXbl
        eV7rt2njxJCUq4YMumoNtgxoOw==
X-Google-Smtp-Source: AAOMgpdYsNb+RoY2CKdglRfaQzjEp7fGI0cSRKzzb2JK1UexRTyXOXSAUf1tV5rUFbeyqvSU/p6S5Q==
X-Received: by 2002:a1c:4004:: with SMTP id n4-v6mr889565wma.83.1532594894652;
        Thu, 26 Jul 2018 01:48:14 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w204-v6sm1439450wmw.5.2018.07.26.01.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 01:48:14 -0700 (PDT)
Message-ID: <190f2749c6e65fddcd2fd17ebdb45be5a434b869.camel@baylibre.com>
Subject: Re: [PATCH 3/3] clk: meson: clk-pll: drop hard-coded rates from pll
 tables
From:   jbrunet@baylibre.com
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Date:   Thu, 26 Jul 2018 10:48:12 +0200
In-Reply-To: <CAFBinCD3i5pRzSp4Sx5349p_2XQfdCNguxU-gU1tD_asFu6YjA@mail.gmail.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
         <20180717095617.12240-4-jbrunet@baylibre.com>
         <d4e5e35a-39e0-fe27-8d27-387c5312ca32@baylibre.com>
         <CAFBinCBc_cFD2ACiSHVuRrXaqSyDnkJb2rem1_k2jwved=QXVw@mail.gmail.com>
         <1532206010.26720.84.camel@baylibre.com>
         <CAFBinCD3i5pRzSp4Sx5349p_2XQfdCNguxU-gU1tD_asFu6YjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-21 at 23:34 +0200, Martin Blumenstingl wrote:
> On Sat, Jul 21, 2018 at 10:46 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > 
> > On Sat, 2018-07-21 at 22:16 +0200, Martin Blumenstingl wrote:
> > > > We could even add ranges instead of table when we know the PLL supports a well-known continuous dividers range.
> > > 
> > > I had a look at the sys_pll settings on Meson8b, here's what
> > > Meson8/Meson8b/Meson8m2 support for sys_pll:
> > > - 50..74
> > > - 76
> > > - 78
> > > - 80
> > > - 82
> > > - 84
> > > - 86
> > > - 88
> > > - 90
> > > - 92
> > > - 94
> > > - 96
> > > - 98
> > 
> > Are those values with the same predivider (n) value ?
> 
> yes, all are using n = 1

The table proposed in this patch keeps things the way they were before the
change. We could extend the table with these values in a follow up patch.

If those value are with n=1, then I would guess that odd values from 75 to 97
work as well. 


