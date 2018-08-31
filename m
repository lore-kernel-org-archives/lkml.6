Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A88AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA772077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="pU2oumeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA772077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeHaRmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:42:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36489 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeHaRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:42:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so9073960edq.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nhIunP7bSFMeR7TNVlpFhYojFMpn151No6kRgAw/0kI=;
        b=pU2oumeISfu4ueFZayViBvW47o3QJDkGy7Q4vdjwVKKKZzIPLJRaJRQRKMXCTR9dkI
         crFCwl5VKeUNdFL5N0aRbV+E/TEf6gsL9LmzUHvTXrJLRnG85Hgl+HknMGMo88FWAZov
         qP6lRzqLQnSjFnVcqDo3GCG3qP1po4cC5nxAontj1ktvCNQ87nSpB0bRQwT2m1N14E9j
         /JDj2+AjayjC6E8/0+Trwd8A1tNKuEjcA63NGVDQTFH1XJrVSPPUFoXGfzadPpO9M6sc
         gYanMP6LwpPqqZ4ws98wL9F+xX+PTIeon04uQffpCsvDdxQxt3gUkR9WlJlwnNpRYIXY
         noVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nhIunP7bSFMeR7TNVlpFhYojFMpn151No6kRgAw/0kI=;
        b=KEw2wpWBLU2woQOBiXIMoWiW3lP7kGvTvjUQ3WVDuv2LVoP+bPOUEXcDMcvEDlqL/V
         LyXaSV6N6iyBGnRcWMbrM0FlxhPf3fXogyCCa1p5wj7Cj8Hx1HBj/86wOAtC+6XlGZvB
         gy/U8A9ga6c6fcD+LOF5+iMEmwsdP/AFnAWGBy19fdguQRFYF4vIdNnm8ySoI4SlNTsy
         8Hx+tnSi/RvdDPmrqfZ5m370BIdnYmaNAExmxhNc1INb3sEjlJK/H7oFllbgbv9QUXDQ
         1DkKMWsV0Qka7UvgjcVijZE1zE4gcmCVe+bY8yTmRLyIJ7ZIkTE97RPz4KnB/PL4tb6X
         55gQ==
X-Gm-Message-State: APzg51DWVT7UO8OcpaDvUazuCmbiJJzd4TNrQYCnYhALLcS3Pr/4WyGZ
        hMgL7vDW1Iyx4Jhc2SsTsG9Rug==
X-Google-Smtp-Source: ANB0Vdbz1zY/xGjjqbccmCM8Hq1x9JeRwVuEiCpE8BeXtiHI8b0Ojp8FTX+UkLYd7JN2StNFhHF8yQ==
X-Received: by 2002:a50:ec03:: with SMTP id g3-v6mr17919980edr.96.1535722485920;
        Fri, 31 Aug 2018 06:34:45 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id i19-v6sm1937851edg.64.2018.08.31.06.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 06:34:45 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on erase
Date:   Fri, 31 Aug 2018 15:34:33 +0200
Message-Id: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matias,

This patchset implements support for retrieving chunk metadata when
submitting a reset/erase command. Patches 0 and 1 are small fixes that
can be directly merged into your patch:
  
  lightnvm: move bad block and chunk state logic to core

Also, note that these do not apply on top of your for-4.20/core due them
depending on patches that I sent before that you have not picked up yet.
You can see them though in for-4.20/pblk. I'll rebase as patches in the
list appear in your tree.

Thanks,
Javier

Javier González (4):
  lightnvm: use right address format on 1.2 path
  lightnvm: assign block address before slba
  lightnvm: pblk: add helper for printing chunk state
  lightnvm: pblk: retrieve chunk metadata on erase

 drivers/lightnvm/core.c      | 51 +++++++++++++++++++++++++++++++++++++++-----
 drivers/lightnvm/pblk-core.c | 47 ++++++++++++++++++++++++++++++----------
 drivers/lightnvm/pblk.h      |  9 ++++++++
 3 files changed, 91 insertions(+), 16 deletions(-)

-- 
2.7.4

