Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09918C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDADE20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wRz7gkXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfARCvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:51:08 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:43603 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfARCvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:51:07 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x0I2oeYm003630;
        Fri, 18 Jan 2019 11:50:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x0I2oeYm003630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547779842;
        bh=1yQKC2/NLxoALDEYQCVUGmittS8HAoFkA3tzO41eZ+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wRz7gkXblDEake5qNuvdooNwZjrlCvspnPv0ObVx/iQj9QcyowIQtPAR0xmcAXfH1
         TAGqh3p68yDXvTF8kyL7zay/m7+6asSZ37mRcuP1IjCa9hNoDiJNTLAlygONvXDlNo
         oCWfN2L4olOTHPsVPSc1o+sWhB8W+qWRTXaoEpo/0pUCNO7tYqus3KXm/xSjvc3+6+
         PayXwaTEI0eYauUN9us6AdxxuMgQ5CNpHG2VQm76M9G/I1sVn6mPaqMRgUDibvOiem
         3mBNk197Wxyf6lBIM2I4gKQ6kogPxTM1SGI80c87f9uIjdv9UrwoGPa4C1pMyuMip+
         sRhOhwaJ5/O/A==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id t17so7563386vsc.8;
        Thu, 17 Jan 2019 18:50:41 -0800 (PST)
X-Gm-Message-State: AJcUukeIsLysQjkzKfDzefnaG9iglMbStz/rvl07qMt+AZc7FvtGeiYi
        YSfHEnlesZot4++j46Z1ZazMMpEtf+ck6llJDgg=
X-Google-Smtp-Source: ALg8bN41c2mw6CErAw0XXhGvoTvCytzaHn7YT6XQlOW2YEr1Umc0fAJ2j01AFMEzCnP4FutT7gPYsien25DGh4gFg7U=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr6972963vsb.155.1547779840012;
 Thu, 17 Jan 2019 18:50:40 -0800 (PST)
MIME-Version: 1.0
References: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 18 Jan 2019 11:50:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkYYaZ68dmYACfadp+sPVbxWJ3r2KdX-7wJdzaCsKD+A@mail.gmail.com>
Message-ID: <CAK7LNATkYYaZ68dmYACfadp+sPVbxWJ3r2KdX-7wJdzaCsKD+A@mail.gmail.com>
Subject: Re: [PATCH 0/3] powerpc: some header search path cleanups
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,


On Fri, Jan 11, 2019 at 2:20 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I am trying to get rid of crappy magic from Kbuild core makefiles.
>
> Before that, I want to drop as many useless paths as possible.
> Actually, many Makefiles are adding around pointless options.
>
> This series cleans some powerpc Makefiles.
> (only compile-tested by 0day bot)


Could you apply this series to ppc tree if you are fine with it?





> Masahiro Yamada (3):
>   KVM: powerpc: remove -I. header search paths
>   powerpc: remove redundant header search path additions
>   powerpc: math-emu: remove unneeded header search paths
>
>  arch/powerpc/Makefile          | 4 ++--
>  arch/powerpc/kvm/Makefile      | 5 -----
>  arch/powerpc/math-emu/Makefile | 2 +-
>  3 files changed, 3 insertions(+), 8 deletions(-)
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
