Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07707ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DC720645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpTcVMDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DC720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeJRF2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:28:10 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:36855 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeJRF2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:28:10 -0400
Received: by mail-qt1-f202.google.com with SMTP id u28-v6so30512974qtu.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tp/fioYie4gVi2ET9bXwNR4jKJ+EDQoZn/CxhLSSFvE=;
        b=KpTcVMDf7FDEEh5CnHBCd4N3OqR97cVx7oqogIhpPs2Xo6fef+/IqYeV73txA+dqju
         7seIK41s9QjHACgz2+nGPsCoYm5V4Oo70wRjBU71sTOT+ioA2X9rufxSdTqF91QiqaGU
         QVmkV6M/ZSUdHqmoWJGO8aLUbJriDQ8Ix7/ymD3YBBMQesgODK7i55FBcAub9MSlWJ18
         MzojoByBv1tsznUDiKCX5sIIBBo4sMHqBvMoFd4tpT+JU8z3VU3llhGJW/OC9nkK1ODf
         m5buyex/j8PSABCdLsEXFZMvOLwpXwrKZ+qWsYayK/eFlvE9V3MR8MosAsOLLIvUWXma
         4RfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tp/fioYie4gVi2ET9bXwNR4jKJ+EDQoZn/CxhLSSFvE=;
        b=tOOSZrg3tg5DaYdPkfodlUY2rYRzIgdclhOQhXgi4iRx3gErAIe+aKgKEFfXaWa4fQ
         DqZpSrn8olj7goWPTlEPmVOQE3nu+ahpGlB0IERTbmYHqb5WV65Ra1qYhNrhwlkBXxhI
         cfgDfPybam0iAYaoAiKJ8y/hPIbJQyY0Jy8Dq/axCZK1kOCdrlAs1EFcpCE3mRRwjqBO
         /Q+9HuZ6QlYw6umZ9SIEzaKmVUE3scTuIqoXiABnlBTXbpLRXxmsBm17uCZuhtKMi183
         pfUHSrF6q4vEzwh1/p8adLVOxZC6B1zn3Zhxkd5xcizdF8DbadiQ8kvMGIks7/U/AmM5
         srRw==
X-Gm-Message-State: ABuFfog2WlbOX/dYhBafJ0eCAbMzw4iN50ySRK7mSKE9f+iYeg9bdE69
        gcBF/tfVa0XLzxJwMcH04v/grup1hQ==
X-Google-Smtp-Source: ACcGV60NEmiVPGMTgN4oejm7RMxYk1PlGFVDkIAnYOFPincAN/Lt4kAJcdZ8IbsRE0jWuXpeVUWWJIJt2g==
X-Received: by 2002:a37:3a86:: with SMTP id h128-v6mr22811861qka.4.1539811834842;
 Wed, 17 Oct 2018 14:30:34 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:30:10 -0700
Message-Id: <20181017213012.233957-1-kunyi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH 0/2] Allow gpio-mmio to co-exist with pinctrl driver
From:   Kun Yi <kunyi@google.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        tmaimon77@gmail.com
Cc:     linux-kernel@vger.kernel.org, avifishman70@gmail.com,
        openbmc@lists.ozlabs.org, Kun Yi <kunyi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to resolve an issue found with Nuvoton pinctrl driver
when it uses a generic GPIO interface. Since the generic GPIO driver
stores the bgpio_data and bgpio_dir shadow register values and later on
modify based on the stored values, any change to the pin states in
between by the pinctrl driver is lost.

Kun Yi (2):
  gpio: gpio-mmio: Allow volatile shadow regs
  pinctrl: pinctrl-npcm7xx: Set BGPIOF_VOLATILE_REG

 drivers/gpio/gpio-mmio.c                  | 50 +++++++++++++++--------
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c |  3 +-
 include/linux/gpio/driver.h               |  2 +
 3 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.19.1.331.ge82ca0e54c-goog

