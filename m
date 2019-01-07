Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6800C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961882085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih4XoQZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfAGSyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:54:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40595 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfAGSyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:54:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so1077445lfe.7;
        Mon, 07 Jan 2019 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/MiFsFGxkATaKSohAbLvhLUzl5KdlriZpggnL4SZpos=;
        b=Ih4XoQZxHUGN1rypAdEa0zF7Ux6jV0VUOslQNrC/pk+uUVtF+auHbG7Tsxwv55kf2m
         m2iTpffFMAAsY7PEq8z5m689Ph0CdUD6LTrPdSoccZgePeody1kt4MEXEonkNm9ilibt
         4xuZUfooFza+KP1jd0WcbwrADVX8JFKOd13KmSlyC8ISwnLbdPq3RFnO5FvlPja/lTmf
         cmz0IYqcAIBFOkeREpetXhHyYlnuQZg5MMTX+678mytKmZHJWN0+YRckVZrJeMKm8tRm
         jV5Pr1cK6MqcpJslHuHLvaw7BZrIWHh7BzLixhZkbES2KFD+oKp2yNg/27vYfXEtItno
         31Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/MiFsFGxkATaKSohAbLvhLUzl5KdlriZpggnL4SZpos=;
        b=UfzMm0WO7OsLmCnA5AEE+TdUYzwxyUTlMReliWfVF5mpNI8/IcHy+SImp8bfKaioDy
         6mB44/GxRMpyuyxpdSbLh7jIz5Qv24gAk5Hws8Mh9I/Cwxd7qXi18LphY7dTc3xjvis2
         7ecssMlNq+vYuh83LbTX/8lTBmSAgEHUURgskh6UBRFghawrGcD6EJeDZTLB1U3WpEyL
         iOt/cH0c4KUJYYSLWV/LoLkWTVbs7dSahIvp95FdCR37Uhngmuwyn0iD73hXce1l0KTf
         V0dg13qfgX9i23gU1N0TiPQS7m4gvH86EeqWAXK3DQ38Ac6hly4FCubwA6GEoWHqdggR
         ImDg==
X-Gm-Message-State: AA+aEWaTJSxht6AqDv37HUepJlpztbxVwxKvRfVIPh2hSrXRvmzzosnn
        ctX4OUq7pAXqfgAWqqfD8fA=
X-Google-Smtp-Source: AFSGD/XjR0D7IOEvwqPXopBEC64JE6jDaNXu2IWK+m4qAi6NcZlu47BYeDTudNwq3mKjGaqHHvOL9Q==
X-Received: by 2002:a19:9508:: with SMTP id x8mr32213693lfd.112.1546887248599;
        Mon, 07 Jan 2019 10:54:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:c050:d453:6c2:1d01])
        by smtp.googlemail.com with ESMTPSA id h203sm12825007lfe.44.2019.01.07.10.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:54:08 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v3 2/7] Input: dt-bindings: tm2-touchkey: Add support for midas touchkey
Date:   Mon,  7 Jan 2019 19:53:41 +0100
Message-Id: <20190107185346.30184-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
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

