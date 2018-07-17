Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A3AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EA52086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXq68SnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EA52086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeGQJ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:56:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37032 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeGQJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:56:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so383049ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c+N6yquO9w2DF1gaQeR513z1riV3LBKXGGfVf4zzASA=;
        b=BXq68SnUJOnOs2E3Xj1LOTuyoB7rn2SZRNlhVaburIer3dDA2VqM2QoDh/8tZjttU5
         pBae0a8NdD3d2wcXg7Kjb9oDAImxGNv4pRuDjG42QdBVF5b3azorCBHZpn97QswB77RZ
         x5mimfFRevLYUnkM5m90GAEX3ElsPdHESRK0awJIFAX7tJOVG1SRwVSccW/Zfp4QppiQ
         yE2i1u2sX6x7l/vbYVvmUrQZH2mo36HelPfXWsVf3fhC01EjS+mIBTvdboPbzt+3SOj7
         1s8/WrXpyrVDFcoOYLIS9yk4m3ZFMyg58x7KwwKBBqQ5+ke2HK9ibfZznPNNS+927kpH
         Rlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c+N6yquO9w2DF1gaQeR513z1riV3LBKXGGfVf4zzASA=;
        b=RUAxKfrtox3K42JBp/qVz7h9TC5sIhZEJ5FVZ3uIUyDzQJG50fwRjjJbf0Ud+mmz0o
         +5Isg6yNKuiIPUvu492DH0SCIq0GaU8AYoHWQ22TyO1V35K4fwP3U1ZWaG5x5XuiQId6
         fpGVZtKloa79ClGD3UJ4qDZA1LpFBXvjJBG1EKE8dJYP5Mo8vsX56fBkMfP7jtvtTFkx
         UAfEnWUF9ONeKMcaWKOg557f8h7dSxWean1XKg9JWQdpU56qC3M395zpRI1Nlo2hROKb
         3IydmdDXTP/riy1Jot+7aXR237K+efDzrPLiokoZeXL6Ej/1EsiXJ7+CVJgPgEUf5brc
         X2Dg==
X-Gm-Message-State: AOUpUlFskJRL/GIcM8QRGJo+U+YN6ByhCcoXYOVztnpMV/Eugdq6pT5j
        rMuKmHf12CFBV5Sbnuy7NO0=
X-Google-Smtp-Source: AAOMgpemKibbmMZHeTNJRypA2xW+3C35+JlhwHV16kl3YpO60BLTxCrZjHcf+1E+TixZlzslih2hug==
X-Received: by 2002:a2e:84c6:: with SMTP id q6-v6mr856197ljh.65.1531819492464;
        Tue, 17 Jul 2018 02:24:52 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id l1-v6sm94224lji.41.2018.07.17.02.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 02:24:51 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 0/4] ntb: idt: Add hwmon temperature sensor interface
Date:   Tue, 17 Jul 2018 12:24:33 +0300
Message-Id: <20180717092437.18918-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180714115834.3350-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDT PCIe-switches are equipped with an embedded temperature sensor. It
works within the range [0; 127.5]C with a resolution of 0.5C. It can
be used to monitor the chip core temperature so to have prevent it from
possible overheating. It might be very topical for the chip, since it
gets heated like in hell especially if ASPM isn't enabled.

Other than the current sampled temperatur, the sensor interface exposes
history registors with lowest and highest measured temperature, thresholds
and alarm IRQs enabled/disable bits, ADC/filter settings. The device manual
states that the switch is able to generate a msi interrupt on PCIe upstreams
if the temperature crosses one of three configurable thresholds. But in
practice we discovered that the enable/disable threshold IRQs bits interface
is very broken (see the third patch commit message), so it can't be used
to create the hwmon alarm interface. As the result we had to remove the
already available temperature sensor IRQ handler and disable the corresponding
interrupt.

Current version of the driver provides following standard hwmon sysfs
files: temperature input, lowest and highest measured temperature
with possibility to reset the history, temperature offset. The rest of the
nodes can't be safely implemented for the chip due to the described issues.

Changelog v2:
- Add "select HWMON" to the NTB_IDT kconfig

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Serge Semin (4):
  ntb: idt: Alter temperature read method
  ntb: idt: Add basic hwmon sysfs interface
  ntb: idt: Discard temperature sensor IRQ handler
  ntb: idt: Alter the driver info comments

 drivers/ntb/hw/idt/Kconfig      |   4 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c | 317 ++++++++++++++++++++++++++++++++++------
 drivers/ntb/hw/idt/ntb_hw_idt.h |  87 ++++++++++-
 3 files changed, 353 insertions(+), 55 deletions(-)

-- 
2.12.0

