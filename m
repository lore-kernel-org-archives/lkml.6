Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B68AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5D125C20
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Tk/O0IIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5D125C20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965419AbeGBKPf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:15:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55975 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965121AbeGBKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:15:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so8414185wmv.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3e6cDhDxUmgVdt8N+qKe7HIOgeYCEHsorWJ//24Rwo=;
        b=Tk/O0IIpnPf5Rxcpog6zjSXlybQs49hBe8mO2HT8hQDbSz9LyXV/O6dah2YYfiS+q+
         +DbscxlihioDuNxAWCHSYAghXmuqWVdETR/DbqGWXEd1ujfAK6TxyFrq/KyRZK9xfLMS
         Quozs1unyxncu01Kr23QB/DG7cDYo+9a3h0J1Se94CvHADcSLHS9+/1bv2JZBfz6nX/i
         qlH/5WgKVTobQT188kP/DPp8K9gozWEwT7V539DPjUAIIp4GNmTGSLFYa0C3is+GKKw1
         BjjNuTpqkVSzWeNxkGVqgVPdi/CrmGivZ4vT8KG/3wArz8LMlDiJ6IXaJaeK+cB+V1RD
         i6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3e6cDhDxUmgVdt8N+qKe7HIOgeYCEHsorWJ//24Rwo=;
        b=NaaDLOtmLJw5wulnPm8xjM5Yf/hfY0K3Jpky6zw85MVOvrFN3h89wM6yazacnHJ+hf
         cs6xYKObaJoCYyWF3Jd+IBoP1L+J6iQO+gbH4vPiAm8sP/ufO8QczpbD7zDgwW//ZbOV
         /8XZUScP06KudSAnwDm/J+7xXjQa6iSa07w9CLSwlfUUDChzaCi+sUeiiQVl2idMMxi+
         yl7xUJlmiw1JwNqVJxmB8bDSZoUMAgYo3SylyTFriEhL9mXJ7c7rsF5kKdouANzVvPco
         bgBD5EOUeCRFkz4PKV7oENv3QuX+Qt60vUy7SAMvnRuPs6jULvre/v4+fjplqJtSVBya
         75Ig==
X-Gm-Message-State: APt69E3IXyeTGEGXMdYKxcc7ldXTqxYHPBgjpa7KzYV84mtHZhdtVAph
        LBrpGdnaArN3ycb1jYfPYILWBg==
X-Google-Smtp-Source: AAOMgpeKNxNDXzIfwGb+XvTomJ+xaQ6B9tyOhSVPJqzbeKdl4yMuA0+2sD3EIQIKeaNcKhh6aUy+eA==
X-Received: by 2002:a1c:afd4:: with SMTP id y203-v6mr7397257wme.55.1530526530144;
        Mon, 02 Jul 2018 03:15:30 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o13-v6sm5967288wmc.8.2018.07.02.03.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 03:15:29 -0700 (PDT)
Message-ID: <1530526528.2900.145.camel@baylibre.com>
Subject: Re: [PATCH 5/5] ASoC: es7134: add support for the es7154
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 Jul 2018 12:15:28 +0200
In-Reply-To: <20180702100533.GD18211@sirena.org.uk>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
         <20180629150924.18197-6-jbrunet@baylibre.com>
         <20180702100533.GD18211@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 11:05 +0100, Mark Brown wrote:
> On Fri, Jun 29, 2018 at 05:09:24PM +0200, Jerome Brunet wrote:
> 
> >  	{ .compatible = "everest,es7134", .data = &es7134_chip },
> >  	{ .compatible = "everest,es7144", .data = &es7134_chip },
> > +	{ .compatible = "everest,es7154", .data = &es7154_chip },
> >  	{ }
> 
> This needs to be added to the DT documentation.

I believe I added this in patch 3 of this serie, which I'll resubmit.
Shall I resubmit this patch along with it ?

