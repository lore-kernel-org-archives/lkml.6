Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6857C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BD320863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQ7IshS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfBAPi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:38:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34703 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbfBAPi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:38:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so3399648plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3NTv5eHd28mLCpqTEB1R7+7g3e4rlfMjMSD3f2Dc//A=;
        b=OQ7IshS1vh2MyN6bnmPd41J15BQEYSEsas9mRLTYWMaNH7KejRPcHc3AEI72ZThfPH
         0e+hn3p88HsjXYUHTLIRujNcqcD3GwH0yFxw0d8855EAFS3R0wZQ18gTyXmo8tyxx4z8
         +X0hD5zoFvVOuM4xadpYChNckWIldSZyrqI8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3NTv5eHd28mLCpqTEB1R7+7g3e4rlfMjMSD3f2Dc//A=;
        b=aQmBf+FBvFi8x7lpUTVS16SsEhhoVs6E86wlgpNpOwZP0fZwsLxyPQqhsq0cDQFpy7
         cJ5oJA71wUrSNmOUN4Uquq6zoQKTC8x9/GkVM3ov9CcnPpKhubmTg25aFftME+mzzvxX
         vxuqTyqNUrhA+nwpOHtm6TpY5PtTmvJ0RziXlRFjcNJj9xPSdFv+KG8g8xDFw03Zlybk
         Kr4mLyqLCu5xMaPl7ZD4bi0l4Xdf8jGJEMqyZaiovfMiAVi8WxknEcC41SfWbYkbd+My
         rbuN43lk1jqJdZOk8tJbc9D4NXP46NbsVNQktGzmAhosIofm0l2eGZkadGstopBbqxuf
         iT6w==
X-Gm-Message-State: AJcUukcMHaEmbDY9jG9YtFxTxp54qSwK0eERR5ck9MOktwuDern5aKLb
        rUX+Sn0o4W2//dHBzLq9iJt2
X-Google-Smtp-Source: ALg8bN6MFbgIMYeKqXUWMofngJPgyLZiFAw9uaV5ssz3uxqpyNVTWZUYrEfrNEWeVvV9WMcGinvLvg==
X-Received: by 2002:a17:902:b707:: with SMTP id d7mr38120490pls.29.1549035538080;
        Fri, 01 Feb 2019 07:38:58 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7348:9f93:3db9:68de:e3db:c028])
        by smtp.gmail.com with ESMTPSA id l22sm12350035pfj.179.2019.02.01.07.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:38:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add Reset controller support for HI3670 SoC
Date:   Fri,  1 Feb 2019 21:08:38 +0530
Message-Id: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds Reset controller support for HiSilicon HI3670 SoC.
HI3670 SoC is architecturally same as HI3660 SoC, hence the same driver
is reused.

This patchset has been tested on HiKey970 board.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: reset: Add HI3670 reset controller binding
  arm64: dts: hisilicon: hi3670: Add reset controller support
  reset: hisilicon: Add HiSilicon HI3670 reset support

 .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt    | 5 +++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi                   | 6 ++++++
 drivers/reset/hisilicon/reset-hi3660.c                      | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.1

