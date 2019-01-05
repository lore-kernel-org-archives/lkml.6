Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0447C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A472F208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bk66Cz+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfAEH3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 02:29:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46063 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfAEH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 02:29:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so18422834pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 23:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y2kjBfabd8Ed22a6YMy+7qr6U4HPwKuqVjrbxxMoTC0=;
        b=bk66Cz+E38O/ZC4NZ3HWn4zbC4Z3nv6wD0dd6SVzho7SuWmKjSl0+9VIgg1un9Pgei
         TNShcJxBqQ2L0ttG6uaXAMf4ASRI85yVr7NWPq4V3wpDSYkk0egW2TVi6pBiMFQguzzC
         Dxoiox0dAuHnmSYs2OAeXxOsPwpR5lD7G0f9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y2kjBfabd8Ed22a6YMy+7qr6U4HPwKuqVjrbxxMoTC0=;
        b=J+X+Bpj1KvxZ79wil0WjyRytDFCXKVo4JBJkFEYsR9hcASA3wiRacyw8vHPARiD85C
         0F7B/JjKGdW1ueBNt13OLSPiojuj1upPUlLDq2dnBr7DojEfWZtGyNMBR1iggeDYvn1k
         5MawaNbk6FH/1pH8PAYaI5UOSPcjt3dVud7WyfBFoFfcWX/JUtSdGcaXjVCe7mpP6vQP
         +RHc8vvMhjNs08YmexkcL+UQ5JzQoO/uyno+M59xnigwFF7tVM2fM9FVQ6evYcltngdf
         o4Pw2wzKcYjCpp6vyDx6S/SH2kKdmGBBBmPqbr+yHypWTqu/+b8EyFA/1IvOIPjZAdyq
         K93A==
X-Gm-Message-State: AA+aEWbhH6g9C7R93G8UnD+pzlQ+iSCN/xq7eLdD3B7TkS4lxrve3ohg
        C0rB1pW7BCe8Ie/++uC3jF1p
X-Google-Smtp-Source: AFSGD/WfGxk0zTINcDE2Y4BN6JhcC+qf57cdNyTjKpB7QDFvlEVSKhuFgfRqChT7SBSqXK3F6frjmw==
X-Received: by 2002:a62:1c86:: with SMTP id c128mr57541884pfc.54.1546673357404;
        Fri, 04 Jan 2019 23:29:17 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id k24sm90677367pfj.13.2019.01.04.23.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 23:29:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john.stultz@linaro.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Add UFS controller support for HI3670 SoC
Date:   Sat,  5 Jan 2019 12:58:56 +0530
Message-Id: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds UFS controller support for HiSilicon HI3670 SoC.
HI3760 SoC is very similar to HI3660 SoC with almost same IPs, hence
the same driver is extended to provide UFS support. Only major difference
is the PHY. HI3670 has 10nm PHY, hence that parameter is used to
distinguish the difference between two in driver.

Thanks,
Mani

Changes in v2:

As per Rob's review:

* Removed interrupt-parent property from binding.
* Fixed the bindings patch commit message.

Manivannan Sadhasivam (3):
  dt-bindings: ufs: Add HI3670 UFS controller binding
  arm64: dts: hisilicon: hi3670: Add UFS controller support
  scsi: ufs: Add HI3670 SoC UFS driver support

 .../devicetree/bindings/ufs/ufs-hisi.txt      |   5 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  18 +++
 drivers/scsi/ufs/ufs-hisi.c                   | 127 +++++++++++++++---
 drivers/scsi/ufs/ufs-hisi.h                   |   4 +
 4 files changed, 130 insertions(+), 24 deletions(-)

-- 
2.17.1

