Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BB0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33B22087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="auISZ1xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33B22087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeLKTRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:18 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:45007 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeLKTRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:14 -0500
Received: by mail-lj1-f171.google.com with SMTP id k19-v6so13995003lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a4b/fc+w67k8CzApARqE+9fnfXjLd0E1YO2zwa9GoqE=;
        b=auISZ1xhEi27/IlNZKl98ykmvKD+Ix0aV6EfOhDDxQjRpuVQ/1Kjv1C75W+BXDlhcD
         w6XFed8C2T3VX+0dXm2bHzvOejh2RoRzRd4K+EgfS8OWNfOeHyo2jfhKguizvoFnL3rT
         t6X/VZFxNUGn5XmF671zX5ltcXJfLG6g/jmC8lstjm1YqJ2X3HNWUL8lIgRzWJE7W78d
         wG/RFFG+j0P7/WkTYpE6MU9kJ9YwN0bNubf5qu2+x9lmNF+05VwwdUhTiakLazh+zK3R
         ppMpxfe8i2Kl03rmW7xvo0h4BbE/22mkoGp1/OqHjReTZyHgp14ey26ask1k6DffqMnJ
         qIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4b/fc+w67k8CzApARqE+9fnfXjLd0E1YO2zwa9GoqE=;
        b=k9VQkJ0IaSJPzlzxiVWM5G9ymvU0x780i4/JpOqB/bKhhitLXz0Io8BezwpPnKk76d
         jcSDWmmLESC+8GQkuMBUkP/5VS2jGqMddWxou48Lg5M7JGPEY6mk1fOykvxvP7UpEMTQ
         OPGQXyDBLUnbCNWkZrGYmEHQr1dO5QHGB8YRkMbND+hgi8Zp4SL+ldIS22N+B+GxmlK6
         rgYuF91SWklPqtTPfSD7AflptXBkSyYWpf/velEiTR9ZOlgDj7w+Xz9akTRNDEU/zO2s
         6OWHcZEzeE5sOgIEKGw4zebtBigHbfyPc2a1pyV9si695CBeyd/XR4Xbzt3ZOMJMcrbK
         xxjg==
X-Gm-Message-State: AA+aEWYpscfksIqotl99O+TjxlioI5mJIWgdY1SLvrE6++bHpfw/Ppzg
        HAO1u2eiFvpQ1zFay0f+oMAZ+w==
X-Google-Smtp-Source: AFSGD/UfXNUkiUaGPGiKXVo3FWl7SGHxLUsU+po4eokupxDTxX2uz5rUkA3aXMK0cKNx/anq+u1Ebg==
X-Received: by 2002:a2e:8719:: with SMTP id m25-v6mr11622450lji.121.1544555831956;
        Tue, 11 Dec 2018 11:17:11 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:11 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 10/21] lightnvm: pblk: remove dead code in pblk_recov_l2p
Date:   Tue, 11 Dec 2018 20:16:16 +0100
Message-Id: <20181211191627.15542-11-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Remove the call to pblk_line_replace_data as it returns
directly because we have not set l_mg->data_next yet.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 0fbd30e0a587..416d9840544b 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -805,7 +805,6 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
 							&l_mg->meta_bitmap));
 		spin_unlock(&l_mg->free_lock);
-		pblk_line_replace_data(pblk);
 	} else {
 		spin_lock(&l_mg->free_lock);
 		/* Allocate next line for preparation */
-- 
2.17.1

