Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935C2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C6320879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBEsTFj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732955AbeL1PqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:46:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39171 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeL1PqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:46:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so19014320ljh.6;
        Fri, 28 Dec 2018 07:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/MiFsFGxkATaKSohAbLvhLUzl5KdlriZpggnL4SZpos=;
        b=QBEsTFj1Y0RrVTjpnYYTCEI/9zxEV2Sb8ho7kDc/lMKwzd9U1xHCE3pAJN6qiOE7nL
         qsl7UZEKYfqbhcGU89zJPFu1j3hs//kBS0GJ5xzd/GoeDOVFHlgN6kp82rNHH0ta9/sD
         Q3G48Vi9PhztXV+wRG1/EZvpF3EosXOU1J1EAayn+1vkeYbmz6VPZYGDzIFyqHOsK/3d
         DSbsJdhY3fAAAOyYkSyM2zGnALHgYwK5dNI/LM2jXrHNZKRe5BCxpOQf0YgNSnisEOUE
         w1lVjctGNIXhwmCQ6XxE4AOvZRb1nXhDJoexjj2Fgjh+QThEn16kI/atj+LZSH8SfHBD
         cpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/MiFsFGxkATaKSohAbLvhLUzl5KdlriZpggnL4SZpos=;
        b=PRp5qG/H+oxzMh71d91bT/z7rT5mrd+XyME3ykIcDX4cUsiqi0hPlzHlLE/vtmxtLv
         peq5uvXDbB7KbpXFgDHIQE9V+u8kui4TfH0lBTdxKLdpmzaJqEwhyazsft4oCCpnubat
         szQQiKvfIpP82LDMxXQMalcJXrSzfO7K6qgXIYucHpkgyhWNWUQvMO0MW9MfzR9uiHvn
         5AgXB52gYxQYFW9wqkWcq4KpPneLuFpGg2UqEf+ctBNlCNjaIqBlJhKUYQoGOkRKSWnt
         wvFunfmX5Cox+q+r9SaZt2nR0GyYvQARQ1oxaejG6ffQz/LxCV1PTHfqkzqILA/lqle5
         hIXg==
X-Gm-Message-State: AJcUukeNOjiMKMruRER9yfl9jOc12yhQxhpzmMxlMy0nCd6dpgIf3yop
        UW+1rygA5fdwBrPbveTl8wE=
X-Google-Smtp-Source: ALg8bN7oIx5CBqajAjlaA1ReWwhrnshBSALFIqRZRZybSjSz8LnJZNlbfSvtB3COw1yNw1JQmojhfA==
X-Received: by 2002:a2e:2b85:: with SMTP id r5-v6mr15862933ljr.91.1546011978429;
        Fri, 28 Dec 2018 07:46:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id c203sm8042444lfe.95.2018.12.28.07.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:46:17 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v2 2/7] Input: dt-bindings: tm2-touchkey: Add support for midas touchkey
Date:   Fri, 28 Dec 2018 16:46:04 +0100
Message-Id: <20181228154609.14846-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Shields <simon@lineageos.org>

Document compatible for midas touchkey.

Signed-off-by: Simon Shields <simon@lineageos.org>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v1:
  - Added Reviewed-by
---
 .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
index 0c252d9306da..dfb3b9f0ee40 100644
--- a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
+++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
@@ -1,7 +1,9 @@
 Samsung tm2-touchkey
 
 Required properties:
-- compatible: must be "cypress,tm2-touchkey"
+- compatible:
+    * "cypress,tm2-touchkey" - for the touchkey found on the tm2 board
+    * "cypress,midas-touchkey" - for the touchkey found on midas boards
 - reg: I2C address of the chip.
 - interrupts: interrupt to which the chip is connected (see interrupt
 	binding[0]).
-- 
2.17.1

