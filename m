Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A091C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31C620869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz2XI+1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31C620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeJPK1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:27:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35619 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJPK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so10083722pgb.2;
        Mon, 15 Oct 2018 19:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
        b=Pz2XI+1ObqUZo1ImYBBq3zxgz48Xj61KFjDE8Byrv/fwDR3xsoNnKThcXWQ7CVJelA
         /zoexFsTfJsm4xS7+UPjlEqibbPlFZNm7i0uVfZQQVvbpgvIhAcoCENWsQ7V9W4Swrxd
         W7l549iqzGALxPUDBWQ3EH27cX467WAUPOHSSPaAqGw44o+7qo23a44cdcdr6CYIhd08
         4b8Xr/AIskYHMU5neqoxKBK1qj4Ab5sQsijSqgVOfbQEKD62oxPSZSpqLqs0raJ52zay
         pTey4Iu1LmYkZe+QctnvuNNlCW+C5nBYTGAEDM3HDqemNmynH0evHZIpaXWFfGjoEZ8l
         ffew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
        b=PgTyOk44qAUPDjM/Z42h4QySTjFmtx0tBZZKxh0j1OLsjf3AljIeRc/TdEdg2WcQoE
         Bt49vFNdmqiic9GsvCu1gIv5/ZZVcm9KjzxEH64YSw8ykl44OOioM2HjCjB69z9i3u4+
         6VKwqkGNQzunVTrXYTcmjnRGS/DXYqcZiPvF7ZbFsoouxKdKmZvRndgA8wBE51FplgOg
         CpS/GHUDfDVZV7U2sbXMqiieyV9gQRblCAbd0NWAQTcn8nhS00iObBL43SvrxGHNDTye
         Mwl5VlO5mpay9rxuYgEE0ZGgxdvN3rRwOBea0nFl27c9jO0OBrBVU6cs7CHO6ZH+0aWj
         gyTg==
X-Gm-Message-State: ABuFfohAnjw8w+rvyrqgq0qKK33sQh8g0tZ6HnEgC09SmEVlY1couSqA
        +q+w3v42tNjG2SOkz3r8wcgeWa6g
X-Google-Smtp-Source: ACcGV60K/M9+CikvdZOPwFw1Q5QCpd7ylyYXwlW3XonkKatKXmbeVjH6iLN3brTXbGrFHskcBfrN6g==
X-Received: by 2002:a63:7d43:: with SMTP id m3-v6mr18490443pgn.341.1539657558952;
        Mon, 15 Oct 2018 19:39:18 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:18 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 06/18] of: overlay: do not duplicate properties from overlay for new nodes
Date:   Mon, 15 Oct 2018 19:37:26 -0700
Message-Id: <1539657458-24401-7-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

When allocating a new node, add_changeset_node() was duplicating the
properties from the respective node in the overlay instead of
allocating a node with no properties.

When this patch is applied the errors reported by the devictree
unittest from patch "of: overlay: add tests to validate kfrees from
overlay removal" will no longer occur.  These error messages are of
the form:

   "OF: ERROR: ..."

and the unittest results will change from:

   ### dt-test ### end of unittest - 203 passed, 7 failed

to

   ### dt-test ### end of unittest - 210 passed, 0 failed

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 94740f4ee34c..7fcf4a812d06 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -393,7 +393,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			break;
 
 	if (!tchild) {
-		tchild = __of_node_dup(node, node_kbasename);
+		tchild = __of_node_dup(NULL, node_kbasename);
 		if (!tchild)
 			return -ENOMEM;
 
-- 
Frank Rowand <frank.rowand@sony.com>

