Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F251CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F5A2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F5A2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLHQBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:01:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39103 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeLHQBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:01:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id n21so7906979qtl.6;
        Sat, 08 Dec 2018 08:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=K26JT2ezNbPOh+TFopWu1l8ZF3ocLZh6AHxGmomMTVA=;
        b=dsPdtthsNaQ/gYICtIMjzpmvKsr+s+OV7b+aF5DxO3JO4DhYUH/iIrsTYN8FZPvfrq
         d6AlSX+dnM0d3HmlbWCPKsb7azeMPRPWfVr5MD8zkiJhyQHE0eOk1WsP5ImfljuQ9HU3
         5xsSoxC+Me53JkHqFIYjNLR1IPGTuLsChmh4yEsv9ssAyt5fZMfMrUbbRuI0DIQO9T40
         ph07G81EwEcsMEucno3lp22gdD1XTVX5+f3AA/BrfB4YvvjJ49AWlewreGS4WMu7MyvI
         sNs1bUl9OveXuCJbkybE6LaGMqlRJ46ZUqIQH33nBUrWqkPQ2oeGNiacEDCC/SPXZroN
         DjFQ==
X-Gm-Message-State: AA+aEWandIIwtAHkgL8vEDSLjTRwUKvQtSvD+gX+8r9yV/ill6TSKPkx
        OGUO2ZqvhmcNNdhfnaslpHzJAcRCoyRdnuNNeR/jE+sP
X-Google-Smtp-Source: AFSGD/XxeFVtHmmGosDonmHdEr38iDer4rV06eTqha2zHatjuKUYquRLONH4mrKTXlOgRIobirK60Ljk/PZ2EhqPb08=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr6007787qtl.343.1544284907345;
 Sat, 08 Dec 2018 08:01:47 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 8 Dec 2018 17:01:30 +0100
Message-ID: <CAK8P3a20S++xEHTYXXuipZ+YUZc0_EY2bj0JmaDwWdgWoLTROA@mail.gmail.com>
Subject: [GIT PULL] asm-generic: bugfix for asm/unistd.h
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guo Ren <ren_guo@c-sky.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-4.20

for you to fetch changes up to b7d624ab431227af376787148cd7d474088c03aa:

  asm-generic: unistd.h: fixup broken macro include. (2018-12-06 16:57:47 +0100)

----------------------------------------------------------------
asm-generic: bugfix for asm/unistd.h

Multiple people reported a bug I introduced in asm-generic/unistd.h
in 4.20, this is the obvious bugfix to get glibc and others to
correctly build again on new architectures that no longer provide
the old fstatat64() family of system calls.

----------------------------------------------------------------
Guo Ren (1):
      asm-generic: unistd.h: fixup broken macro include.

 include/uapi/asm-generic/unistd.h | 4 ++++
 1 file changed, 4 insertions(+)
