Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA14AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE0920894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oql54xLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE0920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbeGaWHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36571 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeGaWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so1460419pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1dBBl6JiTqrO8/3WevPlux/l4iPStc6T9ch8sQTNh0A=;
        b=Oql54xLQEa0jdOvFgejQOVQnOS+oroQ/beA8i0xtfWTRsvIqq46NlZLm2/DrKO7XcN
         0HVzGIgNubURSYQn9qYNgueHVRwh5CrDRTdx44pOfUeNbqSPegPdK+EzgNg+Ob8eGMPP
         /+uGneLZku0soQRES09vSxhNIOLs1qGwdlNFaxqNDuzMV6pIey5PHFRvb4hXkRpnLPFw
         HV/SOtOjD9bcL85yBv8rwiwbcK4TOnvmRYc2jw9ENOaIDKNHXv84ocHerYcTMtE3u4oq
         0p/j5IQ8LZsqv4mOdSVHtZ8xJArvTr2GaGdJwEn361CGGtVpXDI2qkvkB9NA9+HH0GHP
         pGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1dBBl6JiTqrO8/3WevPlux/l4iPStc6T9ch8sQTNh0A=;
        b=A9UxIw0I6EV4xayEHWNUvP4Zrj7UyqeGOLd/nQ54H2D19D6AwaZvrUWihcT/1dOYIa
         257ICdh+8YwD9SuKcopgvuJUSUXoQswdo5PfCgqmksgIXvQzQGsErBDO6kh1J7Vt7ozg
         7kYUaQxEtMHKEq6uet1Nov5uMkBpOsufSC1qZF4A+73BpTDpyYPA9chcJ9Fu+xdlaqyV
         QfAG6QKeJ3x/qKYtWk043H5AlnSRHf72Sy4eDJYpM8exrjMLsYYdqUWwfGNue98hnDkt
         t0pvZOwS1CvpZqZAxwOaXbfoF4eLQTqmzI7G1CKPr2NTTrU2lakc+Uucnz+dCAcRu7DX
         t7+A==
X-Gm-Message-State: AOUpUlFxcvkQ/EKZSB7CJGhakdpvDkj/lRSE44Vdx2wf/AEur280dlEg
        k8064Er7Bepe4oJ/AkQq09+TxguyypE=
X-Google-Smtp-Source: AAOMgpf96Mn23m8T8Z+0pu7DUzrI5OQ5v/BzbSAAPxyMcUVDQrC43PJzpA57TgcQMco9LIDdBsW88g==
X-Received: by 2002:a62:21c3:: with SMTP id o64-v6mr23656563pfj.21.1533068710455;
        Tue, 31 Jul 2018 13:25:10 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:09 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/15] staging: gasket: cleanups continue
Date:   Tue, 31 Jul 2018 13:24:33 -0700
Message-Id: <20180731202448.229487-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

More cleanups for the gasket and apex drivers: finish up TODO items
for static function forward declarations and multi-line alignment
style, a couple of fixups for recent patch feedback, and a couple
other issues found in the meantime.

Todd Poynor (15):
  staging: gasket: core: remove static function forward declarations
  staging: gasket: ioctl: remove static function forward declarations
  staging: gasket: interrupt: remove static function forward
    declarations
  staging: gasket: pg tbl: remove static function forward declarations
  staging: gasket: TODO: remove entry for static function declarations
  staging: gasket: core: fix function param line continuation style
  staging: gasket: ioctl: fix function param line continuation style
  staging: gasket: page table: fix function param line continuation
    style
  staging: gasket: sysfs: fix function param line continuation style
  staging: gasket: interrupt: fix function param line continuation style
  staging: gasket: TODO: remove entry for multi-line alignment style
  staging: gasket: apex: move driver-private defines out of apex.h
  staging: gasket: core: use bool type for ns_capable result
  Revert "staging: gasket: page table: hold references to device and
    pci_dev"
  staging: gasket: page table: fix header file include guard symbol

 drivers/staging/gasket/TODO                |    4 -
 drivers/staging/gasket/apex.h              |   62 +-
 drivers/staging/gasket/apex_driver.c       |   29 +
 drivers/staging/gasket/gasket_core.c       | 2040 ++++++++++----------
 drivers/staging/gasket/gasket_core.h       |   68 +-
 drivers/staging/gasket/gasket_interrupt.c  |  530 +++--
 drivers/staging/gasket/gasket_interrupt.h  |   19 +-
 drivers/staging/gasket/gasket_ioctl.c      |  412 ++--
 drivers/staging/gasket/gasket_page_table.c | 1434 +++++++-------
 drivers/staging/gasket/gasket_page_table.h |   39 +-
 drivers/staging/gasket/gasket_sysfs.c      |   26 +-
 drivers/staging/gasket/gasket_sysfs.h      |   32 +-
 12 files changed, 2248 insertions(+), 2447 deletions(-)

-- 
2.18.0.345.g5c9ce644c3-goog

