Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB7FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF542177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dPmv2FfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfBSKQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:16:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39431 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfBSKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:16:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so10033514pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ybvRK6PwI6dB00OCQbIKqNRM5TMInYmAEtubVRW5xbw=;
        b=dPmv2FfF8o3VJWuFYMHm2yr1vGewOFGUt1WOtpNyzNtsH1q9DCGodssXcRmMYlfhLG
         6P5N/7qeIbfOQqp9I296fSDi2yyOTyYDHazAmzdblI5KAeY+kHnb6JXcglqpraddvYq1
         /5iN9xDrmTrdgQcI6QoBR1HRa7/995yGnwDts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybvRK6PwI6dB00OCQbIKqNRM5TMInYmAEtubVRW5xbw=;
        b=PAKjbc6AmpP4NUk60V+USSzgNqHNd6+vaJJGUAXuKnvApLQcJGFBnKQ4dayuShPslP
         DYHIsR/Ef3XUGDPVO9GcpUT5fTMJGCIGgB+pq1WrenY9klWT0fDmxYabb8dgEneM4TBJ
         KEef5eErcZBgDBKiGfyUvAsenrXVkeN7BJ3lI3G6Vc1xYqUl1dQNWGeihzPsV3EQP6wz
         AUtbcFd3JT+MVfGkB/6a8T4lhMmzHmM7oP68dNEH4253hag+7YSoQ4G1TRexqMSwdfnn
         4IjgsVe5SQQzZO8vPZEcFF9G3RtYzn0v7BVTaF8bwIttq5RgyFxz2y5U0Qj+muUJj1Eu
         OfiQ==
X-Gm-Message-State: AHQUAuYzcXFes8sC16NIGjRnsC8Rgef8K0NTXnAhT6bRAKxG483x12JG
        CkMC4uVZtaZRBpt793pgJHU6fw==
X-Google-Smtp-Source: AHgI3IbjWyR6rKpPzwgrUebdFkpuronj/o8271Mom9dxP1UQwJo6JkyqBjHsblgJxLYtzxKXgED46g==
X-Received: by 2002:a63:1a0d:: with SMTP id a13mr23208738pga.202.1550571415942;
        Tue, 19 Feb 2019 02:16:55 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id g10sm21324011pgo.64.2019.02.19.02.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:16:55 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 3/4] dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
Date:   Tue, 19 Feb 2019 15:46:28 +0530
Message-Id: <20190219101629.15977-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190219101629.15977-1-jagan@amarulasolutions.com>
References: <20190219101629.15977-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GT5663 is capacitive touch controller with customized smart
wakeup gestures, it support chipdata which is similar to
existing GT1151 and require AVDD28 supply for some boards.

Document the compatible for the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index b9b8f196dc90..1dcae643427f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 Required properties:
 
  - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt5663"
 				 or "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
-- 
2.18.0.321.gffc6fa0e3

