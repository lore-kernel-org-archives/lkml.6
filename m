Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6274C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD1320989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6jMfcbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD1320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeLFHbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:31:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39651 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbeLFHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:31:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so11353604pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkAY0uwtC3pzcoa9SMsRh6f2Kqc06jM6mHbefciRqdU=;
        b=q6jMfcbPK9Q6wv4kcd6SGAEPVW/24N0vJwzcUrXVj3dFQPZrEfuaer9Ss0DufP8TtR
         cR655HQVn3R6Uzi02G8u5ZXwML2QVy08jwoK0OnVDcTPxPDJDG8bCqhwq0qiOnS2138m
         C65RCASjehWl6piK3oAQQEhmbjirjRKLzXqVq4IgnfKxTgVzOzHfUC1YUw3xrkVceQoL
         3Jkn77nTvvoQE+txnGnpCm5oO/PtQKMVQE37McIkZU+KmjVoEBtCsexZ4Tl/KqV8PPWJ
         oRPbXA/O0+hUgt94+fOLVCEhkfw/cDBaWCYKEBWbSUo12E109Ecaq/g3WYhjV/bfwY2J
         aURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkAY0uwtC3pzcoa9SMsRh6f2Kqc06jM6mHbefciRqdU=;
        b=CbFcVfbCYcsQV/jnp6eYBcTKAXdyWIV0hfmOjdPB10B8z55Hh6/LZJ0GEm6F71zacR
         mH+B+04HJ1kIh5P36IXrelgTWjKlwT5G+u2yXJWEZeVKV0Rjzi0YgdEd8vyM0Eb1pj+a
         U/vdvbEyXMJsb0OPv8N5WUetVo9FNswKGFpGV09OnGwesfPZEh+/xnVaGXeBJlfZ4xwb
         YUGsQX9TpRS/zQ8DH1Rvr5yQD9ScTc2xMi6I4wbAQvrC71F4RI1dVQ5qyX/KRLHai+yK
         qX3WFZ32tShcG24zV7gPw3n239DO9e4fHbMjLbe5jWsJ6cX0paHA13Plz0QvD2azt4/y
         sDTA==
X-Gm-Message-State: AA+aEWaMmx977nX/IcpAprkFD6qwjZQVAaDk9pIwAWADPmP6elRyW34d
        Lf+SSZpAAnAuPKntXBIjtdXIKfTU
X-Google-Smtp-Source: AFSGD/WMOtb6cZMfYeLQBpszqzfZ4DnRpP2i2qxXLONXRKOsMpg50ncJoRSIOZLdNx1Dxrn3C0ofUA==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr23525671pgp.263.1544081502700;
        Wed, 05 Dec 2018 23:31:42 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:31:41 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] i.MX8MQ support for GPCv2 irqchip driver
Date:   Wed,  5 Dec 2018 23:31:20 -0800
Message-Id: <20181206073125.7255-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series is 4 trivial (and optional) changes and a patch to add
support for i.MX8MQ to GPCv2 irqchip driver. Bingings for new GPC
variant were taken from [gpcv2-imx8mq]. Hopefully all of the patches
are self-explanatory.

Feedback is welcome!

Thanks,
Andrey Smrinov

[gpcv2-imx8mq] https://lore.kernel.org/linux-arm-kernel/20181116154927.16152-3-l.stach@pengutronix.de/

Andrey Smirnov (5):
  irqchip/irq-imx-gpcv2: Remove unused code
  irqchip/irq-imx-gpcv2: Share reg offset calculation code
  irqchip/irq-imx-gpcv2: Make use of BIT() macro
  irqchip/irq-imx-gpcv2: Make error messages more consistent
  irqchip/irq-imx-gpcv2: Add support for i.MX8MQ

 drivers/irqchip/irq-imx-gpcv2.c | 61 ++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 17 deletions(-)

-- 
2.19.1

