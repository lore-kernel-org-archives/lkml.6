Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862D1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566B9218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="kVUmo6PR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeLRScC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:32:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34255 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeLRScC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:32:02 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so8906920itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v96tVdiQwdCUtRJQzi2R8/Mn3AOx13ZcK5SGqbESer8=;
        b=kVUmo6PRyyOoZ4HBmPdMsgxTgqD2Id3rOggVDgr72mATD3PRHWQ5TFiF+YTBslebmy
         kO5GUD7yU4fOX98zeLc5mfkXPcppCnOq24IxmWfb0JbLCCs9gz3q5eJobUXqJPgtmuVl
         5vZftMIcZLpXv59AbtzSMD+guKkQ51GhNg6kw9GozDVjUho4DbLZJ7CNxHxKCToqdZoN
         IfsOOENaVP1HrWQ/luUrpDkLEteAa6S19SlVsppo+9fFFLSyC96H8m2dMWpc26EZwARm
         T3ylExhI2i+WosWKjRdITN+ooWQKtSm1V6s7pnY5RZ115Jh6h6sOLZlPLEeoBX9Tc7YM
         wHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v96tVdiQwdCUtRJQzi2R8/Mn3AOx13ZcK5SGqbESer8=;
        b=n8tPUbdc7KvsDnGOIZiXNSk2iI2LVwLYBYvZitwYTeoLzwVY8PHeCkzNWi36wTYp3s
         I/IW/5IC2K+X8C4+T32s7dNuc/OR4G6u00ud/S1ixPDb8sEaMSOttSzpERJDYMrBX467
         XmuAV/szBRLXAONb6/z9Iyf/7fDa+LrBLR+fgaGdaDFn2B74IYJrRQ4kuP+L1NfUrTqM
         yGACqvOJXQ2unvw2htgZi6Lv99uf7smu30xBLx3Krh7a2CmXuyHNe/jtY1XGA7D59FCm
         WSPMBF+nGMNGe6Kxuo7PZld0GxKAyRAodBTqF57kOs0cQQWo3GZqs24aDh/e68jpm0wn
         f2LA==
X-Gm-Message-State: AA+aEWatie5VPx1EE67MWJiyRpkJ8LezGU2bwOpksBTmP0bQLb6Cj1bS
        NF7ui3nXpP373yeJptdZZWBZvzygOlhBiuk/Zaa5QA==
X-Google-Smtp-Source: AFSGD/V3lrOPst3lbfFT3skINOJ3O89iBDKsIIzq3EwT9QU2TKdNSRE11SmBnpp8diGdbefLiryzppvZfITpuLLuEXk=
X-Received: by 2002:a02:88cf:: with SMTP id b15mr17120516jak.10.1545157920754;
 Tue, 18 Dec 2018 10:32:00 -0800 (PST)
MIME-Version: 1.0
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr> <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
 <20181211154159.54yaytbp4pyjqjhg@localhost> <20181213065113.sz7ce7kpkenyu3dy@localhost>
 <78bcd495-087e-aabf-6462-8950ee986732@free.fr> <CAK8P3a0jbQoAd=q15FPFJixAKgYYiSLCarO=Zfx3zyWkWtPq0g@mail.gmail.com>
In-Reply-To: <CAK8P3a0jbQoAd=q15FPFJixAKgYYiSLCarO=Zfx3zyWkWtPq0g@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 18 Dec 2018 10:31:48 -0800
Message-ID: <CAOesGMjxHxgWjqCTdGsEq37tBCc=wd6MgjRX2oGkCsABv5CBrw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 7:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Dec 14, 2018 at 4:44 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> >
> > On 13/12/2018 07:51, Olof Johansson wrote:
> >
> > > I've applied the patches from the series that were still needed. When
> > > re-running savedefconfig as part of patch 1, several of them were no longer
> > > applicable.
> >
> > FWIW, Arnd had suggested that the first patch should only deal with the
> > trivial case (moving options around), and subsequent patches should deal
> > with removed options, and corner cases.
> >
> > IIUC, you folded "trivial + removed" into a single patch. I suppose it
> > does make the commit log less bloated ;-)
> >
> > Thanks for merging the series.
>
> I suppose I should have asked for the patch to reorder the series to be
> the /last/ one in the series instead, to keep the useful changelog texts.

In my case I was a bit confused about what the series did when it was
first posted; I thought it actually enabled and disabled new
functionality, not that it "just" reflected changes that happened
implicit due to Kconfig changes. I.e. the patches that "fell out" of
the series were not actually making a difference to the generated
config, since they were setting what was now the default (or what
dependencies were no longer fulfilled).

So, I think there was a bit of miscommunication all around. Either way
-- thanks Marc for doing this work and following up on it, and
apologies for the confusion.


-Olof
