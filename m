Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF94CC65BB3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16272082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="DN55VLOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16272082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeLDPUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:20:12 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33534 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeLDPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:20:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so18439558qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PPJ1S2+Ulgn7HUmdfLc1NF6cBIa9z+s7jqKemTNA5Pg=;
        b=DN55VLOS4xwpFvkuq9e5T93jOE6EG942cZQC3tL0ZA1/UX1vDmcjBRbFbFEk/1b1yq
         sfmYeKWq9MgneUhx9q2F1wwuhTn++89cltRIq+tqPDO6Mcsbpczcfn5BzV3iJtYuVGrw
         tdA8ZzxgZFI91PYfShhkbvxgh2oPGwUdGGehyTtn/5naUTUlRmvIxPW7xJHTaSjRd4TU
         bfltSUk+hWdiXzUBWKbJSLftxZ5B2owBP5rkpZGKge4Ce+ClOF/Y4bSLKDA+Yz/YFOlI
         gPRKvVL/fpCcgOWxg5IOCqmMtOGVzjHNFcDGB32lsjHdVBhcAKmu1VkIoFvgluB/1NMA
         XDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PPJ1S2+Ulgn7HUmdfLc1NF6cBIa9z+s7jqKemTNA5Pg=;
        b=R4R+fEDBF/+qrFom0JPx8jU8qAocl0rtTyi6kedxS+pALemX8PKcCiOrc1hg9lnj6B
         uiG6+IUSds1aDrl/cwpFdwwD6WjGOaCQJZ1JAxOQQC11TDsgr5oH8VeNQjAdyBE6eKvw
         II6w8AwIDqYz1YXzwxWvbEGf8f7SoiSs1C7cBAEOUAXU0IQkQvqK3fI4RZa2Y3k/fcmU
         IZOciCd0DXiO2/Av3i437epF2vi1ogmoF8/oB+f3t9a+MIjoIpxqW46KZ8nUzGXz01Ir
         vCBvwXWEelbMsjSCOy6w1a+By5HvEpuKmBzADfqgHbVNWQ3j6GblioUpXA1ANnfIWyEn
         VajQ==
X-Gm-Message-State: AA+aEWbLjYNblayENHHHYh1Mxz6KyzPCv51F1GZVjU8fdtZfOgZ+IsTY
        s8No4ou28wiAkBHyr0Zhpw2hMA==
X-Google-Smtp-Source: AFSGD/UplkyL7Agn6VvRvVm+zDwHW6QQpD6a/mghGXCQ/N0HsHpfxXKtPEhWLkCHq8H76xmuv4ixFA==
X-Received: by 2002:aed:3722:: with SMTP id i31mr20538003qtb.289.1543936805374;
        Tue, 04 Dec 2018 07:20:05 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q17sm11053989qtc.19.2018.12.04.07.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 07:20:04 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 5/5] dt-bindings: display: msm/gpu: document amd,imageon compatible
Date:   Tue,  4 Dec 2018 10:17:01 -0500
Message-Id: <20181204151702.8514-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204151702.8514-1-jonathan@marek.ca>
References: <20181204151702.8514-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new amd,imageon compatible, used for non-qcom hardware that
uses the drm/msm driver (iMX5).

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 Documentation/devicetree/bindings/display/msm/gpu.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
index 43fac0fe0..ac8df3b87 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
@@ -1,11 +1,13 @@
 Qualcomm adreno/snapdragon GPU
 
 Required properties:
-- compatible: "qcom,adreno-XYZ.W", "qcom,adreno"
+- compatible: "qcom,adreno-XYZ.W", "qcom,adreno" or
+	      "amd,imageon-XYZ.W", "amd,imageon"
     for example: "qcom,adreno-306.0", "qcom,adreno"
   Note that you need to list the less specific "qcom,adreno" (since this
   is what the device is matched on), in addition to the more specific
   with the chip-id.
+  If "amd,imageon" is used, there should be no top level msm device.
 - reg: Physical base address and length of the controller's registers.
 - interrupts: The interrupt signal from the gpu.
 - clocks: device clocks
-- 
2.17.1

