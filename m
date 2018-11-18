Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775DFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3907A2087A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJMgbBI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3907A2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeKSISZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:18:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46388 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeKSISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:18:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so13825403pfm.13;
        Sun, 18 Nov 2018 13:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vg6oEPTmQTUEsHikiqr1WkGw4DmuDrhnI5P+socCbPo=;
        b=NJMgbBI0s7Z0DtCSt6EOkNnQWtbjwliO6RWCL1LUHXANn58xZjNqCBGMN4/+YR7GTo
         h8kFOGQ4l1bg2epPWCFmhdwV71R1slDLC6aL4RVxs8YvtgfMYc6T8JXDsGuif4cEUt2i
         VgX+Kl2MP/g1inWIJVbxoWM/h5YVltORZUQppjl00i5QHDMqaIGfUR0sPMoMG7BpLgRq
         D367LCu4objRFLXBEUBySZVsfScd1Ka+VcQsSdgj3X5X2K9k8EMnch70x2LgWtx/Ar1k
         Htna7v60/Cr0pag5GprunCj5YHyKdMCuFXPhCRei9TllUljXzH1tOZ5eObzAWZwkCwt2
         l+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vg6oEPTmQTUEsHikiqr1WkGw4DmuDrhnI5P+socCbPo=;
        b=ZpZzIbJf++vf14knkQEhTj2dk7egIKverwTmMpYeDrMbCYtlMovf7gKJO9rrc9ji4q
         +bP2+38sIrKUUfBVCm7ZB392htA414t/y4MtuGVCDvZ6PwvsZaHw1uIYWyeY/d7xIrkr
         vFcWkarB5w2I7ulKYdxmmrSFNT9gRp9pjdmVDXA5W3+96xGFkqCsmy9t9pFJEMDivYVX
         Iswu0j5gTT3xDpeIpkvVl8LqErNXH8+6l1JPdSxiDKcz4aaMbrktpn/AtVF50fkKvmkr
         W6u9J1dIR8JdU+8TAK1+Bea4FyOyAojDKjiluh/EDQXUXwkIiIMvXAFFYQsU+sQzdSol
         fZgQ==
X-Gm-Message-State: AGRZ1gJXgM/fj7Jr+OHQhKDZSiGj3IdY+oyKNM3xq6OePPPEU+n0dU8D
        f6q67Pb9xjF1MKddkUAaZas=
X-Google-Smtp-Source: AJdET5eyexnRjM4KoIdzQA3hvMV79R2o4altxqjUq56+pK8+oZSXHNq3auScx0DMoaFPpeasGJux1w==
X-Received: by 2002:a65:624c:: with SMTP id q12mr17900696pgv.379.1542578215702;
        Sun, 18 Nov 2018 13:56:55 -0800 (PST)
Received: from localhost.localdomain (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.gmail.com with ESMTPSA id j64-v6sm9733422pfc.43.2018.11.18.13.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:56:55 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: regulator: Change regulator-coupled-max-spread property
Date:   Mon, 19 Nov 2018 00:56:16 +0300
Message-Id: <20181118215619.21518-2-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118215619.21518-1-digetx@gmail.com>
References: <20181118215619.21518-1-digetx@gmail.com>
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

Note that the regulator-coupled-max-spread property does not have any
users yet, hence it's okay to change the binding.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

v2: Added note to the commit description, saying that the property doesn't
    have users yet. That was requested by Rob Herring in the review comment
    to v1.

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
2.19.1

