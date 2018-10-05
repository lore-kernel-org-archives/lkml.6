Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5894BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1E52087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVu2GOkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1E52087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeJEWhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33440 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbeJEWhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id z21-v6so12009559ljz.0;
        Fri, 05 Oct 2018 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wO8rLezgv03Kc1/H2qOEeUj33zOmxhncF8Ftb8pScZc=;
        b=NVu2GOkOfb7iY0EvP908xRb2fPjxVvHVVrFXH2aGx8QW2B9pa/wpRJkbwppKvI/znd
         OWxovxOmmnH7ueeeqMlAB+qWYlulB1h3j8RnSN6ZUcBRbfLGhlk1ZkTGIwRvRaxlPmqp
         iXbbPCm7uiwqypcMbcz3x396fisS9bsMTrkAtE2B9v7PKvAPZGcYYNlsleiLcKmadKeT
         rN7aPtpDY06PIpQqmyQTiokHNuQYF1+BDxYLIRsQFKnMXHRgp8K2kWx3KfY2e8V4WT0I
         T7VQFDtdxmlb5s9j9is/KlSDphjb+x+zgzPinHMJOSjB12iH7k6XcR6B3YCQo5zkRKdV
         ythQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wO8rLezgv03Kc1/H2qOEeUj33zOmxhncF8Ftb8pScZc=;
        b=qXkTbhJ3R/BOaZT2Iw8lyEyQ2tJuk3LXmhc2apLiaafmZHyLNZEbMoxDTJb7uEESnp
         i9gQjB0v/sxqPSmC4pv7clSffSPYTFGr4fg6mSJuaLJ+qTOiyvMZc9tFbPYLQOBy93eK
         vwYTZWBSDSvg2z8EpT6D/kk53ROk2/KhkyZOfq3bMlhC1rT+jbEex7pBX/PwK0lONNQC
         JICvdJQCfD1O5xJ15eAY5bsVAA0ZoUjyloXqAqWqy6ab2jJfnP5OoUSO4ZFatDuhgkRZ
         SCfcdnICLztpbKgnynaVJ0hlAm5OOL4ZEAqximqrwdVeAQGwDYNZRd5Pcf1JdT3RN04v
         ojRA==
X-Gm-Message-State: ABuFfojnJ0dvSwxanYfnCy/K4+fz6RNRwRsnYpNqJJTXNIbEzqZXKi5S
        XnA7WwUDgjtwqM51VXeHqyk=
X-Google-Smtp-Source: ACcGV61tzkAcoe5zkUcESDoYnBzR66PilWuiQizktu3bVLN9FaRF7z0P7b5HSc3thKSnAZE5d0omWg==
X-Received: by 2002:a2e:2205:: with SMTP id i5-v6mr6737163lji.15.1538753879137;
        Fri, 05 Oct 2018 08:37:59 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:37:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 05/11] dt-bindings: regulator: Change regulator-coupled-max-spread property
Date:   Fri,  5 Oct 2018 18:36:32 +0300
Message-Id: <20181005153638.1886-6-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redefine binding for regulator-coupled-max-spread property in a way that
max-spread values are defined per regulator couple instead of defining
single max-spread for the whole group of coupled regulators.

With that change the following regulators coupling configuration will be
possible:

regA: regulatorA {
	regulator-coupled-with = <&regB &regC>;
	regulator-coupled-max-spread = <100000 300000>;
};

regB: regulatorB {
	regulator-coupled-with = <&regA &regC>;
	regulator-coupled-max-spread = <100000 200000>;
};

regC: regulatorC {
	regulator-coupled-with = <&regA &regB>;
	regulator-coupled-max-spread = <300000 200000>;
};

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index a7cd36877bfe..9b525b657fca 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -76,8 +76,9 @@ Optional properties:
 - regulator-coupled-with: Regulators with which the regulator
   is coupled. The linkage is 2-way - all coupled regulators should be linked
   with each other. A regulator should not be coupled with its supplier.
-- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
-  in microvolts.
+- regulator-coupled-max-spread: Array of maximum spread between voltages of
+  coupled regulators in microvolts, each value in the array relates to the
+  corresponding couple specified by the regulator-coupled-with property.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
2.19.0

