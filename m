Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 633C2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5D8208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jWzyn72M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5D8208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755079AbeFNKhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:37:33 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43054 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754871AbeFNKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:37:30 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5EAaqEe008870;
        Thu, 14 Jun 2018 19:36:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5EAaqEe008870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528972613;
        bh=sZDntsvfSkAbkQrfkhq8kCHa/Wdxf+eS/CSIKjDaDnI=;
        h=From:To:Cc:Subject:Date:From;
        b=jWzyn72MCzcIaQv1cPlAFODMVkeP5j+YtwjPb5jagxfH+Lx0kCsMbiuLA0I2GBn+9
         v3Ozrv4wnYRKtF488V1k9KW/PNXmYB5lvGiI5MME1dE+o2/GDngnBh0ou7b4nwcq4o
         wlq/1MPAzDfBNOW8nXjC/vRW7QNQOWiLFML9HXnS7t6E42xrRoYWgQpgGSXqAsnIf/
         nqK21vjO+e0i7LfUY+M63c0Ypo6ZHGGsB8cJ8dfSQbJ6uI54ypF0TC4j8Y5QaHFEJU
         znrXKoHPc9cbSLfOb+hsYsWyweM4exQLQ0irSbygeIIH7SkXsuuFUdeq9+3PampqdZ
         qWLEOZih3odLA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] Some more changes for stack protector config symbols
Date:   Thu, 14 Jun 2018 19:36:42 +0900
Message-Id: <1528972605-24264-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

While I was checking the renaming commit,
I noticed some more fixups.

The first two patches take care of what I missed to update.

The last one is another renaming for consistency.
(Sorry, I should have asked you that.)

Please consider applying this series.



Masahiro Yamada (3):
  x86: fix dependency of X86_32_LAZY_GS
  kconfig: tinyconfig: remove stale stack protector fixups
  Kbuild: rename HAVE_CC_STACKPROTECTOR config variable

 Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
 arch/Kconfig                                                 | 4 ++--
 arch/arm/Kconfig                                             | 2 +-
 arch/arm64/Kconfig                                           | 2 +-
 arch/mips/Kconfig                                            | 2 +-
 arch/sh/Kconfig                                              | 2 +-
 arch/x86/Kconfig                                             | 4 ++--
 arch/xtensa/Kconfig                                          | 2 +-
 kernel/configs/tiny.config                                   | 4 ----
 9 files changed, 10 insertions(+), 14 deletions(-)

-- 
2.7.4

