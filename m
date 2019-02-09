Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C917C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1D8218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-ipv6.be header.i=@linux-ipv6.be header.b="bfouYvkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBIQAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:00:50 -0500
Received: from mail.tintel.eu ([54.36.12.13]:41690 "EHLO mail.tintel.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfBIQAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:00:50 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Feb 2019 11:00:48 EST
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id 2FCFA424DC03;
        Sat,  9 Feb 2019 16:53:11 +0100 (CET)
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id nhXsaBVFDLvC; Sat,  9 Feb 2019 16:53:10 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id B5DD2424DBFC;
        Sat,  9 Feb 2019 16:53:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.tintel.eu B5DD2424DBFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux-ipv6.be;
        s=502B7754-045F-11E5-BBC5-64595FD46BE8; t=1549727590;
        bh=OgugLh0YvI/wkG93AJWR1X2iSQ6uRFdoVFbvmNFEWzQ=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=bfouYvkgiT84cafkoPNucUO0NoVyBPiEWL0cmRagbw+IHM5Ys3SgckWNRurkCQJFv
         lVAzKQBpzx69QLkLAwcJqjFuMGo7DUsw0/Rso0f7IruwnL3U5P+JNbvgYYiQiYnlvM
         6O8r8mfHQ/xoRJQ2vK6NmrLMn0OHZAeQbCIdKBks=
X-Virus-Scanned: amavisd-new at mail.tintel.eu
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id UcrKXnOPeicR; Sat,  9 Feb 2019 16:53:10 +0100 (CET)
Received: from taz.sof.bg.adlevio.net (taz.sof.bg.adlevio.net [IPv6:2001:67c:21bc:24::adb])
        by mail.tintel.eu (Postfix) with SMTP id E97E6424DC03;
        Sat,  9 Feb 2019 16:53:09 +0100 (CET)
Received: (nullmailer pid 18505 invoked by uid 1000);
        Sat, 09 Feb 2019 15:50:05 -0000
From:   Stijn Tintel <stijn@linux-ipv6.be>
To:     khilman@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-gxbb-odroidc2: enable I2C bus B
Date:   Sat,  9 Feb 2019 17:50:05 +0200
Message-Id: <20190209155005.18458-1-stijn@linux-ipv6.be>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: E97E6424DC03
X-Spamd-Result: default: False [7.10 / 15.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[5];
         DMARC_NA(0.00)[linux-ipv6.be];
         NEURAL_SPAM_SHORT(0.78)[0.389,0];
         MID_CONTAINS_FROM(1.00)[];
         IP_SCORE(0.32)[ip: (0.58), ipnet: 2001:67c:21bc::/48(0.56), asn: 200533(0.39), country: BG(0.07)];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:200533, ipnet:2001:67c:21bc::/48, country:BG];
         RCVD_COUNT_TWO(0.00)[2];
         GREYLIST(0.00)[pass,body]
X-Rspamd-Server: musltoo
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ODROID C2 has 2 I2C buses, so enable both of them.

Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/a=
rm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 1cc9dc68ef00..ee666471a580 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -180,6 +180,12 @@
 	pinctrl-names =3D "default";
 };
=20
+&i2c_B {
+	status =3D "okay";
+	pinctrl-0 =3D <&i2c_b_pins>;
+	pinctrl-names =3D "default";
+};
+
 &ir {
 	status =3D "okay";
 	pinctrl-0 =3D <&remote_input_ao_pins>;
--=20
2.19.2

