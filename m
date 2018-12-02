Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE57C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 14:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2DF20881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 14:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2DF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbeLBOf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 09:35:59 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40067 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeLBOf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 09:35:59 -0500
Received: by mail-vs1-f65.google.com with SMTP id z3so6009248vsf.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 06:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efe/ihQjNKCVCXdV181LMVrwQRSc5VmP3rmoepq8e3g=;
        b=hsKk7VS343YNhy94eHl5qfxB6pb+XPn8seS6XrlWNTj+RV8mciCnDAz+GX1vNMFHQc
         sLB0OZYuFAWfLK5+gCGs6TdV8+AmOhlTZweN0vgRolX1wda8WqMEtaSBvUBtHA0HKcUq
         SsIjAk4rTIUE1MGAsvupME9mzdLdIN0qecN2rpUaenzDk7yVYZ7zRWqeE8iynA9txoVj
         +r308Rs7as6WtF+jzsup98+WzLrphYcqT2ax7p6okfw1qcK4TckeSTl+mZP/wTx3M9YR
         YxGwx2gs+bEsIC+c7VVUo7Mavjf5Ab1rGeqgCojl2GblSs/GkVa5Uk1EgwAq9W6ez04j
         1dMg==
X-Gm-Message-State: AA+aEWZ/dhnFtIyxNbbbQI8LYLXBtfXw178F7RYfQbGvncbhyiZPheqV
        SuapEDbjVubWRGx3KUP4x8I30QsAmzWv71hdFG7OxbTW
X-Google-Smtp-Source: AFSGD/VfX9Usnj2szjJbN8tkULMu4Z1seqGYz8ua/k6+J49CtdinsPKa7oRvaP4nrkEYdw7f3UGYZsqlkUJ9fOSn7F8=
X-Received: by 2002:a67:f43:: with SMTP id 64mr5529388vsp.166.1543761354938;
 Sun, 02 Dec 2018 06:35:54 -0800 (PST)
MIME-Version: 1.0
References: <201812022249.YKYfTJ9F%fengguang.wu@intel.com>
In-Reply-To: <201812022249.YKYfTJ9F%fengguang.wu@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Dec 2018 15:35:43 +0100
Message-ID: <CAMuHMdWtZCAE5TX-hpz-c5WGfjJwy9b=_+c1Av8Y15ZFuq4T-w@mail.gmail.com>
Subject: Re: ERROR: "__udivdi3" [drivers/md/dm-thin-pool.ko] undefined!
To:     kbuild test robot <lkp@intel.com>
Cc:     Joe Thornber <ejt@redhat.com>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 3:06 PM kbuild test robot <lkp@intel.com> wrote:
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4b78317679c4f3782a3cff0ddb269c1fcfde7621
> commit: 3ab91828166895600efd9cdc3a0eb32001f7204a dm thin metadata: try to avoid ever aborting transactions
> date:   3 months ago
> config: i386-randconfig-j0-12020939 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         git checkout 3ab91828166895600efd9cdc3a0eb32001f7204a
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
> >> ERROR: "__udivdi3" [drivers/md/dm-thin-pool.ko] undefined!

Wasn't that fixed in v4.19-rc7 by commit 013ad043906b2bef ("dm thin
metadata: fix __udivdi3 undefined on 32-bit")?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
