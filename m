Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AFEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6646520817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6DDwmjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6646520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeKSISV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:18:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44371 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeKSISU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:18:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so4246095pgr.11;
        Sun, 18 Nov 2018 13:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BW9epYEWupYIO3kISzbjhYwXT2QVOuAB2tefKT6BTOg=;
        b=C6DDwmjOnK0eW1263LLuHaTg9LmgmetQd/J5aLGGYM2I6pAxMXUECXfSF6m17fw1Ro
         lYRkuIEJG+oZwqk4BBbFfBwLYTfsYJ0a2XhmQ0kn83Tjq/+O+VV7Yb2wVebjT7zSsvyI
         IxuZYH74gz4Lrl6YBZVEbV9439s1tIPoupK4Vl+Mf9tCtbodx+5J81bDwufjF+n/4XBt
         6fMSPnXXA656ynTHn/R7IUbgaQfu+n9B4MEgOB0QhxzeWb18+fv86AWNhE8I0xulS8ol
         ltLkGfQh/8U1viQLRTPJElbSFHyItzbC1XtIBIxNpf0iYZne1oS0Lo+Ys6EQ0+PeOaRc
         LBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BW9epYEWupYIO3kISzbjhYwXT2QVOuAB2tefKT6BTOg=;
        b=htij+s0TRdFPy5AP5/+Pbl0DHfY/YeuyM20QcqAPoI+8KZ1gd+kMl65MeuGDd+Lwx4
         5d4CvBUkl6SfyfyOsw8YzMWcIXSh8QVLXvZ2h4uM8odbTBo2OnKodTkaKAsh6MecoVCn
         CDEJHCaCkR0nib/yEDTHnoSslLUvEsDcY0S+0S9xiAvOgdW5Y+honCaKlhvzK6RvBU6r
         g34l8eCILmMtdXVU2pTA1SvwL0mmzBwwxhySn3cWgEb6Jgtl41aypcQ6zs1w9SQMYXmV
         eX4sjMPleO+HacC8sit87tfKftVLsAMdcbo/tJDrMaHhkuZ0P6GqDFO13N8A674uvIiL
         ydkQ==
X-Gm-Message-State: AA+aEWYEt5SMMLwMmOvuXKQmor134lv8W28+bJE3rDB7T5ySjyzwQGwL
        ybFsFMZ56WSkCfx15neFrPF6OiUg
X-Google-Smtp-Source: AJdET5fC8gUIlRndhgYBx8/ObaOm+wULn1WySymrGDxmcFrlVFvex6UnBwiG2kRocdghLfUPdNKFxA==
X-Received: by 2002:a62:8893:: with SMTP id l141mr6985162pfd.1.1542578210902;
        Sun, 18 Nov 2018 13:56:50 -0800 (PST)
Received: from localhost.localdomain (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.gmail.com with ESMTPSA id j64-v6sm9733422pfc.43.2018.11.18.13.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:56:50 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Coupled-regulators follow up
Date:   Mon, 19 Nov 2018 00:56:15 +0300
Message-Id: <20181118215619.21518-1-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a follow up to [0].

What's changed in v2:

  - The "Use ww_mutex for regulators locking" patch compiles now for the
    drivers that are touching "rdev's" mutex, in a result regulator_[un]lock()
    functions are public now.

  - Added new patch to the series ("Keep regulators-list locked while
    traversing the list") which further firms regulators locking.

  - Changed commit description of the "Change regulator-coupled-max-spread
    property" patch, saying that it's fine to change the binding because
    property doesn't have any users yet. That was requested by Rob Herring
    in the review comment to v1.

[0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=69250

Dmitry Osipenko (3):
  regulator: core: Use ww_mutex for regulators locking
  regulator: core: Properly handle case where supply is the couple
  regulator: core: Keep regulators-list locked while traversing the list

 drivers/regulator/core.c              | 425 ++++++++++++++++++++------
 drivers/regulator/da9210-regulator.c  |   4 +-
 drivers/regulator/stpmic1_regulator.c |   4 +-
 drivers/regulator/wm8350-regulator.c  |   4 +-
 include/linux/regulator/driver.h      |   6 +-
 5 files changed, 339 insertions(+), 104 deletions(-)

-- 
2.19.1

