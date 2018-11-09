Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADB4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A8920840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="zeh4fjQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A8920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeKIQnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:43:32 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45835 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeKIQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:43:31 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0313C886BF;
        Fri,  9 Nov 2018 20:04:16 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541747056;
        bh=/6Vb8QkaEI2xPJOKG7kW7DCX8djb/m2hFP9GgmfZjLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=zeh4fjQLFGvvzxp6LS1LV9MBKoHf+ILzwhWyNdrJ+/DaCpgMC7QbomoINznk7ema6
         tjq1tFoFjbff0ACbeGD8rntxIpUzMv+8MVKddCu9UFjsJ95iOCWi4MDBmFbqhzhzq6
         fkgnEp0aSWxXicwcLCMYEroQYZ4blKSeH8AdyfZbk5BBB1xm288PBtvt2VW9WDpYkt
         vf+irlbYkS4sU11ObAHgDyKQzknnvhUoRbLcnJkyN6hrExsPYE+bnKVh0VfGDPZdHY
         7wGhrupIK4X/qgh/IAT4sPe5GS/Ja/fCusdHDtVvZ7p9MtsX21KpNiHk4kCp9O4pKx
         MAPsmJqbOU3qg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be5315f0005>; Fri, 09 Nov 2018 20:04:00 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id A993A13EEA1;
        Fri,  9 Nov 2018 20:04:04 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 867FE1E0BC9; Fri,  9 Nov 2018 20:03:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 5/9] dt-bindings: ARM: document marvell,ecc-enable binding
Date:   Fri,  9 Nov 2018 20:03:45 +1300
Message-Id: <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the marvell,ecc-enable and marvell,ecc-disable
properties which can be used to enable/disable ECC on the Marvell aurora
cache.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
=20   Changes in v6:
=20   - new (split binding doc from implementation).

=20Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
=201 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documenta=
tion/devicetree/bindings/arm/l2c2x0.txt
index fbe6cb21f4cf..15a84f0ba9f1 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -76,6 +76,8 @@ Optional properties:
=20  specified to indicate that such transforms are precluded.
=20- arm,parity-enable : enable parity checking on the L2 cache (L220 or =
PL310).
=20- arm,parity-disable : disable parity checking on the L2 cache (L220 o=
r PL310).
+- marvell,ecc-enable : enable ECC protection on the L2 cache
+- marvell,ecc-disable : disable ECC protection on the L2 cache
=20- arm,outer-sync-disable : disable the outer sync operation on the L2 =
cache.
=20  Some core tiles, especially ARM PB11MPCore have a faulty L220 cache =
that
=20  will randomly hang unless outer sync operations are disabled.
--=20
2.19.1
