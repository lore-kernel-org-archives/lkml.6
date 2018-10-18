Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9BEC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020222098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYzGiZ6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020222098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJSGwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:52:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42313 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeJSGv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:51:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id c8-v6so14942164plo.9;
        Thu, 18 Oct 2018 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WBVPhuC+zMp4YeMuLIQWeeUK2AnKgXRkOXabRgJfDhs=;
        b=WYzGiZ6+71Q/6yybAIoFn0lP4kJzCAtD55YJC7Ql7UrdDpNRMzEFH1BY7ytARk0kjX
         P9QKrWdbz9vMZjAPcR6OIYg6jtjlsScBgasC24VYJqYr84L2DraTktfSmMNHiORD58U+
         BdzBbciH1xW7cucv4/PGbXfhHqr6uzwdFxQjOop41/WihY5Bl8ZRrKAdk+qlZTZrZ0Ye
         UBOhhL6ih6foDhLx8D5n+L2n2H6fwh7gEof3PwzAfwICLd5237M0j470gSsVUxgI5rVR
         ChOg+g72hTCTMNh24umGoeVQY8ZF8nxcA8Gpc0K7y+yAf5fy4AnDjYvXbmWcxoCqNYQX
         4iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WBVPhuC+zMp4YeMuLIQWeeUK2AnKgXRkOXabRgJfDhs=;
        b=mDCFi8KBkmQlpX+o/P2SlSbBVZxYJAOf/R09Wen/Hw06Naw7EPV4BQ0xtJbtFLpNEz
         VGeTFTYgFkXyYHfjvN7iXYMkL1qoMIeufEMlnITkYN8w4zaTHH0gzJMCwwp94nqdsdDb
         45cWFUfXAZvfffT5CUt8J/ao1kANo63oDVrYTLojfRQx8CpgFnyp+SpTWcEIk41IyBeV
         rPflYSE5ncWRbKoG579NFZJiPBE6jQ+ueGXcIPpVn9QSHGZ9dRg26HOu+jdwWt4z1qPD
         FOOTihct0eB9lsk5QNkSObr8+GMyZV+THZ5WMioQjMZNYXyJCkXxa2qcqYtn6hDEyAd2
         oHlg==
X-Gm-Message-State: ABuFfogocKkt6kNUXqS3FpioXjYuB6MfWTjR5oD0cWsn6JHZZ32DUQjn
        ewYCc5HO1GweTpMcKAe6Eic=
X-Google-Smtp-Source: ACcGV63FmqZ3lNg59HzFPmxp5L7bb+yogsba4sl3oTD0lPRzi4cxxvvpPC0EPUswLzau2Gw9vRPk4Q==
X-Received: by 2002:a17:902:a9c5:: with SMTP id b5-v6mr27940369plr.340.1539902896647;
        Thu, 18 Oct 2018 15:48:16 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:48:16 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v5 10/18] of: overlay: make all pr_debug() and pr_err() messages unique
Date:   Thu, 18 Oct 2018 15:46:28 -0700
Message-Id: <1539902796-8382-11-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Make overlay.c debug and error messages unique so that they can be
unambiguously found by grep.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index e20d8923f475..88e346234ae7 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -507,7 +507,7 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 	for_each_property_of_node(overlay_symbols_node, prop) {
 		ret = add_changeset_property(ovcs, target, prop, 1);
 		if (ret) {
-			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
+			pr_debug("Failed to apply symbols prop @%pOF/%s, err=%d\n",
 				 target->np, prop->name, ret);
 			return ret;
 		}
@@ -551,7 +551,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_next_level(ovcs, &target,
 						 fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -564,7 +565,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_symbols_node(ovcs, &target,
 						   fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("symbols fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -873,7 +875,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 
 	ret = __of_changeset_apply_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay apply changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
@@ -1132,7 +1134,7 @@ int of_overlay_remove(int *ovcs_id)
 
 	ret = __of_changeset_revert_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay remove changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	*ovcs_id = 0;
-- 
Frank Rowand <frank.rowand@sony.com>

