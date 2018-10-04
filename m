Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFAAC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAE421470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Q1cygXv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAE421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeJDOFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:05:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36804 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeJDOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:05:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so7593935edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vM7vySXZTrr1+BSl9mqXbWAnhT1LO6Fbc3aoCzr+j3w=;
        b=Q1cygXv2QWihRnrCx1fXU2C1z2+TV8l7kZXbQPHL+s6J01fU56YidPa4jGHq0nFZUv
         Vqrx/IEC6VvWWh/y9GkqtcAi9rhhy/nCM5DJb1KGXM6/Llo8muZ+H6jP5uDRo1iWSeWc
         nkemIbO1mYRHW7nxSLHS7183lpjk3/GMxF216TUpYg52Wxyo5Q84wOgKrmZh9w+s0snU
         tB6yRh8gWvmnP6dZVe7nuSvLVbMgjkRg8zKaw5ZhtLv2u9PeBYfcroGwjaitkoMBszkW
         siC7Qzb3I4iBHYGCBvgXl9T0l7PGYVUkjGpHHicdEDB4HWM1X+M8uN/ySDTDNUPNNU5b
         vzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vM7vySXZTrr1+BSl9mqXbWAnhT1LO6Fbc3aoCzr+j3w=;
        b=l7x9Ug5zq9z6cwUEL5yP2DNnF0P/Z1pS5xNeEHkgty9+ayCudt1COJV1efZn8fKgZZ
         pJokQb8cdvmniEc80IucC0/01EB4vWedW5Y2sj7RVOy5f5Tjs5M9pGQsaBFX1ZjJLqTa
         RtdM+lv3ZlgTh45yl4f6+Kv2ebDI7O+jBPTNxmWoYD5aVxE1P6baeP7d4kYlaxrp8k02
         m1s6jwvKfTj/woPINdAsVrcAMYOUdXYtvLkTF4jxzJnMs7uRyRIVsOg3yxV+OIgTPT66
         otN3SwIwqfxddXov45ZedmTLOv08v3WyOHof0LI4XaRFh7Q53RcJ2xdD4zCd9PeIMNxo
         vz1w==
X-Gm-Message-State: ABuFfohjJRfyLR2XMawg3tsLLxl96Jd/T9akzu1XXuWb8kmhUW2kju9C
        Oa0KFkl2Ac4sF6JpMxfpq4RWqw==
X-Google-Smtp-Source: ACcGV631Gi4YUCm4alh3O8hAu/msbjBuJfXc9xRO9PzQXlvpFBFErO+PzNEvkOxgHU4puI6sbIUtqQ==
X-Received: by 2002:a17:906:92d8:: with SMTP id d24-v6mr5162658ejx.96.1538637242635;
        Thu, 04 Oct 2018 00:14:02 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f39-v6sm1297462ede.75.2018.10.04.00.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 00:14:02 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V2 PATCH 0/2]  lightnvm: pblk: retrieve chunk metadata on erase
Date:   Thu,  4 Oct 2018 09:13:53 +0200
Message-Id: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes singe V1:
  - remove sanity checks on the fast path

This patchset implements support for retrieving chunk metadata on reset.
This is the base for implementing wear-leveling and allowing chunks to
shrink at runtime.

Javier

Javier González (2):
  lightnvm: pblk: add helper for printing chunk state
  lightnvm: pblk: retrieve chunk metadata on erase

 drivers/lightnvm/core.c      | 44 ++++++++++++++++++++++++++++++++++--
 drivers/lightnvm/pblk-core.c | 54 +++++++++++++++++++++++++++++++++-----------
 drivers/lightnvm/pblk.h      |  9 ++++++++
 3 files changed, 92 insertions(+), 15 deletions(-)

-- 
2.7.4

