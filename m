Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3004AC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5476E20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZKas+jI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5476E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJWJcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:32:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42474 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:32:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id u20-v6so12087774qkk.9;
        Mon, 22 Oct 2018 18:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=8ZZdwg9lcy0z91UPab3v9CZJ0b9BOj9iK1CKQUx/A14=;
        b=nZKas+jI/hQ2yYEGX5FQ3Q3sw0kY3wvFIt+zIMPf1i3mcH1Z2t5vACn7ZADUsRc5cM
         oco5ErNHEmU8Zy7XKDl/ijhyFypY3axkG2m4ig9PEjkIOh8vRGbFT9kgZGwsp1jgoDD9
         NBemkugAZXqwmEaHfGSQlIbrxZ1fc0L8cd6w1GLyZMEwjXpRM6eLGnhGC934zLJjZwdu
         O7Il21o2Vnx/9JCx6wnIUz9nOAw9yL6Jv1kKxc2hSJ5wEoCWxUTl1PXbSgTAxKAUE3p+
         kMyfNUZIqH7hxb1JebLznoNfY8hkUVe+KS9GDNK7elcFDaebiNqw1ZtkRU99bqDApLM7
         Fv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=8ZZdwg9lcy0z91UPab3v9CZJ0b9BOj9iK1CKQUx/A14=;
        b=rqvNuc2Ni5878sX+sp18BBYUGFriI27fKON++bj3E42Ql3wysfS8lnCbZN82+jb5/t
         oWwDz52GZ0XrQ+YfwcAHOatR4aviYRkYQ5TrapUTEan1XoFs6A8xwWDvahVkBYgEJL4H
         ILGRkJ5f1UislisJ1OrORZaP7ODGiKPG0brlp3SdosUun08RRmPFcwQluxccSWiztf1E
         D4a0/1AwfVEnqAG51bnnyLTqGWsTAGZgMCJ1Oc6vLehlXggMVmCtiLk5lJXgPbWowxMv
         4nqJYH2jyyrFRDgmOwINkIdyFOgb0ClvDHyM0hlzGDEVAfctoYJqVkdfeVUETczCJtx3
         2DJA==
X-Gm-Message-State: ABuFfoh2YSh1DgsQwAx/lZpto7KI9gYfKJh7y39E6IWQdfynf/lykyy6
        GgQR56inGRbh1HKNP7KImBo=
X-Google-Smtp-Source: ACcGV61QGkIkrOKG6h+A8vpL12hB7nyuzZc0aqgBPPeeXFFDdEoUQPP5F7pH0AwdLQl9Yqj3KtATpw==
X-Received: by 2002:a37:8305:: with SMTP id f5-v6mr45679646qkd.230.1540257068671;
        Mon, 22 Oct 2018 18:11:08 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id c36-v6sm37310693qta.56.2018.10.22.18.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 18:11:07 -0700 (PDT)
Date:   Mon, 22 Oct 2018 22:11:01 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] Adds -Wshadow on KBUILD_HOSTCFLAGS
Message-ID: <20181023011101.GA6588@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds -Wshadow on KBUILD_HOSTCFLAGS to show shadow warnings
on tools built for HOST.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e8b599b4dcde..3edae5d359b5 100644
--- a/Makefile
+++ b/Makefile
@@ -360,7 +360,7 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
 HOSTCC       = gcc
 HOSTCXX      = g++
-KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
+KBUILD_HOSTCFLAGS   := -Wall -Wshadow -Wmissing-prototypes -Wstrict-prototypes -O2 \
 		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS) \
 		$(HOSTCFLAGS)
 KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
-- 
2.19.1

