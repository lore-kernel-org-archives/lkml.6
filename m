Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0525C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515B020866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHIHpw8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515B020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIMRWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:22:39 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54643 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeIMRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:22:39 -0400
Received: by mail-it0-f68.google.com with SMTP id f14-v6so7454567ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2LGZVX/QPOtYkFeURxYBVnkopTb78PDQvKrl3YDuBxo=;
        b=WHIHpw8KkoR4nUaBTHFlSxFLWGIQLjp2xzYlQxtTob+omCQaGL4skyEqFKec272o2c
         6xQAMrrDOo8FUVEWXBe+ZDbUcSqR7P4hFJCSj1QwST8N/jmZrkC9Y2hH+zwkSTnvz+Ql
         69HwVU0L0eVXYRg4ALRH4n8O+K2wMZ2E802Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2LGZVX/QPOtYkFeURxYBVnkopTb78PDQvKrl3YDuBxo=;
        b=OqWZhx/zL7/Zqb/0n5qg1nyLPRQNNfdh/ItKBkhCmLzlysCdxbzS7iPauVQOQiMbQz
         LK02V8tmAUU0aRO6aMQ/X8pWLyRAgVCjtB1SK3U9QrcQ7gBaikyWuJ16NjNaQoO55v5z
         iOtjqVLUoDiROtCC4ZU6eXSZsw0CzhojIWRItSJUB6bBmdarmXXBPUZcC2S7CNihQ+1J
         4/a/+evbjrPh9dLdBDGbv4sEtRNYI5LWrZzST6HP2kRV6qQEgTXAq2pNP1EpROI0vbl6
         H0xdJD6al/ZyIpfWmg9txC15pX409qmTTqkYRFouAsZQ7t5IWq/GcZjN3gYXZfMpWNKB
         Up6g==
X-Gm-Message-State: APzg51D6FEi8BdLKWpBp1BPhIT8lT9YPtTJCQtWPkWwm/4s1O+1tGY/F
        I+Yg1I411h43YnrUkEzCGD2N6Nl4lgmXUQUseI3pAZ0wiFg=
X-Google-Smtp-Source: ANB0VdYNxvUvK/Lj3LTH0g92AZ/f4geaGNlaKU3nQbQ+nHMKclJkg8UQWqqvA4mYMTPl5l/E0JGP1AuujN2zaJgM2rk=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr6242858jab.87.1536840807019;
 Thu, 13 Sep 2018 05:13:27 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Sep 2018 14:13:15 +0200
Message-ID: <CACRpkdY7m-Q54BwoKEN5a4+9fTgQ3o6qWNXT+y0bqGkG2dkBiA@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some three pin control fixes for the v4.19 series. This subsystem
has been unusually quiet this merge window so not much fixes appeared.

Please pull them in!

Details in the signed tag.

Yours,
Linus Walleij


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.19-2

for you to fetch changes up to 5bc5a671b1f4b3aa019264ce970d3683a9ffa761:

  pinctrl: madera: Fix possible NULL pointer with pdata config
(2018-08-29 14:02:47 +0200)

----------------------------------------------------------------
Pin control fixes for the v4.19 kernel cycle:

- A complicated IRQ fix for the MSM driver (see commit).

- Fix the group/function check in the Ingenic driver.

- Deal with a possible NULL pointer dereference in the Madera
  driver.

----------------------------------------------------------------
Paul Burton (1):
      pinctrl: ingenic: Fix group & function error checking

Richard Fitzgerald (1):
      pinctrl: madera: Fix possible NULL pointer with pdata config

Stephen Boyd (1):
      pinctrl: msm: Really mask level interrupts to prevent latching

 drivers/pinctrl/cirrus/pinctrl-madera-core.c |  2 +-
 drivers/pinctrl/pinctrl-ingenic.c            |  4 ++--
 drivers/pinctrl/qcom/pinctrl-msm.c           | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)
