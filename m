Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B80C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B691420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UIAJ6nNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfAKFHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:07:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35070 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfAKFHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:07:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so6398391pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 21:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yd4M+CUErpLCr3c/0+nYCFyarZVesvGUD1M9BF/zec4=;
        b=UIAJ6nNZon2Q2BL4+fRnjF0DSEqrmbySw11dEkZySZhoQ+RTUdFhgHcnXCWqlOfW5E
         GDuGolFppJbkfrD9KRwTrMGpMJidGgSfk4hYh/tQZM2Yeqz3d3WPP8zOQtBqU1PWr8VQ
         uKUis2EZKbD4r8J4ad3nbO5l4hX9HQsXrcfms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yd4M+CUErpLCr3c/0+nYCFyarZVesvGUD1M9BF/zec4=;
        b=m4hXnQjhQWsG59uCiTNBVoExWPjsvwx7p0rsWrpa3CIy57pSowFlzK2sAzzur4Nykx
         d8J5NygECn0+J7bBjIRm6+BCKFZ1Y8hziC+4ibakTLUcBipnjpcv5OYRKVp5WTzs1oy3
         Gh3ugJKtsVknB8C9mOah7OQpEl3+mPJEQGtizH6GIkVCFpYVpzVk1wC6R2k1mUzakdu4
         5CBS4JIugHpD9EwFv/L0eaDxtIMVr0A5iqiOFsmd/1PsOf3FhAv8GYVphULfpTlRYgbv
         in1BCXnSH23nWQPIuJWlmoKX61HA8plLNv2lAxaYTpUfCcHXpUX6iFLVGwrT5UgJ5ivn
         8k3A==
X-Gm-Message-State: AJcUukeumE/WtCYTxYWz/Dv/KSk9ycCuVOjyMk6cueE6zjVqDWtkZmJv
        Z/jWTQEvxxCTpiNwl1+ZbOWtAw==
X-Google-Smtp-Source: ALg8bN7KaMYq0qDx2S8gRKglTIAQ+C1QlM0w7SWkpXQQG2VN6Yf061iWus0L2pVnb3FcLVei/ShJNQ==
X-Received: by 2002:a62:6ac8:: with SMTP id f191mr12937290pfc.13.1547183267128;
        Thu, 10 Jan 2019 21:07:47 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d6sm107520893pgc.89.2019.01.10.21.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 21:07:46 -0800 (PST)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH INTERNAL V3 1/3] dt-bindings: pwm: kona: Add new compatible for new version pwm-kona
Date:   Fri, 11 Jan 2019 10:38:02 +0530
Message-Id: <1547183284-19956-2-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Add new compatible string for new version of pwm-kona

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
index 8eae9fe..d37f697 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
@@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
 This controller has 6 channels.
 
 Required Properties :
-- compatible: should contain "brcm,kona-pwm"
+- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"
 - reg: physical base address and length of the controller's registers
 - clocks: phandle + clock specifier pair for the external clock
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a
-- 
1.9.1

