Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF83C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00B7217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpIzrF9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfAYSoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:44:06 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40054 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYSoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:44:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so7631440lfe.7;
        Fri, 25 Jan 2019 10:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rg0YflQaAgoKOTFWzG4l5xusBZjVDCeKxvV91yXWl4Y=;
        b=QpIzrF9ndlDOt53RC3S4ez1rbMzH8tOn2kNtXrfsgzQBsHhWmwED8tZIFuXT/iSdtF
         4WM91WXZphZreNlwKWhN+/oUOt8+e5omgfLnE+zLDZlhcnRCMLTbHDBoTKfp2RFkHRGm
         4oddJGGLTNwb5x2fT/4jI/d+5E/O0C8XFCpp3IeBnA4niUn+yIg4iGTSzV6QTwiRUX/m
         4Z8VwJsKg+W8L3wOqxITptnxZzUd0CVMw7mgSi/8c6feXXpPqjz6mUfwYa0eCL3WRFUU
         SsL91Ez70BDGnqDCqHBdpuvq0dSvdpBgq8HXl704Z+5R2lYQrHokD+NWknpo2k/Sr4TT
         1K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rg0YflQaAgoKOTFWzG4l5xusBZjVDCeKxvV91yXWl4Y=;
        b=sDmd0meKxqpgbbIh0pIZcwDTHXfboElGTV7RfG8icm1yqLJRNSYwyAovl8aBUNfWCf
         Whn3WFejjEmxGuJkfft5vOrdmVtPzD7BEfdp7E/ZFMY61eP5Oe93o7y0HdBB4hNy3FIL
         x7egV9OC15v3/WZNTYKLZLq/QBK/qCcX0YdRwdxOVzqXxHU0vN7Hwlwwl0/aT9iTpMUT
         FzVRVxeJgSr754FRGA6WUkhcIti1Pmq8F7nRcKduRSOYEezwPySe6g81aAdj8Xt+LpHp
         Oy4X6PqsqFI17okkm6/pJyX7o97O6Cl9Vw3hNa3ObeeeQ7qU+oudQKRZZDzX/yxeFxhj
         NJYQ==
X-Gm-Message-State: AJcUukcjL483Lf7BW57uIorUzSl3kgxXz50MGtMCC5rfIaxjVWECu7FN
        VxpXLPvvpL/JgeY/NpXzDWs=
X-Google-Smtp-Source: ALg8bN7u3m0lo39KdvI87tnEFCwQkEkjT7nS6KSExkrO/1l8zWcpoEgxGd4I5y2WoF2YTrMdX2NGxg==
X-Received: by 2002:a19:f619:: with SMTP id x25mr9378631lfe.163.1548441843357;
        Fri, 25 Jan 2019 10:44:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6921:1f1d:2918:d853])
        by smtp.googlemail.com with ESMTPSA id f18sm1715432lfk.18.2019.01.25.10.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:44:02 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] input: misc: bma150: Add support for device tree
Date:   Fri, 25 Jan 2019 19:43:57 +0100
Message-Id: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patchset adds support for device tree to Bosch BMA150 Accelerometer
Sensor driver.

It was tested on s5pv210-galaxys and s5pv210-fascinate4g.

Jonathan Bakker (3):
  input: misc: bma150: Use managed resources helpers
  input: misc: bma150: Add support for device tree
  input: dt-bindings: Add binding for bma150 sensor

 .../bindings/input/bosch,bma150.txt           | 20 ++++++++
 drivers/input/misc/bma150.c                   | 50 +++++++++----------
 2 files changed, 44 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt

-- 
2.17.1

