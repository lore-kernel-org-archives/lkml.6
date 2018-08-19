Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F9CC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 04:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85D52170B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 04:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVUA79Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85D52170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeHSHLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 03:11:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37950 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeHSHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 03:11:44 -0400
Received: by mail-qt0-f194.google.com with SMTP id x7-v6so3656491qtk.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 21:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5D4YUF+p0alJRPnlxV77AWTJkir6fdQLSR8NBHJS0X4=;
        b=PVUA79HtoOEBHBuPCziHD/XF9UX3ZpJ3vaV9h+OUl+z5lM8uwrmWSgNNcsKHPouDPC
         v5GxFyHrruLlumfrc2dZNMggTRhxqIQZPFcLbRAWdEVqxg8nlS7YWsVEiM6Bb2raSCUT
         c5iMbmLUIW9tlbL10hDi0MejLlpsNu5nnG+SnbD8zpiTR9ugBNvNK+hRzMEViC8sFoMH
         LawWa9h8lziDqEIJHsfs6PudZ7XSmz8yoAwi/GYu79ZDsnruKTgJTC9DgZWg1LKaZ6uq
         X2Gwj6ausy+mhqUXrb8TyuRnuaPpH5aT6+Qe9KL1GiDqLfpQg4+7rYMs+GUMc16Fia54
         v16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5D4YUF+p0alJRPnlxV77AWTJkir6fdQLSR8NBHJS0X4=;
        b=U+E9lchX+TIzpuL80xCsQW8V1zj0NEeLQoQbuystyojhcqDNLSPbJ0+MOPm9Xu60qU
         zZRKtSE7DfuV5+UAuBRymJ3QgLmTeznkUyiDmXxlkUUdRiWIdiNiQcAtR5CgKXprTmLZ
         aRZnBkAL/8JCZnBkO1+ZrmE5/4fnclfz34p4bjVcxVte6p+zSXAqUNikUbn3G8OA8puA
         DIW82RW5L+G+ExJ6bZ4wGOh+BFeH22Eo1eZ78bHHkbtqZIKk/abTq7jSewhKs4+jsnGM
         W4uc5E6VcXkk+k7nzg5AkeMnVWHqMzJuFW1dTIoP8/CfqmYwwG7xpdq0kRZAHL0sntmD
         4zPw==
X-Gm-Message-State: AOUpUlGO+98dEoj0eF4nvqI9X3FAblnb0uLVgDsWsZ9DwQddsTx7rK37
        fBNaTkNalwnVoWXbYO6atutA4f1OHfM=
X-Google-Smtp-Source: AA+uWPy4v3qyWdV/lqnoRf4PnwCFCETwkhjLVfcO8HuJq2vXfnISdurB98EAimeSMz3RMzz08yH+Fg==
X-Received: by 2002:a0c:a162:: with SMTP id d89-v6mr36671744qva.198.1534651299429;
        Sat, 18 Aug 2018 21:01:39 -0700 (PDT)
Received: from 192.168.190.131 ([104.237.86.149])
        by smtp.gmail.com with ESMTPSA id n186-v6sm3353894qkb.32.2018.08.18.21.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 21:01:38 -0700 (PDT)
From:   Ocean He <oceanhehy@gmail.com>
To:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [PATCH] libnvdimm, region_devs: stop NDD_ALIASING bit test if one test pass
Date:   Sun, 19 Aug 2018 00:01:28 -0400
Message-Id: <1534651288-30306-1-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

There is no need to finish entire loop to execute NDD_ALIASING bit test
against every nvdimm->flags. In practice, all the nd_mapping->nvdimm
have the same flags.

Because the check of alias is "if (alias)" but not 
"if (alias == nd_region->ndr_mappings)", there is no function change while
just save a few cycles.  

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
A test to check if all the nd_mapping->nvdimm have the same flags, using 
Lenovo ThinkSystem SR630 and 4.18-rc6.

# ipmctl show -dimm

DimmID  Capacity        HealthState     ActionRequired  LockState       FWVersion
0x0021  125.7 GiB       Healthy         0               Disabled        01.00.00.4888
0x0121  125.7 GiB       Healthy         0               Disabled        01.00.00.4888
0x1021  125.7 GiB       Healthy         0               Disabled        01.00.00.4888
0x1121  125.7 GiB       Healthy         0               Disabled        01.00.00.4888

# ipmctl create -f -goal -socket 0x0 PersistentMemoryType=AppDirect

# ipmctl create -f -goal -socket 0x1 PersistentMemoryType=AppDirect

# reboot, to make goal configuration take effect.

# ndctl create-namespace -r region0 -s 100m -t pmem -m fsdax

# ndctl create-namespace -r region1 -s 100m -t pmem -m fsdax

# reboot and find all the nd_mapping->nvdimm have the same flags.

 drivers/nvdimm/region_devs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ec3543b..fc3bc1c 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -234,8 +234,10 @@ int nd_region_to_nstype(struct nd_region *nd_region)
 			struct nd_mapping *nd_mapping = &nd_region->mapping[i];
 			struct nvdimm *nvdimm = nd_mapping->nvdimm;
 
-			if (test_bit(NDD_ALIASING, &nvdimm->flags))
+			if (test_bit(NDD_ALIASING, &nvdimm->flags)) {
 				alias++;
+				break;
+			}
 		}
 		if (alias)
 			return ND_DEVICE_NAMESPACE_PMEM;
-- 
1.8.3.1

