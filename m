Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB18C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873F3208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWD/o6e7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfACPju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:39:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41011 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731404AbfACPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:39:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so30023467ljc.8;
        Thu, 03 Jan 2019 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0/zg3ZF+d06zlm8fGWqHZgI/e7C6omSc4b4XqJgNkA=;
        b=nWD/o6e7axBXZaTDti2GxbsGZHVTc/qvaYFRowhpmJ44uvc65JnoknGoE9xko7eD/0
         R7wYj52hxOgCca3xuqNqYRVk5HjUpLhPKQTGFwFO4mddE9M6nheWKCjMqgP+t9v4DQq1
         Pei3wcrbqvkGQtsNyNb9r6gE4Kg+xSGfYQBj5MULokZVyqqcHwbDIr03ey9Sfa2rFpk3
         8dyYyNu7YKQmJGWxstrMEJ2HGIGLVakVsPp2mSM0tilOcwezBQ8qc29W1z6fxQyiITsJ
         db4f57jWa7yFJ9kF0YYm3OjumQpExlqf7qqNsrKvvXPozizlzrMpPDyff9LWjendKqDT
         I0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0/zg3ZF+d06zlm8fGWqHZgI/e7C6omSc4b4XqJgNkA=;
        b=QNVA0uVmPO2wi+UZMhbd8Hv/nk3bmIxgIr2pGj33iotyFGs7+1euxBO2feQSea7a/z
         Bm5yKdcN0yT8lgAyhWC75oh5djOKD/k44oWQ3g7oE7/SXgqG+trXDl7pRDjzkKkYSqJB
         JisuiTBQ/8j61kiIGWq/DnwtpOMVxYti8YLnAskZJk5zgcMHAO9zI4Ujc3Hn+rneg69G
         4X+gCXafLDH9N/y6itHwqtEeq3wquXO/vlSgfWdhwrazHKaSJTWdCMWD5nxjZJDgGgaA
         qROw66lskq07i0Y/z31ItIHmUH4yuV/SnboyzZWfiB8FHDTPSPeWmyZLy0eLFBfw/fiI
         S9Hw==
X-Gm-Message-State: AJcUukd5i2I3X2kLOt3YFb8ZWp9M2surI6NSktblefWt2rEi5UK8XXrO
        DB5K3mJ335W8V2VN01wfoOgbxHp1
X-Google-Smtp-Source: AFSGD/XfWy+2IlQTZVS6gvub6IDqD3XZkFhVhRhexa+6Rio0CzjQmNKsyJSMun6+O4APrXPxgxIGjQ==
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr25854409ljf.5.1546529986707;
        Thu, 03 Jan 2019 07:39:46 -0800 (PST)
Received: from localhost.localdomain ([185.16.28.102])
        by smtp.gmail.com with ESMTPSA id y14-v6sm11769450ljj.55.2019.01.03.07.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 07:39:46 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 4.21-rc1
Date:   Thu,  3 Jan 2019 16:39:26 +0100
Message-Id: <20190103153926.15596-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 8fe28cb58bcb235034b64cbbb7550a8a43fd88be:

  Linux 4.20 (2018-12-23 15:55:59 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.21-rc1

for you to fetch changes up to 5ccedf1ccd710ba32f36986b49eeb764e53e7ef1:

  ceph: don't encode inode pathes into reconnect message (2018-12-26 16:08:36 +0100)

----------------------------------------------------------------
A fairly quiet round: a couple of messenger performance improvements
from myself and a few cap handling fixes from Zheng.

----------------------------------------------------------------
Chengguang Xu (1):
      ceph: remove redundant assignment

Ilya Dryomov (4):
      libceph: drop last_piece logic from write_partial_message_data()
      libceph: use sock_no_sendpage() as a fallback in ceph_tcp_sendpage()
      libceph: use MSG_SENDPAGE_NOTLAST with ceph_tcp_sendpage()
      libceph: switch more to bool in ceph_tcp_sendmsg()

Yan, Zheng (6):
      ceph: cleanup splice_dentry()
      ceph: don't update importing cap's mseq when handing cap export
      ceph: don't request excl caps when mount is readonly
      ceph: skip updating 'wanted' caps if caps are already issued
      ceph: update wanted caps after resuming stale session
      ceph: don't encode inode pathes into reconnect message

 fs/ceph/caps.c       |  75 ++++++++++++++++++------------
 fs/ceph/inode.c      |  60 ++++++++++--------------
 fs/ceph/mds_client.c | 129 ++++++++++++++++++++++++++++++---------------------
 fs/ceph/mds_client.h |  16 ++++---
 fs/ceph/mdsmap.c     |   1 -
 net/ceph/messenger.c |  55 +++++++++-------------
 6 files changed, 174 insertions(+), 162 deletions(-)
