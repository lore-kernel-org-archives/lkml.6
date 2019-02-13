Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5BFC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE5921924
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InnTlCQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389788AbfBMXgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:36:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51805 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbfBMXgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:36:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so4436955wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35CHtKJBdFYeYnwdQ+jDpVSeyCId7XDKRnuVATTH7qE=;
        b=InnTlCQ8yZGgzzy4vTB16CA5XllT324ARR3hC5Eh4cZKcAxk8+bUWbI3HEGY949UU8
         WQgmSsfwKn0nsbWQHVRSvbK22N4UynAciFjj/AqP2Lw6hFokZmtlca4qcrKCZK7mY7PT
         Q75vRW3RHB+U7jqKUwhmVYXzlHJWwMkgy393G+CWL1ByO+LaaYih2pikAFPeqXJodeQv
         gS/Gdw4F1AbbYbMypx+M2bmkflYli3zbT1trPlUQP7iku42A8wzxF2u9bTbsWvmuTQFy
         u/ncJeTYoaWVMHBit3cyq3LQfWdyGt/W0GQ+UfRAWSBTKqis6VnUIOp7504Lqy1SN2hf
         3Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35CHtKJBdFYeYnwdQ+jDpVSeyCId7XDKRnuVATTH7qE=;
        b=OWtUN7xBSjlHGafBT8pqxc7CB5B8LCHSNO81SnYTzP1jivjvWAeEM2JTbqbFBxG3m8
         eI8BBVlaBFLw2gbdAzm2aEW6P/OLmM8+R8hFfrfhd3B3KuesMUX11tnrM5pJjcfuMnHW
         l3ewXijZXK/BYzsPG5furdhz+2kNgjwt7h6ERZwq2a61Anlh6cE3pEJmxuZIHs+c5BPO
         dOUGFhapjn8yNwK3/zFu82VXX2VpXQ7zE9lc/3EIk48iZBgTktCogO6M3YgZlVpgFwAC
         hkmmWcfNvMa0inhTlNV96+XLeoeX2aq4Yq04J8zE8U6N2i9cImbLqX2O4eOUTzA3XyG1
         C7Tg==
X-Gm-Message-State: AHQUAubtPnDeYtU5JUHtE+q6V662bJO/nqmyEcbC8IFsnUwWRaCE/NEY
        zRXzHJjYAOdhFGHuGBmJJZD2QeQeYi6bYA6u4+Q=
X-Google-Smtp-Source: AHgI3IY/VTF+lc7eJHG8woM0S5LFIESsNRCDJ3XtAbYMj2wONvmcNsDiP1HyzEpCNa+Zu3QoMN4OVi0jn0FgOD+fjxc=
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr392919wme.115.1550101001331;
 Wed, 13 Feb 2019 15:36:41 -0800 (PST)
MIME-Version: 1.0
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
In-Reply-To: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 14 Feb 2019 00:36:29 +0100
Message-ID: <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
Subject: Re: Userspace regression in LTS and stable kernels
To:     Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        graham@grahamc.com, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>, mhocko@suse.com,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC'in relevant folks]

On Thu, Feb 14, 2019 at 12:19 AM Samuel Dionne-Riel
<samuel@dionne-riel.com> wrote:
>
> Hi,
>
> I am posting as a representative of the NixOS Linux distribution,
> about a userspace regression on 5.0-rc* which recently was backported
> to the 4.14.99, 4.19.21 and 4.20.8 current LTS and stable versions.
> The issue has been reported to the bug tracker, bug 202497, but seems
> to have gone unnoticed by the maintainers.
>
> The issue seems to break userspace for long-standing patterns in the
> NixOS distribution, with regards to use of the shebangs.
>
> Here is an example shebang causing an issue:
>
> #! /nix/store/mbwav8kz8b3y471wjsybgzw84mrh4js9-perl-5.28.1/bin/perl
> -I/nix/store/x6yyav38jgr924nkna62q3pkp0dgmzlx-perl5.28.1-File-Slurp-9999.25/lib/perl5/site_perl
> -I/nix/store/ha8v67sl8dac92r9z07vzr4gv1y9nwqz-perl5.28.1-Net-DBus-1.1.0/lib/perl5/site_perl
> -I/nix/store/dcrkvnjmwh69ljsvpbdjjdnqgwx90a9d-perl5.28.1-XML-Parser-2.44/lib/perl5/site_perl
> -I/nix/store/rmji88k2zz7h4zg97385bygcydrf2q8h-perl5.28.1-XML-Twig-3.52/lib/perl5/site_perl

This this ever work correctly? It is longer than BINPRM_BUF_SIZE.

> (The shebang was artificially wrapped spaces replaced by newlines)
>
> Another contributor tracked the regression it to commit
> 8099b047ecc431518b9bb6bdbba3549bbecdc343 in the 5.0-rc* tree.
>
> I bring no particular fix to the issue, but I believe it should at
> least be fast-tracked to a revert for the stable and LTS branches, and
> since 5.0 might drop soon, a solution worked on, or possibly a revert
> until one is figured out.

Your shebang line exceeds BINPRM_BUF_SIZE.
Before the said commit the kernel silently truncated the shebang line
(and corrupted it),
now it tells the user that the line is too long.

Thanks,
//richard
