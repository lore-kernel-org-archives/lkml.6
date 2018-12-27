Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC3FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A83C214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MvR42ypG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeL0Vuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:50:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35209 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeL0Vus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:50:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so6456231wmt.0;
        Thu, 27 Dec 2018 13:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGl6wDcv18nbdMCsHxKqHa15xVmZTDDMiXxC8PDTofU=;
        b=MvR42ypGbUXKRDB3dpUyyzgsNMVVpHcnsUhotUvvXBaCiHtCtWt9sCiC2BBzgX/mVm
         B7+5sCbZ6FUNmwk8sl2wFaJbxVl/BHK0Ox9HcVmO9C8X3NMp71ci6l75kQvq/K+Onc0V
         CWadsSwcfq8V6mLnJjvyOMp0bsT1dVnvPt76D1oKc6ih+4T/PQ6kiJZ7bpj9WdnRBCAu
         bREm7m1svtljiMwUng1ejHpvxhojCQkmLXaQhNdmHxEk/MHJAAS52uufDfDqLXn5491e
         hU6L6Wwh1x0BLkbIOo20rQ391akgKRg08U6YDhOxGpg5TTvvE9xYWkTzP5qbZtBs4lWl
         1yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGl6wDcv18nbdMCsHxKqHa15xVmZTDDMiXxC8PDTofU=;
        b=DpNLiH9trH9XduZun5QtfcRbJe8AWVV/hQUetNaXwrCImD5ETMp8Iqe4bx3CAmokWq
         1k4kADGdy2S+Mrg70h4eJ9et181OlR57smzJfRJjubgZLQYL4IYqjufGeI3l5Tw50h+Q
         XMTmtbsrBMzq4wwjITSykvP53VObOQivCeUsEfQ35poMVE2WbBq0r4P/oV9UW7h011Q3
         ZTEoUKb09FSwHTOE2UYRv5rH74Hw8xk2nlGQr1GCuzO5ndR3mv78WgwkAbA93JQED7z0
         E9rEB++BljeA1hibLHdc7C4G2KR9FeD49TMizyr+8ASOdEdxD8y4UqwchUep817G5KiX
         VMRw==
X-Gm-Message-State: AJcUukeF/sZtig2OdX5CudbVK11Q30snUvMhwnpAQgKr2IMwI2PJqimP
        P0xa7y+eZPFPeVAXPav7qs8=
X-Google-Smtp-Source: ALg8bN6ieOhYIq1Kis9m7na7acyY2+nvXugjt1uuR7Dii8uadNTOEZZDjJAx2UYcFua+8zlMFsGBdA==
X-Received: by 2002:a1c:8acd:: with SMTP id m196mr22837472wmd.120.1545947444131;
        Thu, 27 Dec 2018 13:50:44 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD711B00071582302E30AD474.dip0.t-ipconnect.de. [2003:dc:d711:b000:7158:2302:e30a:d474])
        by smtp.googlemail.com with ESMTPSA id m4sm34538164wmi.3.2018.12.27.13.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 13:50:42 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     balbes-150@yandex.ru, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] meson-saradc: temperature sensor support for Meson8b/Meson8m2
Date:   Thu, 27 Dec 2018 22:50:18 +0100
Message-Id: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the temperature sensor on Meson8b and Meson8m2
(both are sharing the same logic).

These SoCs can use most of the existing infrastructure that we already
have for Meson8:
- parsing the TSC (calibration data) from an nvmem-cell
- the math to calculate millicelsius from the register values

What this series adds on top of the existing infrastructure:
- The TSC data is 5-bit wide instead of 4-bit. The upper-most bit has t
  be written into a register in the HHI area (which is outside the ADC
  register space). Thus this adds a new device tree property to pass the
  HHI syscon to the SAR ADC and we set up this register during SAR ADC
  driver initialization
- the multiplier and divider values (to convert the raw register value
  to celsius / millicelsius) are different compared to Meson8

This was successfully tested on multiple boards:
- Meson8b Odroid-C1 (me)
- Meson8b EC-100 (me)
- Meson8m2 M8S (not upstream yet, me)
- Meson8m2 MXIII-Plus (an earlier version of this series, Oleg Ivanov)


Martin Blumenstingl (2):
  dt-bindings: iio: adc: meson-saradc: update temperature sensor support
  iio: adc: meson-saradc: enable the temperature sensor two more SoCs

 .../bindings/iio/adc/amlogic,meson-saradc.txt |  4 +++
 drivers/iio/adc/meson_saradc.c                | 33 +++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.20.1

