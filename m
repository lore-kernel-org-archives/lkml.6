Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4CFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C7121709
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KApLR1ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C7121709
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeHOBHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:07:23 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:51556 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeHOBHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:07:23 -0400
Received: by mail-yw1-f73.google.com with SMTP id v14-v6so27657318ywv.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=0jcTr2jZFTFq0mJjH4TgMxz6NVPThf7kR9ohRsDw31U=;
        b=KApLR1ciciPPmRMy40Avwki/CF8Mw44FEw04SuAFoiKYnNIT6DRCthP/fsGaydL1on
         aEaRg11bdRyv+ul7KSGDAv7kiHHfNb7G+H8ejIx7c3EYTG4vDzUHORVsNCpImkz14DWu
         YA9513J1xI481CJYejx1ID5TZIGOTSsR5AYTL6k9hySyonKHpn4Wb1Zs4xmcKgvWj7Yb
         2/S+6+o9ltFgH3h8no0jdx72ooSVqqwIwNL79OZFr8PqBEIyD66iIOyxlgmJ42ZHa1wd
         pT/FBLcCYPuBZwdYTnETuCseJL5qbESbwKzX0auC++/LqqnmOlP5xK1+gm3Z0sgCrocE
         WYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=0jcTr2jZFTFq0mJjH4TgMxz6NVPThf7kR9ohRsDw31U=;
        b=iORXQCeoOxd2mscxgTiObb+zpmrb8KTL23ROrkWuoFWlmizSQobidybUSf/E7oQMqB
         1Gpr1Tv5cSMkL9q999t82L1vmWFITK3c4EmtPwUGMyCWmmu/Dn7AY8N01PXC3aGpmqSs
         UaKcd/FHDh0HvzPIluEvYWWCz8uXcnn84Q7fuRXix2SeOh/FNDo7XxDZpf66LGNhWrdD
         tSS+6l1Or5ki70ij3XsDF8M9P1VcZ2a4jyDvl5kHFeoJ7UrtjxPeA1WPHwy32hhmi2J5
         KMH9ZFBAZBv5CTAaMCJqBRSvuDKXvkUtETiEPlkFzh4bIuHHW6WrvznQtmxizBEHlcWq
         3NAw==
X-Gm-Message-State: AOUpUlEHVUkwoXcXSWCGG9DQv/U119QbYDB3vfwboabJ9VfVWPe4Rb8S
        IAhC26A283u/7m2S38eRfZ8oLwvkYK2THyI=
X-Google-Smtp-Source: AA+uWPxlTjhV9wTRHvFa4ygpvCFDlK9zqMS0/23tjlSQLD0AqQpFWwwN13sfPcaMFNvSOvPwcbQOHlark/ROnjE=
X-Received: by 2002:a0d:e0c6:: with SMTP id j189-v6mr7387483ywe.80.1534285087784;
 Tue, 14 Aug 2018 15:18:07 -0700 (PDT)
Date:   Tue, 14 Aug 2018 15:17:35 -0700
Message-Id: <20180814221735.62804-1-wnukowski@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH] Bugfix for handling of shadow doorbell buffer.
From:   Michal Wnukowski <wnukowski@google.com>
Cc:     yigitfiliz@google.com, Michal Wnukowski <wnukowski@google.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds full memory barrier into nvme_dbbuf_update_and_check_event
function to ensure that the shadow doorbell is written before reading
EventIdx from memory. This is a critical bugfix for initial patch that
added support for shadow doorbell into NVMe driver
(f9f38e33389c019ec880f6825119c94867c1fde0).

This memory barrier is required because =E2=80=9CLoads may be reordered wit=
h
older stores to different locations=E2=80=9C (quote from Intel 64 Architect=
ure
Memory Ordering White Paper). The following two operations can be
reordered:
 - Write shadow doorbell (dbbuf_db) into memory.
 - Read EventIdx (dbbuf_ei) from memory.
This can result in a potential race condition between driver and VM host
processing requests (if given virtual NVMe controller has a support for
shadow doorbell). If that occurs, then virtual NVMe controller may
decide to wait for MMIO doorbell from guest operating system, and guest
driver may decide not to issue MMIO doorbell on any of subsequent
commands.

With memory barrier in place, the volatile keyword around *dbbuf_ei is
redundant.

This issue is purely timing-dependent one, so there is no easy way to
reproduce it. Currently the easiest known approach is to run =E2=80=9CORacl=
e IO
Numbers=E2=80=9D (orion) that is shipped with Oracle DB:

orion -run advanced -num_large 0 -size_small 8 -type rand -simulate
concat -write 40 -duration 120 -matrix row -testname nvme_test

Where nvme_test is a .lun file that contains a list of NVMe block
devices to run test against. Limiting number of vCPUs assigned to given
VM instance seems to increase chances for this bug to occur. On test
environment with VM that got 4 NVMe drives and 1 vCPU assigned the
virtual NVMe controller hang could be observed within 10-20 minutes.
That correspond to about 400-500k IO operations processed (or about
100GB of IO read/writes).

Orion tool was used as a validation and set to run in a loop for 36
hours (equivalent of pushing 550M IO operations). No issues were
observed. That suggest that the patch fixes the issue.

Fixes: f9f38e33389c (=E2=80=9Cnvme: improve performance for virtual NVMe de=
vices=E2=80=9D)
Signed-off-by: Michal Wnukowski <wnukowski@google.com>
---
 drivers/nvme/host/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17a0190bd88f..091c2441b6fa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -292,7 +292,7 @@ static inline int nvme_dbbuf_need_event(u16 event_idx, =
u16 new_idx, u16 old)
=20
 /* Update dbbuf and return true if an MMIO is required */
 static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
-					      volatile u32 *dbbuf_ei)
+					      u32 *dbbuf_ei)
 {
 	if (dbbuf_db) {
 		u16 old_value;
@@ -306,6 +306,12 @@ static bool nvme_dbbuf_update_and_check_event(u16 valu=
e, u32 *dbbuf_db,
 		old_value =3D *dbbuf_db;
 		*dbbuf_db =3D value;
=20
+		/*
+		 * Ensure that the doorbell is updated before reading
+		 * the EventIdx from memory
+		 */
+		mb();
+
 		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
 			return false;
 	}
--=20
2.18.0.865.gffc8e1a3cd6-goog

