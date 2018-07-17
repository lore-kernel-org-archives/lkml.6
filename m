Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B334ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E383E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTvtQMtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E383E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbeGQVjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33142 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731245AbeGQVjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:20 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so999091plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCOFmLA1gK7VYup/osCyCBFC/ocd6npVJLY54eLqjXM=;
        b=iTvtQMtNNmRdz+MEGVe15sDpTGnobM/XYODm8WjZSXxzYTR5BhHE9k+RGv0qNMLWh6
         LNt6lGnbTkSBhty+KspFtEPkBeyJxldaEaBfc9Z/HWhebEgV6IERdn8TSO2gMPIDWA1D
         upn1B7lIkJHuuYlGulA/dIcYePL7T1eEkkYnxSvEuYVva229ZXM+aJ54OqF6jpCa4+Qp
         mKycBP8WHMk8312eIOGKY2iA+Gl34Ib36eUaZU1eVjhuQk7K6KINuFQv2lwlqoiBU4IX
         1Phf8EC4aTW+T6b3O2MM0FtzKnpF50pnJxJ1+5G7WHYbYzxLGN3maoRlgzh+ZUOlvcx/
         grbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCOFmLA1gK7VYup/osCyCBFC/ocd6npVJLY54eLqjXM=;
        b=bcGaF7ih5q6N5X5MWbw6UFZ73r7UzsLOvFG0pbo60e5gcTnDffNZ+NF6WI5JPTOvMu
         ICKQial/VoSkcj+BRGW4w6hWr/2T2HbfZ+Y0rW/o2kvQv5ZkBxHBNijRoeJe/dWtT9Xo
         q6frQjGomTg7H8qNaaZ+6zGpaaFFdf53KfHy9Xpn2XM949f5np/cDUC9Q/lDd1CDAuAq
         KiHKE4eTZiYgd4iDMtioZ07SlKZRdGvx6ARRBCvPC2NvLjE2TOVTQe1KuucIkPt/R5Xh
         WGuC5ppRB+EYvvHvcwRvgcOrP5OEKeI4boffQJXRwW/S7RVIcWtji0xlEoTLowBOfOQo
         RBPw==
X-Gm-Message-State: AOUpUlEj9Hzu8wrE1pnpHQOmB2p1E2zyhUsco+VMmQNJ/5xehMdR5Yj6
        UfAG880gr4dxfBpXHUfF08A=
X-Google-Smtp-Source: AAOMgpf+8lz2JwEHRwc+WrxpkLTWudy4uoKjw0fCyoyFicwRz1Su5eQviJKAyhnLd+lGyAXgoinRBA==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24-v6mr3138632plo.250.1531861493602;
        Tue, 17 Jul 2018 14:04:53 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:52 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 07/32] staging: gasket: Return EBUSY on mapping create when already in use
Date:   Tue, 17 Jul 2018 13:56:47 -0700
Message-Id: <20180717205712.29495-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_sysfs_create_mapping() return EBUSY if sysfs mapping already in
use, as a more appropriate error code than the current return of EINVAL,
which would indicate invalid parameters.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index e3d770630961b..dd4d3aaa57e2f 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -194,7 +194,7 @@ int gasket_sysfs_create_mapping(
 			"0x%p.", device);
 		put_mapping(mapping);
 		mutex_unlock(&function_mutex);
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	/* Find the first empty entry in the array. */
-- 
2.18.0.203.gfac676dfb9-goog

