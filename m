Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C191EC46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5182147E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB1up3UP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5182147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbeHBKdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:33:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44875 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeHBKdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:33:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so807022pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=onxrZC2lcOIMrbQCqvJ5HNoaXo2Tg/ND8y+h2EPTHdg=;
        b=gB1up3UPLlg7b7apDAbE7/aJHhLAoBIjLjmUVvAQeVh84HgPTEtqsmBRnFjIYr4Raz
         s17WPXEPg7NNJYHq4K9eYeUBHTu+QV4X//FnE0/+mLIfB6xAmIJnkr/Ykwudc0zycJfv
         cEQmBr3uuUL1yqMUDRRO8bCfJuG7izoW3ptvb+jJ7a24GQ7/JdwIdTbQtJolevlILO2x
         5sCnXhp0Y8Psx3x43qEiC3LeH9rYSJ/qWQPIE8Bz/3dYy1iua+kkTPej2Q72/b4ciQ6o
         1CXGQgfQdxnmNGj8ExS7/kZSDu3wZP3SI6u/ELlhtYyqIxJl2mHpJRD1GPB3X6C9MSQ5
         6X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=onxrZC2lcOIMrbQCqvJ5HNoaXo2Tg/ND8y+h2EPTHdg=;
        b=VIZ7UP+x/OvMLrJ0UJ8a5MKFoSNyHHcyYEWRMDAQfLhojIuo8Du/zyVcX1mAVjlHBD
         jSGFLLT8PXSU67ekdIZ6g/fA8FLT4s/No1aK1bww3npZ8SH8dz1o+eoIBY3RORfYxpVb
         zU4BI4Lodv1taqM0Wf+nFkeM8lLVGDMvZ+GSepAXepNAC44tC6/UE6KkQENmAy6RRe8G
         QltV8Ki2GHjkdY/lPaPIiA9HrAsMmMFQKE/WRapsHSrZFOAHosJEp2pNQfsFVeDzhzV6
         vWaVh6s4QlGta5Q/1oYvLB1ev75pNfWJnkpzgnjLOzGbz+jMloCykzWLqTAgfyLie9lM
         2SVg==
X-Gm-Message-State: AOUpUlE8Pam8Ch81vdZG1MvPc9PY78l3y6t0EO8+zkU+4xu3ZUdkYp/p
        XqLSydpzLbL4axUJNtwEkc0=
X-Google-Smtp-Source: AAOMgpc2kw4UQZFjbnp3ooZlGhC2dkhTvOXFAB/36gZ2c1HdqRmngKZgEFnN3++tnae/M1lU+fmkPQ==
X-Received: by 2002:a63:c902:: with SMTP id o2-v6mr1840606pgg.118.1533199388719;
        Thu, 02 Aug 2018 01:43:08 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2128397pfl.156.2018.08.02.01.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:43:08 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 8/8] Revert "staging: gasket: core: hold reference to pci_dev while used"
Date:   Thu,  2 Aug 2018 01:42:45 -0700
Message-Id: <20180802084245.239689-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180802084245.239689-1-toddpoynor@gmail.com>
References: <20180802084245.239689-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

There's no need to take an additional reference on the pci_dev structure
for the pointer copy saved in gasket data structures.

This reverts commit 8dd8a48b9a7dae5493494a8603adddfdf1914716.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 99994e30b154b..8c5574305f13b 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -253,7 +253,6 @@ static void gasket_free_dev(struct gasket_dev *gasket_dev)
 	internal_desc->devs[gasket_dev->dev_idx] = NULL;
 	mutex_unlock(&internal_desc->mutex);
 	put_device(gasket_dev->dev);
-	pci_dev_put(gasket_dev->pci_dev);
 	kfree(gasket_dev);
 }
 
@@ -1475,7 +1474,7 @@ static int gasket_pci_probe(struct pci_dev *pci_dev,
 	ret = gasket_alloc_dev(internal_desc, parent, &gasket_dev, kobj_name);
 	if (ret)
 		return ret;
-	gasket_dev->pci_dev = pci_dev_get(pci_dev);
+	gasket_dev->pci_dev = pci_dev;
 	if (IS_ERR_OR_NULL(gasket_dev->dev_info.device)) {
 		pr_err("gasket: Cannot create %s device %s [ret = %ld]\n",
 		       driver_desc->name, gasket_dev->dev_info.name,
-- 
2.18.0.597.ga71716f1ad-goog

