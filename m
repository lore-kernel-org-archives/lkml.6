Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2539C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B98D2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR4Ayoa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B98D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeIDPM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:12:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45454 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeIDPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:12:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so1490942pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BNS15GySw45MLcrj6NgFJRkc/1V72+qIGsnSMM50p6c=;
        b=lR4Ayoa8Egf7LcfLET+hKFEJCPY9ST2ocafcSClgn6l8lKLraDjC3U7ceAi1inQfQ2
         bpsGz+i3knINtNig38Y8RW2Gr9KKHKko8IA49BEQbt3uXrmSiUb2b2hzVXrt9vy3UOko
         Rbu3w361pScDKqN8ifW2M+tYX3Lao6Z1VUMot9hrEmP2M56yTMtlbzRyhqyKHUl9QRzZ
         3+PY/laKuAgn2vLp8NRukCnJpLJVOMdoSRu/1G8cjdWzYN63E0Z/mK8615t/DfG/TtRj
         JOfWQk8VwEg3EPFMPvVGoKpe/iSO9M2MbgHfvTItkwZisKRSTChiFlNY/Oe9+a8l4yc0
         Wxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BNS15GySw45MLcrj6NgFJRkc/1V72+qIGsnSMM50p6c=;
        b=j0qrOvhmoT7hJF+aUpWE0mB2/VIgSiIpo8Fni7AJHYsocKdxSWFoHC/sBSBOYkeNUk
         /jbxd2WDWRJkUDx550f0YICw6Kprd6pozRRbJ0PEh/5yzBWXlVewzPJXI9h8KD8HLCyj
         ZbM1JZeR1aQ+Sw0dwYmj3MrQfhZWNYHuOIZ2iypq9OFUfBVidB2V/kXalqNLSQvg/RO9
         2MHZkxusGGPSSCzFK86ofKRVssuMOSl9Dl65NipCCU2t1/uSZOJVVErPMVuLohWtntPe
         NptQrQWzt0uhH6YTiQ0TTYPv4Y5j4sI5hg+RI7J4VL6Albf7nGO0EGgGgVhRxBorc2VF
         JKAQ==
X-Gm-Message-State: APzg51DhBiFWvnHeZlrYDD8/zJRBfh2/I+BcCsBpPOyGoTf2+YrdDIaq
        tqemT12QNnB8u+ffMBhButk=
X-Google-Smtp-Source: ANB0VdYzYQwdTWVWI6EjIXXnKwmyr300PU2WWYYdR3guvGGe0fj2mfgFa74dkAA39tmgBuESYY2vFg==
X-Received: by 2002:a63:a51c:: with SMTP id n28-v6mr366243pgf.453.1536058075480;
        Tue, 04 Sep 2018 03:47:55 -0700 (PDT)
Received: from localhost.localdomain ([45.56.155.158])
        by smtp.gmail.com with ESMTPSA id d6-v6sm27917315pgt.66.2018.09.04.03.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 03:47:54 -0700 (PDT)
From:   Ocean He <oceanhehy@gmail.com>
To:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [PATCH v2] libnvdimm, region_devs: stop NDD_ALIASING bit test if one test pass
Date:   Tue,  4 Sep 2018 06:47:42 -0400
Message-Id: <1536058062-18894-1-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

There is no need to finish entire loop to execute NDD_ALIASING bit test
against every nvdimm->flags. In practice, all the nd_mapping->nvdimm
have the same flags. So it's safe to return ND_DEVICE_NAMESPACE_PMEM
if the NDD_ALIASING bit is found inside the loop, while saving a few
cpu cycles.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
v1: https://lkml.org/lkml/2018/8/19/4
v2: Per Vishal's comments in patch v1, remove 'alias' variable. 
In the loop, just return ND_DEVICE_NAMESPACE_PMEM if the NDD_ALIASING bit is
found for any mapping. 
Outside the loop, simply return ND_DEVICE_NAMESPACE_IO. 

The following test pass on Lenovo ThinkSystem SR630 based on 4.19-rc1.
# ndctl create-namespace -r region0 -s 1g -t pmem -m fsdax
# ndctl create-namespace -r region0 -s 1g -t pmem -m sector
# ndctl create-namespace -r region0 -s 1g -t pmem -m devdax
# ndctl list
[
  {
    "dev":"namespace0.2",
    "mode":"devdax",
    "map":"dev",
    "size":1054867456,
    "uuid":"fc3a2126-9b8e-4ab4-baa4-a3ec7f62a326",
    "raw_uuid":"eadc6965-daee-48c5-a0ae-1865ee0c8573",
    "chardev":"dax0.2",
    "numa_node":0
  },
  {
    "dev":"namespace0.1",
    "mode":"sector",
    "size":1071616000,
    "uuid":"0d81d040-93a1-45c6-9791-3dbb7b5f89d2",
    "raw_uuid":"2b1b29e6-0510-4dcf-9902-43b77ccb9df5",
    "sector_size":4096,
    "blockdev":"pmem0.1s",
    "numa_node":0
  },
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"dev",
    "size":1054867456,
    "uuid":"cbff92ed-cd45-4d24-9353-7a56d42122b1",
    "raw_uuid":"f6ea1001-5ef0-4942-889a-99005079ab5d",
    "sector_size":512,
    "blockdev":"pmem0",
    "numa_node":0
  }
]

# reboot and OS could boot up normally
# ndctl destroy-namespace namespace0.2 -f
# ndctl destroy-namespace namespace0.1 -f
# ndctl destroy-namespace namespace0.0 -f

 drivers/nvdimm/region_devs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index fa37afc..16ee153 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -228,19 +228,18 @@ void nd_blk_region_set_provider_data(struct nd_blk_region *ndbr, void *data)
 int nd_region_to_nstype(struct nd_region *nd_region)
 {
 	if (is_memory(&nd_region->dev)) {
-		u16 i, alias;
+		u16 i;
 
-		for (i = 0, alias = 0; i < nd_region->ndr_mappings; i++) {
+		for (i = 0; i < nd_region->ndr_mappings; i++) {
 			struct nd_mapping *nd_mapping = &nd_region->mapping[i];
 			struct nvdimm *nvdimm = nd_mapping->nvdimm;
 
 			if (test_bit(NDD_ALIASING, &nvdimm->flags))
-				alias++;
+				return ND_DEVICE_NAMESPACE_PMEM;
 		}
-		if (alias)
-			return ND_DEVICE_NAMESPACE_PMEM;
-		else
-			return ND_DEVICE_NAMESPACE_IO;
+
+		return ND_DEVICE_NAMESPACE_IO;
+
 	} else if (is_nd_blk(&nd_region->dev)) {
 		return ND_DEVICE_NAMESPACE_BLK;
 	}
-- 
1.8.3.1

