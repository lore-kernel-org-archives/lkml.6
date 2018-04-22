Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524405868-2-13407594290226879476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405866; b=bm3lvGURxsc88q0lbEbm/m8XOirEcc09BgDAgfw6h3AORH4Ypl
    6QMrXB52aKIQ22OHpybVnPL3r/iTARBFyOFRtm7ycBFUpbs0li/Dp+5aEmjYN+nx
    lAM3VhR8JP+tuUMWpNaVgfMqIETDYuLHGeTA/t4ymI0xRkAWznh/Q4dzYzeMVTQo
    A0VOH9oPIm29WSG9PRADu52bMJ20xOV0c1dD0z3HivpmYrLSfNh7r37q2wzbKRAl
    FHjzct8S88KPN6R75++Lxv59sKJEjSP75Tz5dBOjZ6zkr4nilI0vUPPWsTMIVE5S
    idxLu2z3xD7vhOcIA6JJtLPfdiZK3meANiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405866; bh=8d9XZ0hRsILQymLmC54S7HdCGHfVJf
    XVEmyqwEXW798=; b=Ncr9pon1f650NKKHjvAQlxFCWi3SWo66zgoTaz6BB3zlhz
    PyvK82Wut76wweWg8KsexcUkp28B4b0c9rYHugTjLNBHtSRW6VV2NDI92teEZfSl
    nUkgN1iIJzWaurebPQBaP2ucx3K3mKHfuAEOFzqskxNTnai6etd3xAOnuQWXOqp/
    ML5ISSev1gDZGmPWgqpxRsEsjYSdwwOh0qiPHPIpvVUkBMJC46SmF0LHLoKTYeMl
    3LFj3InccyU9LTsjhFRQTbmgX8QPSpm72/09hkQ8Ie+R2BaYxZr1YD0Mo2hKJKbC
    RaQwsbWvc6n7NXtmhCxtP6y/CiL8H/xYZ0rblU3A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfASa0EMWQA+z7iwmo6jqgckYhG7ket5u1CVKjzHm+Rz2SedoTSzH+V5x2wZ1uHIJbP3+ZL14VYEe3vybAxfvlywbRCiM2BZbCuFQVHWURT7l0vgH90P9
    h9StDjnuvQMxt5WrMNBnozFm7RQtuWKnDQshAfkIiCvF/3G0RofnDI0sBOsPzGrJunD/6/K9ufSRs6dtAuf4fnit16N6cacoaoleeaiNjBsayLv9J6bD33LW
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=tNO4O5cXOXHF88bhu1gA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755182AbeDVOEX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:04:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754963AbeDVOEU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:04:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 024/164] ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250
Date: Sun, 22 Apr 2018 15:51:31 +0200
Message-Id: <20180422135136.387650171@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 6f4870753f29edf7dc39444246f9e39987b8b158 upstream.

The proper name for the property, which assign given device to IOMMU is
'iommus', not 'iommu'. Fix incorrect name and let all GScaler devices
to be properly handled when IOMMU support is enabled.

Reported-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 6cbfdd73a94f ("ARM: dts: add sysmmu nodes for exynos5250")
Cc: <stable@vger.kernel.org> # v4.8+
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5250.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -643,7 +643,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL0>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc0>;
+			iommus = <&sysmmu_gsc0>;
 		};
 
 		gsc_1:  gsc@13e10000 {
@@ -653,7 +653,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL1>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc1>;
+			iommus = <&sysmmu_gsc1>;
 		};
 
 		gsc_2:  gsc@13e20000 {
@@ -663,7 +663,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL2>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc2>;
+			iommus = <&sysmmu_gsc2>;
 		};
 
 		gsc_3:  gsc@13e30000 {
@@ -673,7 +673,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL3>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc3>;
+			iommus = <&sysmmu_gsc3>;
 		};
 
 		hdmi: hdmi@14530000 {
