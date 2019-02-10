Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C14C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB2F2145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaBrvaaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfBJUg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:36:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36308 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJUg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:36:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so13021355wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 12:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pd53kY7Zn/KTDbNDHPYJSH/JLmIxxzkNhX+LN2ZGuB4=;
        b=OaBrvaaBaeLmkrrymGt8X3rplynAIGwTyJaRUKDU1LXH6fWuTo/rWXBGiys7EoMtD7
         plvy72nzLPfg9DCTb86kJ1pT2AC4CXjgFngoP7RfRVhHqG/XkXmhGXE8vhSnWoFiPiT4
         SXZewpIBSj4wwybEsZ+qFxK1YQdDrQiKKGo4mjYv1yF2owTJlEMNCWCjUFNXd4cp+WkI
         NJ4EPjMUp/SFKvjAxaAO/adPKoKaOkPVOPUu36wg2PhNh8KdmpkD9XvlJsYFrIIWSQ2n
         kL3bI9UxqE/fw/iD+bNPp3PDSb/zQoj5cjqtFMSwYEFqm1+mz+onHDPfKajz7nPqkbaW
         qLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pd53kY7Zn/KTDbNDHPYJSH/JLmIxxzkNhX+LN2ZGuB4=;
        b=f73KNgJXXU2sgN7ioVLus+zjipibTMf2PcNO2fcWfZhh/olmMkfDQXCk3WgiyhgMiS
         OoaNXQ2k/3LjNARowUgRNQiV6cuq3JKE0ms0fAJar+rlDSeKpiea7evE9Qu7NNeY+NrS
         ZwNXoj0mVyrrVJOznQV8SkchvQ1hVVbvuh2OViXwL/IJuDcWKC5tRgKfiqkNvOwchOO7
         Uva7RXFMyBYyFF4V1FXa3iOErU830LyZ6+H/MWfzC3dD17xpwVQ0yhWU3I/1wcEFNXcr
         ee5oGA02f3mJIzLC56ZtiXdmE4M8d9HBI97WV2DouH2gRtxq/Z8NwdZtW8ce5cEwVyOp
         fkPg==
X-Gm-Message-State: AHQUAuZdxFEIeVslVvQzc03wyHEDsne4q1S2UmJcjb+OLaSGrmjzCb38
        lFJ9j7so0AIhsf2sWv3G8fFInBxR
X-Google-Smtp-Source: AHgI3Ib+u6m6Vwu5Z8A5WHJ0w2oAxKxv7ZigtIHsS/BMzjyZvZ7Cz3qdSt+b+JP+BmjQe4Uf7HcN8Q==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr6374798wmf.17.1549831015206;
        Sun, 10 Feb 2019 12:36:55 -0800 (PST)
Received: from localhost.localdomain ([46.216.193.115])
        by smtp.gmail.com with ESMTPSA id u25sm15151903wml.31.2019.02.10.12.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 12:36:54 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gsvqO-0005ed-Pf; Sun, 10 Feb 2019 23:36:52 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and external charger tweaks
Date:   Sun, 10 Feb 2019 23:36:47 +0300
Message-Id: <20190210203649.21691-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At implementation of charging support for Lenovo Yoga Book (Intel Cherry Trail
based with Whiskey Cove PMIC), two pitfalls were found:

- for detection of charger type by PMIC, bit 6 in the CHGRCTRL1 register
  should be set in 0 (and set to 1 for Host mode). Pick up its definition
  and logic from from Intel code drop[1];

- "#CHARGE ENABLE" signal of external charger (bq25892) in Yoga Book is
  connected to one of PMIC outputs controlled by CHGDISCTRL register.
  Enable charging at driver initialization. Pick up this from Lenovo's code
  drop[2,3].

Please keep in mind that I have no docs for Whiskey Cove PMIC, so this patches
are based on some kind of reverse engineering and suppositions, correct me if
this semantic is wrong for common case.

[1]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/0001-power_supply-intel-pmic-ccsm-driver.patch
[2]. https://github.com/jekhor/yogabook-linux-android-kernel/blob/b7aa015ab794b516da7b6cb76e5e2d427e3b8b0c/drivers/power/bq2589x_charger.c#L2257
[3]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/EM-Charger-Disable-battery-charging-in-S3-and-enable.patch

Yauhen Kharuzhy (2):
  extcon-intel-cht-wc: Make charger detection co-existed with OTG host mode
  extcon intel-cht-wc: Enable external charger

 drivers/extcon/extcon-intel-cht-wc.c | 71 +++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

-- 
2.20.1

