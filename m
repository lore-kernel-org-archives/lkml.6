Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rwLLMg8GG1uZOQAAmS7hNA
	; Fri, 08 Jun 2018 22:41:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B6102607E7; Fri,  8 Jun 2018 22:41:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XO7TR5tr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 23F55602FC;
	Fri,  8 Jun 2018 22:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23F55602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeFHWlO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 18:41:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41915 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeFHWlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 18:41:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so7307107pff.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7qNzeVCA2b4p9JFm1T0oHGDGDmG0QquKl+EvEGO//eA=;
        b=XO7TR5trol2sLbQcNAbRkPar80qWaXC7YwdPIDRw6XcRzmbhiJOzd6XKATqJ8kQBOk
         skYLAaFIBD1ufWAa0L4xwmSnP+u9prgVyX4Am5rGnNxvJNc43GO3OiXhqxSttW0oaxM3
         irnKxGe3Pz6CEd03l08Cmkm/Eac6BYKhhiwgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7qNzeVCA2b4p9JFm1T0oHGDGDmG0QquKl+EvEGO//eA=;
        b=re+zpFY/3FIkU2qw1N7EsqhKRxyEdFNS5+i5Lzbv5id8OWrCBp1nCh9UciJIsdAWkd
         jTjqwRfJFcED35rtwkUh+ZPgRbBU7KdXzULy/DAVY27ZjWQlQ5T+0W48MokLZkWYysub
         M0h30qHm1/RtAumKbcJKRgPeo+epGCLFmeSJQx1QrYvhrNE4p4u4XmazSfdROmGNri3G
         TllEmT3X6lBdLMd+y2gt2AI+CjL8C/B9GlcPMDncYgJdbSRBPPozcThZJe3St/oZ3sdp
         BRjl+nqzAmAmj1YXa0Is4KhDJuayj1ZCtYU9j4KpfbYnB2OX33F9GHqXO0JPHdaWel88
         XL2A==
X-Gm-Message-State: APt69E0aecXXWQRtsFd63uJrfMv7F/wL8cngO4JFq3ic9pUGnrE+Wbhy
        L3Aw+3RtwU1BCad3iygAes54Ug==
X-Google-Smtp-Source: ADUXVKI00cBlgs2zfggGLPVwehhjhyuDE2s9Zk/GaGD6mY6Fwf3clBRtLeXiQxnbADR8Rea/KURxdQ==
X-Received: by 2002:a62:f0d:: with SMTP id x13-v6mr7826875pfi.100.1528497664122;
        Fri, 08 Jun 2018 15:41:04 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id g4-v6sm61164550pfg.38.2018.06.08.15.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:41:02 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>,
        Phil Reid <preid@electromag.com.au>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 2/2] dt-bindings: power: sbs-battery: re-document "ti,bq20z75"
Date: Fri,  8 Jun 2018 15:36:55 -0700
Message-Id: <20180608223655.33565-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180608223655.33565-1-briannorris@chromium.org>
References: <20180608223655.33565-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This compatible property was documented before the driver was renamed to
"SBS" (see commit e57f1b68c406 ("devicetree-bindings: Propagate
bq20z75->sbs rename to dt bindings")). The driver has continued to
support this property as an alternative to "sbs,sbs-battery", and
because we've noticed there are some lingering TI specifics (in the
manufacturer-specific portion of the SBS spec), we'd like to start using
this property again to differentiate.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Rhyland Klein <rklein@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2: add Rhyland's Acked-by
v3: no change
v4: add Rob's Reviewed-by
---
 .../devicetree/bindings/power/supply/sbs_sbs-battery.txt        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index c40e8926facf..a7a9c3366f82 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -2,7 +2,7 @@ SBS sbs-battery
 ~~~~~~~~~~
 
 Required properties :
- - compatible : "sbs,sbs-battery"
+ - compatible : "sbs,sbs-battery" or "ti,bq20z75"
 
 Optional properties :
  - sbs,i2c-retry-count : The number of times to retry i2c transactions on i2c
-- 
2.18.0.rc1.242.g61856ae69a-goog
