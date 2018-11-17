Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62D2C04EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DDB206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlcF3LQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DDB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeKQLWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:22:34 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41360 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbeKQLWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:22:34 -0500
Received: by mail-qk1-f202.google.com with SMTP id n68so54734756qkn.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 17:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=//oLCiaulrU9R/KxJFqT9+N+Fsj9dA6lmJFRUXTRLEc=;
        b=VlcF3LQB2Y42qfvTiU3KNZqAvi2pTcAVzWtEneJ5Tfb45i0I6Eq3mi0UMaVeVdkFWw
         3rcgdseEFurHdFUfsA0ucpy0mt4vnvWfmRQbR+MnpvHwF0NDZJUAzj2pg0t/848UfImB
         Km/3ffOGk9LyePxLH81bRKpVWoy0wlH4ndFKp5yWB9vx8vhJByUM6yRw4adzBRDzMfMy
         oNZdaYnJ0wH+uXwemJCogKV7YcmQ2w4SD3qTdPF9etT5k53e8o0fguEmB951vCdYPhnz
         IEzUdCvcBhNqGXW1Dq3Spo8otpBc5Ddt/o9QEHkpm6qISHryHGPS1Vs19tiRcoS3CGn7
         uljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=//oLCiaulrU9R/KxJFqT9+N+Fsj9dA6lmJFRUXTRLEc=;
        b=sabbdahyKljOq5CGYHwRE18NdaUxBgZuo90yA37QjveE+ImxuASgOJe3A78uDEb1rQ
         Rk7JIyE107jrysj0ia1LnNPBWlFuGQq5KThF30KlGjeVIZxO8C9VGyROHZbJ68kDRts+
         HVoldgQm5aQVOfkgSJq2yfcIrbUILyslJ9rbEbwU3iXqAYsqnHrWNXruv+IfW/7ZSyOk
         Xhc4T25Ry8iUkqemUbMiw/NsfwA34codo5nRbH25Ubx1Lx1JPJYsJIOqtLpPV3mk6LGE
         FfTIP/3f1uQbNbWObK+QL5aNAg+vZnYzZOi9BMz88vXQ044614IYpk5OtzKNYK5QOXnY
         GnGg==
X-Gm-Message-State: AGRZ1gJy1VCXMU1+GMI8Z9BuhnRs8l/zbI/pwtzl1RpZqNRI13WbGJer
        BVWYVlEaRdP0PNeHV9LleVg5F4Y+JDBs
X-Google-Smtp-Source: AJdET5dUOdhATft1VO59rYlUEY0vQ3/Nq4Y0lQVF7D5mT5h+c9/l+ZQwf5l3A3yEibeQhg1wa3RLEmZrj6ZV
X-Received: by 2002:aed:22a7:: with SMTP id p36mr5010855qtc.53.1542416873139;
 Fri, 16 Nov 2018 17:07:53 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:07:43 -0800
Message-Id: <20181117010748.24347-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 0/5] Reset Intel BT controller if it gets stuck
From:   Rajat Jain <rajatja@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc:     rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be error conditions within Intel BT firmware that can cause it
to get stuck, with the only way out being toggle the reset pin to the
device. (I do not have the details about the issues that lead to such
conditions, Intel folks copied here can elaborate if needed). Thus, this
is an effor to be able to toggle the reset line from the driver if it
detects such a situation. It makes few enhancements to the common
framework which I think may be useful for other unrelated problems.

Dmitry Torokhov (2):
  usb: split code locating ACPI companion into port and device
  usb: assign ACPI companions for embedded USB devices
  (This basically allows ACPI nodes to be attached to the USB devices,
   thus useful for any onboard / embedded USB devices that wants to get
   some info from the ACPI).

Rajat Jain (3):
  Bluetooth: Reset Bluetooth chip after multiple command timeouts
  Bluetooth: btusb: Collect the common Intel assignments together
  Bluetooth: btusb: Use the hw_reset method to allow resetting the BT
    chip

 drivers/bluetooth/btusb.c        |  63 +++++++++---
 drivers/usb/core/usb-acpi.c      | 163 +++++++++++++++++++------------
 include/net/bluetooth/hci.h      |   8 ++
 include/net/bluetooth/hci_core.h |   2 +
 net/bluetooth/hci_core.c         |  15 ++-
 5 files changed, 171 insertions(+), 80 deletions(-)

-- 
2.19.1.1215.g8438c0b245-goog

