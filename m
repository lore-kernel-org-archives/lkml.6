Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF05C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC16B2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kguWpSZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC16B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJOMoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:44:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46734 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id a5-v6so8543995pgv.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 21:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6Rq4xP+dxlt44CHmwm3Ik+qH8WbttItwOGLnRNudN8=;
        b=kguWpSZS0VfEGYVTaH+7ZAKRws+fpHFmhTznZnifpYSw4vRTOyc35gcV0FOyAPwcbS
         WHUoQ2TfJ2LUwFVp9JwF+UYAQkzH2vDZjZ+3TpEORsWC+GJ/cbQ9iRfhcRLeSejGEoJP
         WPzWPNk57mxB24XTCf49SweaF2IH8Vgvxi9luC+KR+wNgOEBur3fsATzvhR6x7HbuCjP
         cCWjPZKtKpNyDV6AoBJflvpr4caHb6XDJ0318CEFCZ2seU57NyXid6PV8dkDONseOv1X
         u0/zdmmQf5KCs9vd7+SoUsPUL89SsWeOq2JvVhzpWXHQodOaF+IQzB/ZZpj5kanr1bYy
         /tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6Rq4xP+dxlt44CHmwm3Ik+qH8WbttItwOGLnRNudN8=;
        b=SRi9SJ8kT4pUjZaqGe9m+Ch9JrrB8ncH+FYwmzytc0406R8OXLkzIPpb6AXZyw66Y6
         wDhg+cMON00Ag5oZg3JZV6RTn/ao8bw/zdhx5oW0uvTUKVXGVEKlnGmbPTP7LR+pzu6/
         kWpZdZ0kR7f0Y+jmj/w46vMoGgQZIhwKe2e81ppelloObPEC1Mq+pHCBWeoLjAjZepgO
         LJPdwsuRaxfkn1MSEeGhOyvlBo+9kv4VazWznG6ZLZg6Dd2NLnvV8ZPVThSyeLu1DdkW
         Vzn7fysIzDVgWJIpY417WOepwsor5FLGwUs4vJBmU3TKFdR3tJO2PmSwv9ypnyJHN9/l
         3r7Q==
X-Gm-Message-State: ABuFfoi1fUVKdp6ENx+sVm4A+xSThLpmmBIFH2BuIEbe+Nzz6yo3wArv
        wj3/B8u8FjNlURhT4LEfWKM=
X-Google-Smtp-Source: ACcGV63Qq8oDBRdRh1eLc4Rhf5hwLAILTa6BrxM7c9qBORrvm2MbzU3PxHfaJVl58FJgjwzzKdYqag==
X-Received: by 2002:aa7:8195:: with SMTP id g21-v6mr4396449pfi.71.1539579597608;
        Sun, 14 Oct 2018 21:59:57 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.21.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 21:59:57 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 02/11] staging: gasket: page table: return valid error code on map fail
Date:   Sun, 14 Oct 2018 21:59:18 -0700
Message-Id: <20181015045927.156790-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Return -EINVAL on mapping failures, instead of -1, which triggers a
checkpatch error.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 964146f0df526..2e1de8ad4a2c6 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -514,13 +514,12 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 					(void *)page_to_pfn(page),
 					(void *)page_to_phys(page));
 
-				/* clean up */
 				if (gasket_release_page(ptes[i].page))
 					--pg_tbl->num_active_pages;
 
 				memset(&ptes[i], 0,
 				       sizeof(struct gasket_page_table_entry));
-				return -1;
+				return -EINVAL;
 			}
 		}
 
@@ -1165,7 +1164,7 @@ int gasket_page_table_lookup_page(
 	*ppage = NULL;
 	*poffset = 0;
 	mutex_unlock(&pg_tbl->mutex);
-	return -1;
+	return -EINVAL;
 }
 
 /* See gasket_page_table.h for description. */
-- 
2.19.0.605.g01d371f741-goog

