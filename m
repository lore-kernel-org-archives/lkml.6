Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA4C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6D9206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqozKgxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436708AbfBMVNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:13:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39660 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfBMVNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:13:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id m11so2905345lfc.6;
        Wed, 13 Feb 2019 13:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YxCnqiw3qRuu8S8s+hubZUE8yINrCez58uPPp7Pj40=;
        b=bqozKgxYzDJBL/jO2VGqJvZCfmuOrNMw2VhQmXpM5kZFgtqVx32uyMja988eWW+zxr
         MBWapo3EUWRT/G82lyKA6ULeyCJgV8iW4EiVWwVKJvv/arQMfYdCcsBDdIW0iFbYmuqP
         aJv4NxZLQboG5wdWf/RMnZWu+G4pBvnq9o6ReghnHf2+mzST6DRWKOmZAp/jKs6I6c8z
         skyZiAM3ubW1bF9OJzLurzeEQ8o6Wj3VyVHydD6GpSj7IgkuLnAY9zx6KYpT8+VjT0Yh
         EG6gDHU9puCJPmVoS8lffCgLHhZLnG7SOddR/Zbzd2gKA5jxHPC5uBlU1EQclKsMCJIL
         ByZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YxCnqiw3qRuu8S8s+hubZUE8yINrCez58uPPp7Pj40=;
        b=adVawpkhgE1gBNGQFikNi+bGDBke65ijX8a4gNZzMppPtTVnQYHcZK6s05EJpjkyxX
         cOEX+p/ZkESE/IQUAT574aeJ5HiquCzwsiVw2o72AwzeWQEg8cIPIvxFzyMr6OOH1VZa
         q0nHGb5Vq0r1K73TkwTa07K+UxFzQF/cPgPDfAKIWZ/bqwH5Qx9WOIvAGY+Q23tCAsSO
         Sod3LkPYd4MMu4im/0VNmABrJMOtVj7UJTUTJVUeZtYMUkO0U4nKss3220Zl3x9NStXm
         h41pEBMlXKml80vzSOu5diTJ/lC5Ir9B6zQm1S+Zuc8RproZkkKDR683D4Q0rI1Wr+ay
         NjeQ==
X-Gm-Message-State: AHQUAub2av9l8O1Glk4FBu/qrzu7wt2CvTgQKBf+yhm3ekWTFI2MMAPn
        R2f0IcmdgLETi4acb4KwTR6neb3HeRw=
X-Google-Smtp-Source: AHgI3IZTt/DmnEUpLQ/DRCo53421XAeqwdOf45qCHPIxOXqxWVjg4zrj9QVxYp9Mug+0PNl0RmD77A==
X-Received: by 2002:a19:f814:: with SMTP id a20mr105663lff.138.1550092422099;
        Wed, 13 Feb 2019 13:13:42 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id p77-v6sm83857lja.0.2019.02.13.13.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:13:40 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Martin Liu <liumartin@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Harry Pan <harry.pan@intel.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Samuel Sadok <samuel.sadok@bluewin.ch>,
        Ivan Mironov <mironov.ivan@gmail.com>
Subject: [RFC PATCH 0/2] Fix for the internal card reader and suspend on MacBooks
Date:   Thu, 14 Feb 2019 02:13:21 +0500
Message-Id: <20190213211323.6072-1-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

There is a known problem on some MacBooks: internal card reader
disappears after the first suspend/resume and all subsequent attempts
to suspend laptop are failing.

This was reported[1][2] and even discussed in the mailing lists[3],
without any real solution. After trying various things[4], including
some existing quirks, I discovered that switching link state to DISABLED
before suspend both fixes the card reader device and allows any subsequent
suspend to succeed.

First patch adds code for this new quirk, and second patch enables this
quirk for card reader device which is used in my macbook.

I'm not really familiar with either USB standards or kernel code to
support them, so this patch series is RFC. I'm especially unsure with the
"resume" part, because I implemented it by trial and error mostly.
However, I'm using kernel with these patches and it works for me.

Also, feel free to suggest other kernel patches or existing quirks or
quirk combinations to fix the same problem.

Oh, and by the way: I've checked schematics of various macbooks available
on the internet. It seems that the actual chip is Genesys Logic GL3219,
probably just with the custom ID. What I found curious, is that USB 2.0
pins of this chip (D+ and D-) are not really connected anywhere, but
instead shorted through the resistor. Could it be possible that this
somehow messes up some logic inside the device, host controller or
linux kernel?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=111201
[2] https://bugzilla.kernel.org/show_bug.cgi?id=202509
[3] https://www.spinics.net/lists/linux-usb/msg164261.html
[4] https://github.com/im-0/investigate-card-reader-suspend-problem-on-mbp11.4

Ivan Mironov (2):
  usb: core: Add support of disabling SS link before system suspend
  usb: quirks: Add quirk to fix card reader and suspend on MacBooks

 drivers/usb/core/driver.c  |  6 +++
 drivers/usb/core/hub.c     | 84 ++++++++++++++++++++++++++++++++++++--
 drivers/usb/core/quirks.c  |  7 ++++
 include/linux/usb.h        |  3 ++
 include/linux/usb/quirks.h |  9 ++++
 5 files changed, 105 insertions(+), 4 deletions(-)

-- 
2.20.1

