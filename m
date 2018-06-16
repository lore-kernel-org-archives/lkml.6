Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFACC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 11:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E667B2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 11:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E667B2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932763AbeFPLKL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 07:10:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59486 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932479AbeFPLKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 07:10:10 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AhakGkO1E0wm; Sat, 16 Jun 2018 13:10:08 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDAB600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bda:b600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B69671EC00DF;
        Sat, 16 Jun 2018 13:10:08 +0200 (CEST)
Date:   Sat, 16 Jun 2018 13:10:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
Message-ID: <20180616111004.GB28657@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing this when I do

# make menuconfig

after a fresh repo clean: git clean -dqfx

Might wanna silence it...

/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  HOSTCC  scripts/kconfig/lxdialog/checklist.o
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  HOSTCC  scripts/kconfig/lxdialog/inputbox.o
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  HOSTCC  scripts/kconfig/lxdialog/menubox.o
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  HOSTCC  scripts/kconfig/lxdialog/textbox.o
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  HOSTCC  scripts/kconfig/lxdialog/util.o
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
/bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
  HOSTCC  scripts/kconfig/lxdialog/yesno.o
  UPD     scripts/kconfig/.mconf-cfg
  HOSTCC  scripts/kconfig/mconf.o
  HOSTLD  scripts/kconfig/mconf
scripts/kconfig/mconf  Kconfig

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
