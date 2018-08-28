Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19FFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63112208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63112208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeH1FoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40555 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeH1FoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:10 -0400
Received: by mail-oi0-f67.google.com with SMTP id l202-v6so7665oig.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Itk664lmdbNctR5SZGyB6I+/yMedxOONGllCxQrvwks=;
        b=IkUyRzye5xvdC9RG+qd0nt3m6E70FruDW076x96xaDkJbI0UhlXqqRyA19qvEVggeL
         h3Sgg1XYnv9LhrHC8BvHnw3pqatK/0QkrE9iUmIrG8H6jas0rH2jMzUAZ1zJqgy0Ab7R
         dxP4YpfaM1M19qNAjqiUMrzYTXvSQx4Nw5id7tsclulcmGLDJ/K60Rx9nfARqnGCh8sq
         giaHc1A01JkGcpbYh1BNP3DGHi9XXhRGylt9TJDH+IYttKTj+mg1AEenw3ESbiTHn6+T
         RI4bx35x6H+mKRIxmTb3Oxm1EmoBvQaY2jSW7IzsrpST+HQkm9r1XoOdBSYXti9HdSFl
         j/QQ==
X-Gm-Message-State: APzg51Cx1UXpehXudowqGOjC5KB1WYHyjcrLzPl9LPjxUeGCz00ETVq8
        xhxZd2SiEH3+o5/tYyluir34F2Y=
X-Google-Smtp-Source: ANB0Vdb5brGWdGXtDqSvEGcG9IFBxWEfR3RWDqSOfWZaY8P79LlWa6THH8c0Wecm2LBB4rZQpyiqNA==
X-Received: by 2002:aca:4e50:: with SMTP id c77-v6mr1020769oib.254.1535421293719;
        Mon, 27 Aug 2018 18:54:53 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:54:52 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH] mailbox: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:28 -0500
Message-Id: <20180828015252.28511-27-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mailbox/ti-msgmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 5bceafbf6699..713d701b6568 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -560,8 +560,8 @@ static struct mbox_chan *ti_msgmgr_of_xlate(struct mbox_controller *mbox,
 	}
 
 err:
-	dev_err(inst->dev, "Queue ID %d, Proxy ID %d is wrong on %s\n",
-		req_qid, req_pid, p->np->name);
+	dev_err(inst->dev, "Queue ID %d, Proxy ID %d is wrong on %pOFn\n",
+		req_qid, req_pid, p->np);
 	return ERR_PTR(-ENOENT);
 }
 
-- 
2.17.1

