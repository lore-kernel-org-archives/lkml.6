Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF90AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26EA20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VX//NAAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26EA20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeGYWZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:25:54 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42661 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbeGYWZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:25:54 -0400
Received: by mail-wr1-f54.google.com with SMTP id e7-v6so8666887wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4nPdfggiOGVQERpd2IiCg01DZ78gI915G5m/TcNWxY=;
        b=VX//NAAqU8pHo5OjRscWy1bz5P1c/fAigpys+IseJzxvC5EQwz7ousgJnNLemRmFGk
         smmw8jSaybUMgYqHJrINHLqv0t+jgeCURTw584KCKEcPZBBEeqZ9ZChkKNpv4rOZXIV1
         BCbwGN4lxL2YesrxAug9qGV+VkHQRTtcoVdfD6ihubQ+6pRlGxibWvYE1CfgVN5or9pH
         hn1zs7rpR25OPH7m9JYNpkpzJwraXm7ogQNwX+NIWzvuzws0zYVkkZk4niVT5/xPhOC3
         2zcX6m6dmWmw2rBYgN1AqjU7CQ/t2FRwZnGtC7Zetyl3ha11Wat2VQW0ZtGm2rD3cVrU
         ht5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4nPdfggiOGVQERpd2IiCg01DZ78gI915G5m/TcNWxY=;
        b=g5AmUF2WlWaohSs2nekPwK0HYaA6JFq19KLCdr+GTM2lfS8Mnsn2eOeR7PvOCcSt0E
         xsFpnaULrWvOnsHBTP72NuQywclcbZjui5NWy2ld6l2/1OHXfZRK18qGdN74Pel2sEBe
         +La4CfLRySsjK/yVlEiraG2Q/s9t24PqRYtVQ4Kynz5YMspcDLDz/Qv7C/se9yBSNB6B
         N9bHEd9AHK77yx4ybbOYk3AWqaB6fdWpxLPYloum+ZP4rh+QyUsC7e5VE+7HT+SdmBr7
         TFqJK7k3OjqTYakYflNAlxFSqRsUvkM2ZgG9IF1BuUkGch9DbHf36oH584mGwv77iEqU
         3flA==
X-Gm-Message-State: AOUpUlF2H6qKpwd0IATgKrRL2D4GmANqCic+j06T4G/Cz0ORznzJl1q9
        fZhg4yyzfsuUB0wn0xzUATI4vQ==
X-Google-Smtp-Source: AAOMgpfanEAd90UeBgypVuq6cEL47lUee/jFfRAuV9rmBQAjig5Tz4kEk+moxGsK5v10HdFnKZRkag==
X-Received: by 2002:adf:de84:: with SMTP id w4-v6mr16411133wrl.270.1532553144068;
        Wed, 25 Jul 2018 14:12:24 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id f17-v6sm16324389wrs.1.2018.07.25.14.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 14:12:23 -0700 (PDT)
Message-ID: <5bd3eb356f7b9ef18a409b549e3d6ac97733a4cf.camel@baylibre.com>
Subject: Re: [PATCH 14/15] ASoC: meson: add axg sound card DT binding
 documentation
From:   jbrunet@baylibre.com
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Date:   Wed, 25 Jul 2018 23:12:21 +0200
In-Reply-To: <20180725190619.GA20234@rob-hp-laptop>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
         <20180717153643.8806-18-jbrunet@baylibre.com>
         <20180725190619.GA20234@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 13:06 -0600, Rob Herring wrote:
> On Tue, Jul 17, 2018 at 05:36:41PM +0200, Jerome Brunet wrote:
> > Add the DT binding documentation for axg sound card
> 
> I see Mark already applied, but...

It's very recent, no DT using it yet.

I can easily have your 3 comments fixed if it is OK with Mark. I'll submit
something for this tomorrow.

