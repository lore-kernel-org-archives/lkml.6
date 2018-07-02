Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA5AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE0C2124D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlBoBw5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE0C2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933423AbeGBJ1g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:27:36 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33165 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeGBJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:27:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id k7-v6so11277136wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTi8UeNVbU/dn7KsDmydJUHAIRnifNvp0yct7YRuGeA=;
        b=vlBoBw5X2mSOHvvpkLk068FsyRDS+HesyOLNOfHqsnkfLZc63IXuuVFTdUJUSqh0hC
         2vmRFRRdxqNN/97Se1w0JuJTBAVqTpXnMvQTCgvB8ZB8h4OYFNwS1Fxynl5HPMOg/XBY
         MNPR4JCTbVBPMVjuKplXt8fMycN/mGke68HV2gO7Nl/aYawN+7erpr1FWolMztDhTPaF
         8Cyz1iKh52hFPDqoWdzvku3UzqUQLjXWCiNcMNOUW0KmuSJgLVajJhrq5i+LBycCpBGD
         3dE9g3UmY6CLrRE8XJIkWGm3SnhEsbmkDO9X1iAoQWs7jDD9QwCcMsodYPEpuXVnQB60
         Fn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTi8UeNVbU/dn7KsDmydJUHAIRnifNvp0yct7YRuGeA=;
        b=kdpOSyx+dyfC6pawC/SYUe0l65UNKoW4Hp3naVaWM6nZT1idu0VpFMwNw9SpgHGEc0
         2h/CzvX0HZwfI2hIdDG7GytPbXWyns0kgVwgbCScUVBoPJd1weqqVTKJ1Y94DQUS7gk9
         bybdzWOc5n9R3ssbZWKWrRIJxnU7E/JK+hsR2to5E/imzeFBo3C9xdRprRx7bJCmuyp8
         5priHPvRVbdq4VKRR1N7ziFJB7FaAkmaCTYp8+HlfkDuk88oJfpeYtj+utzyVX7jAxQX
         f0k2xRNG0DPn2q7DbC437PhWYBDCdHd+TZI8F2KtBYooFBmfv8tlGZxj5yJSuKxiKjcy
         z9EQ==
X-Gm-Message-State: APt69E1xirK1eslHj4j1ziEYNz8OZmbv0COrTVWImGy9foKimKSgDOfB
        cyq/YzwlM0haObhkCTcr2qdLFmDOgNiu4C3L8amwndcp
X-Google-Smtp-Source: AAOMgpcCERk5sKnifqtEhWUkUJRhUXJaAdLm4sA5/JdYzaWljVujnm3VyDAsxywPgHSK1ru93zKDtrgcAU5Sz9hZlrU=
X-Received: by 2002:adf:a094:: with SMTP id m20-v6mr1562164wrm.125.1530523652522;
 Mon, 02 Jul 2018 02:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <201807021228.PZ5wzCyl%fengguang.wu@intel.com>
In-Reply-To: <201807021228.PZ5wzCyl%fengguang.wu@intel.com>
From:   Martijn Coenen <maco@google.com>
Date:   Mon, 2 Jul 2018 11:27:20 +0200
Message-ID: <CA+_MTtzgL2pNY3nu6xTAKWdSYKWHEyWXM6PSA8iFMK-Pub2z1w@mail.gmail.com>
Subject: Re: drivers/android/.tmp_gl_binder.o:undefined reference to `__user_bad'
To:     monstr@monstr.eu
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

See below - this error was introduced because the binder driver uses a
64-bit get_user(), even on a 32-bit architecture. Would it be possible
to implement a 64-bit get_user() for microblaze?

Thanks,
Martijn

On Mon, Jul 2, 2018 at 6:53 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Martijn,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   021c91791a5e7e85c567452f1be3e4c2c6cb6063
> commit: 1190b4e38f97023154e6b3bef61b251aa5f970d0 ANDROID: binder: remove 32-bit binder interface.
> date:   7 weeks ago
> config: microblaze-allmodconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 1190b4e38f97023154e6b3bef61b251aa5f970d0
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=microblaze
>
> All errors (new ones prefixed by >>):
>
>    drivers/android/binder.o: In function `binder_thread_write':
> >> drivers/android/.tmp_gl_binder.o:(.text+0xcbb0): undefined reference to `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xcbdc): undefined reference to `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xcfc4): undefined reference to `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xd650): undefined reference to `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xdbc8): undefined reference to `__user_bad'
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
