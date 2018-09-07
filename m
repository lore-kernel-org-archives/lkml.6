Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB28C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D530A20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwL8G+5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D530A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeIHCuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbeIHCuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:50:46 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 819A820869;
        Fri,  7 Sep 2018 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536358063;
        bh=8z+Xx8SgBvvGl935GEc5JSaT8p9oVJI9X+PffIMEYtc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lwL8G+5oVRSK9Ypvtx2YVgj5dgwu3pDHyfUGxY3WVN7magcKxo9CWmykUJZTrR8sK
         OlY8LeRuww3TV91qn47e/WfCbXW2OqavWyCGDB93eVU+OS3LXGzpoifWzjQUVpKfJg
         eMt575Wp4+b2bRMwqlaBmsTFhqjA7oz+GE/cTUPU=
Received: by mail-qk1-f178.google.com with SMTP id c126-v6so10637878qkd.7;
        Fri, 07 Sep 2018 15:07:43 -0700 (PDT)
X-Gm-Message-State: APzg51DuWscersrV5KH9pPg4UaFQoGXoLbr19d/nqIbbKsE0Wik7xiKq
        Ev6zn1sVaHu9l7buX5uDppNX58VPqOKPAyK4rw==
X-Google-Smtp-Source: ANB0Vdaft2fKJMJMZoEp21SV9aY0UIcbmyrBRu0WuHWK6YS+9FtsBbbK/jMM+W+HDdMHDaaizT5c6goXzWmJ0ipwcvg=
X-Received: by 2002:a37:56c7:: with SMTP id k190-v6mr6959020qkb.29.1536358062637;
 Fri, 07 Sep 2018 15:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180907185414.2630-1-paul.burton@mips.com> <CAL_Jsq+n4e5_ptuh89CJibViGS_bgHz0A+Ki-uwtcGU38+mHXQ@mail.gmail.com>
 <20180907210124.rrqbexp423igxbsr@pburton-laptop>
In-Reply-To: <20180907210124.rrqbexp423igxbsr@pburton-laptop>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 7 Sep 2018 17:07:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKZYiDpH8900Mw+ADiUx--GbqF7j1MYoqbcJYCmbjvY4g@mail.gmail.com>
Message-ID: <CAL_JsqKZYiDpH8900Mw+ADiUx--GbqF7j1MYoqbcJYCmbjvY4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] of/fdt: Allow architectures to override
 CONFIG_CMDLINE logic
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 4:01 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Rob,
>
> On Fri, Sep 07, 2018 at 03:29:03PM -0500, Rob Herring wrote:
> > On Fri, Sep 7, 2018 at 1:55 PM Paul Burton <paul.burton@mips.com> wrote:
> > > The CONFIG_CMDLINE-related logic in early_init_dt_scan_chosen() falls
> > > back to copying CONFIG_CMDLINE into boot_command_line/data if the DT has
> > > a /chosen node but that node has no bootargs property or a bootargs
> > > property of length zero.
> >
> > The Risc-V guys found a similar issue if chosen is missing[1]. I
> > started a patch[2] to address that, but then looking at the different
> > arches wasn't sure if I'd break something. I don't recall for sure,
> > but it may have been MIPS that worried me.
> >
> > > This is problematic for the MIPS architecture because we support
> > > concatenating arguments from either the DT or the bootloader with those
> > > from CONFIG_CMDLINE, but the behaviour of early_init_dt_scan_chosen()
> > > gives us no way of knowing whether boot_command_line contains arguments
> > > from DT or already contains CONFIG_CMDLINE. This can lead to us
> > > concatenating CONFIG_CMDLINE with itself, duplicating command line
> > > arguments which can be problematic (eg. for earlycon which will attempt
> > > to register the same console twice & warn about it).
> >
> > If CONFIG_CMDLINE_EXTEND is set, you know it contains CONFIG_CMDLINE.
> > But I guess part of the problem is MIPS using its own kconfig options.
>
> Yes, that's part of the problem but there's more:
>
>   - We can also take arguments from the bootloader/prom, so it's not
>     just DT or CONFIG_CMDLINE as taken into account by
>     early_init_dt_scan_chosen(). MIPS has options to concatenate various
>     combinations of DT, bootloader & CONFIG_CMDLINE arguments & there's
>     no mapping to move all of them to just CONFIG_CMDLINE_EXTEND &
>     CONFIG_CMDLINE_OVERRIDE.
>
>   - Some MIPS systems don't use DT, so don't run
>     early_init_dt_scan_chosen() at all. Thus the architecture code still
>     needs to deal with the bootloader/prom & CONFIG_CMDLINE cases
>     anyway. In a perfect world we'd migrate all systems to use DT but in
>     this world I don't see that happening until we kill off support for
>     some of the older systems, which always seems contentious. Even then
>     there'd be a lot of work for some of the remaining systems. I guess
>     we could enable DT for these systems & only use it for the command
>     line, it just feels like overkill.

We have the same thing with old systems on ARM. I think the big
difference is the code paths are well separated. We have support for
old bootloaders which populates old boot parameters (atags) into DT
(and can replace or extend DT bootargs). That's all in the zImage
decompressor wrapper. Then in the kernel, there are 2 separate paths
depending whether you have atags or DT (setup_machine_tags and
setup_machine_fdt). I think the difference is we've imposed rules such
as the bootloader can only pass parameters one of 2 ways and if DT is
used then the bootargs must come from DT.

> > > Move the CONFIG_CMDLINE-related logic to a weak function that
> > > architectures can provide their own version of, such that we continue to
> > > use the existing logic for architectures where it's suitable but also
> > > allow MIPS to override this behaviour such that the architecture code
> > > knows when CONFIG_CMDLINE is used.
> >
> > More arch specific functions is not what I want. Really, all the
> > cmdline manipulating logic doesn't belong in DT code, but it shouldn't
> > be in the arch specific code either IMO. Really it should be some
> > common kernel function which calls into the DT code to retrieve the DT
> > bootargs and that's it. Then you can skip calling that kernel function
> > if you really need non-standard handling.
>
> That would make sense.
>
> > Perhaps you should consider filling DT bootargs with the cmdline from
> > bootloader. IOW, make the legacy case look like the non-legacy case
> > early, and then the kernel doesn't have to deal with both cases later
> > on.
>
> That could work, but would force us to use DT universally & is a larger
> change than this, which I was hoping to get in 4.19 to fix the
> regression described in patch 2 that happened back in 4.16. But if
> you're unhappy with this perhaps we just have to live with it a little
> longer...

You should probably at least do just the revert as that was what
worked for some platforms. But I guess you enabled some platforms and
just reverting would break them after working for a couple of cycles.

> An alternative workaround to this that would contain the regression fix
> within arch/mips/ would be to initialize boot_command_line to a single
> space character prior to early_init_dt_scan_chosen(), which would
> prevent early_init_dt_scan_chosen() from copying CONFIG_CMDLINE there.
> That smells much more like a hack to me than this patch though, so I'd
> rather not.

That doesn't seem that bad to me. If you want to put an "if
(IS_ENABLED(CONFIG_MIPS)) return;" in the chosen scan as a short term
fix, I'd be fine with that.

Rob
