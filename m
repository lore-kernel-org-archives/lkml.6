Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A7C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B53218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T60o4cA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfAXXW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:22:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36353 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbfAXXWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:22:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so3784320pfc.3;
        Thu, 24 Jan 2019 15:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fT4h6oqWEOPvndp8+AEJcxPnPDZPV1abg43E3tyKnHE=;
        b=T60o4cA1K/rSoooGjZxnp3kFjENsibGPTXssolDYgxfdRW2KwtnmHSEvfd//dstva7
         AKWYpJR6/+iHKNX+qf2AYWhE12MQCnp5iaieg5sOS7UMAqk0Ia1E8wdx69JrYT0t9BJm
         xut5bJLlLOpZou1DEKnosVAKoqMR5cGMR49c7soOLZFttGOE2sjBbR+3ownIz71jkDFH
         i5Fu6qaKQPW0f2YP6a6HepIEtAWQ/NrYTRLbjamZ6bKk1EFeGWXtk3xS1mIqn7vFUOvK
         mxUhGKRLobCVOfStqzg7x0ps/0lR6PV5YbovId9Y6mt8P2/hbfaW8holx4FeBdft1T66
         c6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fT4h6oqWEOPvndp8+AEJcxPnPDZPV1abg43E3tyKnHE=;
        b=F4zAliaonWyuT4G9DaN0hRsx5j36Pg7BVymYCE2I6D7VNYh/IKstnb2jKoc0yFwvl9
         cmI3tpHbKDM7gJ/bgGwtbPfsa05kaB2PHVkvUxxIIuaEWCILiVFzgJnRawpL5pk5MPm6
         3lZV0py/icvt2Tx/MbQFeJhPCsnBgy88qy3yYNoeysbNo7sKhD3BN35dc4HkZ58TJg2Z
         mTB1A9rz2nTcJt3t8XW6p7Cct95U4BjawedqkIMFgSCllpNpxi57ZECtH8iPAek0d/SD
         fukPl9UHajhNlVF8GoQxr4vC6wJjslCyUjGppsgNAQVF/up7KZqeh8YZGUceWfsE4JUx
         WNJw==
X-Gm-Message-State: AJcUukfW7wUcRev0wuEyM//VzfNp0l2sZX+6vhucEj74FZlnyROnwOUM
        CEiw+PpiibPegBx11Tft+gg=
X-Google-Smtp-Source: ALg8bN7iN/salSAHrrxSyv6U7h4S/5uu4aVJX3J7ZvcuGpnm3PsQXAnH7DYfu+dZonPf1qMuKCm1xQ==
X-Received: by 2002:a63:5153:: with SMTP id r19mr7736931pgl.281.1548372172704;
        Thu, 24 Jan 2019 15:22:52 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id g15sm95216217pfj.131.2019.01.24.15.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 15:22:52 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] of: unittest: remove report of expected error
Date:   Thu, 24 Jan 2019 15:22:13 -0800
Message-Id: <1548372134-15729-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548372134-15729-1-git-send-email-frowand.list@gmail.com>
References: <1548372134-15729-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

update_node_properties() reports an error when the test data contains
a node (such as "/aliases") that already exists in the base devicetree.
The error is caused by of_fdt_unflatten_tree() autogenerating the
"name" property, thus both the existing node and the new node will
have a property with the same name.  Suppress reporting the known
error.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 84427384654d..3249fe259d30 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1116,9 +1116,12 @@ static void update_node_properties(struct device_node *np,
 	for (prop = np->properties; prop != NULL; prop = save_next) {
 		save_next = prop->next;
 		ret = of_add_property(dup, prop);
-		if (ret)
+		if (ret) {
+			if (ret == -EEXIST && !strcmp(prop->name, "name"))
+				continue;
 			pr_err("unittest internal error: unable to add testdata property %pOF/%s",
 			       np, prop->name);
+		}
 	}
 }
 
-- 
Frank Rowand <frank.rowand@sony.com>

