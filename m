Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC42C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FE321476
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnThzByl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FE321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbeHBKdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:33:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41143 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeHBKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:33:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so812130pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TF1DgZ7pY4LPbfrswnAT7Lt2fEXLPlNspSQ5l4KfkWk=;
        b=lnThzByl/yyr7vUM2PjPX5wbMxag8KugK8xjAmjC0gLgXElNSf38mpvlvI4hxGN6hu
         mOyHaqI59DJpItdoquC3x8ixiqXIUUCGYkwpE3dKYxBtZxIYvJYxDUUA3aStXcREW0hz
         SD/bhChcHqfAkAwfr1/5amaJUXAkI6vlf5dSVyrSp6AzCL1eb18NqoUYDAr+/XflLXKa
         mB5HhH/mdg5HjqyJAWtDJ8HcOyMvphXR+OomY2bXMAwL+D1skU4we5yivi60R+8R5rIG
         Hfgrxgire1mlWIMnRHbc0NvJUzzSVokfbLiSJKmEppK0Cb74p4N/K/S6kZ2Nn4ZYr1yD
         vJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TF1DgZ7pY4LPbfrswnAT7Lt2fEXLPlNspSQ5l4KfkWk=;
        b=BcoLU812iQfmLGyXYmvpHb97MsB8B205GifgtX799zOfgu8iPycQ6aPYC+ylH+mRxS
         MUtnVeO4MlPLH6w2AmUpsGsHCa3oetu2ElGaXEMO5MuzYavFH/pxIb++Q+r1YCPXHPRw
         Vs513PPn51Y4LIZq/dije59Tg5eMwSHyyseNLUko9k9PSB2L6bgR38EgDmQYDYA8nGpo
         D6zEma/jxJRN1PPTgM05DTRIQarn2H8KWjtEr5Kzfaz9CXF2AoR+LJC676b4Ng6aKDx4
         F3U4TCLU1qu4ViXxdGtlxQk0brCMb3/l3xWbGD2Xrjn38lgUEGdBrVuTdt0FBh7ka7q/
         hPhQ==
X-Gm-Message-State: AOUpUlHuUypU6aitBDy07kReaylVC4o0+GsHOhk3YaNWiPq+ocCqQJ0m
        CfuKchexmacom0eVg5GIXVo=
X-Google-Smtp-Source: AAOMgpcG4IBHlBJffVezwVWz3TgfyMGI/7OeEm/WDzwWaNx4BO9FkaGGsKQdigry/Ry2hgfpNVRtqQ==
X-Received: by 2002:a63:c60:: with SMTP id 32-v6mr1827617pgm.155.1533199380828;
        Thu, 02 Aug 2018 01:43:00 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2128397pfl.156.2018.08.02.01.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:42:59 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 0/8] staging: gasket: cleanups du jour
Date:   Thu,  2 Aug 2018 01:42:37 -0700
Message-Id: <20180802084245.239689-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

More cleanups for the gasket+apex drivers.

Todd Poynor (8):
  staging: gasket: apex: enable power save mode by default
  staging: gasket: core: print driver version code at registration time
  staging: gasket: core: move driver loaded log after error cases
  staging: gasket: core: device register debug log cleanups
  staging: gasket: core: add subsystem and device info to error logs
  staging: gasket: remove "reset type" param from framework
  staging: gasket: apex: drop reset type param
  Revert "staging: gasket: core: hold reference to pci_dev while used"

 drivers/staging/gasket/apex_driver.c      | 22 ++++-----
 drivers/staging/gasket/gasket.h           |  4 +-
 drivers/staging/gasket/gasket_constants.h |  2 +-
 drivers/staging/gasket/gasket_core.c      | 56 +++++++++++------------
 drivers/staging/gasket/gasket_core.h      | 13 ++----
 drivers/staging/gasket/gasket_ioctl.c     |  3 +-
 6 files changed, 43 insertions(+), 57 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

