Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31683C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA042177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYacp5f5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfA2IF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:05:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33095 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfA2IF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:05:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so8443097pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fUSQT/ebFnVlbQY+g/k8cRO6IWadUFBMzhAc1bfyjqU=;
        b=gYacp5f50nYzokMJ58Yy8CH6UbUPnyXJnbMJSaCBupTB5KvIOiV9ijjNyhxubuWc6h
         h+GkgTo1D9T8fWF/oo+bf4Oi94dWc/a9nqz+6IaWCW34D5wlvqRsm9db68pOhwGueM2d
         0xj7B9jzxQNuGbPoCyuLlVdXmsEa+JbDYH5Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fUSQT/ebFnVlbQY+g/k8cRO6IWadUFBMzhAc1bfyjqU=;
        b=Kn5bDnWeapucAWmDaEoKVHCgQt8uib+oTQxxlB//X3nAMUCZSID2MLdIIFiZBTt8iY
         ODdHv5z1O+DXUOwtw/DRBlRahh0neQC8oPqQ1FABp4Lnk+fCRq/GmWu0ZHvCy8V/NQPC
         zVrkuFtcuMG62keLItxNF6C5K8iw+DaZ8LYzkYBUF46iz0AjFszbE7A05HGHc9Syalwp
         1NFXwgq0xJekcinHL0lwl29DOr50bpbA90XNMjKXR7Rxhlkhy4RhnY7pdPh1txEjqSjv
         FzLwJoR9t5jupfC2PBVsvADfSobF+Wnbluc9nE1ECMy+D2sOQWLi9JbNwAP+jx8jidT+
         qAeA==
X-Gm-Message-State: AJcUukc3kc35B2+ewEVmBz5ycsBn/03eWoqOlu6fcJXrT6zzBo5MxzyY
        lomyoQN5lv7NtwhrZeTKmhRHxA==
X-Google-Smtp-Source: ALg8bN45eaqt5wvkB7fLk/XqbIU79AdW2qLri0c9stVIntH18jtvRUl6pzdB4XB8UPbjDflbfL1K3g==
X-Received: by 2002:a62:3541:: with SMTP id c62mr25000021pfa.19.1548749158127;
        Tue, 29 Jan 2019 00:05:58 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v14sm40926177pgf.3.2019.01.29.00.05.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 00:05:57 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 1/2] dt-bindings: ASoC: Add Spreadtrum DMA platform documentation
Date:   Tue, 29 Jan 2019 16:04:44 +0800
Message-Id: <15c562bcfd488fbf1979a69f96ddbd8df57f7e69.1548747137.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Spreadtrum DMA platform driver.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/sound/sprd-pcm.txt         |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sprd-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/sprd-pcm.txt b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
new file mode 100644
index 0000000..4b23e84
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
@@ -0,0 +1,23 @@
+* Spreadtrum DMA platfrom bindings
+
+Required properties:
+- compatible: Should be "sprd,pcm-platform".
+- dmas: Specify the list of DMA controller phandle and DMA request line ordered pairs.
+- dma-names: Identifier string for each DMA request line in the dmas property.
+  These strings correspond 1:1 with the ordered pairs in dmas.
+
+Example:
+
+	audio_platform:platform@0 {
+		compatible = "sprd,pcm-platform";
+		dmas = <&agcp_dma 1 1>, <&agcp_dma 2 2>,
+		     <&agcp_dma 3 3>, <&agcp_dma 4 4>,
+		     <&agcp_dma 5 5>, <&agcp_dma 6 6>,
+		     <&agcp_dma 7 7>, <&agcp_dma 8 8>,
+		     <&agcp_dma 9 9>, <&agcp_dma 10 10>;
+		dma-names = "normal_p_l", "normal_p_r",
+			"normal_c_l", "normal_c_r",
+			"voice_c", "fast_p",
+			"loop_c", "loop_p",
+			"voip_c", "voip_p";
+	};
-- 
1.7.9.5

