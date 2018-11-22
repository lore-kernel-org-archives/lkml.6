Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC81C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137822075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="M7jsvJjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137822075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbeKVKss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:48:48 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36606 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388056AbeKVKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:48:48 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A0704886BC;
        Thu, 22 Nov 2018 13:12:05 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1542845525;
        bh=rae9SLKCduqQ6QEiCm4DhgneloNg8AcReqsB9OpXNK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M7jsvJjLd60VdFtabvc1kMoGy2/Ykg2Dk1SCxb8mLyZ7VJauP9VzuXHOeC6C4NSTf
         NhyQ22LgL+tmAcKXYvEI0QhmEdfgGHprptL9RtGzsrXwD4ZH51k1nQ8xc9S3AB3dU2
         f1xnHr9Wsyj8HSoyxmGgqnxUVria/K0oivMqLIV49KhkFfWEbSirVZ7GdYNk7HC7ri
         KOcIQ25dnrWkLnUFteiSQj7HNSAZksPuKmpvC9hDr46JUQCNsMoMykSbaxT8Hkcqb9
         nLEPgsxV101wo8RF0eUHk9DKlTq3dYNXYDxBbfx3ZOfrttET8TKXFSCVdCEL+NZydV
         A9TLz+oDmsi3A==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bf5f4550003>; Thu, 22 Nov 2018 13:12:05 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 0D19813EEFC;
        Thu, 22 Nov 2018 13:12:08 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 995041E08D9; Thu, 22 Nov 2018 13:12:02 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 5/9] dt-bindings: ARM: document marvell,ecc-enable binding
Date:   Thu, 22 Nov 2018 13:11:38 +1300
Message-Id: <20181122001142.19187-6-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
References: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the marvell,ecc-enable properties which can be
used to enable ECC on the Marvell aurora cache.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
=20   Changes in v7:
=20   - remove marvell,ecc-disable
=20   Changes in v6:
=20   - new (split binding doc from implementation).

=20Documentation/devicetree/bindings/arm/l2c2x0.txt | 1 +
=201 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documenta=
tion/devicetree/bindings/arm/l2c2x0.txt
index fbe6cb21f4cf..69e890d56392 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -76,6 +76,7 @@ Optional properties:
=20  specified to indicate that such transforms are precluded.
=20- arm,parity-enable : enable parity checking on the L2 cache (L220 or =
PL310).
=20- arm,parity-disable : disable parity checking on the L2 cache (L220 o=
r PL310).
+- marvell,ecc-enable : enable ECC protection on the L2 cache
=20- arm,outer-sync-disable : disable the outer sync operation on the L2 =
cache.
=20  Some core tiles, especially ARM PB11MPCore have a faulty L220 cache =
that
=20  will randomly hang unless outer sync operations are disabled.
--=20
2.19.1
