Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E6AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1D020676
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXdGGgPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1D020676
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeHPBrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:47:01 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:42840 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbeHPBrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:47:01 -0400
Received: by mail-yw1-f74.google.com with SMTP id r144-v6so3031574ywg.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=aPSLv5dxBQ0ubZIfumqlXVCtEHYTEIvDoYj9dQJU/d8=;
        b=NXdGGgPlpN6a65M2U36Tec6U5jlz1se37ItOfjQ8lZKGVYOVHHozIXK+wcENXr2lKh
         w5ncDjTj3yE9QvDBJ/FDgK0Zfp13duyDVjnQALVR44zSLttGp7ZeNmE33RwJLDsC4Vxs
         pW0ziGMlhLQFKxdTwFhLW6Kd8Xyd1lg3Yt/cjqCs9yNEj9fQmA0kiWG1sl/woc0tFH9R
         X7rPXLNXY1JiQc7UX96fscK43+ntoQIT27mOy301OumKa1Jh6VFYAFXwVBgfvU1Aq1/f
         Mj6ZSeuKMVy8JRMq0VdrRlHOozsxCcVqz/SF424/li/1QKS5Hvcy7Z6cvkGhpwJe0CJH
         5eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=aPSLv5dxBQ0ubZIfumqlXVCtEHYTEIvDoYj9dQJU/d8=;
        b=h84GuLTThyl9BokWmLLs25PV7eVaZAA6PevsK30EgMN8N6zh8b2TyNa2v6Hgu8N3jU
         2HJcuqS7YXArjko1YcNw1l8qgLlhsYur7EP0ZElRd1zaH4/AZECKEbKHWwBYXlDmN+br
         PFwTtq3EDlGZhwL0rcxyaSUAxMH1v9BqhuTnCLPLvpnHVKh8yodEKFga7jVHVWfjVvJh
         zwX87yzM8/cgMnAA3A1+bmLq3mRo32Kw7vxJXIN3aNkIA/AqFwzcQqRkij6oGfiy4l56
         /nq1fdx4+ube5qCbpdKbuo8y7KOSqV2Xdl6cl6HmC0mRa174fIJqMC/D75DVQZpn76xP
         tzyw==
X-Gm-Message-State: AOUpUlHbS9mFNxkK/BIEQhMZ5xhMF2QYjv4B/WHafKnwuPsKSq9iyTxM
        nXZy/jInFmkNuccYV4xZP129NsWRKOr4+54=
X-Google-Smtp-Source: AA+uWPwbMdlAM3hruZhD6PDqxKom3OHq6hhdgRkm+njbjITFCi2EgjaSrDptCtX/frkqd/z3+I/UgzJlq4P8lsk=
X-Received: by 2002:a25:3802:: with SMTP id f2-v6mr8034853yba.76.1534373566067;
 Wed, 15 Aug 2018 15:52:46 -0700 (PDT)
Date:   Wed, 15 Aug 2018 15:51:57 -0700
In-Reply-To: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com>
Message-Id: <20180815225157.89523-1-wnukowski@google.com>
Mime-Version: 1.0
References: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v2] Bugfix for handling of shadow doorbell buffer.
From:   Michal Wnukowski <wnukowski@google.com>
To:     torvalds@linux-foundation.org
Cc:     axboe@fb.com, hch@lst.de, keith.busch@intel.com,
        keith.busch@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, sagi@grimberg.me,
        wnukowski@google.com, yigitfiliz@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Note that NVMe controller should have similar ordering guarantees around
writing EventIdx and reading shadow doorbell. Otherwise, analogous race
condition may occur.

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

changes since v1:
 - Additional note about NVMe controller behavior.
 - Removal of volatile keyword has been reverted.

---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17a0190bd88f..4452f8553301 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -306,6 +306,14 @@ static bool nvme_dbbuf_update_and_check_event(u16 valu=
e, u32 *dbbuf_db,
 		old_value =3D *dbbuf_db;
 		*dbbuf_db =3D value;
=20
+		/*
+		 * Ensure that the doorbell is updated before reading
+		 * the EventIdx from memory. NVMe controller should have
+		 * similar ordering guarantees - update EventIdx before
+		 * reading doorbell.
+		 */
+		mb();
+
 		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
 			return false;
 	}
--=20
2.18.0.865.gffc8e1a3cd6-goog

