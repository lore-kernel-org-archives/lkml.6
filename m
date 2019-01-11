Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF886C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC5020872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ps8hgp9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfAKFVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:21:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41244 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfAKFVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:21:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so6230280plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 21:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yd4M+CUErpLCr3c/0+nYCFyarZVesvGUD1M9BF/zec4=;
        b=Ps8hgp9KQELNTG1W1mrwKJ3flExA2lNI26ytiNvhzBXzgwS6wNgwmjBLCGuWHlbL37
         zBdKXfCrnBZrLA1wbv4QpFYt0pITMjTvB4Ig42TUUs6MbpD6xsy2zWJBdv1QCjnu30iO
         8JsqLylacKIcSI4yPiVNt1QbQD8w14GK/HZlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yd4M+CUErpLCr3c/0+nYCFyarZVesvGUD1M9BF/zec4=;
        b=oiRrv++ZMu3sT3emKv0f2sNUniRi8AeZ3f65n3C69RY5MpcrFmwDCGU/M9R2s0iyu3
         kb3Lmwd5+tYlUzO2K9jEYA3ejCpHMi1sD81sId33JKhG+g3HzLw1ccOUDF3QiMSpetD3
         YwdUvPxvSDYB89SbnpagGH/TNPQgCEg5E+ilbwaf4h55bAfAIZ2hcOdns+NX827w4Nr3
         oIsDPgAgNF3SGL9v8YgrGr5WbiIDc44sr6+dpvw5UFqL85YZWFQ3A8sKkKZeJOkRjmCx
         x73CHC8004CYGt6d1zIvQNZvxVL/SO5KpLBnOvbVB83KU3s5aIarUQILIVa6XG9ld/Cq
         8Z/w==
X-Gm-Message-State: AJcUukcKrLDtWBw35gHowa1zbZs/61AhD7ZAL+O90WcN2p/0vHc5JnYR
        O96tDNJw28bzW4ERsk5DHScRqQ==
X-Google-Smtp-Source: ALg8bN4QGefj7NR/MPTsSMJLmH5z3WSsQE9axJGSg+690Oc4ppwgjnjqr/yLogVMcJdLniGqWRFOJA==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91mr13509426pld.18.1547184078787;
        Thu, 10 Jan 2019 21:21:18 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 186sm148425418pga.36.2019.01.10.21.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 21:21:18 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new version pwm-kona
Date:   Fri, 11 Jan 2019 10:51:14 +0530
Message-Id: <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
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

