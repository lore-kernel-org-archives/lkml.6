Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FBFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E706B2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiAfQAAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfA2KZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:25:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35138 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfA2KZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:25:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so8567469pgs.2;
        Tue, 29 Jan 2019 02:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yCoqyS5sQXkP21/OTQAB1RFTdGLdq0rZC3i7yVDJ9jo=;
        b=EiAfQAAc2YRyybe4jf6fWxnef7ujdYUZyUuWjDL9/ScYNiLocvXK/DF5Uf6g9fXy9K
         FKaJ41fPoTxnTgMFbNdAdJ4fwEtwf1Vig6gfBh450RVgDQFyIITV2NP0tgLp00Hgz0rS
         e1MzkYIwFvWeZ3+AOjS829oufwJ2qsn8aBBn8i2Exk3/5ay3zSUyg4qcfkZwCq6Vrl4a
         1u8IPCkjuahV4vXvvMZezNU3faqXeZxaibz47G0bvbvc2bsOxTHtvGkKMvLyplj4Cc+C
         kqlHjkUWJGbBHZWdAw/Teq7SzCF8AqeuLp+USjAfPXQHkIF+kfMmPaUMd6sfdJtGTBO2
         LdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yCoqyS5sQXkP21/OTQAB1RFTdGLdq0rZC3i7yVDJ9jo=;
        b=OMrsKmjL7qSY5EpPnZd2OxfrJlWSp3diDaf5WKpth9ePjSbY1MsY+aQaRO9ghFmMiS
         AMSmbG+tq9FR65a0q8n59cFAvrzNkcN5RJg1MPgGhkRecltUI3IGJIlZz/YkmQh1L7Mx
         7oJ0thGU8OVkOpGq9fqRG9dXn52pND56Byb3cL3lDj8IBKwHbkIfSp+CzreZ2UwVn0lQ
         WmnskaloCm0QQehVwjfLg1jmjnQdD4BV4TJC7QDfyJUHTXkaloNwT6VcEETe2nnewety
         A9COULCr/HZv7fGophvt0fsqdN+xfm4CCwuGVmwLsYR8ABfiTzfaDAV7tvpZe55yNCrO
         bGsA==
X-Gm-Message-State: AJcUukdpxr+wNLJNbWtVKlvlWRPX7kQfU/fMiZpg/LU8I+ebtjyhDaG/
        tnOgc+UykTaUyEZYl34eLP3VqNqU
X-Google-Smtp-Source: ALg8bN4caAyx6vY7J82t3dGW3QZWBS+SsIi+Bh/UXDRyRyXsNpJn7BWvm/SeXdPbvlV4dOkCfRcfqA==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr25389034pfg.235.1548757528738;
        Tue, 29 Jan 2019 02:25:28 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.149])
        by smtp.gmail.com with ESMTPSA id d21sm47744462pfo.162.2019.01.29.02.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 02:25:27 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCHv3 0/2] Odroid c2 usb fixs
Date:   Tue, 29 Jan 2019 10:25:19 +0000
Message-Id: <20190129102521.4141-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is follow up on my previous patches.
Changes rebase on mainline: 5.0-rc4

[0] https://lore.kernel.org/patchwork/patch/1031243/
[1] https://lore.kernel.org/patchwork/patch/1031243/

changes depend on phy patch

[2] https://patchwork.kernel.org/patch/10777359/

As per Martin's suggestion and input I have tried to fix below issue.

Fixed the phy power issue on the usb port.
# cat /sys/kernel/debug/regulator/regulator_summary
 regulator                      use open bypass  opmode voltage current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  5    4      0 unknown     0mV     0mA     0mV     0mV
    c9100000.usb                  1                                 0mA     0mV     0mV
    c9100000.usb                  1                                 0mA     0mV     0mV
    c9000000.usb                  1                                 0mA     0mV     0mV
    c9000000.usb                  1                                 0mA     0mV     0mV
 P5V0                             1    1      0 unknown  5000mV     0mA  5000mV  5000mV
    USB_OTG_PWR                   4    2      0 unknown  5000mV     0mA  5000mV  5000mV
       phy-c0000020.phy.1         2                                 0mA     0mV     0mV
       phy-c0000000.phy.0         2                                 0mA     0mV     0mV

#  lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 2, Class=Audio, Driver=, 480M
        |__ Port 3: Dev 3, If 3, Class=Audio, Driver=, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M

Now hotpluing of usb device is working on odroid c2 boards.
TODO: need to initialize the otg usb port to accept usb device.

Any input are welcome

Best Regards
-Anand

Anand Moon (2):
  ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
  ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator power failed
    warning

 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.20.1

