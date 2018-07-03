Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853F1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E26523EDE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KmLdTlSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E26523EDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933768AbeGCP7v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:59:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36249 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932834AbeGCP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:59:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so2869764wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfMQX652cNGrkXgSSjOJS1DInzufTUTRPVUAE9sajfQ=;
        b=KmLdTlSG7mjNewrZY0IZSAkXZ9S27K1UUas0wYPSJXiYuWDdd28iyZFKlzAMggws+z
         I0xXc/QEYap2lbLY1nrBWJu/3Xd7uUmGC4ZHw0YTtyghD/g80aJ1EdVdsCJ1aCxdE818
         1ORbb0otR7kG8NGcU9bLsJyXTNO9moYy7qcPnyT6kYRBilDncpI9yclTxR7XX12DomY4
         LpuRUJggSVFRegpNWuNfXPwL4Ep7TKzXIx5kU+2zlSopw8Jogv14eUrwox6PsDEZXi0N
         prfLPydrMgUrHu2VKu9pdNG9msn8DOacssfoK85seaxZuzmI3VTsMTEpZ609ytfvMH/Y
         x/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfMQX652cNGrkXgSSjOJS1DInzufTUTRPVUAE9sajfQ=;
        b=TtJCC2Sy49mx+wFQIKKqCFyDmrD8NyTji2Qe6oS2cA6SPPt1/q8IPMaLXrFRVwu1pp
         ZNBAH/AveY8MMBD5Zi9avF30F8wW5sZF0zioaTjGeS0gn1Jo1gfap5WdMz6EsfwiHh+f
         DdgzF5H4UHhx12GNjToRM8x3fmOSYhh4NLWoz3mWF+cCdEGDXd/Bp4YYF+eP22MLlDQq
         thNUKCZIwGTAXkrkloGT+Np+enMyAtV7Nc/hFwLyiTP+PkcEPZlI63B/hhrYYbvnlyoC
         C65Ub/a0Wcis1QFKxyiTPK3dKRICojUt67JQUyh7f80G60XUeaID5RJPsr5GXdHQ4PSf
         btAQ==
X-Gm-Message-State: APt69E0/LEL9dTPDUhO4buqhkST0UPpxmW00RgfhhtIc1Bpwud0+S5+0
        3rE0N/4OLY0JTdDhTvbp4rXbqg==
X-Google-Smtp-Source: AAOMgpeKaydAyhUO8zpYGZ488QfiaQqXcRwruG96jtHVTJ/Vwnmbss3+ey5Oh/Yha4TXpN+IKcT3zQ==
X-Received: by 2002:a1c:cf81:: with SMTP id f123-v6mr10964987wmg.83.1530633586727;
        Tue, 03 Jul 2018 08:59:46 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q140-v6sm2771495wmb.35.2018.07.03.08.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:59:46 -0700 (PDT)
Message-ID: <1530633585.2900.213.camel@baylibre.com>
Subject: Re: [PATCH v3 0/2] ASoC: add es7241 support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Jul 2018 17:59:45 +0200
In-Reply-To: <20180703154137.GD13744@sirena.org.uk>
References: <20180703132845.26554-1-jbrunet@baylibre.com>
         <20180703153212.GC13744@sirena.org.uk>
         <1530632179.2900.210.camel@baylibre.com>
         <20180703154137.GD13744@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 16:41 +0100, Mark Brown wrote:
> On Tue, Jul 03, 2018 at 05:36:19PM +0200, Jerome Brunet wrote:
> 
> > Unless I missed something, which entirely possible, I don't think any patches of
> > this series have been applied yet. You asked me resubmit after the v1 because of
> >  power supply bindings and the mode selection.
> > I don't see anything related to the es7241 in your tree ATM.
> 
> Oh, my mistake sorry - I must have copied it into my to apply queue
> twice so got a reject on the second application.

No worries. Just wanted to make sure.
Thanks !
