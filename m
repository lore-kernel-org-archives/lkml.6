Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E3C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F50205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OecMCuBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F50205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLHQuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:50:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35705 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeLHQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:50:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so7261238wmh.0;
        Sat, 08 Dec 2018 08:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsaJbjcpB24+zLEci7Jp1YL8GeBwVROEK15Bc3ThBjo=;
        b=OecMCuBCNojRkcT5KvSjHKh3PDPlkdrkqfgwRyDFIcEjFSHX0NJfjca6hBqMhaKeX+
         MoBb3/VB+VCryFRKLyksxdh/VwmJnVajNTuM2/LhGdt2UpmdcCaV6Ci7vsroxrfj3+mG
         NV7lOsBWBBVWs12Iv/y/Lbh24HyimBlJMN0fMKNk2C2o/px0HhNGASvyD6UzjOHsJD21
         NfQtnf7eNQQbTYvIu2QSOHdj1ctwFlBNtWaY3AtzawbvyM+2ElNef5RlLz0UmnK/TN8C
         nmxIyW6nJcRDntNgMwB2aZGxnxpwT/eiQTvcu98/Fj2fCM52dzv5ZoM+iKUYCBHliKOr
         hdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsaJbjcpB24+zLEci7Jp1YL8GeBwVROEK15Bc3ThBjo=;
        b=h3FSbjB8tpy0yyB5QJss72AwalRugEu08ZQVVN/2DXJjk3oayRpzpw94UUenVtUqvX
         HM2SND+MIBZAU4UtZCmJCfyhb9yDPBAHCk7dN+rW8el7JMYdxlks9NYufCqo9EkaucaM
         LeG9ZK6svgRmRz6yWSKUB8fX+KN8+D4y/FAHjWpBsXnBcNtzyjcyQMTej+LvCcveMH0H
         /u2VmmwBMQ/6dbuCHAIEVx2ayTOThftFtKcNOk9xsJaS+qGG0two1pyBcKIEWPO1K7HN
         zzWZfBCfW6wEmnO1Iq4F8fB4BPb5oT5ZwHaKKk0L1xi8BGH495QH8D3IZAlcpGHabWvk
         lPvg==
X-Gm-Message-State: AA+aEWZv1eONueFehh3fGpsNumb6sbpKqKoq41P3o62wcKQsewl3cuRc
        UP6bk1nOfH+I3ecmm/wVhug=
X-Google-Smtp-Source: AFSGD/UU3bNYFBKFvnLoD0Mc0ZqsqkwP5X3TZ6g7FI6b98WTxalGTiWnGwPzL4EG5/XA6tJmRiYBmw==
X-Received: by 2002:a1c:e90c:: with SMTP id q12mr1450507wmc.12.1544287831832;
        Sat, 08 Dec 2018 08:50:31 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n15sm11395651wrt.21.2018.12.08.08.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:50:31 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/3] ARM: dts: meson: add the APB/APB2 busses
Date:   Sat,  8 Dec 2018 17:50:22 +0100
Message-Id: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
Meson6. This is preparation work for adding the Mali GPU which is
located on theses busses.

Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
region at 0xd0000000 is called APB2 or A9_APB and it has a different
size (256k) compared to Meson8 and Meson8b (2M).

Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
- Meson6: [0]
- Meson8: [1]
- Meson8b: [2]


Changes since v1 at [3]:
- re-send the patches but this time don't include the old patches
  which still had a typo in the patch description (ABP vs APB)


[0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
[1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
[2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53
[3] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009424.html


Martin Blumenstingl (3):
  ARM: dts: meson6: add the APB2 bus
  ARM: dts: meson8: add the APB bus
  ARM: dts: meson8b: add the APB bus

 arch/arm/boot/dts/meson6.dtsi  | 8 ++++++++
 arch/arm/boot/dts/meson8.dtsi  | 8 ++++++++
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 3 files changed, 24 insertions(+)

-- 
2.19.2

