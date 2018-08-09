Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8104C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFCF223A4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Toftlf+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFCF223A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeHJCGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:06:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42165 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeHJCGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:06:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so3466808pgp.9;
        Thu, 09 Aug 2018 16:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WH9C6aPncpv7oadaxYzhzS2e0PHVeyYCboiUoVpE7Ys=;
        b=Toftlf+xmhLrhGwUtX7fzsRBzLw5Oh4HGYO2nTMLrU068JcYEL2OMguVZ9tCCfPh4P
         WR80CJCZdBKexbkus5fBf1ZLgoQbNi4lRybZN4kSWnuRrklnvEZU1wHOVg1liCRoCSM4
         E1JYQc/SNLf6zxKTlFJs6KXzXJ0r0Rqwg9tVs/hUPo2gmiJHdwksO7urQDsGf01vgjjD
         XSHFHMZ9eMF2ZLlGoLHfScT086kblfo4tmi/+ifYJjCR2Bqu7Rp2UECgM0URvRhTgRGs
         PdJWdnTs7qDhG848Scu9dYH8UHSkzXzVWKsuvHMwnPdeSrUpEQZjgQI/Nr4M/Y2/jKFf
         6dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WH9C6aPncpv7oadaxYzhzS2e0PHVeyYCboiUoVpE7Ys=;
        b=mG0/P5J9D/jfomkPOaMLSlBq5kNPpXhcMI4O2VwkW1BKNPsjeAb8rQTT3B12xHrvPW
         VkjAfNWE6y5adMzGtui5oTZm2k/7MNvEvY9tVAiuNBSDEBCXQT7s1A3V//KFVgCqx3YB
         viwL2QRLWPg1Ck/nc3rHqOsxIJg0F5a/oUAun13kDN8Nv90bZdsRIU4frjnY0WwPs1yB
         gDNuYQlu2n36YapCyXqa25jYuoQdD+JLBLwX8b/zOQHgXBOkuXGSAoO6LBe8klvMAn9Z
         j3FaadSdykjh+lntOGG1TY071cJqweXncJc2+Kq7a8C9v+32uMaOYx6pUW7MuNSvQp/Y
         A6UQ==
X-Gm-Message-State: AOUpUlH3Zngg0bAyVr8CiRL+DEN8Hvj/SyukHsmkxkFlgxvVRRoK2rqi
        8b6/r2kmRureW6l7woY5SH6Gu9ms
X-Google-Smtp-Source: AA+uWPxtie/yAeCFrazMzEaWqhVbVOuq8xnmnzeu7QqxN2QGaJiyCuEqWCOeAPVUsTnrrXzgYNv2aA==
X-Received: by 2002:a62:7086:: with SMTP id l128-v6mr4435426pfc.144.1533857969400;
        Thu, 09 Aug 2018 16:39:29 -0700 (PDT)
Received: from hobbes.alyptik.lan (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id d191-v6sm14275101pfg.172.2018.08.09.16.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 16:39:28 -0700 (PDT)
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: [PATCH RESEND 0/4] reduce Surface Pro 3 multitouch jitter
Date:   Thu,  9 Aug 2018 13:39:15 -1000
Message-Id: <cover.1530402641.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180809233915.fzWMBW4HWIbJ9OitIwSp2q3scDkFWnDztL1PYPOUuRY@z>

The Surface Pro 3 firmware doesn't reliably send contact lift off
reports nor handle invalid report values gracefully.

To reduce touchscreen input jitter:
  - add MT_QUIRK_NOT_SEEN_MEANS_UP to the MT_CLS_WIN_8
  - drop invalid report values

Patches have been tested on my personal Surface Pro 3 for a
couple months without any problems, as well as being run in my
Arch Linux AUR kernel package [1] without a single complaint
so far.

[1] https://aur.archlinux.org/packages/linux-surfacepro3-git

Joey Pabalinas (4):
  HID: multitouch: add MT_QUIRK_NOT_SEEN_MEANS_UP to MT_CLS_WIN_8 quirks
  HID: multitouch: don't check HID_GROUP_MULTITOUCH_WIN_8 for serial protocol
  HID: multitouch: drop reports containing invalid values
  HID: multitouch: remove unneeded else conditional cases

 drivers/hid/hid-multitouch.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.18.0

