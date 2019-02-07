Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD5C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A620A2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRsmHZv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfBGLSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:18:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37674 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfBGLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:17:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so6231345wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oBG4BBi2BLLQTeAw9jQ6rQjuF426ty7AkYNuZtLk2uo=;
        b=uRsmHZv0TbTfk4zGNg8tlluG9ARjmXRJZWvXuG13K9GjIPmz9A9OiH2TflgVzbkTVI
         0mMYhUwb46o2JoMSMCop8Qd4xIBcNq5kevqPlpnqFDANRgDY/BL83AVESLYa0RHT+qxx
         4jELlqQZMF2PTllBFB34EUMkQarHCbemPmYwnviAc3fv7i3gvxb48klYni1pVBVK2Q9s
         GjYQZZZvqyWmlKBl54f1E8VyJHzmAYzXmTmsUfKxgJgScuSIrKWsih6WVvkt7GU6zu2e
         R0IQZxa5qhNMWjTFxChMIalG2ZyXbiQ7b6R+GnkbowYo8JzuVmzG0exl56gaSHga7uXj
         cqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oBG4BBi2BLLQTeAw9jQ6rQjuF426ty7AkYNuZtLk2uo=;
        b=hULO3scM3BvyWdMC4f0c0fHG6kAqudhri1cWMNsUgZKCuQx8bBGFDNUSYGEZ/wShDG
         znue8ykwJYLeevGaEdYdjXSy78F+nYiINNGZ61DRb8yLYwrhlRCux5zMMHr2VE9bnpLM
         wObi29bCJg2Cnnms5jUImagzSsX6xoS1q7QYrq3UUzW7DVslVNP0RW+S1Dd7aOHEq3QA
         NBu2/VtYODjvrX9NTbiPUSCBgjptf/9onf6lci/LcQUfzEBlfi8+L2tvuh4zd6ErW59U
         sBVIZ+6zjCIWhUpTnthaaP9W8sCJR/Yr6jsxF9STu9FbMXfJ1chciD2hxRhRSIAvmrmd
         84uA==
X-Gm-Message-State: AHQUAuZdPc8hNOHigpNQVkRw5bHxscSL/+zzNhlQg0gwT9Zozu2BVugu
        TOMctKAVJPOxquqPO7giJ3+fKg==
X-Google-Smtp-Source: AHgI3IYz6fvDsk2uDQ/EKC5vtERIuM9VvaoPjN7OBXn8QhqpzzUNAzIDc2kxjwxx7fZ/RjCVppQLNQ==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr6721438wmj.129.1549538262631;
        Thu, 07 Feb 2019 03:17:42 -0800 (PST)
Received: from localhost.localdomain (42.red-95-121-90.dynamicip.rima-tde.net. [95.121.90.42])
        by smtp.gmail.com with ESMTPSA id a62sm24490224wmf.47.2019.02.07.03.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 03:17:42 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh@kernel.org,
        bjorn.andersson@linaro.org
Cc:     swboyd@chromium.org, andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khasim.mohammed@linaro.org
Subject: [PATCH v4 2/4] dt-bindings: connector: Add vbus-supply property
Date:   Thu,  7 Feb 2019 12:17:32 +0100
Message-Id: <20190207111734.24171-3-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some phys might need to control their VBUS regulators while not being
supplied by them. If such support is required, use the vbus-supply
property in the connector to retrieve the regulator.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 Documentation/devicetree/bindings/connector/usb-connector.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
index a9a2f2fc44f2..2ad22dd6dc39 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.txt
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -16,6 +16,10 @@ Optional properties:
   non-fullsize connectors: "mini", "micro".
 - self-powered: Set this property if the usb device that has its own power
   source.
+- vbus-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator VBUS supply node. Set this property if
+		 the connector is supplied by VBUS.
 
 Optional properties for usb-c-connector:
 - power-role: should be one of "source", "sink" or "dual"(DRP) if typec
-- 
2.20.1

