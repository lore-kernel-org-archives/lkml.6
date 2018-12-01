Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0725C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D1E20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D1E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeLATcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 14:32:15 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41655 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLATcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 14:32:14 -0500
Received: by mail-vs1-f66.google.com with SMTP id t17so4760793vsc.8;
        Sat, 01 Dec 2018 00:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKwPKY2Nn2V9o3Dm8YrIjf++Rb2aQ9kh9XZ3bs8WO9Q=;
        b=gSslPxSpCUJTqHu89wx+R5ylJXSTSfrjw5rIwSe8WBPbwaOPwqdCLme834JVTnmIGI
         xg9G+V8tFhJLo2lLWj8ou8IlESoFGp1ExI5Hk6doj+Nin/9r5BNjefkFt0ok8pOvg2SW
         0l36s11yXWxOkalc6SIXzO2ufV7cRsqVpFjT2h0y/m7pEPOiE6qAtcalfFtC2aOSRuCQ
         +hGIgsI2KZwg2KUDJoXBIXrzyyjQbJVsUFlsesXaVt9V+s8u7qDTZ35K8X+S0ZcGZUS+
         zo5Cy3flszv5S8AdNfY0rfnYOIL5oNQf1Uus6sV+XXP3DljzRZ82Xy/o7eL0u/eYM7rH
         0i+g==
X-Gm-Message-State: AA+aEWa+8RB6nRwj/nN4ESZL8fkSdg3xrrTiDQ/Pzk0bAOTXkz3FH1y5
        wyJXtIVWSqqOzn/DHL4y22V/Kmx6JG16Pu52BdQ=
X-Google-Smtp-Source: AFSGD/X0lcYZrcdyoxG0TEhAF1cadTurTtwwlncyjgLp+r1oFuq81GNgdAlr6qMIKq05TYbAeShDY0HGVMkkKmurI/c=
X-Received: by 2002:a67:f43:: with SMTP id 64mr3904280vsp.166.1543652415886;
 Sat, 01 Dec 2018 00:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <CAGXu5j+jBNBsD3pvUSfEh6Lc5T1YMpbM0HeG1c6BHiJe+cKVOQ@mail.gmail.com>
 <20181130195652.7syqys76646kpaph@linux-r8p5> <20181130205521.GA21006@linux.intel.com>
 <1543611662.3031.20.camel@HansenPartnership.com> <20181130214405.GG23772@linux.intel.com>
 <1543615069.3031.27.camel@HansenPartnership.com> <20181130221219.GA25537@linux.intel.com>
 <20181130151459.3ca2f5c8@lwn.net>
In-Reply-To: <20181130151459.3ca2f5c8@lwn.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 1 Dec 2018 09:20:03 +0100
Message-ID: <CAMuHMdUkpLWm5NZmYj=uMgVncw6ZOb7j9KxFoDGhrnr7vzpx_w@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amir73il@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Axtens <dja@axtens.net>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Eric Dumazet <edumazet@google.com>, federico.vaga@vaga.pv.it,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Helge Deller <deller@gmx.de>, Joshua Kinard <kumba@gentoo.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev <netdev@vger.kernel.org>, nouveau@lists.freedesktop.org,
        pabeni@redhat.com, Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rob Herring <robh@kernel.org>,
        sean.wang@mediatek.com,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        shannon.nelson@oracle.com, Stefano Brivio <sbrivio@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Tobin C. Harding" <me@tobin.cc>, makita.toshiaki@lab.ntt.co.jp,
        Willem de Bruijn <willemb@google.com>, yhs@fb.com,
        yanjun.zhu@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Fri, Nov 30, 2018 at 11:15 PM Jonathan Corbet <corbet@lwn.net> wrote:
> On Fri, 30 Nov 2018 14:12:19 -0800
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
>
> > As a maintainer myself (and based on somewhat disturbed feedback from
> > other maintainers) I can only make the conclusion that nobody knows what
> > the responsibility part here means.
> >
> > I would interpret, if I read it like at lawyer at least, that even for
> > existing code you would need to do the changes postmorterm.
> >
> > Is this wrong interpretation?  Should I conclude that I made a mistake
> > by reading the CoC and trying to understand what it *actually* says?
> > After this discussion, I can say that I understand it less than before.
>
> Have you read Documentation/process/code-of-conduct-interpretation.rst?
> As has been pointed out, it contains a clear answer to how things should
> be interpreted here.

Indeed:

| Contributions submitted for the kernel should use appropriate language.
| Content that already exists predating the Code of Conduct will not be
| addressed now as a violation.

However:

| Inappropriate language can be seen as a
| bug, though; such bugs will be fixed more quickly if any interested
| parties submit patches to that effect.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
