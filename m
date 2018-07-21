Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7040DECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F03E20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="nD4q3/+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F03E20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeGUWJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 18:09:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36753 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbeGUWJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 18:09:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id u7-v6so13835219lji.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=rkcHUiXWumDfXGbM5Jy5uNQWiA2/TK8jZ7jtZKpPrHY=;
        b=nD4q3/+pi0/YAHkXS9IGOt/xq/gJ92THaTF6zzVM69gHpBujnWykSYLCC8oPj393wT
         1W8aEK8hkTQGsKJMogJvBDkNaao5VUQwjW9P9SSbD4ad46El1lZmtr9fms+72UIDSFnq
         KoRxGzdjqRyR9JzyO6fS5nENxqQaQ7wUZ6WWvBVbXN88vuVZE5xIQ0sRMscb3sBO7Ckz
         m+yBIBYZqcebUFWb2NMGmQVMXcrll+VKRc0kRZqDBph7M6z3ggzZj8rtBJ8rnkMVlaIh
         ozPrC393MMcYxDSu1xDwVxtGKeBe1VK2PYKPRemi/TXcrjA3JGsPcDCTdqMOOT1rSD+u
         ft+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=rkcHUiXWumDfXGbM5Jy5uNQWiA2/TK8jZ7jtZKpPrHY=;
        b=fcG5wVEFg4iVmorCUBI3jbHWHSvR6GF4fX5KXuh9YGOVv73VPyIlLBOzYVm0L9gr8p
         WnrIHOCl/jxBMHqnjRtmE7BS6j4pG4iF8iAkAxAerFlYWjL8G8Fej6tXVDjoQ6cYZsWv
         tSkWr48FiCLGUo8bPZX5BL3qckp/TYytpW0TuvXHU51w5G+PXt3HJGR6O9hCZjuHT7ii
         BqRaZf8O9Jv0pDep1a/w0jnHAgD9ARpHYyRYMZ+YRpYMMqBzw5yjPqHSv7cF6w9Z2RqJ
         bX8IjG4uxUL6SeuJjK+z/9cXbTH0SMn84zUUtepsInTeSc5wn/waEJvoZ/XZkq4VIart
         D9ag==
X-Gm-Message-State: AOUpUlE76HB6NYhF9gixjn1NDQjIepNM33jBSB+tVLvn3tKIX0mAJYzq
        IOdsW+wEiLjKPl1jYQxV2V0wPw==
X-Google-Smtp-Source: AAOMgpd0HSS2UIAoGtDyNKGXh2EwiRDMVr3yTEcdaFeUNlr702yYpJAFymVuMYMGoJFkxjxQF5ctkA==
X-Received: by 2002:a2e:144f:: with SMTP id 15-v6mr5169665lju.122.1532207730450;
        Sat, 21 Jul 2018 14:15:30 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id n129-v6sm478197lfb.3.2018.07.21.14.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 14:15:28 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:13:49 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180721211349.f43vzd67fm6b5jim@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 13e66ceea1600f1061181acc2d4e0fac1a7d0333:

  Merge tag 'omap-for-v4.18/fixes-rc4-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-07-14 15:14:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 5858610f0dd76151c4e12420fd11801d23737663:

  Merge tag 'imx-fixes-4.18-4' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into fixes (2018-07-20 14:22:11 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.18-rc

 - Fix interrupt type on ethernet switch for i.MX-based RDU2
 - GPC on i.MX exposed too large a register window which resulted in
   userspace being able to crash the machine.
 - Fixup of bad merge resolution moving GPIO DT nodes under pinctrl
   on droid4.

----------------------------------------------------------------
Anson Huang (1):
      soc: imx: gpc: restrict register range for regmap access

Olof Johansson (3):
      Merge tag 'omap-for-v4.18/fixes-rc5-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'imx-fixes-4.18-3' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'imx-fixes-4.18-4' of git://git.kernel.org/.../shawnguo/linux into fixes

Pavel Machek (1):
      ARM: dts: omap4-droid4: fix dts w.r.t. pwm

Uwe Kleine-König (1):
      ARM: dts: imx6: RDU2: fix irq type for mv88e6xxx switch

 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi  |  2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts |  9 +++------
 drivers/soc/imx/gpc.c                    | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)
