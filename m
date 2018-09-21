Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42B3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED5721550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h798V7kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED5721550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390862AbeIUWxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:53:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40819 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390757AbeIUWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:53:08 -0400
Received: by mail-it1-f193.google.com with SMTP id h23-v6so2659800ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AypJKrShZ46lIS6xYCO1jLVZcRivm2Bifskyzb14EgY=;
        b=h798V7knxQ3BLF6xQGaazS6SRrA359PFKXRIoRTQ5DuXgJCUdny1dKgfqQj7brztwc
         iW2Odi9/jxqmzeoS2Y7J0/ccr7GIAUF0e2ItFwkvpuRr8giFnjM99aYplVma4IYXR6Zd
         46itaGUDIRwIH5Jvw/6/U0MTNAbADj5vs0eF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AypJKrShZ46lIS6xYCO1jLVZcRivm2Bifskyzb14EgY=;
        b=E7vTC9xocpynZkhVfIbKv3g5Q97wtGi3bToMEWMhN1ehWAjIroJlW7hhg/1nFygAGa
         VG/xiTewZjizxeZtdoYqCfoBQ6e6hLJUZd2kmW4IBOdmg2XSauXMs85lo2quPEaX0wY5
         XUFqOxeoGpNqsEZtE4nDaEVeviC49YYuartPhlL0a4cPXhj3EcmGhDgyRVW058G3DKL4
         Hl/nIngOtDbdjWnL72DGOAc3t18WWTnbIfg17M+maoiHTNzq6JX81XkulQeQO4na2dHp
         9RykI9S0He2tITx5nK9YwefiAQ9sCTKJFavkblCekvLjt9Gf4MZgpUAFS3oCzu1yddWq
         NI0Q==
X-Gm-Message-State: APzg51DeoKI4EClCqviqUboZ0oQN4RapVwMaBgUCr7LxXyJsVMWdeYZ2
        Nzq+CCbwVpaZ7ouZfXVkW5oDM4E6CqDi4mkh2JUfYQ==
X-Google-Smtp-Source: ANB0VdbDvOewE7nY0+feNOhV551cEFzXH82cv2LXsdKHrj5oU5rfakbYmNY0ZXFZ01++8Vgqh0+96UqizGCs+SnHhTI=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr40778056jag.112.1537549401302;
 Fri, 21 Sep 2018 10:03:21 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 10:03:09 -0700
Message-ID: <CACRpkdaTsM-VV7ck1E8Q_Fv+9NSQ7a8mQp_WAyBMvZjGkrYeLg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v4.19
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

here are some two fixes for pin contol for v4.19.

Please pull them in for the current HEAD.

Yours,
Linus Walleij

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.19-3

for you to fetch changes up to 96147db1e1dff83679e71ac92193cbcab761a14c:

  pinctrl: intel: Do pin translation in other GPIO operations as well
(2018-09-20 08:21:52 -0700)

----------------------------------------------------------------
Pin control fixes for v4.19:

- Two fixes for the Intel pin controllers than cause
  problems on laptops.

----------------------------------------------------------------
Mika Westerberg (1):
      pinctrl: intel: Do pin translation in other GPIO operations as well

Simon Detheridge (1):
      pinctrl: cannonlake: Fix gpio base for GPP-E

 drivers/pinctrl/intel/pinctrl-cannonlake.c |   2 +-
 drivers/pinctrl/intel/pinctrl-intel.c      | 111 ++++++++++++++++-------------
 2 files changed, 64 insertions(+), 49 deletions(-)
