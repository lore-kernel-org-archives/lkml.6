Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504DDC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29432086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="h4Sx3Obw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29432086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeIKQ2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:28:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35473 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeIKQ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:28:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so18974330edq.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEulAD0VPHCbsyAksOB2BXn4vdGCb5wrW1dUMxzetv4=;
        b=h4Sx3ObwBxy3vEt3UtVYRpGZuKfiRCTquYAj3x+27hQ+uy6CfcMvjsExFA05MhWutu
         Ksoi6B734Fc5OuRpO/sQC5Q/o7xICUN7AKQXyArzF90AOJ6lUlXwa/1MOMJP4b5oEAtt
         FblCG6f75aNcQrJZaRAewc8wD0NOomjW6uGwEjWJz9Tq9V7T7wQgc5aafMPK5BPt26f2
         0tcb+kvrsbUhEacF93kGiygbERy/UVzlsI/rkjXIP5lfU52G9Y1E8pLoTtOLM4wLJmQV
         3bmtMufSDFlPcL6NGAhBNUL5oGMhoGCo0n+4zgvcxavUhGKsSh7c1icKhhWwZDIx2uor
         46eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEulAD0VPHCbsyAksOB2BXn4vdGCb5wrW1dUMxzetv4=;
        b=antVTu02rZ0uiY8E5ox84E+npiK2+5hm1RiSUbeYCB2rmbma+Vt5aKGK2rmOKEl7a5
         FvUvUwiclwpYAtFGUDp2PHFMjis1FHN/pp5sI7xYuUw+jAt3qLORzyAGZj3/qTDmJXv4
         o9YJFBeLdjtt09KIPKtxbCqbm5C4MvnCLPq1dRDizvCiVuC3UOYoa09hRYOmxKXag9mh
         ljIEd48wjtfJs3QyyzPcIPLGhCFl84BxPF383XlXeAd32mhu1CawcNjC8P+xYCjLKDue
         Lbr3PQD+X9Y93nHGk+WHYqBpoFkGikUyBuMFUQHHb4DCeGut5iLvysfVYPcLZueJ2VgU
         ntdg==
X-Gm-Message-State: APzg51AdqL+DMkPC3+Z1LZ0L0sKxrM4WlEYPkKy8HfjaQzvEjTC8d5gP
        VmuKsKvOSnbyYsJ8mfVknrAdkg==
X-Google-Smtp-Source: ANB0VdYAkNmI7jLhpTgGbRVxm4ULgN2t4BHLGWWS2sWsv2MTmMnLQq6NtEZHnWYI5I73eGST380aEQ==
X-Received: by 2002:a50:a0a6:: with SMTP id 35-v6mr28525584edo.280.1536665361225;
        Tue, 11 Sep 2018 04:29:21 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id r11-v6sm8690216edh.32.2018.09.11.04.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 04:29:20 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V2 PATCH]  lightnvm: pblk: recover open lines on 2.0 devices
Date:   Tue, 11 Sep 2018 13:29:13 +0200
Message-Id: <1536665354-13493-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Changes sinve V1:
  - Rebase on top of Matias' core

Javier González (1):
  lightnvm: pblk: recover open lines on 2.0 devices

 drivers/lightnvm/pblk-recovery.c | 406 ++++++++++++---------------------------
 1 file changed, 124 insertions(+), 282 deletions(-)

-- 
2.7.4

