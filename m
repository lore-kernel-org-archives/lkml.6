Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C6C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED13620815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXViSzeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED13620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeKRE3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:29:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41504 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKRE3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:29:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so12000769pgh.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 10:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIVIEsAcS+mtjbS5QZCMjtScOtNatQOaiRih4W87jh8=;
        b=pXViSzeBjm5uNZpVbLfw+/XBnO80h+MS6chFWU7O9t43tn7VMkWSihzJIorajlUJS8
         uaINCJD6pJWKow+moAWmhMXUqK24LznarVGa8HLDXznpF71hEDGZF6xdWqoz6ZjEf+B3
         8YpdLasHB7xjHTf+qgbfq4NlSHi0Wnexp0x+iadAZ2tpJcAIgxAmB05xp04IEfYkwbeT
         HUmFtVFNwIZzBt5/c8gppMVzVZ2CRSepJX+M3VuQWnQ176OMQM4wZPzkFDNecPfF1KDI
         3/g/T/VO5aduSACKBO94EjJ/jP7psJ5neVmRaHTKxWpJ1hvETD8nTtpuPUQG/AYq3ZuW
         u4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIVIEsAcS+mtjbS5QZCMjtScOtNatQOaiRih4W87jh8=;
        b=HN3J7Ue9vahSHmbmhxXx5GvnO6CUF/ikraa2Sd4ZdjDKxC2puDviM4hkCGkijU7yEE
         goR73fik27Y60wP5g8BH5hTgLazN2TEVmXgeUcUmdvsoJ6zYbCDN9h7BMhCQINQ3Lgaj
         sXfvryaCONY+BcvmAN/BpNInsfufs+Qk57AwbIoanQOt19YO/8JlOBgRO6h08ZqeqvmB
         2+b1RgrmFpclB+yOptKKbq3kVkCOQ/fzF5iPfENkBXX4Y1u8+ZYByI6ackej4GONrvzr
         eaeMn7vW8liQKT0bEvH2OB/44VfYc+GdrnIH6suCaIiSKmYyZaOA4lpGCgZkGoqYSn4n
         HMWg==
X-Gm-Message-State: AGRZ1gJTdIuNMa1KPg5jcoxSZuyHN9XsbZVKubli5E1MK3FX3CP3n90L
        qxcLtbtepuwzX2P2Lid6mBwwroZ9kws=
X-Google-Smtp-Source: AJdET5cJ5uGCvalr8J6QU6WD/u94BxcRE7CJDvQnyPKdT20pXRRbqrkMwp+e+GUmIgVDAeWqeReHwA==
X-Received: by 2002:a63:c503:: with SMTP id f3mr13961807pgd.431.1542478309480;
        Sat, 17 Nov 2018 10:11:49 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a73sm24816500pfa.7.2018.11.17.10.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 10:11:48 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, p.zabel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/1] Reset controller support for i.MX8MQ
Date:   Sat, 17 Nov 2018 10:11:30 -0800
Message-Id: <20181117181131.9330-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This patch contains changes I made in order to add support for i.MX8MQ
to reset-imx7.c in order to enable support of PCIE IP block on i.MX8MQ
SoCs (full tree can be found at [github-v0]). This patch is _very_
preliminary and by no means is ready for inclusion (it also has some
unmet dependencies).  However is should be in OK enough shape to get
some early feedback on, which is the intent of this submission.

Specifically, I'd like to get some feedback on whether the approach of
having a single shared reset lookup table is acceptable or not.

All other feedback is appreciated as well!

Thank you,
Andrey Smirnov

[github-v0] https://github.com/ndreys/linux/commits/imx8mq-pcie-v0

Andrey Smirnov (1):
  reset: imx7: Add support for i.MX8MQ

 drivers/reset/Kconfig                   |  2 +-
 drivers/reset/reset-imx7.c              | 66 ++++++++++++++++++++++++-
 include/dt-bindings/reset/imx7-reset.h  | 15 +++++-
 include/dt-bindings/reset/imx8m-reset.h | 47 ++++++++++++++++++
 4 files changed, 127 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8m-reset.h

-- 
2.19.1

