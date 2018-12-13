Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25CAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CFF20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emDiYTAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CFF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeLMUB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:01:57 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34778 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeLMUB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:01:57 -0500
Received: by mail-oi1-f195.google.com with SMTP id h25so2685865oig.1;
        Thu, 13 Dec 2018 12:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aKZnuEDkap6jVAOtxyGknHe2+YUTgCaOPRWN5thZw1E=;
        b=emDiYTAPdH/8UmoKkVuHfo58y/D/oF7r9b2p+3X+ugiTiMEZaB2rX3x6SrIBJpgz6j
         G7i6KpsaHdxkYRqlqHK+p95y14gSEc1np5h3CfLDOBULQ2n/zUEUhZr+ZcD4fjqcOOcW
         UJ5hcDm+0wNL0L0eJ0bwoKuCbS+NGLBZGYpxPMGpR4JGjvgTU8uVHeqQ53HUU80TJKlP
         VBMVh/y1Nsx3YBTuHkf16rjEMyr1It4WLFXdIZfiqSqnKwIlz1X72qWiBe3PHML7RuMM
         JjmkBOTxSqtoOm2o5A6rXDikKJI9FjlKdLjiR+SikII0KBJlMSLtuhdDiV06R2mRcq/f
         IJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aKZnuEDkap6jVAOtxyGknHe2+YUTgCaOPRWN5thZw1E=;
        b=R0oxdkn+ygivoDILFNGcgZ+eJ56CTn1t5xsyocF0GRRUSXhaTCDjOULS5YwU/IrCfR
         tgz165tuhMkHuAyRjeZjraFJ5dMbIBzWwFKbhj8MCiKm92fmIHh/XLFCIB8aoQc3W0+M
         QKiwkO22f/gj/q7gD8r+uxauoQuo02ipmcuVvgXznGkt9vkwX8QlaaQ+VaCAUVRiwKaq
         do1DX78zVq1VuIEQ6D9pUm8mZA+MTh2SA3aUjQG9ch1qkUUHSm3kDYdcTYeISJ5G/c91
         43ElpeqAxIKrxmyKb7cR/fy+W290lFRAXX37K4uiNv6+N3bWiXW+8mgf69IBBiRMld7R
         fF3Q==
X-Gm-Message-State: AA+aEWYuouX7VkynnEmV2fnM98/T0iHkpENOyaIsE6+pu9bW7yXSCLNC
        u2Nrf18/Ue4ltXo4XugpBBAbBpLf
X-Google-Smtp-Source: AFSGD/XsgYAyLd1bydjkprvZwjb520qy3kAJWn7GGz6+bHyoreaPeh33CJoEwSCpMZAkWmyo72TexA==
X-Received: by 2002:aca:bf06:: with SMTP id p6mr79139oif.269.1544731316243;
        Thu, 13 Dec 2018 12:01:56 -0800 (PST)
Received: from localhost.localdomain ([172.58.40.174])
        by smtp.gmail.com with ESMTPSA id x9sm1137340otq.73.2018.12.13.12.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 12:01:54 -0800 (PST)
Date:   Thu, 13 Dec 2018 12:01:49 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management fixes for v4.20-rc7
Message-ID: <20181213200146.GA15849@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Consider pulling the following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to 99c47fcd4daa2b9a1348872ba49226dcdc58cb40:

  thermal: stm32: Fix stm_thermal_read_factory_settings (2018-12-10 20:15:28 -0800)

Specifics:
- Fixes on STM and HISI thermal drivers

BR,

Eduardo 

----------------------------------------------------------------
Daniel Lezcano (2):
      thermal/drivers/hisi: Fix wrong platform_get_irq_byname()
      thermal/drivers/hisi: Fix number of sensors on hi3660

David HERNANDEZ SANCHEZ (2):
      thermal: stm32: read factory settings inside stm_thermal_prepare
      thermal: stm32: Fix stm_thermal_read_factory_settings

 drivers/thermal/hisi_thermal.c   |  4 ++--
 drivers/thermal/st/stm_thermal.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)
