Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383E1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E6421746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCKdtezP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E6421746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeH0MIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:08:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33963 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:08:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so11644545ljk.1;
        Mon, 27 Aug 2018 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kMK7vADaYUb3uoA3K0PRlMXBDFYMW3OHjrli6EBxJE4=;
        b=MCKdtezPpLuUtsbonrbkCwRNnI36hXL3H/YNYt4As9iRpmwfGduA/SlRk1jQQrZrWv
         pULvUc4Cs1eU4GVqpqlfca4zhHIdADoeXsX+CyaN2r+53/d9Q+4wCzngPZZyic0gOoAF
         8T7iz1NyM1ee+TsGBcx3/g6NCg3BARZshQ9sUCLRwnJJ+OHXddWp7BjQB/sz9QTAsgdL
         FVfFxVYMyTEaqSWheTeEuR/3iCxprEFiRBive9ytOJBGCR/yZsWoEkt+isRRgAenNq7g
         2PYlC2XaCoupiFA07VAmGUQpwkqaCOX1H62kGy+J2Kua75V3kbKdLhCAhAyLdZHu15W2
         e/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=kMK7vADaYUb3uoA3K0PRlMXBDFYMW3OHjrli6EBxJE4=;
        b=Y8lS7PRTkRNaEoNTVAXTumoYH6tbn2NlmZhiSBnWewBOE3YSWUz/HZGbpfG0pae0Z6
         l4E/QYd1SnyR+kOZ4VkuJ1JgTN4mkS6eH3mlQVjKOIayA5qDaj7K0L+poqd2E3cZZWsX
         wXHVHVFyVznHeBihTIrF3BLIW/hyK7cV0JLfRUNo/meGPHihFXsprY/rY80fzmPCjhXj
         gM3UO0+1hhPEhYDk3bEAvzYkjLRMW9qSsmEZBTHH51Xi9ytbOpNDnnkQXRIRKKNnqj5w
         nDImCwblPoG+xHOSdoIHMyTovCPFzNVMakIRmq341GCgyk4+rf2oLHfcBsP+XgO4G04i
         YomQ==
X-Gm-Message-State: APzg51Ch2HnD0Bo7/l+9L07cAiM/SZCJcJcsp84UHGO3Xmkt7fGvpWoY
        sirYeyG3Y80K00onYbFRTyc=
X-Google-Smtp-Source: ANB0VdYw5PU6PM20Mx43Gf+6+IHOSfmCU8Kg8voG7Kz2muq8NwznNjR1fuptycA5mbugBmONOYLBgA==
X-Received: by 2002:a2e:1290:: with SMTP id 16-v6mr8186756ljs.94.1535358154357;
        Mon, 27 Aug 2018 01:22:34 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u2-v6sm2642547ljg.55.2018.08.27.01.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:22:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fuCn6-0005sc-PS; Mon, 27 Aug 2018 10:22:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v2 3/9] drm/msm: fix OF child-node lookup
Date:   Mon, 27 Aug 2018 10:21:47 +0200
Message-Id: <20180827082153.22537-4-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827082153.22537-1-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the legacy
pwrlevels child node instead of using of_find_compatible_node(), which
searches the entire tree from a given start node and thus can return an
unrelated (i.e.  non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the probed device's node).

While at it, also fix the related child-node reference leak.

Fixes: e2af8b6b0ca1 ("drm/msm: gpu: Use OPP tables if we can")
Cc: stable <stable@vger.kernel.org>     # 4.12
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index da1363a0c54d..93d70f4a2154 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -633,8 +633,7 @@ static int adreno_get_legacy_pwrlevels(struct device *dev)
 	struct device_node *child, *node;
 	int ret;
 
-	node = of_find_compatible_node(dev->of_node, NULL,
-		"qcom,gpu-pwrlevels");
+	node = of_get_compatible_child(dev->of_node, "qcom,gpu-pwrlevels");
 	if (!node) {
 		dev_err(dev, "Could not find the GPU powerlevels\n");
 		return -ENXIO;
@@ -655,6 +654,8 @@ static int adreno_get_legacy_pwrlevels(struct device *dev)
 			dev_pm_opp_add(dev, val, 0);
 	}
 
+	of_node_put(node);
+
 	return 0;
 }
 
-- 
2.18.0

