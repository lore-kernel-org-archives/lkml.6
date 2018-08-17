Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30532C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA928218F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fy3BP0X6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA928218F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeHRAqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:46:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeHRAqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:46:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10-v6so4129143pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CD+I3EtfjTVRv8UGAr0JBdr/LVr4o/w1tSfB1TQz9QY=;
        b=Fy3BP0X6fXRyfNLeWV9Rdvby1vXCjkmao0ydAuZuxWE2yryaPMBUj/sCCdgL1hyKFl
         RnCjKscT10wmP2kiT+95kdd9rjBtVi+nosLdj7CKryyDDkSsZiJQ70nsVDSyMMZUxg/z
         7H5qrBo+QZPsAcqwKuXSxYxA2YHne5koeO3mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CD+I3EtfjTVRv8UGAr0JBdr/LVr4o/w1tSfB1TQz9QY=;
        b=UsKhrJ5aC4hA1Nl4rsDxdIJJdjL8EiGIhSAk7xQKagikTHDGQTln4gMgfBgktqW/Pu
         vLOArqx9OaMYo84mnM25RNjNbMYTpUkAwb6t44H7IDyV21N8aN0+FCFW4CEkvHSAu0R/
         8NEPDdKoGQ2eoopBekXP6j+aXW0AKP8qP5gq1RDW/YbhWImyQ0Nloq/drDzYnUF+IQmm
         4ZPSKhxxebPWpYn8uX7C8X+dOu2tdJIASnC5gV15FyDLfRTsAecTP6084zTBGueAadTC
         ZxVsgDVSq8jgsbH4VG+xTL/sU1UrYWHoJm7dpjS46kJYMciGMxwybUJxJnaOQhxvfObX
         3AGg==
X-Gm-Message-State: AOUpUlEqu3pFn5oEp4cyqHFY8PeFfGwdkR53Cx+cjnkPz+UhFoEuTuhw
        KBqDFfRq+G27BaE7rN81CK0bng==
X-Google-Smtp-Source: AA+uWPzaq8zez/8gZn2MSqhxdKFq8gg97l9IpvSKTAdkMira9MGGOcInCeN/gaGz6E2VNI6nbx40lg==
X-Received: by 2002:a62:398c:: with SMTP id u12-v6mr38401264pfj.9.1534542092154;
        Fri, 17 Aug 2018 14:41:32 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l84-v6sm6087863pfg.3.2018.08.17.14.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 14:41:31 -0700 (PDT)
Date:   Fri, 17 Aug 2018 14:45:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>
Subject: [GIT PULL] hwspinlock updates for v4.19
Message-ID: <20180817214522.GC3941@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/hwlock-v4.19

for you to fetch changes up to ddb34f480d1b8051bc18e6ff22e93a6c9a33f94f:

  hwspinlock: Fix incorrect return pointers (2018-07-30 20:54:51 -0700)

----------------------------------------------------------------
hwspinlock updates for v4.19

This introduces devres helpers and an API to request a lock by name,
then migrates the sprd SPI driver to use these.

----------------------------------------------------------------
Baolin Wang (8):
      hwspinlock: Add one new API to support getting a specific hwlock by the name
      hwspinlock: Add devm_xxx() APIs to request/free hwlock
      hwspinlock: Add devm_xxx() APIs to register/unregister one hwlock controller
      hwspinlock: Remove redundant config
      hwspinlock: Fix one comment mistake
      spi: sprd: Replace of_hwspin_lock_get_id() with of_hwspin_lock_get_id_byname()
      spi: sprd: Change to use devm_hwspin_lock_request_specific()
      hwspinlock: Fix incorrect return pointers

 drivers/hwspinlock/hwspinlock_core.c | 223 ++++++++++++++++++++++++++++++++++-
 drivers/spi/spi-sprd-adi.c           |  11 +-
 include/linux/hwspinlock.h           |  37 +++++-
 3 files changed, 262 insertions(+), 9 deletions(-)
