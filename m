Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADFAC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E9021916
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYS+hvYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E9021916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeHEWNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:13:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39765 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:13:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so5783095pff.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs/H7XduWgrli+d+F5Rqwgv7TDM4XFuZXMan8DvKyL8=;
        b=pYS+hvYWUb5auuwPMwFOBpsnbqig5G3OFRQYc28Hx4FqiwibtZzbBQP0KaAIFrakvD
         DM5zHMF/qrs6fl00FHghsrd4GzzDyHWAnZz0FNXFsYKq3UPyc8WidiXRz9jN4MxZUVUf
         ZJvMGVTgVjtqAEAoGCvrOIRdg3hvcUNFdEIkiyh+R5V1v0IDCByrGKpk1nO4uM0lR8F2
         A+hAlvDhY+Ul2+lJpHucvG7Fw4Na+QyTD/Z0VcrHaZDj/VPCZ5G2njiU2eXNiSoOZxuu
         FB61/ZL2J34+ZU7TNxdvWbY9i0Q0pEEQ1rFroPGgNQAnUneaYHjdMAnErs6tQZ18FXc5
         xUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs/H7XduWgrli+d+F5Rqwgv7TDM4XFuZXMan8DvKyL8=;
        b=fjUD+RqYM340WAdNA9KCkT+eIpBFBUa05HZSxOCo66pW4C7Ql1MhPuAfbowgA5wbU3
         e1kAQkntsOv/uVTexCCte7rXYkSvMh/Nsmo91djVu6piAWJS/apeF/QnRleIlJhYboJZ
         AQlXlSmWs0o+TGaNskgPF5XfnYc1+pTKNfM+FEqQmIofJkGbu0kGRzJl+RW2+263Yt/f
         1hBscCaBRH1xuobYeqhK9CPAH7zbjwgFUXz8mVMs/WrVvel239NA7bq2E2fLuHIMhTgq
         /5GNsuje5GDWKOjhMk+G4lH2Kz6tqfrPi04me+55g3EbmwoFM3XFUynGgsLw3BJI+Mc/
         7vNw==
X-Gm-Message-State: AOUpUlHB35hXMogqDveSyde53UJJYPbS8eJ9RC47QQ0aZTyZwF5rX/SP
        vCBvys3ykyu+Hqe9G3hqdDw=
X-Google-Smtp-Source: AAOMgpcvdKiwLG8NKRnC0jsp2VXZG2xxDSMqmoAFMmABxT9Eha+UXt3+JwGllBD+QKorbSCL37hFrg==
X-Received: by 2002:a62:c410:: with SMTP id y16-v6mr14045499pff.161.1533499689200;
        Sun, 05 Aug 2018 13:08:09 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:08 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/15] staging: gasket: unwrap pci core and more
Date:   Sun,  5 Aug 2018 13:07:34 -0700
Message-Id: <20180805200749.116693-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Stop wrapping PCI core calls like probe, enable, remove, etc. in the
gasket framework, move these calls to the device driver instead.  Have
gasket drivers call into framework on init, enable, disable,
etc. sequences, rather than the other way around.  Remove the
gasket-to-device callbacks associated with these sequences.

Plus a few other fixes and cleanups.

Todd Poynor (15):
  staging: gasket: sysfs: clean up state if ENOMEM removing mapping
  staging: gasket: core: move core PCI calls to device drivers
  staging: gasket: apex: move PCI core calls to apex driver
  staging: gasket: core: convert remaining info logs to debug
  staging: gasket: core: remove device enable and disable callbacks
  staging: gasket: apex: remove device enable and disable callbacks
  staging: gasket: core: let device driver enable/disable gasket device
  staging: gasket: apex: enable/disable gasket device from apex
  staging: gasket: core: delete device add and remove callbacks
  staging: gasket: apex: fold device add/remove logic inline
  staging: gasket: core: remove sysfs setup and cleanup callbacks
  staging: gasket: apex: move sysfs setup code to probe function
  staging: gasket: core: protect against races during unregister
  staging: gasket: apex: place in low power reset until opened
  staging: gasket: core: remove incorrect extraneous comment

 drivers/staging/gasket/apex_driver.c  | 145 +++++++++++++++++---------
 drivers/staging/gasket/gasket_core.c  | 140 ++++++-------------------
 drivers/staging/gasket/gasket_core.h  |  82 +++------------
 drivers/staging/gasket/gasket_sysfs.c |  13 ++-
 4 files changed, 148 insertions(+), 232 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

