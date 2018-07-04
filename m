Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C470C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3471246CC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="peeqKYTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3471246CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933068AbeGDD7y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:59:54 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:38456 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeGDD7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:59:53 -0400
Received: from mail-ua0-f180.google.com (mail-ua0-f180.google.com [209.85.217.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w643xfEu003499;
        Wed, 4 Jul 2018 12:59:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w643xfEu003499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530676782;
        bh=/oFkg9po2YzXABnXxKs2WPeVZbm3BxG6+TveezITLL0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=peeqKYTgtfdNUcQpQDaY77w/pM6nJeT/UAwq5IOuzGFL6XhQz89MyifIRA0fpMUDh
         o1z9IFlLznkViBzrNMHBOppxIhpE5EWXw4j0efr3UDUUjrAHnHldXoVE0v1fDU9ekS
         tAlBv5jrdKryfgssHYsZ9z7/0puQEA8Zg3ldXGFhfI/R+xtEMYTSwd8TP6KoINtJ9S
         wJoyG30OSvtFNl9DvM6MZ3SmezJ3Qfa5qqWi1MilkL3dVd5JAyLW/50/diXG1VPhHF
         ED0AEbvXMJ7yAgY0BrV0qP3sT1f6l3xKJyzKejlAZPLBimMi5ul0Uj4hA8MH7uXmxV
         6fVC3L4dBFieA==
X-Nifty-SrcIP: [209.85.217.180]
Received: by mail-ua0-f180.google.com with SMTP id y8-v6so2610572uan.3;
        Tue, 03 Jul 2018 20:59:41 -0700 (PDT)
X-Gm-Message-State: APt69E3ReijaRsU+li9ZqOz2RwYSq/2w5fGm+PEXNec6YW/oXn7dwTLN
        3YQGxM0NThGJ6ecOwzSieofrsueJF+jsOTWb75c=
X-Google-Smtp-Source: AAOMgpcUZSzDEPW9apCZE6yKNTt6gFYrT4tXqi+VFmhg15h5atIyjB7wvMkAMfWOjavXZvfZ3Hsbrn/D0aryp9FtmpQ=
X-Received: by 2002:ab0:e3:: with SMTP id 90-v6mr180982uaj.52.1530676780637;
 Tue, 03 Jul 2018 20:59:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 20:59:00 -0700 (PDT)
In-Reply-To: <20180703233430.14416-2-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com> <20180703233430.14416-2-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 4 Jul 2018 12:59:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS7XBwDidNaLKC1wD+G30AyAvTHG5GN=UAiP5zz1EO8JA@mail.gmail.com>
Message-ID: <CAK7LNAS7XBwDidNaLKC1wD+G30AyAvTHG5GN=UAiP5zz1EO8JA@mail.gmail.com>
Subject: Re: [PATCHv5 1/4] kbuild: Add build salt to the kernel and modules
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Thanks for the update.


2018-07-04 8:34 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> The build id generated from --build-id can be generated in several different
> ways, with the default being the sha1 on the output of the linked file. For
> distributions, it can be useful to make sure this ID is unique, even if the
> actual file contents don't change. The easiest way to do this is to insert
> a section with some data.
>
> Add an ELF note to both the kernel and module which contains some data based
> off of a config option.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: I used S-o-b here since the majority of the code was written
> already.


I think Suggested-by is good enough.
S-o-b is appended as a patch is passed from people to people.

Anyway, this looks good except one bike-shed.

> Please feel free to change the tag if you think it's not
> appropriate. I also tweaked this to take an ascii string instead of just
> a hex value since this makes things much easier on the distribution
> side.
> ---


> diff --git a/init/Kconfig b/init/Kconfig
> index 041f3a022122..8de789f40db9 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -107,6 +107,15 @@ config LOCALVERSION_AUTO
>
>           which is done within the script "scripts/setlocalversion".)
>
> +config BUILD_SALT
> +       string "Build ID Salt"
> +       default "Linux"


How about empty string ""
for default?




-- 
Best Regards
Masahiro Yamada
