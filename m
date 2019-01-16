Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3980FC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061972086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e8iQNiQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbfAPUO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:14:57 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40350 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732365AbfAPUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:14:56 -0500
Received: by mail-yw1-f65.google.com with SMTP id g194so2928723ywe.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bPjBy59K4hCzODQ+3TXNaK5jB6A30bX7T9519H++o4I=;
        b=e8iQNiQnREBcjKcRolIBb1fUMq4l8wqAv1dKo5698KeQPOXYop7YrmNS3HZRxIChKm
         3oEdEaKDj6JD4ShxZZZ9t3iqHDd5NOgXyxO5LQL8k0r7SmPPt4qjlEutm9muLJL7Hmyf
         vs3xQXionnuWEnsSYsDfOA2r9u0G+CY1lEfgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bPjBy59K4hCzODQ+3TXNaK5jB6A30bX7T9519H++o4I=;
        b=LKlfCYti0Kd2/2ClFOxqikwcL0f3ZGbqIr5XS4ToPjUj5cVo0SnunVMJ5CpNMaDyE2
         s5HCHfOXd5Iwdw2Vda81H/KydblzWWwoYhgF4WqEAXFWMFW0bPJJkDP1s10C8j4EODAH
         j8xf/m835N+ExmjfVVhBCBJe0iNYwfHuyfVV9hz0bzT4KFx+3DmpdcyyiE7nYY+RrMst
         ceEteMHP7wCe1O0Ocy6bCZzqFbzEuE16WRslwDp3oDVZqWPQDpVMYYJ06HvYqdYEGYwR
         Fg98aicKXTAckUfi3mTSU0CHDcBUmyvJeLOBueZYe+8CcLNiHtqPu36QVHC+rh19oVZ3
         oBgQ==
X-Gm-Message-State: AJcUukdI6fvtSaYgpen5zQ8mtp2YfPoMCxy1W/iUsJCuk/YIGJeDdxEP
        Q7Lxud3mOaJZD3PUx3EmtIJzoQ==
X-Google-Smtp-Source: ALg8bN6HhgjIeh8OK1IH2cHwkN+oA9mADWA/GUvUoGHhlvEBeA6MXO0aj8+uvt14uejadgxtDsfYEQ==
X-Received: by 2002:a0d:fcc6:: with SMTP id m189mr9667909ywf.71.1547669695705;
        Wed, 16 Jan 2019 12:14:55 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w63sm2541026ywc.46.2019.01.16.12.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 12:14:55 -0800 (PST)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V2 1/4] dt-bindings: pwm: kona: Add new compatible for new version pwm-cygnus
Date:   Thu, 17 Jan 2019 01:45:13 +0530
Message-Id: <1547669716-20070-2-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Add new compatible string for new version pwm-cygnus

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
index 8eae9fe..b224142 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
@@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
 This controller has 6 channels.
 
 Required Properties :
-- compatible: should contain "brcm,kona-pwm"
+- compatible: should contain "brcm,kona-pwm" or "brcm,cygnus-pwm"
 - reg: physical base address and length of the controller's registers
 - clocks: phandle + clock specifier pair for the external clock
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a
-- 
1.9.1

