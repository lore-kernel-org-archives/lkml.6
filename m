Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC2C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8DE21A06
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpri20O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8DE21A06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeHLQkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 12:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbeHLQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 12:40:40 -0400
Received: from localhost.localdomain (unknown [58.212.144.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C58219CD;
        Sun, 12 Aug 2018 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534082551;
        bh=Ey7++sjGnMNuQQPuR7NhRVTTfcBZK8XH8uzLkUNcisw=;
        h=From:To:Cc:Subject:Date:From;
        b=Hpri20O0KQBoGWPgJ3kXk+EmsdMto9dqNx+LnemmudWfUAhXKEQIe7NLzB6Ms2DZG
         CoqFiNIPRtM5HFot+dNcdU08cEI+k7ucWQIGRj9YMErU+XHS9KiQcwcuqZztmys2Bj
         0S4bKLrDR5i0evKHbd2fLmMPdrQJ95wMCXoVi+3c=
From:   Chao Yu <chao@kernel.org>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 0/8] staging: erofs: fix some issues and clean up codes
Date:   Sun, 12 Aug 2018 22:01:42 +0800
Message-Id: <20180812140150.13397-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

This patchset mainly adds error handing code for erofs xattr subsystem.
In addition, some code cleanups are also included in this patchset.

P.S. Some other patches are still previewing in the linux-erofs mailing
list, which will be posted in the 2nd part later.

Gao Xiang (8):
  staging: erofs: introduce erofs_grab_bio
  staging: erofs: separate erofs_get_meta_page
  staging: erofs: add error handling for xattr submodule
  staging: erofs: cleanup z_erofs_vle_work_{lookup, register}
  staging: erofs: rearrange vle clustertype definitions
  staging: erofs: fix vle_decompressed_index_clusterofs
  staging: erofs: fix integer overflow on 32-bit platform
  staging: erofs: fix compression mapping beyond EOF

 drivers/staging/erofs/Kconfig     |   9 ++
 drivers/staging/erofs/data.c      |  62 +++++++++----
 drivers/staging/erofs/erofs_fs.h  |  11 +++
 drivers/staging/erofs/internal.h  |  64 ++++++++-----
 drivers/staging/erofs/unzip_vle.c | 149 +++++++++++++++---------------
 drivers/staging/erofs/xattr.c     | 125 +++++++++++++++++--------
 6 files changed, 266 insertions(+), 154 deletions(-)

-- 
2.18.0

