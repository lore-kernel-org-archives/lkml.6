Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33109C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D187B20833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Sq37eSTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D187B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeIKQYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:24:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38669 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeIKQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:24:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33-v6so18930206edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pnS1XDdseMU+8bNpUPTr6AbfkXzhvcMmEQrjy2K4DE=;
        b=Sq37eSTrAVzuziqoL4bWAF7gNCQBusw33r/dFbrVudHfwGoTj6cteFFuL8t8S+wwsA
         dMlg5DqrNBSyeG3aoulJZJ/nWo04HEaSwsM/rBXulbeTBQYKNOarZdE7gZF3RnqwC/Yt
         wzHxNLePLLlzb5mia7DqDyzVY+e5xlDx0xNV0BPhSJOwPsGD3QPSW9gcTovgizCwBU0j
         L6DoTNO6/LvNZhrvEip6+++pS3Kajeas1CT9cFzQSq3iMdAFaoarpzgRHCVURot8+205
         jhLQAHIHAnp+qsFHcYQI7TzF+FqY7xy+ghSpTLJWktb9IWc4hZizrsD/Y7vKcja7nk9M
         DRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pnS1XDdseMU+8bNpUPTr6AbfkXzhvcMmEQrjy2K4DE=;
        b=RlhUhzrnTyijgCTcJDv18zpsOXhdjJUNQu5iosr5VFx6sawqwRR08N8nQ0hIyqxePY
         zlecjYJaY6EKCMgI7M2k3dae3gR92Nic7SljNQZPx39Urp2J9Yl9N+WWyeHGmV3I/kgl
         0XfMrut5MUnmtwIt5JWr5l9oF5w4BJ5o27WxMkmPMnNe0cGEDWxtp7caJTUn4A8jGnnq
         uLQj8zDThDL8hTyT3lAJEwxG4IhZWur5zu517OR/fAxNfnzzz07lFIpln13dWaxMzD5h
         BEVcAJzxesvBZXnSkiLb6AjDg+r+a2EMquvDdDRB2Vl7vsHT0XXko0jMGkU0wjxQta8A
         JDjA==
X-Gm-Message-State: APzg51CiNz5dZAvIOAtU4x/BCK2OdN5CC/wr4oEB9+L2lz/MhUffDHUc
        1ZReHJz5oG3FQrfhkYCHRlvFSg==
X-Google-Smtp-Source: ANB0VdZquD02wbLju64IUbnUVPRnSSiPHgEOKxxNoa96CWbj4XqohzpPGFhCi2nsDYmpqKfgnH8yBA==
X-Received: by 2002:a50:f10d:: with SMTP id w13-v6mr29236895edl.0.1536665109159;
        Tue, 11 Sep 2018 04:25:09 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id e38-v6sm10941351eda.74.2018.09.11.04.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 04:25:08 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V5 PATCH 0/3] lightnvm: pblk: take write semaphore on metadata
Date:   Tue, 11 Sep 2018 13:24:48 +0200
Message-Id: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Changes since V4:
 - Rebase on top of Matias' core
 - Reorder patches to avoid in-patchset changes

# Changes since V3:
 - Encapsulate rqd dma allocations to reduce code replication (by Matias)

# Changes since V2:
 - Split the original patch between the metadata refactoring and the
   semaphore logic. This simplifies the write path, where the semaphore
   is taken.

# Changes singe V1:
    - Fix double I/O on the read path (by Matias)
    - Improve commit message (by Jens)

This patchset refactors the metadata separate write and read paths,
which simplifies how the semaphore is taken for writes.

Thanks,
Javier

Javier González (3):
  lightnvm: encapsule rqd dma allocations
  lightnvm: pblk: refactor metadata paths
  lightnvm: pblk: take write semaphore on metadata

 drivers/lightnvm/pblk-core.c     | 376 ++++++++++++++++++++-------------------
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-read.c     |  31 ++--
 drivers/lightnvm/pblk-recovery.c |  34 ++--
 drivers/lightnvm/pblk-write.c    |  15 +-
 drivers/lightnvm/pblk.h          |   7 +-
 6 files changed, 222 insertions(+), 243 deletions(-)

-- 
2.7.4

