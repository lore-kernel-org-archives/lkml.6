Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02408C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 00:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBBB2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 00:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PItRim+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeLaATw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 19:19:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38016 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLaATw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 19:19:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so17589552lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 16:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwyBMO7upIM00OVScCxbSDpYDpTCZ0N9RM6ZpHJs+Fc=;
        b=PItRim+M51Dbm1rzwUucCI1c6+0JMaWiq28CerFnB7qKk19IEp3EK3rzVDWSYlzSZh
         X1G0trpvpYV1y8QhjVJ6h9mD6zWCEoM7zkT4mgi8gE0jkLrYJPncsST092LYD5dmM6tN
         3wSWiYD4kAatgjkUZFY0AxegE+rln+RYqJO1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwyBMO7upIM00OVScCxbSDpYDpTCZ0N9RM6ZpHJs+Fc=;
        b=WDhqVWc1+SbJFIyKM432z0roJrPDBSZ/DDHFOB0tq20MU9xFeIV+XiL0+3eGpR24IM
         dShduSDR0RoI5nRA8e/EVRTs7jds1jOjC7qGf+AKPyYA9N+4LwiTaa22YVkjSDseSbut
         y5X2DNPs8b5id7bU/OdpBMhSe1hhjR7hfihYRENYxjeKqFyAUb95xPcYS2n9/i1ga/Jg
         0jCIzorJX9SVtZ1uBcoOropYqg4x0kRHJP7SliP2TpFetroZHUBP+XLrnQNV8/fSs/eL
         sadTz20uGpU4W3zfK38qqDTALlw/Ynl2OHeOuqSh3FNcp5l8D57RIxWIPVtrsEbr0zPG
         g8lw==
X-Gm-Message-State: AA+aEWagBnQhPGuacgQBc6w29Y9OAjRkLd4QzidsWKkVodz0j9q2Eigg
        1qwyXlg/waiMmrN+Bkki8lEHmBychbI=
X-Google-Smtp-Source: AFSGD/Unp6N1mkhF8WR0RqVX7k572+OViNDdgyv9VnAtmKNGtkpeniAHydyvGhLXqgOzcqC2Y6qvbg==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr18728971lfi.19.1546215589625;
        Sun, 30 Dec 2018 16:19:49 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id j25-v6sm9791903lji.77.2018.12.30.16.19.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 16:19:48 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id n18so17598208lfh.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 16:19:48 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr16921519lfa.106.1546215587860;
 Sun, 30 Dec 2018 16:19:47 -0800 (PST)
MIME-Version: 1.0
References: <s5hk1k48ayx.wl-tiwai@suse.de> <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
 <20181228124303.GA16558@gmail.com> <s5hmuoplgw2.wl-tiwai@suse.de>
 <CAHk-=wjXVPpDWHzvNL=9gGVGNnYg1jOH8hQx=dq4caEzip-n0g@mail.gmail.com>
 <s5hef9zl69r.wl-tiwai@suse.de> <82bb7f60-c3c2-4715-a0a0-f1f2a8b14c74@linux.intel.com>
In-Reply-To: <82bb7f60-c3c2-4715-a0a0-f1f2a8b14c74@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Dec 2018 16:19:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgDKUQthwqe_RYm1=uJBKLvGQO9-90BNkO6rE-Ck7hVwQ@mail.gmail.com>
Message-ID: <CAHk-=wgDKUQthwqe_RYm1=uJBKLvGQO9-90BNkO6rE-Ck7hVwQ@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.21
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 3:18 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> The KabyLake Dell XPS13 was initially used for the ASoC driver for
> HDaudio, so there is no known hardware-related reason why this problem
> happens.

Mine isn't the Kabylake one, it's the older XPS13 9350 (2015 - Skylake) one.

> The simplest way to make the problem go away is to force the legacy
> driver to bind with the (untested) diff below.

That diff is wrong, since it changes the meaning of the binding
numbers, but then the module interface is wrong:

   static int skl_pci_binding;
   module_param_named(pci_binding, skl_pci_binding, int, 0444);
   MODULE_PARM_DESC(pci_binding, "PCI binding (0=auto, 1=only legacy,
2=only asoc");

so I think Takashi's patch to just change the default value of
skl_pci_binding is the better one.

                Linus
