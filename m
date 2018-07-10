Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CEDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58575208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58575208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934205AbeGJPHk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:07:40 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:32940 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933710AbeGJPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:07:35 -0400
Received: by mail-vk0-f66.google.com with SMTP id y70-v6so10307555vkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1JfmLc6V94SlJvSFYwQ+AE3j7CGviePpeKik9/Q3e4=;
        b=qOnYZiXJAt+LJ/W+fmgw5uzv8D6yC2GuDWvUlukg7M+kYrMT5GVlzY5hCY14L00sAr
         IX4C1WhJqPbrQngTP8Txo6VOm3YWgXx3B9PuXkf5ptTXq0i7HeDkeCmn371DXXloqHBt
         byMMTq2iAhuM5Z12V5tJeoaWaEC6O4EgS+aux1kcuWanl0gQ4qwK3BrkOVGULNqzI3c6
         ezArKWkdDG2ckohQkRKbvjTNhmVzOuGAFXrnNHwc8D5gvVxKtN11oNMTGKk94Rbw+vNW
         CRLVaoHZJBteA4Y3qaE3HtFZQEusSWvXeuOV8LE/vcNbF2/v66h94LWCLiQmVvmT+Dan
         G18g==
X-Gm-Message-State: APt69E1hOU+ZgZcCSCzbI2lrvOfrSxtlZRjhHx2tZCz/lR5C7SKeMx9G
        tQzjQZE0n9QaON9kym/5cpHjQ8nlYmFvg8/BSFo=
X-Google-Smtp-Source: AAOMgpfk6wHuj1deuyY48MofIg4O0w2VYFjhgOUZh0JgQF0FlLPCGEkzPJcommnmOkHbiPODNcz4Kq6MQ8vQt+Wysfg=
X-Received: by 2002:a1f:4a03:: with SMTP id x3-v6mr14477679vka.90.1531235254949;
 Tue, 10 Jul 2018 08:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180710121014.31119-1-geert+renesas@glider.be> <e4e25250dbea658f25dcf10504f3147731b5d2e9.camel@perches.com>
In-Reply-To: <e4e25250dbea658f25dcf10504f3147731b5d2e9.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Jul 2018 17:07:23 +0200
Message-ID: <CAMuHMdV34P+2=-Myfzdv1-+4m2_cTHQcQO80fZ5Ai+G9J6X0kA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Require author Signed-off-by
To:     Joe Perches <joe@perches.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>, jgg@mellanox.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Jul 10, 2018 at 4:34 PM Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-07-10 at 14:10 +0200, Geert Uytterhoeven wrote:
> > Print an error if none of the Signed-off-by lines cover the patch
> > author.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -13,6 +13,7 @@ use POSIX;
> >  use File::Basename;
> >  use Cwd 'abs_path';
> >  use Term::ANSIColor qw(:constants);
> > +use MIME::Words 'decode_mimewords';
>
> Is this a typically installed perl module?
> If so, what perl version installed it by default?

I don't know. At least my Ubuntu 16.04LTS and 18.04LTS systems had it
installed.
It does not seem to be part of the core modules, cfr.
https://perldoc.perl.org/index-modules-M.html

I've tried using MIME::QuotedPrint instead, but then we need to parse
=?UTF-8?q? ourselves, as decode_qp() only transforms the actual
quoted printable bits in side the encoded From: address.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
