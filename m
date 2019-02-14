Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F255921904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f71ucV6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfBNAlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:41:47 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33813 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBNAlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:41:47 -0500
Received: by mail-vs1-f68.google.com with SMTP id e10so2637250vsp.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWDWkCscEGObTet0nMfiwJDncASNslatrfgpuXCXCcI=;
        b=f71ucV6TZFXwAnyQzDk56uajsFCqsGW+dmNsnjbPGl0zAVpVYLKgddkJoT0ertw9pf
         qJ8qMGpb8FSGFS+ZNgrIluJKotVghG+xUvTxGZX4IR2kBtTeDXpiE8CQxUYOuXq6PVkE
         Nn3bPNpD4D75lFS6S481emdTVY0ASMm6X+vQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWDWkCscEGObTet0nMfiwJDncASNslatrfgpuXCXCcI=;
        b=CwTmTVmwf66rEYspvwlr7Azy4uqdK+HD4JhVQ5gLvmTdempVCjiLfM3XOoRmuIJD+W
         tQAcmryNP3S7fwpx2OxmumsG5POVfBxL+9C3C+6bVvqN1vSP+xH9dQ/UEWRh7p06phrp
         NYmp+0/dV8bHEPLHccOHDSpPq5LIAyoMCMbkMbFFrhV4cCXDsW6A+8b4u5qOeCqSAlgc
         E0rruoQVrjwrZ6AcEWrhcwncRZV1QnOKh36p+2OrBMlSvrbnf+bxPGIPRYNFYiJJtkqM
         aV4HPunO1DWmJbl67j3nVdfn/yVDP5DuGeMN0LG/sgY6KirCnMmhqgRC7hTJO/9h6Mby
         o4bA==
X-Gm-Message-State: AHQUAuaSMlndM75uTB8M8ExjKuiIcyuabV5WpGxEkXlQZVDKlthRHRwG
        EQm8NbMFWUV9n1Av497frwegj63gm+E=
X-Google-Smtp-Source: AHgI3IYbgBIp6G5nZDF9vvnhCWtmR/in+45RgI3Q6HP5m0mRW1fnSWqdjqBWY1Nr7jedSLoyZLhWMQ==
X-Received: by 2002:a67:f5ce:: with SMTP id t14mr582090vso.7.1550104905132;
        Wed, 13 Feb 2019 16:41:45 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id n206sm1166556vkn.36.2019.02.13.16.41.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 16:41:43 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id y14so994300vky.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:41:43 -0800 (PST)
X-Received: by 2002:a1f:8e49:: with SMTP id q70mr562750vkd.40.1550104903100;
 Wed, 13 Feb 2019 16:41:43 -0800 (PST)
MIME-Version: 1.0
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
In-Reply-To: <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 13 Feb 2019 16:41:30 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLvq4295SP7ZFmQqi0UxuwFMNHdb-R7tTb5KxmMCL7TUg@mail.gmail.com>
Message-ID: <CAGXu5jLvq4295SP7ZFmQqi0UxuwFMNHdb-R7tTb5KxmMCL7TUg@mail.gmail.com>
Subject: Re: Userspace regression in LTS and stable kernels
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        graham@grahamc.com, Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 3:36 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> [CC'in relevant folks]
>
> On Thu, Feb 14, 2019 at 12:19 AM Samuel Dionne-Riel
> <samuel@dionne-riel.com> wrote:
> >
> > Hi,
> >
> > I am posting as a representative of the NixOS Linux distribution,
> > about a userspace regression on 5.0-rc* which recently was backported
> > to the 4.14.99, 4.19.21 and 4.20.8 current LTS and stable versions.
> > The issue has been reported to the bug tracker, bug 202497, but seems
> > to have gone unnoticed by the maintainers.
> >
> > The issue seems to break userspace for long-standing patterns in the
> > NixOS distribution, with regards to use of the shebangs.
> >
> > Here is an example shebang causing an issue:
> >
> > #! /nix/store/mbwav8kz8b3y471wjsybgzw84mrh4js9-perl-5.28.1/bin/perl
> > -I/nix/store/x6yyav38jgr924nkna62q3pkp0dgmzlx-perl5.28.1-File-Slurp-9999.25/lib/perl5/site_perl
> > -I/nix/store/ha8v67sl8dac92r9z07vzr4gv1y9nwqz-perl5.28.1-Net-DBus-1.1.0/lib/perl5/site_perl
> > -I/nix/store/dcrkvnjmwh69ljsvpbdjjdnqgwx90a9d-perl5.28.1-XML-Parser-2.44/lib/perl5/site_perl
> > -I/nix/store/rmji88k2zz7h4zg97385bygcydrf2q8h-perl5.28.1-XML-Twig-3.52/lib/perl5/site_perl
>
> This this ever work correctly? It is longer than BINPRM_BUF_SIZE.
>
> > (The shebang was artificially wrapped spaces replaced by newlines)
> >
> > Another contributor tracked the regression it to commit
> > 8099b047ecc431518b9bb6bdbba3549bbecdc343 in the 5.0-rc* tree.
> >
> > I bring no particular fix to the issue, but I believe it should at
> > least be fast-tracked to a revert for the stable and LTS branches, and
> > since 5.0 might drop soon, a solution worked on, or possibly a revert
> > until one is figured out.
>
> Your shebang line exceeds BINPRM_BUF_SIZE.
> Before the said commit the kernel silently truncated the shebang line
> (and corrupted it),
> now it tells the user that the line is too long.

Yeah, it looks like it just truncates:

$ cat /nix/store/mbwav8kz8b3y471wjsybgzw84mrh4js9-perl-5.28.1/bin/perl
#!/usr/bin/perl
print "Arg # 0 : $0\n";
$counter = 1;
foreach my $a (@ARGV) {
        print "Arg # $counter : $a\n";
        $counter++;
}
$ cat test.pl
#! /nix/store/mbwav8kz8b3y471wjsybgzw84mrh4js9-perl-5.28.1/bin/perl
-I/nix/store/x6yyav38jgr924nkna62q3pkp0dgmzlx-perl5.28.1-File-Slurp-9999.25/lib/perl5/site_perl
-I/nix/store/ha8v67sl8dac92r9z07vzr4gv1y9nwqz-perl5.28.1-Net-DBus-1.1.0/lib/perl5/site_perl
-I/nix/store/dcrkvnjmwh69ljsvpbdjjdnqgwx90a9d-perl5.28.1-XML-Parser-2.44/lib/perl5/site_perl
-I/nix/store/rmji88k2zz7h4zg97385bygcydrf2q8h-perl5.28.1-XML-Twig-3.52/lib/perl5/site_perl
print "I am the script\n";

4.20.7:
$ ./test.pl
Arg # 0 : /nix/store/mbwav8kz8b3y471wjsybgzw84mrh4js9-perl-5.28.1/bin/perl
Arg # 1 : -I/nix/store/x6yyav38jgr924nkna62q3pkp0dgmzlx-perl5.28.1-Fi
Arg # 2 : ./test.pl

4.20.8:
$ ./test.pl
Error: no such file "I am the script\n"

(My shell seems to fall back to direct shell execution)

Since this is breaking existing userspace, we should probably switch
back to the truncation, but do a WARN_ONCE or something so there's a
visible hint _somewhere_ about the (long standing) issue? What do you
think Oleg?

-Kees

-- 
Kees Cook
