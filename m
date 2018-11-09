Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB00C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5032120818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo7VXw2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5032120818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeKJC3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:29:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33068 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeKJC3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:29:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id f19-v6so4167990wmb.0;
        Fri, 09 Nov 2018 08:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a9RDBxSbWsCIxd77IRGeV0BtOEwXPO5Picc2PuFNTc4=;
        b=eo7VXw2fTRYcDcEmMJAsUKDn1ufszl97PDp4egrP1gzOjejyR2esBbMY0DqdqWET6I
         av4JLKzp4NlOvUNlrCluCWXMeqP51aYpVrBJcZCA6ZqYVu/Y97V5ovUGKzUZJMenrkNX
         89MWdmu+kuPBLe4aqf/DxtdE4OSOacQ/SNNzz0qpC6S1MIzCyHfmKycW6mZL+zBSZxBI
         PDCXGxH+9iwzJy3/CzpJh9gDWPPyn2KQX+oRAbO81idDDbBClkGmiBIh62JnIU8eCnLA
         9ImTVflladuuDaRVKQXpF8nAQbyqGgGkXwG4H1GalsIcSNeu2HYBQy/d/eyc+mY+5gqW
         5W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a9RDBxSbWsCIxd77IRGeV0BtOEwXPO5Picc2PuFNTc4=;
        b=mvSybQTX+nXiN87f7aFwgT/LrWyHGzeSyiZZDVWaZFYlpksUQUVg/p9ZjpqWTyqb8g
         FGNHheLIyaooRxLGQxat9r4cspVdGY0qTDxcWJCyLAh8rk2lEb48F0DmdifaREOOCm4M
         MbkaoZ0bCPzwI6LfF60wzEFrxOgmmWQ/RV9upOu48yYGnMJQXFcK+6YHVTwDOQAva/hh
         DtSVK9wtPRThyOzwHdAhXfH4F2GQF962hTvE4inxWpWJRXJZwd4wfJcUNjwxJUCcu2aH
         pyYU+T6cHS0mTpF43plGP6rXtkVbyNvgfPuVyVl+vQGmRHipo9Kj3yF6U6PU++db5tkB
         CmMQ==
X-Gm-Message-State: AGRZ1gJTZFWJf9IbumvbIoHQ8uf7TgW3txXA4RVgbASl7g6WAINyaOXd
        +VZI1ey1JZ3fUNAOzC6gurpuOcYZ
X-Google-Smtp-Source: AJdET5dJty5emRWa4GqPdz11pC2tdjgKGf2WwF5eDVSa+fEdguNgGvvbzbOvINdrhc3GTzyclULdTQ==
X-Received: by 2002:a1c:c142:: with SMTP id r63-v6mr75611wmf.95.1541782097202;
        Fri, 09 Nov 2018 08:48:17 -0800 (PST)
Received: from orange.local (ip-86-49-115-215.net.upcbroadband.cz. [86.49.115.215])
        by smtp.gmail.com with ESMTPSA id c184-v6sm1282300wma.15.2018.11.09.08.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 08:48:16 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 4.20-rc2
Date:   Fri,  9 Nov 2018 17:47:55 +0100
Message-Id: <20181109164755.13100-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc2

for you to fetch changes up to 23c625ce3065e40c933a4239efb9b11f1194a343:

  libceph: assume argonaut on the server side (2018-11-08 17:51:11 +0100)

----------------------------------------------------------------
Two CephFS fixes (copy_file_range and quota) and a small feature bit
cleanup.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: assume argonaut on the server side

Luis Henriques (2):
      ceph: add destination file data sync before doing any remote copy
      ceph: quota: fix null pointer dereference in quota check

 fs/ceph/file.c                     | 11 +++++++++--
 fs/ceph/mds_client.c               | 12 +++---------
 fs/ceph/quota.c                    |  3 ++-
 include/linux/ceph/ceph_features.h |  8 +-------
 4 files changed, 15 insertions(+), 19 deletions(-)
