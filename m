Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372BFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE098218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am6rJEKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfAIFCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:02:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53129 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIFCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:02:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so6264447wml.2;
        Tue, 08 Jan 2019 21:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oaFkg5f6X45Rbbbv3nNt+0yxB8tpFAn+sQnBw93ysb4=;
        b=Am6rJEKBaZFM1HbNYn9A5WDIOItzy/8cnLPgfIDVDUCkkOVe4ashKPDw0bv7b2K52o
         M/mlmlr/KMBcikD8Xm71AuKLS+vLkJqIZ5xjbIcozeia5dX3E10yRkZXBhzqHWsVecHV
         62E/ysHUE93DumocN7hQelIMNS9//kSOYP8J1uxYgCWzJ5/Gfmkqeq9F7Qh5BOPJAq1e
         4gxmMqfxuQqPKndrCU6yVl0/L0xz5uizpn2zysbeu0xrcmOoFojlDVzfHSm3VJp/bcZz
         23GmwoVvjCJ4yxiFzj27nadx0L6I6iHK8D+6H4i7KRVgFnM4QG/N0bD9HvrA6ULijvLd
         Tz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oaFkg5f6X45Rbbbv3nNt+0yxB8tpFAn+sQnBw93ysb4=;
        b=UbAJooIT9Lr78N85dmR+o62NXaUJGtoKae/ZjPV2Q03DM1HBeR2zKccr/VmHiWQXA2
         FWaEfaTHaZL1gKanjdqoQhxFJdwGBtxAOAIsOr5loPdBFI65OFUwvxWsodV/o2k11/DN
         Bpg+jyYZSDoGETAVl0pbz5Lj1o5MKHvFiYJ+agdVi+5eQCTj40ghFFLd/6ftYBxqNKnj
         LkOo3yhCF71Mr5mDYg49BzH+Pv5yWQhAyiwZoGq6zghdYiazBYRdJuorzbCXHuFp6Unz
         lfD/Q9Otb5iF1E2ZSd0JOt3MbYvVy+l/f7JRUbRyalnu1JQs78q2A2DHsLamFA61IjdR
         RvkA==
X-Gm-Message-State: AJcUuke/cEU2TJbCXdqYBVIu8uHFdBNcQ45QcJMJEiYNIkjRNwJFHTtq
        nSMAwlVM0MwPRWcXbLisl38=
X-Google-Smtp-Source: ALg8bN4qex/SSicLHCwnayTLTsK9uTmPYTS6BkPnIz3BksuHC1K6BAyhI45pQ218TTQpuY22PpDClA==
X-Received: by 2002:a1c:8b44:: with SMTP id n65mr4091472wmd.104.1547010147555;
        Tue, 08 Jan 2019 21:02:27 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t199sm323151wmt.1.2019.01.08.21.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 21:02:26 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] nfit: Mark some functions as __maybe_unused
Date:   Tue,  8 Jan 2019 22:00:37 -0700
Message-Id: <20190109050036.17322-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108045853.5471-1-natechancellor@gmail.com>
References: <20190108045853.5471-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 little endian allyesconfig:

drivers/acpi/nfit/intel.c:149:12: warning: unused function 'intel_security_unlock' [-Wunused-function]
static int intel_security_unlock(struct nvdimm *nvdimm,
           ^
drivers/acpi/nfit/intel.c:230:12: warning: unused function 'intel_security_erase' [-Wunused-function]
static int intel_security_erase(struct nvdimm *nvdimm,
           ^
drivers/acpi/nfit/intel.c:279:12: warning: unused function 'intel_security_query_overwrite' [-Wunused-function]
static int intel_security_query_overwrite(struct nvdimm *nvdimm)
           ^
drivers/acpi/nfit/intel.c:316:12: warning: unused function 'intel_security_overwrite' [-Wunused-function]
static int intel_security_overwrite(struct nvdimm *nvdimm,
           ^
4 warnings generated.

Mark these functions as __maybe_unused because they are only used when
CONFIG_X86 is set.

Fixes: 4c6926a23b76 ("acpi/nfit, libnvdimm: Add unlock of nvdimm support for Intel DIMMs")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Mark the functions as __maybe_unused rather than expanding the
  CONFIG_X86, as requested by Dan.

 drivers/acpi/nfit/intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 850b2927b4e7..f70de71f79d6 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -146,7 +146,7 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 
 static void nvdimm_invalidate_cache(void);
 
-static int intel_security_unlock(struct nvdimm *nvdimm,
+static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
@@ -227,7 +227,7 @@ static int intel_security_disable(struct nvdimm *nvdimm,
 	return 0;
 }
 
-static int intel_security_erase(struct nvdimm *nvdimm,
+static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key,
 		enum nvdimm_passphrase_type ptype)
 {
@@ -276,7 +276,7 @@ static int intel_security_erase(struct nvdimm *nvdimm,
 	return 0;
 }
 
-static int intel_security_query_overwrite(struct nvdimm *nvdimm)
+static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
@@ -313,7 +313,7 @@ static int intel_security_query_overwrite(struct nvdimm *nvdimm)
 	return 0;
 }
 
-static int intel_security_overwrite(struct nvdimm *nvdimm,
+static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *nkey)
 {
 	int rc;
-- 
2.20.1

