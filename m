Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B39C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD472084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="zrE6XIc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD472084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeH2MwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:52:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34809 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2MwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:52:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id u1-v6so3179901eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LOWMU9nbKLMRVxYpdWBu3kVYOaxx2yoK/+OTATVMhF0=;
        b=zrE6XIc+Z4lKyvbMO2XJvcJoqNiUAOynfriuc9PPVstXorGAeCA6Dx5aF3bZmIcdkG
         lwe+1aylMYEII8zsy+O8o7ovZhLw35oOI2FHVOMjQ3jGWu89e+8WNOs8ktjMSwm1E+Bn
         phpnXHjMCgNrv/As6NYHrMlGnD61P3klnOYN9q/67UvbJzGu/q8nCIfBgUhexhMsuJno
         WiG/pMNq2GuGcMABy5ASmf2n1XeoRVH+Gx4Dzl4gzDEyscRgxh8YI2fiTN88xzdZDsM+
         ojcsNcXtZg1lmZhFzpH4yaiyr2y9XohU7Xz/Fh5p8peCf0kMsXuPD9EbrYFmngpUl6eV
         j7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LOWMU9nbKLMRVxYpdWBu3kVYOaxx2yoK/+OTATVMhF0=;
        b=m+0IvVMgK8ZuPQ5qp1/qQ+BzN6wLvp24qjT9La581K6rgZXh/QcIOT9boPZls0ti0M
         4RiJg3VET60u+X1FRCzw3HsHZHMstU2BPri4szU3jzc2+Pi/ajxM/CqdHr1Pz4C7a3xH
         8FSU2ptxPwb+6Kt8Nyyeq6mfZkCP14Moh6kDa1XeSh7jnaRkJxjAs93ZXbSedk7Ugqor
         BeqMZkIZN0RGxT+1K/yFOuvcL0Jnk5IBol4UqwkBc490TP34TH3Pz+ZF8QwvwcRilGBG
         Dw3jsUIk/Y1ctqthbUkodMxrvda2PMNZkTmoxJOqN3JdL030V8bngLIfmbrTj/mpR7a3
         9gjQ==
X-Gm-Message-State: APzg51BkEW3qrqRbI8Drq9YyBT4iKToUj+rFtbyfBL2iCo3Soo5qUfMT
        ec5bDrbp/Sasl0QL5XCmolSiKtMXotw=
X-Google-Smtp-Source: ANB0VdbmjHP4PEWXZjRNhNgEoz2iVE0GmNUODriP77b3opnTgoCaU57Kb05O1IkZHFrfqdxa2B2C2A==
X-Received: by 2002:aa7:c485:: with SMTP id m5-v6mr6468295edq.205.1535532987447;
        Wed, 29 Aug 2018 01:56:27 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1867867eda.34.2018.08.29.01.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 01:56:27 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V4 PATCH 0/2] lightnvm: pblk: take write semaphore on metadata
Date:   Wed, 29 Aug 2018 10:56:17 +0200
Message-Id: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  lightnvm: pblk: refactor metadata paths
  lightnvm: encapsule rqd dma allocations
  lightnvm: pblk: take write semaphore on metadata

 drivers/lightnvm/pblk-core.c     | 377 ++++++++++++++++++++-------------------
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-read.c     |  35 ++--
 drivers/lightnvm/pblk-recovery.c |  33 ++--
 drivers/lightnvm/pblk-write.c    |  15 +-
 drivers/lightnvm/pblk.h          |   8 +-
 6 files changed, 230 insertions(+), 240 deletions(-)

-- 
2.7.4

