Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD3C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E779D2170A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2mfty9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E779D2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbeHCDn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:43:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44131 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbeHCDn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:43:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so2055139pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 18:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WnRuYzGFhx6UlbQlz+6BC+5YyfqFt0ZD4rvGYljuAg=;
        b=H2mfty9QL/qnO8wXsKaSkr5nqB77cxc9nKo3i7TbsGetHZgYB37CxeL1ronlPdmXGw
         7eyUpZuLcuoNxwd1uvEKh0Woqn6+DAzL9P6U0X3Z+ZOkSDAy/TTBC/WqIFA1JgIwqhjs
         IOwWuNSP2mx1TSx01LgBSEFXN0T/l29/fMMA2XkhkfUDJyu+1ftZmBLdb9hE+y7gYxDj
         ps3aM9jC/C6mzTmD6Hzzh7Lx1Xz3TLP0bfaEEFWnHIm9Pbpk92NLlEklWdEYGVp+UPVH
         wMDYIsjZ2kT1IP0KWriUtAyeipM43mQ/BPqfYSx4dquu15q0VBOrEoAScaJiWKNOkv5A
         1q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WnRuYzGFhx6UlbQlz+6BC+5YyfqFt0ZD4rvGYljuAg=;
        b=ZIjgg0xh+CrJyFvfjzGYng1SDvRKWoREvdgtapKChi98RoQETIFXTC6/WCuXaScbWz
         YD63n2sdCn+YmYrNyJ8GXZ6ESADXkTVQ0V8fYyKA/4ZPkP9NJukBu23AQ/oma1C3Rhsn
         XsPpKZ5LaegjK5SyAvmZwq+XYYQkNT1wlvCUH0jFN70fcBWqRQQlc1PBUyaSJ4TYpBnF
         R4zMfB+t6woiUQUDbad9ybJx6D3BRkf4Oa+m6nToSLwGf98VG9FWY+5r/gkGEl2maLj/
         boDtzz46pZ7W0r/pfdF9tqiilPKGNyiA1LXvP6vkJ4y/uV5LxL5znN5uPTbTUP4kJoEB
         3V9A==
X-Gm-Message-State: AOUpUlHCF/f/H4Xf1z0I2mKjhvoF3UgxbGiHGkD4J1MDHA1/7zI6oFZH
        usply7SV4s6rpTYJDm0DerM=
X-Google-Smtp-Source: AAOMgpdNetvPeFO+afhcIQmlHi7D0y6uHRMy7crIsRqlLtHZ0dUDXwnJtg0oIzO8i6YSmtgdjwqp+w==
X-Received: by 2002:a63:a919:: with SMTP id u25-v6mr1746118pge.211.1533261003453;
        Thu, 02 Aug 2018 18:50:03 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m81-v6sm7348315pfa.188.2018.08.02.18.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 18:50:02 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 0/4 v2] staging: gasket: cleanups du jour
Date:   Thu,  2 Aug 2018 18:49:48 -0700
Message-Id: <20180803014952.104582-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

More cleanups for the gasket+apex drivers.

Patched changed in v2 from v1:
  staging: gasket: core: print driver version code at registration time
  staging: gasket: core: move driver loaded log after error cases
     Above 2 patches replaced by new patch:
        staging: gasket: core: remove registration logs
  staging: gasket: core: device register debug log cleanups
     Drop explicit "gasket:" prefix, use pr_fmt instead (in following patch)
  staging: gasket: core: add subsystem and device info to error logs
     Renamed: staging: gasket: core: add subsystem and device info to logs
     Use pr_fmt for modname prefix on logs
  Revert "staging: gasket: core: hold reference to pci_dev while used"
     Fixup SHA format in commit text.

Patches dropped from v2, already merged from v1:
  staging: gasket: apex: enable power save mode by default
  staging: gasket: remove "reset type" param from framework
  staging: gasket: apex: drop reset type param

Todd Poynor (4):
  staging: gasket: core: remove registration logs
  staging: gasket: core: device register debug log cleanups
  staging: gasket: core: add subsystem and device info to logs
  Revert "staging: gasket: core: hold reference to pci_dev while used"

 drivers/staging/gasket/gasket_core.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

