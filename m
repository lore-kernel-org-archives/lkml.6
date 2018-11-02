Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058FCC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ED32082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="1iV4pCq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ED32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeKCF1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:27:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46846 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeKCF1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:27:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id c13-v6so1474820plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EpUtuo1aXZR+mRPTamA85+rvBe/obQkol0FVeKXW1z0=;
        b=1iV4pCq8mYG6wEBUqN6xT2PiQXO2vyo+KrvdCABm5sseW9ngSvHzrFfYcscB+xBE7/
         h+Gb1wRFANUzyCY8FiyhhycIPX6y2o9Ef3W7iWvlQvWoKjs24a3xfscbNdZbDfrcQT/B
         04cLPV2t+bW3RCGFEVmaacaGsVfNy5Mqifh7KDKCuODZuysyoDBSu3Ca9+K9p8ZI58DF
         E73PC1MeVAK4BRcfSh6wuo+xxs5UFY6tUgDF5q74K6l6QhoehN3meHb9jkTs7C52Kmkj
         GICd/G/VPHlv6NTX0Ssd0gJ9F/hZf01Y1d0dlscIpP2WtOv5lSZkn6G+eML3EfDgbqXt
         5g3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EpUtuo1aXZR+mRPTamA85+rvBe/obQkol0FVeKXW1z0=;
        b=OE023AHRj7d2QN5viRqfEgE7RI0cs7b6jLwx+28xy5z4bTprAMtslGIHIJaVOSA5Qj
         eFjCkvEYmm2mTm0y75dIGdxHB3zUnWBYJBQMGVWKTdeM8PRR9UflVvNd4y8GsR213Bel
         s6RnS7ugrVUexXwG7Q++uWqc66QB69KJxR00VzNswYsNB5qSdKqZuG+Ix5lZA0dqUwkt
         DVEPxZVc5Z75Ax8wZ9h4J3sKq02aiyioV8E6DOnV7jUtxNeo3UpNUYdtqMzxLAgTtQr1
         aKCG2PK2GDnuBMnc1FjjBaNH+YdU2yJLoVwEN9uqdYwC9KIBcoOd8jR0lKdlh5O1WwoL
         iqQw==
X-Gm-Message-State: AGRZ1gInvzzMquKiRszNI7auQRJlJbfY/VfWAf46hl34piHKc8sZNqmH
        fSBFRK6hMj5HraGvMY8FqkKWfw==
X-Google-Smtp-Source: AJdET5cpXUwt9H8N6yXBAiIGWO/04iHT5PrnRCWjOd8Og4JQVzpYV3F3Ox6eUTaZJXJo4rCNlZGvvQ==
X-Received: by 2002:a17:902:4381:: with SMTP id j1-v6mr12744663pld.59.1541189914233;
        Fri, 02 Nov 2018 13:18:34 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.162])
        by smtp.gmail.com with ESMTPSA id h62-v6sm26641676pfg.27.2018.11.02.13.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:18:33 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 1/3] dlm: fix invalid free
Date:   Fri,  2 Nov 2018 14:18:20 -0600
Message-Id: <20181102201822.12518-2-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181102201822.12518-1-tycho@tycho.ws>
References: <20181102201822.12518-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dlm_config_nodes() does not allocate nodes on failure, so we should not
free() nodes when it fails.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 fs/dlm/member.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index 3fda3832cf6a..cad6d85911a8 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -680,7 +680,7 @@ int dlm_ls_start(struct dlm_ls *ls)
 
 	error = dlm_config_nodes(ls->ls_name, &nodes, &count);
 	if (error < 0)
-		goto fail;
+		goto fail_rv;
 
 	spin_lock(&ls->ls_recover_lock);
 
@@ -712,8 +712,9 @@ int dlm_ls_start(struct dlm_ls *ls)
 	return 0;
 
  fail:
-	kfree(rv);
 	kfree(nodes);
+ fail_rv:
+	kfree(rv);
 	return error;
 }
 
-- 
2.17.1

