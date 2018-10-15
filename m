Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B93C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE782087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9Z3O8Xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE782087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeJOMnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:43:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45133 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeJOMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id y15-v6so8660380plr.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrrjXDylsjA8jXfuKWOkw4AqKD8yYRoBXOn147lLQNE=;
        b=i9Z3O8Xrmtt8JumQRsjb/vUSS3zIvZTcrw6Yb6+ynwiC8Gj+aFTmDUm/Ep9s79qAMa
         RchU5GlOTDHY5H18yNph0PdRKsEgGACAX9jo850WVCQJc9IuDAzwdydyQKoixLBGcyVa
         e4tTeXHXwyhznvI5iCEc9Ev1cY3WaXPZT7Us4+pVckSI33UppB78ynFddmg31AElCdp4
         3Y0e8R5ChPgZTW227WqWYJscd6lba93n53Pl0kfs40nNhkdzQdcL1BXFrTYwHV7rQzDM
         IuEN8+bt23ynzv2G7+v0KE0bjueLLI/1CXDF8AeSKIaIKJGe02dlzY/1RLFZ0OO/FLyD
         BG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrrjXDylsjA8jXfuKWOkw4AqKD8yYRoBXOn147lLQNE=;
        b=F5335iMUEH2Nuu2vf6HtJ1gEvE5uC6Mqs2m3ZkY1IWxMbphWi7PZ3YNkAOqvfSZeCN
         t4Wi0H40QzOUrCMpP7pP2eTOGf01vYLe5rzYO7z+Mq/xJUleSPqC6WnE09UoOGeiPVgs
         IpyECJlG/sicuGw0wEf9xqInyJ/AcsJ/n8TqIPdMX7oYmy+E2xOPAoinp6o40cY8yNXw
         jLicjArMhXqUu59zkuEsy+29jV91jQ3Ng/z0JiQ4X72sPta3fpA76OPiAalyyhijlhoM
         Aym7HUZnDouNJXn9xbYCSXMO0NurWjbBljTCLrfrSASiIPn3su7vLLywjQrNbR1A2Evs
         TRqg==
X-Gm-Message-State: ABuFfojG9z6ovNA0F/WRgPMeYOWQgWn5LVTLseQ0uLhoXR5Yd6S1ALQy
        YKPKsPnOV0cFST3oyjFk2yteEAHg
X-Google-Smtp-Source: ACcGV61BtY8/5bVzJTRbSrdfKApYZ+gm8sXyDKN1lxYeRCyYY3u9AEVkam4/O3p/xtV6VU25S01T0A==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr2888730plb.279.1539579605100;
        Sun, 14 Oct 2018 22:00:05 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.22.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 22:00:04 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 11/11] staging: gasket: Update device virtual address comment
Date:   Sun, 14 Oct 2018 21:59:27 -0700
Message-Id: <20181015045927.156790-12-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Add that number of page table entries and extended address bit offset
are configurable. Update example virtual address format to be more
consistent with typical usage.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index c2fbab74194f8..5b398b7ba81d3 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -10,10 +10,18 @@
  *
  * This file assumes 4kB pages throughout; can be factored out when necessary.
  *
- * Address format is as follows:
+ * There is a configurable number of page table entries, as well as a
+ * configurable bit index for the extended address flag. Both of these are
+ * specified in gasket_page_table_init through the page_table_config parameter.
+ *
+ * The following example assumes:
+ *   page_table_config->total_entries = 8192
+ *   page_table_config->extended_bit = 63
+ *
+ * Address format:
  * Simple addresses - those whose containing pages are directly placed in the
  * device's address translation registers - are laid out as:
- * [ 63 - 40: Unused | 39 - 28: 0 | 27 - 12: page index | 11 - 0: page offset ]
+ * [ 63 - 25: 0 | 24 - 12: page index | 11 - 0: page offset ]
  * page index:  The index of the containing page in the device's address
  *              translation registers.
  * page offset: The index of the address into the containing page.
@@ -21,7 +29,7 @@
  * Extended address - those whose containing pages are contained in a second-
  * level page table whose address is present in the device's address translation
  * registers - are laid out as:
- * [ 63 - 40: Unused | 39: flag | 38 - 37: 0 | 36 - 21: dev/level 0 index |
+ * [ 63: flag | 62 - 34: 0 | 33 - 21: dev/level 0 index |
  *   20 - 12: host/level 1 index | 11 - 0: page offset ]
  * flag:        Marker indicating that this is an extended address. Always 1.
  * dev index:   The index of the first-level page in the device's extended
-- 
2.19.0.605.g01d371f741-goog

