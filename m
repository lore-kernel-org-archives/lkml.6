Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4982C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 01:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EFD222E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550368206;
	bh=+Ueeik+8CATK7Ei8R+bLJuZn3VqO/ATnnbE06bfkXw8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AEP7J6Vds1NDF+x41rjuKmZ3ZGbED3a7AVgsj2NUpKZya6MS1+Hl6H3xrXPbLS9Oe
	 1eRHH1eWGWp0asNa68ezyOBHJuyGLxsriANfwgnYghG3esQDqkS0L5WkapoYzLzIdd
	 Bq0PSAp/2i2iOFUS8wiS4pnvenIyW6tDrvD+O49E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbfBQBuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 20:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfBQBuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 20:50:03 -0500
Subject: Re: [GIT PULL] Compiler Attributes for v5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550368203;
        bh=+Ueeik+8CATK7Ei8R+bLJuZn3VqO/ATnnbE06bfkXw8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BbOeVt8kznQxRKvEIzxrMnDLJHwWvW3rb5K0niHSf6QtZJ+B78cyPDk9d3r9U6oTx
         B7WANw3D5kEEGHtzqvoxY9mNE5PFKmn+IX5ZRHhYwqdFl+ClEIsUIpqGOQPwWnoaZ7
         zU7StHf9r/cqOhpyv65ZrydNW5ToANofv1TL5pZQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190215191059.GA24082@gmail.com>
References: <20190215191059.GA24082@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190215191059.GA24082@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/compiler-attributes-for-linus-v5.0-rc7
X-PR-Tracked-Commit-Id: a6e60d84989fa0e91db7f236eda40453b0e44afa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b999ae3614d09d97a1575936bcee884f912b10e
Message-Id: <155036820339.25738.13527526913697209660.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Feb 2019 01:50:03 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Feb 2019 20:10:59 +0100:

> https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b999ae3614d09d97a1575936bcee884f912b10e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
