Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD53C677FE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D136520841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IIL1NgBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D136520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeJKXB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:01:29 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:54832 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJKXB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:01:29 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9BFXWKU022455;
        Fri, 12 Oct 2018 00:33:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9BFXWKU022455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539272013;
        bh=Cp/gB/J2n37Z+7imvuePQbkNegwSmHeGuREzCbR+aC4=;
        h=From:Date:Subject:To:Cc:From;
        b=IIL1NgBHWwgaoafFJv7nI4e1K6KxoJLzA1dZxCVUwjNRsMWwbKKWCyYf+SM3tr25i
         phQx3cH4+119X567/zRuIjKLeaXOzZIHw0ALUZaWOZOlFH96zJRRdmMSbtY1kDSZe+
         /JAnBM1n6S+FqGdDOsdq9iiFilIFnoo/WKYMMaw7Nex97Yh+kotKD5Oevn+UHyMxh9
         17fZ5rMttlaYGHutqzNfiZKw9eepYUv+nlIV67s459bNKqtloEUVIBf6IsG2iyHGBb
         m1RVZT1wnFsZyr/L86osAD2DVzYR+P9kfhwKWiQDOWojPQ3qdfLkuwHfnNVil/b9iA
         WFmEjWo+rpaNQ==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id b2-v6so2246398vkd.11;
        Thu, 11 Oct 2018 08:33:33 -0700 (PDT)
X-Gm-Message-State: ABuFfog5aEcrTSHTmzeiX+VwDKS/jf9XBz0CLd3yHPwDwFhcwYPw4noc
        M88dHAzyxNcW06RnYGORo3W67AiBxtHhpNcWsPc=
X-Google-Smtp-Source: ACcGV60BzHF5d3IRz1CQGRigPHPrkzN9qdT8J5C0XjcBzTSl38fbEsDdlHrpKwTIxqsau0POoSyOz7UujmuP3RcJ4Xo=
X-Received: by 2002:a1f:b215:: with SMTP id b21-v6mr922120vkf.0.1539272011904;
 Thu, 11 Oct 2018 08:33:31 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 12 Oct 2018 00:32:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQHYH-SM+fZ0PkLYYCpeHZ-yYDKQpFeJKb7BCR7LtCr0A@mail.gmail.com>
Message-ID: <CAK7LNAQHYH-SM+fZ0PkLYYCpeHZ-yYDKQpFeJKb7BCR7LtCr0A@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v4.19-rc8
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull a couple of Kbuild fixes.

Thanks.



The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v4.19-2

for you to fetch changes up to 5318321d367c21ca1fe9eb00caefc239c938750a:

  samples: disable CONFIG_SAMPLES for UML (2018-10-11 02:15:46 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.19 (2nd)

 - Fix warnings from recordmcount.pl when building with Clang

 - Allow Clang to use GNU toolchains correctly

 - Disable CONFIG_SAMPLES for UML to avoid build error

----------------------------------------------------------------
Joel Stanley (1):
      ftrace: Build with CPPFLAGS to get -Qunused-arguments

Masahiro Yamada (1):
      samples: disable CONFIG_SAMPLES for UML

Stefan Agner (1):
      kbuild: allow to use GCC toolchain not in Clang search path

 Makefile               | 8 +++++---
 samples/Kconfig        | 1 +
 scripts/Makefile.build | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)




-- 
Best Regards
Masahiro Yamada
