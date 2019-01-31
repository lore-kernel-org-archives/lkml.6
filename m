Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB33C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7992084C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="dKClg84r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfAaCdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:33:10 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25417 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaCdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:33:09 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548901892; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=LDgy6MugAyxvHx80sLMn2iTsvyO7FIJPvN6b5Uxl+C5vSxKbCELW4c9ymRR7+rFPowiDD8KEpFjHwEvjoudnNvu5tuwPBDp/HcKmL9TizoHmWrRM1QPwx1ux2Gx/AkMoSt5gYhZS05AzW8A48sMyhShvzvzSMA+k8Rf3F7CNGfE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548901892; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=DeSXpkuBaRP5FZTknldkbxhMQMJx9Q4qwy3wT5Ssm1k=; 
        b=Rfl3TdNzlrd8lngOI4Fk0VHGqWEAvfmDdyp5KH/r/xB12cy5v3mmedKgk5ROKR+qItRD9P3RHdUGpHSemFvU7XyOn/yp0KQC4BZwxdc4U+3snepVgUfa4Sek1OLHUWirmowRJp2exAkjp6dAQCdMEDBYwHCm7LSlmZONmUON4XU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=WpEjR8C+TDFyTr6GwT4b6SnH3DxM6SJLnrxkYjPnL1UuMBeF2Hkr0s7isUQ7mxJXrH0BALBEueHW
    POE53UgKTMdTRic2yHNPIjSJfj3DC+0HrYolLpwpCtTlDrdoq+tl  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548901892;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1009; bh=DeSXpkuBaRP5FZTknldkbxhMQMJx9Q4qwy3wT5Ssm1k=;
        b=dKClg84rZYnrzufN1FKEICy7VAZdgifPw/2VyDfO1CzslIVF0QaFnjcuy8c6U4Xv
        C3GSJFOWvfVYuTGZSNz+Dy0jVLKheYUFiNlPqWh4CUgLSSEX+psG3AQwFmzKQqcdTtE
        elawTJegklis7p3BQPSX3OrGeqJJbbwUnYqJm9A8=
Received: from YEHS1XR956R00D1.lenovo.com (106.38.1.115 [106.38.1.115]) by mx.zohomail.com
        with SMTPS id 1548901890474272.2511908503543; Wed, 30 Jan 2019 18:31:30 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     dan.j.williams@intel.com, hch@lst.de, jack@suse.cz, corbet@lwn.net,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v3 5/5] dm-writecache: output seq_count within status
Date:   Thu, 31 Jan 2019 10:29:55 +0800
Message-Id: <20190131022955.9920-6-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190131022955.9920-1-yehs2007@zoho.com>
References: <20190131022955.9920-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

seq_count is important for flush operations, output it within status
for debugging and analyzing code behavior.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 2c1e825..3396710 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2231,9 +2231,9 @@ static void writecache_status(struct dm_target *ti, status_type_t type,
 
 	switch (type) {
 	case STATUSTYPE_INFO:
-		DMEMIT("%ld %llu %llu %llu", writecache_has_error(wc),
+		DMEMIT("%ld %llu %llu %llu %llu", writecache_has_error(wc),
 		       (unsigned long long)wc->n_blocks, (unsigned long long)wc->freelist_size,
-		       (unsigned long long)wc->writeback_size);
+		       (unsigned long long)wc->writeback_size, wc->seq_count);
 		break;
 	case STATUSTYPE_TABLE:
 		DMEMIT("%c %s %s %u ", WC_MODE_PMEM(wc) ? 'p' : 's',
-- 
1.8.3.1


