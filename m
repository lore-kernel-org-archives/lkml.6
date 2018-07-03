Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C90C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8ED2244D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JseB3xnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8ED2244D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbeGCHUw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:20:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37864 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeGCHUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:20:50 -0400
Received: by mail-lf0-f66.google.com with SMTP id j8-v6so741186lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AkFpguKHLJdNCb8VtDLF9kvz8hotA3mDxBD3P5qppc=;
        b=JseB3xnnQ1A45ieQPoZ9zSb2ad1uQBol6qUfF6PMLk6aP6o2ac7EW8pa+Nxlkl++bY
         D3CHZO6Z2+VJmSOdXNUoNNcoXtah3e/n7DXYLT4dvU4PaL0P2CZ6TkG4h53vBSc/LzpY
         u5hMbpHBkkxUBOV05Yx2rJK12bJy8vSrEfnv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AkFpguKHLJdNCb8VtDLF9kvz8hotA3mDxBD3P5qppc=;
        b=qlfTPJegtx5ExwbUqx0U5TaIEZIO0epP6/sthuv2lmm6rnEsc92b2Q/zRqhy6IaUT8
         CyOKxMWOlZmWOAeT8eZ+XjiwyM5P5zqHFumxhrTgUregyJ2bC58K0O4cJKTsRzDED7pd
         pHn5ypClyg2yew+/I32rjoa8Q6jkuys3j2orvB5hL0YDDaV3WTAvxXBIx4hkTpBzZCXu
         Je63tTZvdzV26l22axAa3bAFfjluuaGlZoivDxOgwebhEPQ69fhp5WxZl6gQ6TNP/MUt
         oPfh2TECwa8zg8O9H+QShJOgqd6APqNzihET+lOwtdTzj3/JsPMkHk1t7EskYunIpbOG
         whdQ==
X-Gm-Message-State: APt69E0NL/8Y44Zl1zwogLVXW4naCHNQBY6vOADz4PpUWN0vf0z2qVbW
        ZFoQzipzAWfPFY3pFy4NvYLsow==
X-Google-Smtp-Source: AAOMgpdGjCt0h2KaN8atgsiG5MykTItDOcJPgkZWrGN5+ZXb1pYkA9piMg8rwof3yxi16Xy3hcYKpQ==
X-Received: by 2002:a19:2593:: with SMTP id l141-v6mr19781111lfl.10.1530602448695;
        Tue, 03 Jul 2018 00:20:48 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 10-v6sm65125ljh.91.2018.07.03.00.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:20:48 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
Date:   Tue,  3 Jul 2018 09:20:27 +0200
Message-Id: <20180703072034.20213-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
we unconditionally include the soc/qcom/Makefile.

This opens up the possibility to compile test the code even when
building for other architectures.

This patch series prepares and enables all but two Kconfigs to be
compile tested even when building for other architectures.


Changes since v2:
-The qdsp6 fixes are now solved in another way, and those patches are
 already applied in the ASoC-next tree.
-Dropped rpmsg fix, as it has been applied in the remoteproc-next tree.
-Added a new patch to add sizes.h for the new driver llcc-slice.
-Added COMPILE_TEST to each Kconfig instead of the menu entry,
 in order to allow more complex expressions.
 E.g. RPMh has depends on x && y && z || COMPILE_TEST.
 This way, if COMPILE_TEST is set,  it will be able to ignore multiple
 dependencies. This is not be possible if we refactor out
 ARCH_QCOM || COMPILE_TEST to the top menu entry.

Niklas Cassel (6):
  soc: qcom: smem: Add missing include of sizes.h
  soc: qcom: llcc-slice: Add missing include of sizes.h
  soc: qcom: smp2p: Add select IRQ_DOMAIN
  soc: qcom: smsm: Add select IRQ_DOMAIN
  soc: qcom: Remove bogus depends on OF from QCOM_SMD_RPM
  soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs

 drivers/soc/qcom/Kconfig      | 19 +++++++++++--------
 drivers/soc/qcom/llcc-slice.c |  1 +
 drivers/soc/qcom/smem.c       |  1 +
 3 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.17.1

