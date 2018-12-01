Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B198C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 03:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93E420867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 03:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lroTmmu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93E420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeLAOqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:46:25 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:47425 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLAOqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 09:46:24 -0500
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wB13YcAF007080
        for <linux-kernel@vger.kernel.org>; Sat, 1 Dec 2018 12:34:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wB13YcAF007080
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543635279;
        bh=FY8fXA8CF4jB6GdPRb1yLOKDnQGiI8/Hhk9WS2m2CmQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lroTmmu31deRNWfnjypfhZx4++afORQHkj9ARcixA45PP3zCfZNKgK2/fr9trZJlF
         ckMNV18yiL339dNPk1Hde3/ABXwhg6RoRvRCM5LkjDxztY0Apt2a7A2qidYHuMZY1L
         JQaoJBPdONqBpPqHoKvyGqdWMYX7zN4+FGEaKk+zh8XI7ZBFeHxc8Cvz617jDnWyUR
         hdXUpDB3FwFOMI+c/sVyZknAUxuOx/V89m3sGhDRuYR9QXRn5DYHXsiIFP/Y6mCl/E
         6dRg6GfyNPWc5xGN6CmvpIOLOQeIAott9LTa2Eas1HDH8Or6dp4TX9eP1onI7xn/LN
         rp8C1R0251E7g==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id o130so1753215vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 19:34:38 -0800 (PST)
X-Gm-Message-State: AA+aEWbRy/TMhnA0qM0mLGBVQeeoMj4Sim9DC6jiVKRkIS+wLdzVydr0
        16fbDG27aG5yDxUnzDcpiTa71zR4Q2qPqWIwsjs=
X-Google-Smtp-Source: AFSGD/VV4U+M6JsMovb1LAlCb+p390/AHD2G6HLFdWT6zx+mVlMBotY4PXYpAwfA+6dg7txzuMjR0VRl1omG3i7ns8A=
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr3500130vki.84.1543635277420;
 Fri, 30 Nov 2018 19:34:37 -0800 (PST)
MIME-Version: 1.0
References: <1542856462-18836-1-git-send-email-yamada.masahiro@socionext.com>
 <20181122143201.d7vifhlny7gmrhzd@ltop.local> <CANiq72miapoMHiXsq-gSu5+dhpGDE6Dnf3c_6DpHRkwNiPPU6g@mail.gmail.com>
In-Reply-To: <CANiq72miapoMHiXsq-gSu5+dhpGDE6Dnf3c_6DpHRkwNiPPU6g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 1 Dec 2018 12:34:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZLHaaFNjuFEteY59ybAHTKp3ciwOMgacTXr+Sagk-DQ@mail.gmail.com>
Message-ID: <CAK7LNARZLHaaFNjuFEteY59ybAHTKp3ciwOMgacTXr+Sagk-DQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kernel.h: disable type-checks in container_of()
 for Sparse
To:     Andrew Morton <akpm@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Crt Mori <cmo@melexis.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,


On Sat, Nov 24, 2018 at 6:06 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Nov 23, 2018 at 10:14 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > On Thu, Nov 22, 2018 at 12:14:20PM +0900, Masahiro Yamada wrote:
> > > When I tried to enable BUILD_BUG_ON for Sparse, the kbuild test robot
> > > reported lots of "unknown expression" warnings from container_of(),
> > > which seemed false positive.
> > >
> > > I addressed this in [1], but fixing Sparse is the right thing to do.
> > >
> > > The issue was fixed by Sparse commit 0eb8175d3e9c ("fix expansion of
> > > function designator"), but it will take time until the fixed version
> > > of Sparse is widely available.
> > >
> > > Disable the container_of() type checks for Sparse for now.
> >
> > I would prefer that developers upgrade their version of sparse but ...
> >
> > Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>
> Indeed. If someone is writing code for the latest kernels, I think it
> is reasonable to assume they are able to use the latest sparse too,
> since it is not required for compilation anyway.



I was reconsidering about this.

I saw other Sparse warnings anyway
unless I use the state-of-the-art version of Sparse.


So, now I think Luc and Miguel were right.


Requiring the latest Sparse is the right solution.
We do not need to take care of old Sparse.


Andrew,
Could you drop this patch please?


-- 
Best Regards
Masahiro Yamada
