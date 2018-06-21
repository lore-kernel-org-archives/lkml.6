Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369AFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD10921A68
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm0X0Row"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD10921A68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeFUTKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:10:24 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34418 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFUTKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:10:22 -0400
Received: by mail-lf0-f67.google.com with SMTP id e13-v6so5925679lfc.1;
        Thu, 21 Jun 2018 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GH2YKOTnqrBRezrH/s9j1A0Vj9abnRVpKWlWlMrNyBo=;
        b=nm0X0Row7qZ34CVw9vIQS9Gp9l94lg5e6j+yiBYexvYXTKN55zX+x+Em3+Ls01yqrT
         lao6VmBjyDkfbMPgYLbjZ38G9HFFVCrV8QrOnWA1PFOP4frFLA20U1LC0OfpBYQzGgSn
         t5ue+0cRfmfSGYQRK8iEAMQT8lmwbhwoQOGgZ5wKPaPce+uPJjd+j3qlcbmL45XbEizw
         wOAJwEWvRAEvoVJR+gJoSqVU4jeW+/jIeI+V5MpzqV0Tt9YVuw33t/MbZWj5BqQYtpP4
         WXapL70kDdhRND1yIJCb///bLYEYQBcfvYLMrcBJPYtKPyWrJ7Ja0mrcChBVLlCZqcnn
         fOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GH2YKOTnqrBRezrH/s9j1A0Vj9abnRVpKWlWlMrNyBo=;
        b=stzzjPFzGMHPQSP50R3eR8CmZsm1/vkPqas3myiSHdlqF5pi45V7xv+dNxE1/CHq+/
         m4Dcli54cO4UwiD5llNJOvum/CJS5Q9DG3e90GvjGJcwMJrrWHL+kiyfp1QeQQ6ELGbo
         hwHqZ7UIh+TbWb/Szuo769oEGXyHHMSGE3X7UKHCa4AaK0h7thHtyKQYjf5HrrlP1md4
         JNhwU1fBRiMqDR3LTWxjfuQsW8ctOW3ipXjPvE8/8IBCmYCXDwjY0iHy46W6rN+0k87M
         SOL17BiB2uqB2FcaASxtbNHiQun07Y59hF1gdXFCzrWNCGmhgB2SHX8nFJy4nd+/7VRP
         nhXA==
X-Gm-Message-State: APt69E2dMhdsJTzwPAE5ZgVpDLdi0bZUWZCpH7wPLNWVQOzCb3urpec4
        Xv7ssbT5PXnrjFWEAQF3osQxE4dhyJc=
X-Google-Smtp-Source: ADUXVKLH8xhz7v5/Ite5Rfo1owqV2Lume2NNECV3QOUhd2JpXEU2/uGdnso6oKR4kUC/m+47M2Dv5g==
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr14542983ljj.49.1529608221109;
        Thu, 21 Jun 2018 12:10:21 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id u3-v6sm988036lji.4.2018.06.21.12.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 12:10:20 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH 0/7] Initial support for Samsung Galaxy S and Galaxy S 4G
Date:   Thu, 21 Jun 2018 21:09:52 +0200
Message-Id: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Bakker (2):
  ARM: dts: s5pv210: Add initial DTS config for SGH-T959P phone
  dt-bindings: samsung: Document binding for SGH-T959P board

Paweł Chmiel (5):
  ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
  ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones.
  ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone.
  ARM: s5pv210_defconfig: Enable drivers for Samsung Aries based phones
  dt-bindings: samsung: Document bindings for Samsung aries boards

 .../bindings/arm/samsung/samsung-boards.txt        |   3 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/s5pv210-aries.dtsi               | 397 +++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts          |  40 +++
 arch/arm/boot/dts/s5pv210-galaxys.dts              |  72 ++++
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             |   2 +
 arch/arm/configs/s5pv210_defconfig                 |  49 ++-
 7 files changed, 562 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts

-- 
2.7.4

