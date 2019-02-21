Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C18C20842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ioBwx6qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfBUJMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:12:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44531 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:12:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so3630944pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Uz/zMpOi+KkAAuCzdy49uLhPPZ/Zw1nBx+ZgW775X5M=;
        b=ioBwx6qoiBtDvumbkahZu2HaZr24NCNmA8kAJj5Krt6RipwoeihHaPTgifgCc/qqI7
         gSSSW71USiWQDMilHKHY5kg5y0vOhjypMueYnTYwY83VhYW36faMKRlL7MclhYKQj2t6
         ng4FcLn8BZySFVX6zIJpC53cYY0KSuirjedZcsYyNLZgNhS/S7O3zp8NK7CkJ2fYB2IX
         yHp5iZJLSjdPXBhha8XpYUna9Ne4qSgFbcAm7IEZH/aWXFUkGfwJ0emdh/xl1r0uB+y+
         WmfzR9lW47Xegz+C6yQvYpp07Wcixs3NfQIxu97tj9WNBh3XYh8E24zi4t7r4W0LHflP
         uC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Uz/zMpOi+KkAAuCzdy49uLhPPZ/Zw1nBx+ZgW775X5M=;
        b=WMT6UANasSiX5TgWHRQpXu9WxUhfZfMVAzrUB9qzivn4KlKkPMp1og1k3VK+JLpkOr
         AutrZL6hwPgY6nLvueIOcVz3vm1a2IGIh18AwSa+H6XNf0NKTahBE0pl5XTu4hqkGrrG
         YP8+y5l1Ebx4eF4sypR2KsEFb3J1YQZoWcoDtdBc9Vg5hdc8mJhdZPI7BccdaOt28zLx
         ASoE9Q4KAsjbG1Pz+Vq4lTUzVo/YOgeMOvCJETBnjdJuM+tqhTYXcnARo9St44nOq5Wa
         +XCko7+22zTqhjoS/WrCdRk3z2EDZd72dhIdQnQXhB5bX5Jj6Zva0X2yl0urak5YBarx
         oUJg==
X-Gm-Message-State: AHQUAuZYA+2LFV/oCWVYl+nkjDSXJ1ujMqkC5IgrpoxBGJ1c/3+mg1Cc
        HX1zZbYOM5EEZvVfRjb0NJfbcA==
X-Google-Smtp-Source: AHgI3Ibth07YChFAPs3/OUxV3NfBarIcpy8ocqn1pHmPjyOajfzlDiCNLHCvksjnCp1RM+WhqDwDGg==
X-Received: by 2002:a62:3047:: with SMTP id w68mr25754046pfw.17.1550740325670;
        Thu, 21 Feb 2019 01:12:05 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id i71sm66145208pfi.170.2019.02.21.01.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Feb 2019 01:12:04 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v7 0/2] PWM support for HiFive Unleashed
Date:   Thu, 21 Feb 2019 14:41:39 +0530
Message-Id: <1550740301-10097-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

v7
- Modify description of compatible property in DT documentation
- Use mutex locks at appropriate places
- Fix all bad line breaks
- Allow enabling/disabling PWM only when the user is the only active user
- Remove Deglitch logic
- Other minor fixes

v6
- Remove the global property 'sifive,period-ns'
- Implement free and request callbacks to maintain user counts.
- Add user_count member to struct pwm_sifive_ddata
- Allow period change only if user_count is one
- Add pwm_sifive_enable function to enable/disable PWM
- Change calculation logic of frac (in pwm_sifive_apply)
- Remove state correction
- Remove pwm_sifive_xlate function
- Clock to be enabled only when PWM is enabled
- Other minor fixes

v5
- Correct the order of compatible string properties
- PWM state correction to be done always
- Other minor fixes based upon feedback on v4

v4
- Rename macros with appropriate names
- Remove unused macros
- Rename struct sifive_pwm_device to struct pwm_sifive_ddata
- Rename function prefix as per driver name
- Other minor fixes based upon feedback on v3

v3
- Add a link to the reference manaul
- Use appropriate apis for division operation
- Add check for polarity
- Enable clk before calling clk_get_rate
- Other minor fixes based upon feedback on v2

V2 changed from V1:
- Remove inclusion of dt-bindings/pwm/pwm.h
- Remove artificial alignments
- Replace ioread32/iowrite32 with readl/writel
- Remove camelcase
- Change dev_info to dev_dbg for unnecessary log
- Correct typo in driver name
- Remove use of of_match_ptr macro
- Update the DT compatible strings and Add reference to a common
  versioning document

Yash Shah (2):
  pwm: sifive: Add DT documentation for SiFive PWM Controller
  pwm: sifive: Add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  33 ++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 346 +++++++++++++++++++++
 4 files changed, 391 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1

