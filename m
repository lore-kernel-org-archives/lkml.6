Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D35C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F98D2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XHSgmnRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbfAKKVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:21:21 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:57819 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730920AbfAKKVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:21:20 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x0BAL8Ke017069;
        Fri, 11 Jan 2019 19:21:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x0BAL8Ke017069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547202069;
        bh=bi5gXUU2H3UH2Rk2hSMeWMnCsazFzyD/fdnj1Pu1CVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XHSgmnRhZFRId+KxWTZfxACVqteZJ6z9OOkN1S0ZC9QPC9amvOpmKatlF90pIk/4x
         IPd1+F4ie1rtGMjn+boXzCTaXoYKc5o8lLiyyIuAK8GcjWrfc+RZMwMCAP82AmpNC7
         ncrXtCBFYFiZvNYDgku1EeadjB9y7cH8Sd5QxTHIc0E64pj+er9f2JdF+6h12kwO9E
         YkDQZP/6BHj/hzj7xJPTkm6bj1RCfpgoP9ax7wV/PFVlPxtLsICoLzccXvEv2UMMQU
         kBHjXCLqaYauJ6lfb29eRzn3gQuWwF114hWAgPq31ML+0ZMH749CxihIl+Tm2vuWBv
         iedMLEzf4ipjQ==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id u19so4579509uae.4;
        Fri, 11 Jan 2019 02:21:09 -0800 (PST)
X-Gm-Message-State: AJcUukdZl41bIHXwJuaU41nQ6cA/JbGbrhFsEDWRD2RndeIiPzdC8icY
        teByzOmU0lKQ0lqChlKWJ/ShnnWRtKvpFWatAuQ=
X-Google-Smtp-Source: ALg8bN4vvwmY0J+PQ1IRDmpbuvZqEKQ2NnBjr97EYqcfDymVFWgZUvH2HwkeIYOiZ/wSGGgSiHM7mHwOmx8gBZiO9SA=
X-Received: by 2002:ab0:849:: with SMTP id b9mr5317176uaf.93.1547202068160;
 Fri, 11 Jan 2019 02:21:08 -0800 (PST)
MIME-Version: 1.0
References: <1547200321-17120-1-git-send-email-yamada.masahiro@socionext.com> <20190111095924.GA555@kroah.com>
In-Reply-To: <20190111095924.GA555@kroah.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 11 Jan 2019 19:20:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQdmVpL5_v+6Tw+o0A3_mPWafMfGF5j9imXBuXMHTuDA@mail.gmail.com>
Message-ID: <CAK7LNAQQdmVpL5_v+6Tw+o0A3_mPWafMfGF5j9imXBuXMHTuDA@mail.gmail.com>
Subject: Re: [PATCH] firmware_loader: move firmware/ to drivers/base/firmware_loader/builtin/
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 6:59 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 11, 2019 at 06:52:00PM +0900, Masahiro Yamada wrote:
> > Currently, the 'firmware' directory only contains a single Makefile
> > to embed extra firmware into the kernel.
> >
> > Move it to the more relevant place.
>
> So this moves any "build in" firmware to need to be placed in
> drivers/base/firmare_loader/builtin/ instead of firmware/builtin/ ?

Nope.

The build system searches extra firmware in the directory specified
by CONFIG_EXTRA_FIRMWARE_DIR.  (default is /lib/firmware)


See drivers/base/firmware_loader/Kconfig:

config EXTRA_FIRMWARE_DIR
        string "Firmware blobs root directory"
        depends on EXTRA_FIRMWARE != ""
        default "/lib/firmware"
        help
          This option controls the directory in which the kernel build system
          looks for the firmware files listed in the EXTRA_FIRMWARE option.



>  If
> so, why?  That seems like a lot of extra work for people now.  And
> burrying it down in the drivers/base/ directory is not obvious at all.


The firmware search path is a different thing.


I am just moving the Makefile
because all the other stuff (C files, Kconfig)
has been moved into drivers/base/firmware_loader/.

And, this is the last piece work in order to
make drivers/base/firmware_loader self-contained.



Just a reminder of previous commits you applied:


commit 06bfd3c8ab1dbf0031022d056a90ace682f6a94c
Author: Luis R. Rodriguez <mcgrof@kernel.org>
Date:   Thu May 10 13:08:43 2018 -0700

    firmware_loader: move kconfig FW_LOADER entries to its own file

    This will make it easier to track and easier to understand
    what components and features are part of the FW_LOADER. There
    are some components related to firmware which have *nothing* to
    do with the FW_LOADER, souch as PREVENT_FIRMWARE_BUILD.

    Reviewed-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


commit 5d6d1ddd27301dc85b13b794262c8bcececf88f1
Author: Luis R. Rodriguez <mcgrof@kernel.org>
Date:   Sat Mar 10 06:14:50 2018 -0800

    firmware: move firmware loader into its own directory

    This will make it much easier to manage as we manage to
    keep trimming componnents down into their own files to more
    easily manage and maintain this codebase.

    Suggested-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>



-- 
Best Regards
Masahiro Yamada
