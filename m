Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D4C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADDF20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASODztvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADDF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeG1Gr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 02:47:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39870 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeG1Gr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 02:47:27 -0400
Received: by mail-pl0-f68.google.com with SMTP id m1-v6so3160381plt.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 22:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YNs2ohy2eoAFLKC5aolKid2MyfF9L0Orgb9HiRaN3mE=;
        b=ASODztvhrnGTG33K1rL1W4JNHgshBfN1cyf6xxjLSsc8rKiur7ZDb1ShlwxBTMt0fB
         RjAwDN96GV0uLXc0NPh0cO1C177GE5SKxaexHZezYsqqqlZkztW8VwAeOTP9LKCbpNc9
         1bvpqFqi7Ls8z6753GjboP4JkeS+aR7ZNGDzijGZqnXXEqSDwlINC5RZQ0Y2Zc4wfDCs
         esJulOcxfA0B9VacLcjHM4R6GJhZ8yufLXgvlk6d48tOwkepZVVEc0uP2EDeRQ3nPmFa
         VkJzaxRBulxM4Orx2MHtSUlIgPKJZd7EUX2d25tUtFIrznVyR1c8L7TYEGZmi2Q6lrkE
         y9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YNs2ohy2eoAFLKC5aolKid2MyfF9L0Orgb9HiRaN3mE=;
        b=MA5nU9UWaqKtgoQISRFgvula5Lzf61KegBYl059guL+SYpBqz6WGdyGKuKvELp0OvE
         1Zv9XW7ZBoL0GUonMF2LIyrfr1Zr9vwOGiXZU1Py4WyNdF5uQorticXgu1xsGUgfdmFa
         pYWfohH8No6GXnVd0YvuyU23vrSB0waN09HEblbF7muPJpcUi0XmpQrwbEkigfPcuR2I
         sREGiLO7vQ1cq2tRRsv5coHGov9D8AMOFL/Lrzab8/E/cDX46PnFJoLHR8QZrN6z+RUx
         xqIaA2pE9d+G3ybptRtNmcKOPwDbhEOi3Ot4qrc5ttm+ERehiTu9IiNNy3vRqk9tZs7o
         jL8g==
X-Gm-Message-State: AOUpUlGgEfYVmNUUniuegkQa6ZGblmOxBYMFLk0Mh9Fm8sTjDVPvSluh
        j3wXGF76WpRjgOtbbfuE9NA=
X-Google-Smtp-Source: AAOMgpfSgOsaoxP1NYSuhwTVhGrhErVwN1YdUF73gYCFInkYmCsBM7QBqBLF/Se37NyAlC2P2FFe7w==
X-Received: by 2002:a17:902:280b:: with SMTP id e11-v6mr8507791plb.298.1532755340308;
        Fri, 27 Jul 2018 22:22:20 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id y85-v6sm8837195pfa.170.2018.07.27.22.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 22:22:19 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 0/5] staging: gasket: fixes and cleanups
Date:   Fri, 27 Jul 2018 22:21:55 -0700
Message-Id: <20180728052200.228796-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The fun continues with gasket+apex: remove dead code and unnecessary
stuff, fixup apex PCI class for devices that advertise class 0
(undefined), and make sure the struct device doesn't go away on us.
Most of these from review comments of previous patch series.

Todd Poynor (5):
  staging: gasket: sysfs: remove check for refcount already zero
  staging: gasket: apex: fixup undefined PCI class
  staging: gasket: sysfs: remove unnecessary NULL check on device ptr
  staging: gasket: page table: remove code for "no dma_ops"
  staging: gasket: core: hold reference on device kobj while in use

 drivers/staging/gasket/apex_driver.c       |  7 +++
 drivers/staging/gasket/gasket_core.c       |  5 +-
 drivers/staging/gasket/gasket_page_table.c | 58 +++-------------------
 drivers/staging/gasket/gasket_page_table.h |  3 +-
 drivers/staging/gasket/gasket_sysfs.c      |  7 ---
 5 files changed, 17 insertions(+), 63 deletions(-)

-- 
2.18.0.345.g5c9ce644c3-goog

