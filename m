Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC36C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E08245D1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/3A9wJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E08245D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965796AbeF0Qt0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:49:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39000 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964870AbeF0QtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:49:24 -0400
Received: by mail-wr0-f194.google.com with SMTP id b8-v6so2728135wro.6;
        Wed, 27 Jun 2018 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4Uc7fU8pOxMXjp+uVDKI4e+ixnI79eJBawwDV1p5uA=;
        b=P/3A9wJNhsvZmlTfpWtkyp+dL0RtHfJBLkLqhUjs65qpX7JgBDTdmNnAImEjRdnR8s
         /lLzpXlWz6QaWxaFh1Zg4RnPOhn9YtAhCZuCL0EeKuxJBTXV5SuKoTOzJEdsigEzxMhW
         OlHKwCG1avKGPmYwK8QQMLoKPEpXj4ClakZ1+T+h6rAHkTXMyOPiO09Va3+56AUGdBVl
         IhzGtTWuZhwUV0oauuVBsLMYI0tIhgm1n6Iv7ylL8FWFYAZec1Meiy86fdpMOS6WgO07
         MXRfij9/fPJv0woLaA2a28idAqTyNvc7fVwigRUt3IlykqzawuXldhURYujumnOreLjo
         9MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4Uc7fU8pOxMXjp+uVDKI4e+ixnI79eJBawwDV1p5uA=;
        b=hAFLcPk0M5mP9saWKri4fSX5d7TZmqwqpBlGstr3mIzBvZWALPbH1gNB5YG+9Gq1Ki
         /epp6yTq6AGiWsPKael3eRjGWK8yAYitoJp8Tfkmyeq3v5iCLIOMsjDFeQ3HUMbBi1ot
         ieifAIA+M+y14DajH2B6Q5ngg0kFVXsHDFQXquu3wzinUPEUbf1AcWTUpJdTXpdzdG6b
         6S4WtyRoVGgiYxNGP0Barfh2uzcDrHcv0eyduyhpvmywX9po+eI6CLZ67XYBlTmR4WMB
         NY1wl9CtkthP4BY6DvMrOJzsyXIU1L73+p1wIn11F+lbpAXtoVg7CoAN7B07V/rcc/dj
         KXAQ==
X-Gm-Message-State: APt69E0ZVOzDmhw0T7Xh6lG/CRroTwCykWBosNA6GlDvo8NgzD5v+3UV
        TCkKDOeXqJZgzaq3VghU1NmKGgrY
X-Google-Smtp-Source: AAOMgpecQzmQGZUhZ+edQrNZ7FWmCv1sTHoPgA1MpOjh+prO3uJ3YnRzFzUSz7KgsT4zNOZxQWlZXw==
X-Received: by 2002:adf:ff0b:: with SMTP id k11-v6mr6259395wrr.15.1530118162931;
        Wed, 27 Jun 2018 09:49:22 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id s2-v6sm7178860wrn.75.2018.06.27.09.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 09:49:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, paul.kocialkowski@bootlin.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Qiang Yu <yuq825@gmail.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [linux-sunxi] [PATCH] ARM: dts: sun8i-h3: Increase the GPU clock to 576 MHz
Date:   Wed, 27 Jun 2018 18:47:56 +0200
Message-ID: <2117931.94GTsegy69@jernej-laptop>
In-Reply-To: <20180627072635.3592-1-paul.kocialkowski@bootlin.com>
References: <20180627072635.3592-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 27. junij 2018 ob 09:26:35 CEST je Paul Kocialkowski napisal(a):
> It was reported (based on declarations from the Allwiner BSP) that the
> Mali 400 found on the H3 can be clocked up to 576 MHz.
> 
> The frequency was tested using the r6p2 out-of-tree driver and a Kodi
> userspace with associated r6p2 blobs, leading to a working result.
> 
> This increases the clock to 576 MHz, which directly increases the pixel
> throughput of the GPU (given the 1 pixel-per-cycle rate).

I think that current clock speed is on a bit conservative side because there 
is no thermal throttling support yet.

Best regards,
Jernej


