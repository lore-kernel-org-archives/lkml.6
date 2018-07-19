Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42280C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C5F20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FmtYa9u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C5F20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbeGSIht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:37:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37190 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730253AbeGSIht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:37:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so7055912wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMOkLIsG/oHM9JHFwTipgD2hZHc9heTydoDPlmr6g38=;
        b=FmtYa9u5OsxyjlMofN48n0ZaXa/MtWiU7CP96YR0JDMXQ92j/bzh/XOwk3JlRIhlIT
         Ud/sjNDY73iLSRuxxbjkUArbHTKzWEI6zp4Zu7er3rWeW8HpbZl1co4xwIudaoLeAvgR
         K+SjbqgrF2Cyb93s41t/dtUP96Ov7bdArhG2831eB5Al2wzWjMxtskDhLJK6YOd3skHI
         7/XU5Xwb3OrZvFNYQJQUvIXLLi+miO2/AOrqE1ZKMDhz3i1NIY6yg3cExamkceqLF5sj
         lp20VwbjXtdV1AieOErB3DnZJrSU5M3aGx0k3OGEOtI98CfANApll5Iyd1J66ayVkF9z
         RxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMOkLIsG/oHM9JHFwTipgD2hZHc9heTydoDPlmr6g38=;
        b=JKMEg9CRgQ4/BN8RZmmNoo+uBr+I6P/74duM5CUlKSzncxgSntH6Rsh/MeeyDC4vAr
         AG8VuHwato4R2BlabtBVYn1qGxAPsPPJTtG0Mpc3R6CQ2UqEwlSwJG6CNK1u43N43FRF
         TNFjr5ez4nBIzuchAHJXgJO/jMtD7w3pzIh+w5BmSOVM2EwpZ179zEIEzGbGmtFU696Y
         xhZnDn80so2R79UPqSRF4NFUkMNm53P8J5/KnMumEQFlCrFXZb6SAGSEqBdANlMrgle3
         Ksmy77AoiDF+sW39vWrRlOR2XuKdc07ppB3aSoQmjODfgrNU+WWuXwYFMVghwJpwBBd6
         RzNw==
X-Gm-Message-State: AOUpUlH5Qf3xSklxsFSAfoePtQFzXtwbEyexA76iIrdqevo6r0zViyuJ
        DGgfzRscQnlPs3CE8HgiraFuNw==
X-Google-Smtp-Source: AAOMgpe+DriaAu6TzkFmGZ6LIHSZLsD4bPgzMhCvFlD0JAV8ieJJgVWZhMQORLtUXDl9V/HWMiUC4w==
X-Received: by 2002:adf:f74d:: with SMTP id z13-v6mr7056112wrp.85.1531986955141;
        Thu, 19 Jul 2018 00:55:55 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 35-v6sm4103428wri.78.2018.07.19.00.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 00:55:54 -0700 (PDT)
Message-ID: <1531986953.26720.21.camel@baylibre.com>
Subject: Re: [alsa-devel] [PATCH RESEND 02/15] ASoC: meson: add axg fifo
        base driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org
Date:   Thu, 19 Jul 2018 09:55:53 +0200
In-Reply-To: <s5ha7qoblk0.wl-tiwai@suse.de>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
         <20180717154304.9973-3-jbrunet@baylibre.com>
         <20180718115054.GI5700@sirena.org.uk> <s5ha7qoblk0.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 17:39 +0200, Takashi Iwai wrote:
> On Wed, 18 Jul 2018 13:50:54 +0200,
> Mark Brown wrote:
> > 
> > On Tue, Jul 17, 2018 at 05:42:51PM +0200, Jerome Brunet wrote:
> > 
> > > +	return !status ? IRQ_NONE : IRQ_HANDLED;
> > 
> > Please just write normal conditional statements, it makes things a lot
> > easier to read (the ! isn't helping either here).

Indeed. I'll correct this in a follow up patch

> 
> ... and there is the standard IRQ_RETVAL() macro for this purpose.

I was not aware of it. Thanks for the tip Takashi

> 
> 
> Takashi

