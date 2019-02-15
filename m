Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B715C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140022192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex3frOk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732821AbfBOTLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:11:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40446 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBOTLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:11:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15so2558339wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hRDcLrUuOTqhOZr37htjBDSKJ0KM/4qYtesCfk9S0Gg=;
        b=ex3frOk+LWyLoedLdVjtHIwqWE5NWHkhHFyam5L3kjrbNtWHZu9np3eE9J5PWVWIxx
         tShPzhXXpCRd6ishVQ0CjYLSFQfCK0tzzXv6xIPBeBmOm4isOosZnzYGKqUb/aYoJ0iT
         7CL2MZRZ7ttMli60DxurHd4qZtjBCBG5KpTbA3R9x82P4nXXCUXAGsw2Zfa8PyiOFUwF
         KF27qmpk5cvR6pUKLEaKuawEDk1Ry0X2QSXy/6D/eV94syHXBrHEy1xazdjNRBkbbemt
         Jf8wjGD1jS3D3KYcdtinlO6z1Ba8TenmMmU5Thhob0aMDbttX3iLUksH9Br2vSXBx+e3
         ooWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hRDcLrUuOTqhOZr37htjBDSKJ0KM/4qYtesCfk9S0Gg=;
        b=GoyrKc1LFJMwC6fl30B+xvq5I9aD+Lpo3L4BM1JOrbKi+69YGUv1Gam2DSHhDe0Uxv
         NC0PVu3/l9reCvBPb1TOUEZ5aQpmBB6khHfTnoPsWDFkBkweqJHtWOU7tM18w0+EpJBv
         4Zu/mSelLI3L1/5tXsQo8OEDgWX7J7FruZUMB8eTa51zpDKgyAJ9d2ku+jVTehy1MOmv
         E93mze9/mFqFx6+YZIhSjdA62023mJ1rpID6k0+qayipE9tKBlTBtee4qjf3u1TSNAFk
         mVXv00JxGBQADn7pRufLuz1W5nUhlIq9dMWZB9hxqm4A7ZQ2B72DUDt5PYQBNJeFoxZk
         eeDA==
X-Gm-Message-State: AHQUAua41ea758LsAljqo4AOt8ggszBhA39/HVWWHWgD/JwgtJ5nuIvu
        RSE8A7YHbGuiS6N98pHn31Q=
X-Google-Smtp-Source: AHgI3IbZ+JBg8Oi/px/7SViimPy0q/AnA8MGfAiQhBvrgmeWrEbh7thqQxIddu0cKVcR6uDLHGA57Q==
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr7205674wmu.29.1550257869709;
        Fri, 15 Feb 2019 11:11:09 -0800 (PST)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id b197sm13814101wmd.23.2019.02.15.11.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 11:11:08 -0800 (PST)
Date:   Fri, 15 Feb 2019 20:10:59 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <james.morris@microsoft.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Borislav Petkov <bp@suse.de>, Matt Mullins <mmullins@fb.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        WANG Chao <chao.wang@ucloud.cn>
Subject: [GIT PULL] Compiler Attributes for v5.0-rc7
Message-ID: <20190215191059.GA24082@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these changes to clean up the new GCC 9 warnings coming from
-Wmissing-attributes. With this, we can avoid disabling them.

The patches have been for quite in -next in several forms/shapes during
the iterations we did.

Cheers,
Miguel

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.0-rc7

for you to fetch changes up to a6e60d84989fa0e91db7f236eda40453b0e44afa:

  include/linux/module.h: copy __init/__exit attrs to init/cleanup_module (2019-02-15 19:52:56 +0100)

----------------------------------------------------------------
Compiler Attributes: Clean the new GCC 9 -Wmissing-attributes warnings

The upcoming GCC 9 release extends the -Wmissing-attributes warnings
(enabled by -Wall) to C and aliases: it warns when particular function
attributes are missing in the aliases but not in their target, e.g.:

    void __cold f(void) {}
    void __alias("f") g(void);

diagnoses:

    warning: 'g' specifies less restrictive attribute than
    its target 'f': 'cold' [-Wmissing-attributes]

These patch series clean these new warnings. Most of them are caused
by the module_init/exit macros.

Link: https://lore.kernel.org/lkml/20190125104353.2791-1-labbott@redhat.com/

----------------------------------------------------------------
Miguel Ojeda (3):
      lib/crc32.c: mark crc32_le_base/__crc32c_le_base aliases as __pure
      Compiler Attributes: add support for __copy (gcc >= 9)
      include/linux/module.h: copy __init/__exit attrs to init/cleanup_module

 include/linux/compiler_attributes.h | 14 ++++++++++++++
 include/linux/module.h              |  4 ++--
 lib/crc32.c                         |  4 ++--
 3 files changed, 18 insertions(+), 4 deletions(-)
