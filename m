Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB287C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E2220855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KhzJX/iC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfARKmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:42:38 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:47677 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfARKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:42:37 -0500
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x0IAgFGt003979;
        Fri, 18 Jan 2019 19:42:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x0IAgFGt003979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547808136;
        bh=xjSDPRxQGZLfTBJrPX4o/SgdC05g07pN/CaTV31cUjI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KhzJX/iCu6ZCLuU3gJJR3+Ry6bwG/mWRomjxjKu7yEsDevxizjbSrE69k/As1V944
         Rh/MngAbQi+jChoINwRozOCNE2SCbIW8BHOVHMOiPxEpIh2f514HgY1DVjR+O9hmGL
         77DwSdFbGKHxctqbUJmCxKUgdsMOwOTN2Uhn+BAJVC53IeuOIUmQHjblq4JkXcE4Ol
         MV3OEq0bvj/rY8ZfaUSDrBSEQ0FsI5RIlcupM3gEuivlE3YpjfBnuIuGZusuUp/w4d
         GK8XN9F3p7OqxwV6l+pydykLA5cp+CEZPh3Imw3/1ntmos4+JZqA+qPs5lHIhKc1Tr
         QDiTEO4ptTyAQ==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id d21so4515501uap.9;
        Fri, 18 Jan 2019 02:42:16 -0800 (PST)
X-Gm-Message-State: AJcUukfZoyXteE6b+HDdp7sarfmhdI6Qsx9ObhIFn60GsyAAtrq8cUd2
        3Y5lktlf9nlC+0OJZJSIIR4X//v/WygIZfikq+k=
X-Google-Smtp-Source: ALg8bN6zhpGzzCVbyydBGiBWiypHH1RdGWUOZy02YmAi6Ubq3Ww6avHifboNt5b0GljM3z0iOVdw5q345XFzRmLv0LA=
X-Received: by 2002:ab0:849:: with SMTP id b9mr7256515uaf.93.1547808135497;
 Fri, 18 Jan 2019 02:42:15 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNATyx5DtopKfkS4ge=6F7e16qjvOr_1XOTvCZqaZKnPwxQ@mail.gmail.com>
In-Reply-To: <CAK7LNATyx5DtopKfkS4ge=6F7e16qjvOr_1XOTvCZqaZKnPwxQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 18 Jan 2019 19:41:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBzc+vM4v2ESF5LkDoAi4MzB6WVmMnVGnjKdM2PTqDMg@mail.gmail.com>
Message-ID: <CAK7LNARBzc+vM4v2ESF5LkDoAi4MzB6WVmMnVGnjKdM2PTqDMg@mail.gmail.com>
Subject: Re: [Question] What is the license of scripts/basic/fixdep.c ?
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kai Germaschewski <kai.germaschewski@gmx.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:58 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi.
>
>
> The comment block of scripts/basic/fixdep.c says as follows:
>
>
>  * Author       Kai Germaschewski
>  * Copyright    2002 by Kai Germaschewski  <kai.germaschewski@gmx.de>
>  *
>  * This software may be used and distributed according to the terms
>  * of the GNU General Public License, incorporated herein by reference.
>
>
>
> It does not explicitly mention the version of GPL.
>
> In this case, I think the corresponding SPDX tag
> is GPL-1.0+ instead of GPL-2.0
>
> Is this correct?
>
>
>
> There could be another problem regarding of this.
>
>
>
> Commit 9f7ef9854e80 copied scripts/basic/fixdep.c
> to tools/build/fixdep.c, but it ripped off its license term.
>
> Later, it was tagged as GPL-2.0 by b24413180
>
> See 'git show  b24413180 -- tools/build/fixdep.c'
>
>
> Maybe tools/build/fixdep.c should be corrected to GPL-1.0+ ?


I am not an expert of software license, but
a little more thought about this
if scripts/basic/fixdep.c is GPL-1.0+,



Probably, either of the following is correct.


Must tools/build/fixdep.c inherit GPL-1.0+
from script/basic/fixdep.c ?

 or

Can you choose the license (any in GPL-1.0, GPL-2.0, GPL-3.0,
GPL-1.0+, GPL-2.0+)
for tools/build/fixdep.c at your opinion?
(In this case, Jiri Olsa, the author of commit 9f7ef9854e800)



If the latter is correct, we do not need to fix tools/build/fixdep.c


-- 
Best Regards
Masahiro Yamada
