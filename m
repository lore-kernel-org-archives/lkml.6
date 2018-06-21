Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC550C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882CC208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mZmVwJAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882CC208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeFUIdO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:33:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44502 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932879AbeFUIdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:33:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id p12-v6so591703wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rw8NxYxgOqWZdbKalS1xo0Yi+Kx/8/ah6OqY5FIYUFE=;
        b=mZmVwJAVyzsGAQvOVTQLl/9fy4HpbNMN9KiFfmi+cmeeIoNpVyNBgV0Y27AUeMqnkn
         5ec7PDzcxdg/585v4X9KQmgc24lJmwZh5dpNaBApy8f3iBpQoNC2MzZjDZ5h6oqAlH82
         JiMOOChDiU+uXo/VYorDGJlJgbBteS6+iNBAi8v8AR/ZnXq6n0kBTv10FWr3j0TM9w9q
         BjJ0u+YPaon/77DdhPkCcvM0xJrDF5V0Y0tr4UGavQ5Zw1oaKMkADbZxlBoBO5aPv15M
         87B9QcP+NNBjEwgfxX7tnNPDd0rIx//78NzZNVzwP/8cYFPJoaOlMP5atnG2ZzxH++Ae
         WauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rw8NxYxgOqWZdbKalS1xo0Yi+Kx/8/ah6OqY5FIYUFE=;
        b=OU1UvHDXEPIIZ3Iot7HxCEmAk7J9S7LQrugHDHjmt3LVQiaereK1aQ8QORfjfK1kcW
         koCkheQoxKDPms86ifSnuU2OAlSLZkJRLH2wa+RMpa+Ssyf5DbgYtNP1OaxMfpyczjQ1
         yHc08npRHvqbUom2byBDrURBtrllQgJUD+p8m6nBdcLuKfqNcqMPUNClH6WUSCHUDzv2
         E+JUMJ+QEusrhvqnquI9S07OfwXiOB0wpg3d+w2dOHfSK3CwTvVPMXeRGL10HMAbiqAr
         fkvk6cCVJBx4kRzE1LV6sGRQKxS4zY8SNgVaAvWa08xQUNHUqfabfdlIRG/eJlm2j4bD
         hE5A==
X-Gm-Message-State: APt69E3eihwL2bVfmT9Sg2mEnCewIvFl2dieUZaUCI5Mwjs2JcEXAeft
        iykUFcN+DnkWBNHoWEnXbff2AA==
X-Google-Smtp-Source: ADUXVKI+MdpEkh8sEs+nbKysScy6XdNZAdafVVSuC/X+k6acMiH8zy3keAFMZGCb7L8q67i+xI5zXA==
X-Received: by 2002:a5d:4b4b:: with SMTP id w11-v6mr20769273wrs.87.1529569990995;
        Thu, 21 Jun 2018 01:33:10 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-1-7080-22.w90-116.abo.wanadoo.fr. [90.116.249.22])
        by smtp.gmail.com with ESMTPSA id r123-v6sm6062754wmb.21.2018.06.21.01.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 01:33:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 2/3] powerpc: dts: use 'atmel' as at24 manufacturer for kmcent2
Date:   Thu, 21 Jun 2018 10:33:04 +0200
Message-Id: <20180621083305.5322-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621083305.5322-1-brgl@bgdev.pl>
References: <20180621083305.5322-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using compatible strings without the <manufacturer> part for at24 is
now deprecated. Use a correct 'atmel,<model>' value.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/powerpc/boot/dts/fsl/kmcent2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/kmcent2.dts b/arch/powerpc/boot/dts/fsl/kmcent2.dts
index 5922c1ea0e96..3094df05f5ea 100644
--- a/arch/powerpc/boot/dts/fsl/kmcent2.dts
+++ b/arch/powerpc/boot/dts/fsl/kmcent2.dts
@@ -130,7 +130,7 @@
 					#size-cells = <0>;
 
 					eeprom@54 {
-						compatible = "24c02";
+						compatible = "atmel,24c02";
 						reg = <0x54>;
 						pagesize = <2>;
 						read-only;
-- 
2.17.1

