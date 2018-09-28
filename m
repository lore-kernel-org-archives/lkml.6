Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B9AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB84B2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzwJvy/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB84B2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeI1NWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:22:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45583 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbeI1NWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:22:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id l2-v6so5501213qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sVl12LPaWU/vTGich20JfVfI1hMbOr67OUKx9uCQgF4=;
        b=QzwJvy/zRsiaHGgauLQ1LDdDyZ9OPYEj5O3ubVorkx39ySF1Tq5RL/9rn5J/EVluT2
         d5+DLoh3hSyRCPQO8fcRGepoNRd6OQymkTvQADljxPZy7Xyn6QkUZwqL2CWASgJUduJ/
         AZ62IF91yDjU2LhqSdgeufIQ4UgK3phAufnEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sVl12LPaWU/vTGich20JfVfI1hMbOr67OUKx9uCQgF4=;
        b=Ck6juckdN1lT+VcYeHwzvbS5yE5CurIltsL+ersLKynlGo6giWYphZv8hJ7UTzzF+n
         m6dgqwmnLAu24r3I3nnk8cE+MW9mmuGrwjGvvPOkEM978P44R34U8H4TBdEfN4ecbxPA
         IBerrQYONRjNA6daNtJTMrXhF/LNW6/TurX9bnWP2xBQbsckZkYBh0qdyWYfMU3HCI6P
         qR+652WpPjbgy9WmDPXWxiRiYUqT6uCNbvG6OyaCqJ399AIIW3x1W036JzXciB2px5Cj
         JV6/l+Gm29pKOzV8DOJGx33yqUNB7cnKddLaR4B1yKxF56sxTAMDOdISOP/ozYm9RhFm
         KDzA==
X-Gm-Message-State: ABuFfohZobeVqEauvoLsTyrglBVd/5mztiVhH+faXH3cOxLRwmNto3T1
        dQNm3VuoyENHqmaq30uYWE8Bc0i8M7I40IMHrt4gzWP0RSI=
X-Google-Smtp-Source: ACcGV63WOYOM3GRsDJ5N/hJN+hk9+AznmOrmqZCZ2h+Y8E0QPbkbOVjKCHwKcVrdf3gZG/gdkMtPeAS00Goy/6cTQ4k=
X-Received: by 2002:a0c:af2f:: with SMTP id i44-v6mr11109046qvc.105.1538117984423;
 Thu, 27 Sep 2018 23:59:44 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Sep 2018 08:59:32 +0200
Message-ID: <CACRpkdbQrZ7HHunuB_BdUo666riyg4ZKAOKo8BDHCY3RDYrXgQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v4.19 take 4
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

here are some three pin control fixes for v4.19.
All are x86 related.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.19-4

for you to fetch changes up to 72923e5488f0604fac8ef2c7e683fabd3b4c203b:

  Revert "pinctrl: intel: Do pin translation when lock IRQ"
(2018-09-25 12:50:00 +0200)

----------------------------------------------------------------
Pin control fixes for v4.19:
- Fixes to x86 hardware:
- AMD interrupt debounce issues
- Faulty Intel cannonlake register offset
- Revert pin translation IRQ locking

----------------------------------------------------------------
Daniel Kurtz (1):
      pinctrl/amd: poll InterruptEnable bits in amd_gpio_irq_set_type

Mika Westerberg (2):
      pinctrl: cannonlake: Fix HOSTSW_OWN register offset of H variant
      Revert "pinctrl: intel: Do pin translation when lock IRQ"

 drivers/pinctrl/intel/pinctrl-cannonlake.c | 33 ++++++++++++++++++------------
 drivers/pinctrl/intel/pinctrl-intel.c      | 32 -----------------------------
 drivers/pinctrl/pinctrl-amd.c              | 33 +++++++++++++++++++++---------
 3 files changed, 43 insertions(+), 55 deletions(-)
