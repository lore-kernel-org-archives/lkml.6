Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09201C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86BD218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO+mGXVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfAYRuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:50:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43023 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:50:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so9072112lji.10;
        Fri, 25 Jan 2019 09:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoKD2yzVkDewZTNwY92ncgipg2tQiMj5H4jA9i+Eq2E=;
        b=JO+mGXVE7MiaCfayD9BIePPow+n1ev/EasUbCkJkklrqMOkuy8h+FSoGCBOjf9coe4
         yLiMoEyTy7PiteNtpOf9EWgs5YDFCh1HQmvsFIgZ7A+wwC//8t4i1yVJxc2hHDZ0YoB9
         O/bnyccTP9i6oZ7DCjPcdMj0Q5qcprFwjvoc6lRuiFonh+QkbJ/aHmKEL9nJgCHh4BlH
         y3wIx3oCYUqyXbifd6xTSPKy973JgGYfqDSzYeys5goR3MTMNMjcUfeQ4hi6SsrLiv0G
         dvuD89bUaw8ujNCi3D94MFMDVCh707Bw7eNECzRflFql0vSVnpVH8fJzMX6cfdKncDKS
         +9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoKD2yzVkDewZTNwY92ncgipg2tQiMj5H4jA9i+Eq2E=;
        b=qTJZuEmdgvL8pBTasH9PFZdN8Vfe5itBWFURavubfFSSQ9BzE1VjIbEPSXl/5qXiq+
         SWRFMyhmNlV1KyJXL6AvrFfg6zkl6RV1RRhiRBL1f0WUyJz/Bjkhp2VXW3/6n8tggNp6
         A7zaQKe+qwXVn7lQB9hnTA4Dd0+YCaPIEk170E7lBMlD6SyWBMrgbNe+T4msaUasue95
         /XQCPZ734tCf57G2UlTr85QhHo+Na7UQ7anHh0OGJ0VfbVc2r4QLnVx5Mz3U4ZFwPIsp
         qG6to1ylI08IqNbDCeoBkR1PsNLdCr6F2R2nfv+b/jfrTq0IvJzOLO1+8q7bSfuVbF/J
         wEnA==
X-Gm-Message-State: AJcUukcqIMwXKw8oljkw4x4yEEsDlbuVX1/fZLMR1SYwRYTVnImSJuc6
        3RpMbXKNEo9IwcsNItuica0yVY71ppY=
X-Google-Smtp-Source: ALg8bN52VG73ZLWfLswFK6hjYJCP+4rs0M3KgjYBes+KCLKG9A6tIZaZZY8hZQijTRdV0p4sF9MZ6w==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr9740891ljo.10.1548438648980;
        Fri, 25 Jan 2019 09:50:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6921:1f1d:2918:d853])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1575606ljj.48.2019.01.25.09.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 09:50:48 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, colyli@suse.de,
        ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com,
        arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/4] input: misc: gp2a: Add device tree support
Date:   Fri, 25 Jan 2019 18:50:41 +0100
Message-Id: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal of this patchset is to add device tree support to driver.

First patch is doing little cleanup by using managed resource helpers.

Second patch adds support for light sensor part, which is supported by hw,
but was not supported by driver.

The last two patches adds device tree support to driver,
with documentation.

It was tested on s5pv210-galaxys and s5pv210-fascinate4g.

Jonathan Bakker (4):
  input: misc: gp2a: Use managed resource helpers
  input: misc: gp2a: Add support for light sensor
  input: misc: gp2a: Enable device tree
  dt-bindings: input: Add documentation for gp2a sensor

 .../bindings/input/sharp,gp2ap002a00f.txt     |  29 ++++
 drivers/input/misc/Kconfig                    |   2 +
 drivers/input/misc/gp2ap002a00f.c             | 154 +++++++++++++++---
 include/linux/input/gp2ap002a00f.h            |   4 +
 4 files changed, 163 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt

-- 
2.17.1

