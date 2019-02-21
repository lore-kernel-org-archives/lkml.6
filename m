Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A5BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5622083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBoxrJDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfBURP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:15:27 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40502 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBURP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:15:26 -0500
Received: by mail-wm1-f43.google.com with SMTP id t15so9918138wmi.5;
        Thu, 21 Feb 2019 09:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayxuSwqcGDCqyE2cx8MplKfS479f9qUe16s4+Kmxv0o=;
        b=aBoxrJDfcJmvlSC4Uacm88etxXMtA9VqD0AwF32o4ty5XI5lG7WyQ5al3vHv5v7iKn
         TW/j13CcGiJpjc2xPHQ0NdyEyMlA5vdBICqbsHiSF0UVuubOBLNAok7rAl4svUlycViN
         xi7nZAzupIe7v7+pbQ6aZHteHZbk0C1zoPnJd7DGVtl8KwtKl/f9DO4p31zM/8FaKLfU
         mjfRLPwJcDieZdtcjmWf1WXOfY36CQXj9xmlPkA4lEa4FFBq532CmBUQS1+O+BU81d83
         kyrAO5zIxpUt5uRmm8UGCcQitgqaGSc2hjMk8/w/zoK2aRdIKqHmYdbGotYw2CPpVk2L
         zjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayxuSwqcGDCqyE2cx8MplKfS479f9qUe16s4+Kmxv0o=;
        b=PKCz3nv8TKNKJm2b5ZvP1zOCcGgVFHE44GwUniGVAuRWCepujgqahBQtHYPni25gIE
         LFOvvTrewLAfBlDv7ak4ZKyUQryY0yG89TiVAcT7+uHObu27WUvB64N/AvBkdBWd1Qs6
         PXD/jBOxbe9Qe3vfjRp/jNzEEm3tyyECg/kTWnNcbgSvfviGT+syWbX2L6fWAsdZepNp
         SzhFSm0vdrhrDxONLq0fVW/+OLCnJ/H4uF8Yq7AMPySNJSlduNCOjVo7cIRXkCFSn62M
         lcn+pPXo7d+eFJF4XqclRy8aHYKCFmdRYnaj364AmJ2NmsjzHgfLv3deSYJhc/7PAXm4
         AJIQ==
X-Gm-Message-State: AHQUAubAgRqT8R5Y+lXVcwIMSZ2Oynyg6yCnqAj1LbyK7srcV33guk7X
        wHw7P2R51Ir9ivlC9EOlHqsJiRCG
X-Google-Smtp-Source: AHgI3Ibp4bGNWHZRSg0WHTwiK4o3E7uwbpIcbI3++Jc2JHLK5D64UcyvR5o+j+jdVdrXxzdj53Lx+g==
X-Received: by 2002:a1c:4009:: with SMTP id n9mr10776020wma.132.1550769324733;
        Thu, 21 Feb 2019 09:15:24 -0800 (PST)
Received: from kwango.redhat.com (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id m16sm18309450wro.78.2019.02.21.09.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 09:15:23 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.0-rc8
Date:   Thu, 21 Feb 2019 18:16:07 +0100
Message-Id: <20190221171607.2756-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.0-rc8

for you to fetch changes up to 04242ff3ac0abbaa4362f97781dac268e6c3541a:

  ceph: avoid repeatedly adding inode to mdsc->snap_flush_list (2019-02-18 18:08:29 +0100)

----------------------------------------------------------------
Two bug fixes for old issues, both marked for stable.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: handle an empty authorize reply

Yan, Zheng (1):
      ceph: avoid repeatedly adding inode to mdsc->snap_flush_list

 fs/ceph/snap.c       |  3 ++-
 net/ceph/messenger.c | 15 +++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)
