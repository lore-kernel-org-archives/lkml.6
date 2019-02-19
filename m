Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077A7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4792146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1qhDgOpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfBSOw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:52:59 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:20592 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfBSOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:52:58 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1JEqhZ9017330;
        Tue, 19 Feb 2019 23:52:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1JEqhZ9017330
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550587964;
        bh=xP30D4YxpnNFln5iqsfA1eAddOgWKaKFsgsedHPcz9M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1qhDgOpTyn69L2g1Ro+pQSkMmsPzFCRG7uaBk1mWFzEr4ZidcQKSWF8jRowByicy/
         NKMRiiOEdtJ5rC1QHeM7WqIJXEOoP7skHWr45DGXbpF9XTR/jKnfkS10fQFC8clhha
         pKxZzkB4obSv6VaxGLbgnHzFwg9lNyx+JSglsfCMDSt9tAAyzAZhArXhI60UsxHSN8
         TnPwDQ7hx9LqvEE6ft2AON0skX8Tshzxom5lu3FisQRMC+BZR7GKh3rk1hloDAg4OP
         URtdnQIfrYz8znK0sGt50m11wf4QY3GYrU232LnqB0JRbavDUuWt1HvUyAPUBh8Flf
         l6IwYYBvqOczQ==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id v187so2927408vkf.12;
        Tue, 19 Feb 2019 06:52:44 -0800 (PST)
X-Gm-Message-State: AHQUAuaxSZMLbnYZSrBA+ne0U5reFhJaWAQOQGh1ST8zO1EFmWbjuyns
        h019Ytphdr3/8FWIxchuZwkeS/1KKQp9vIXXSf4=
X-Google-Smtp-Source: AHgI3IZnYlcITOpiP77cwnonCea10bX+5r29wWWlg9//UjqKNpvtBGBnJ/7cWCnfZzZyA+2CHz9HCzw+AQfy5A0d0hc=
X-Received: by 2002:a1f:b754:: with SMTP id h81mr7494206vkf.64.1550587963041;
 Tue, 19 Feb 2019 06:52:43 -0800 (PST)
MIME-Version: 1.0
References: <1547799412-20120-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNATiQFTwyZsy-Hw1e8S=HBzT_tzjEkBwivQD+o=Cga1Yhw@mail.gmail.com>
In-Reply-To: <CAK7LNATiQFTwyZsy-Hw1e8S=HBzT_tzjEkBwivQD+o=Cga1Yhw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 19 Feb 2019 23:52:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATcp8isvRG2M83_egBf9vocLoefFRJTSc4tyaV8SVK+Mg@mail.gmail.com>
Message-ID: <CAK7LNATcp8isvRG2M83_egBf9vocLoefFRJTSc4tyaV8SVK+Mg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: descend to scripts/kconfig/ directly when
 syncconfig is needed
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 1:25 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Jan 18, 2019 at 5:17 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > The recursion of the top Makefile is inefficient.
> > Just descend to scripts/kconfig/.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
>
> Applied to linux-kbuild.


I dropped this patch from my tree
because it has a drawback.


When I run 'make' in a pristine source tree,
I see a strange 'scripts/basic/fixdep: not found' error message.


$ make mrproper; make
  HOSTCC  scripts/kconfig/conf.o
/bin/sh: 1: scripts/basic/fixdep: not found
make[1]: *** [scripts/Makefile.host;109: scripts/kconfig/conf.o] Error 127
make[1]: *** Deleting file 'scripts/kconfig/conf.o'
Makefile:594: include/config/auto.conf: No such file or directory
make: *** [Makefile;634: include/config/auto.conf] Error 2







-- 
Best Regards
Masahiro Yamada
