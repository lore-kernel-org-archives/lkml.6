Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099A5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D452086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="WnPVRfgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D452086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeH2M6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:58:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40825 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2M54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:57:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so3352718edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UX0Pvs4Hz0Ki3EZ2/37DxNKm9gdSEWipWRlHXL/KZmU=;
        b=WnPVRfgZhZycAWcdCQ7uA8q2+BksDSZeunfi8VjN6pxIoTuy/YzYZzfVQxCyoN8Y+O
         jT+ZhjTi5DWL6OndPKki5ixcbLZs+6b2B1VqoCyh52AmUacNyFXh8UEyQfd1RwaEnlEY
         P4qlXQdJxIl3f/ssCfR3oLSkT1dPp2GFqV6uwLt/wFnvpyAXHkgDCpnzpOeK2mFypWvr
         jO5/J+wkALyNPYfdouZYenEw5L/cbZqTgzdFM0QJzrQZ5GxKprZ2Q5YhjLEKRXRcRbyY
         k6UXHXBsCepk0Xphn/2cOsre+aiJDjDhsxONckAFjdgUEgaSf0KoVQGjIZPOvvdE5m8i
         siSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UX0Pvs4Hz0Ki3EZ2/37DxNKm9gdSEWipWRlHXL/KZmU=;
        b=Z0uikHI+l81b5lFK0GM0B0jmfVpLlTJDhAUVWlSqEqGsWst6TIVrRVPKx5ZVsc0+yT
         q3eFz4/+9Md9Vf/soWWmtjB/svztNIUgiinwG9qgXqLhadLTVemRFJnfIURv9pcVhlYt
         kDsjMyHWcQ7nE66Md9bgQObjgWLHUisHBEUlqRCIzzdcRqGykRe6V/dQ9IFVgjNDt4I0
         kiQgS2V9WMZffpUIy/Tje1PJcdxpKGbbW0rjv0sTVwrXDdrvdga/DSWrmQ59wQoffA6/
         Oh31IOLO1qyASWWRqQVjWjYLUtAGXriXMknyBRNmwj2VDjpdPDW335p8BBNGqEEymX/Q
         q6LA==
X-Gm-Message-State: APzg51DKyHDq5hH9Nt8uEKpRTlC7lHSRFCgI8psDZ3R39Lh1Xo9m6CAo
        2ZLyb/0yohWW+UV1zlR32/lydg==
X-Google-Smtp-Source: ANB0VdY/BPOOxayAXQscpxfAHHm9mEFrmcuJJ7Wc2ZdsZ0zUqIhw3QyUZVyifHS9CpBX80cE6eVdow==
X-Received: by 2002:a50:83e6:: with SMTP id 93-v6mr6365599edi.164.1535533320972;
        Wed, 29 Aug 2018 02:02:00 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id a41-v6sm1546569edc.57.2018.08.29.02.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 02:02:00 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/4] lightnvm: pblk: fix comment typo
Date:   Wed, 29 Aug 2018 11:01:51 +0200
Message-Id: <1535533313-29944-3-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comment typo Decrese -> Decrease

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 767618eba4c2..617572717065 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -195,7 +195,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		/* Release flags on write context. Protect from writes */
 		smp_store_release(&w_ctx->flags, flags);
 
-		/* Decrese the reference count to the line as we will
+		/* Decrease the reference count to the line as we will
 		 * re-map these entries
 		 */
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
-- 
2.7.4

