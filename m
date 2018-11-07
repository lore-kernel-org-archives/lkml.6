Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE73C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03782086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xa6+FST2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03782086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbeKGN27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:28:59 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40132 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeKGN27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:28:59 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5612880237;
        Wed,  7 Nov 2018 17:00:22 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541563222;
        bh=w1T+IMlqrKOlQv2pajmMZ39hIqEScBR8Pzb7aVTyJKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xa6+FST2ZjjgKrkDzxlDBIaFSVaNL/243WYAD0cmJl9LWLeq29R/ZHg6h3tIVCwng
         m3BJQLpf5m3NDmBpucNbb/+2VxXU6SqzdjDkqvdAMLAV1bfrLQGplgluLNpk6bEeL/
         t34qLYBeGidt+dAwsDTnhnk39I3Wu7VHRvyfzIT+06PTy8hVC+XgIzlLyAKOE9IZcm
         P+Ysqzwn59Dm7ALyfJpZJhAwHp+0SexAhA9U5y9GQvP2JWs0tDaep2au2AUnOdilug
         ZZXa2/EKmw5yiOnMlOgt4R47tHIj/GZtyNv1h5PKJc407V8sj9zdUYdO9ilg7Cunf+
         AuhEeJDlp21RQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be263550000>; Wed, 07 Nov 2018 17:00:21 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 644D613EEA1;
        Wed,  7 Nov 2018 17:00:26 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4582D1E220C; Wed,  7 Nov 2018 17:00:21 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, robh+dt@kernel.org, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] dt-bindings: hwmon: add binding documentation for adt7475
Date:   Wed,  7 Nov 2018 17:00:09 +1300
Message-Id: <20181107040010.27436-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107040010.27436-1-chris.packham@alliedtelesis.co.nz>
References: <20181107040010.27436-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of the invert-pwm property the adt7475 needs its own
binding documentation rather being captured under trivial-devices.txt.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
=20.../devicetree/bindings/hwmon/adt7475.txt     | 22 +++++++++++++++++++=

=20.../devicetree/bindings/trivial-devices.txt   |  4 ----
=202 files changed, 22 insertions(+), 4 deletions(-)
=20create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.txt=


diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.txt b/Docume=
ntation/devicetree/bindings/hwmon/adt7475.txt
new file mode 100644
index 000000000000..79255439e157
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.txt
@@ -0,0 +1,22 @@
+*ADT7475 hwmon sensor.
+
+Required properties:
+- compatible: One of
+	"adi,adt7473"
+	"adi,adt7475"
+	"adi,adt7476"
+	"adi,adt7490"
+
+- reg: I2C address
+
+optional properties:
+
+- invert-pwm: This configures the PWM to use logic low for 100% duty cyc=
le.
+
+Example:
+
+hwmon@2e {
+	compatible =3D ;
+	reg =3D <0x2e>;
+	invert-pwm;
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Docu=
mentation/devicetree/bindings/trivial-devices.txt
index 69c934aec13b..4f29100d6bbf 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -14,10 +14,6 @@ ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-P=
in SOT with SMBus Alert an
=20ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor-=
Based Systems
=20adi,adt7461		+/-1C TDM Extended Temp Range I.C
=20adt7461			+/-1C TDM Extended Temp Range I.C
-adi,adt7473		+/-1C TDM Extended Temp Range I.C
-adi,adt7475		+/-1C TDM Extended Temp Range I.C
-adi,adt7476		+/-1C TDM Extended Temp Range I.C
-adi,adt7490		+/-1C TDM Extended Temp Range I.C
=20adi,adxl345		Three-Axis Digital Accelerometer
=20adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility =
value "adi,adxl345" must be listed too)
=20ams,iaq-core		AMS iAQ-Core VOC Sensor
--=20
2.19.1
