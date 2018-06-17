Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6D2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C4F20874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/ZyMo9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C4F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757012AbeFQBL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 21:11:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36745 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756932AbeFQBL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 21:11:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id a12-v6so6536972pfi.3;
        Sat, 16 Jun 2018 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2W2Gm7K4ZAUFtmPdhaToCIfjNpot7ZNt+wV5jYJsThU=;
        b=r/ZyMo9QhC4wKgo9MZicBRk8Pch+hGXZoQNkOU5taSZy/k9pNA0rZ4re5eEWWfGUVm
         dfqKOtAItBjctRvk2KIFtt10+nKccOTuv8E1HMZHGVE+TGs7Zq1brei84Rsh6kBD0iIv
         w8ECUnemkKejVWKWFqtt23AiZpiUKcFPjsD6S3Q9rNF5QkNuIQMigZpfZiZVONl3T50K
         YUcuywhz0dlfz5TO/Rc4GmVgjHbj9DT4BGMwYTQhMVOt+vm6kQ3UsRyUBYKY67WCEC7R
         VJI2BjzNt+AcKzSqWLFJndtmQd65sz9FwHzgFtgAiee+ey2QSiiqVh0zxaNWcSKDCbj9
         P8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2W2Gm7K4ZAUFtmPdhaToCIfjNpot7ZNt+wV5jYJsThU=;
        b=KzaLS2UQCBFLaq1mE8/vuP/2UDq6vCreKLV20ZFXGIGzg0BnXdX861SSj/Vhm5mL2I
         C7bog3kVkHR8QcllcCdVZb9ojabBDT8rpIUwM/5QBZAd76kudNvPLIhwcelTfd7bqiOI
         EI2YDRoGiEvu86BoJvlUE5Vz1HPGzNMKoeoFC86gBlpMGYWaRlUn7JLIlj4dP3q8CaF5
         Cm3zukKbj/PvgIwUKxOUMmuZCb9Avu5Y/y5mUruatbdMu9bz5y/TOUUoDYDM/gDYXsB0
         j0EPiH4SwS0sAjcCXO9Tws9RILDdwSUHxzFj2dJuX6l9Gp1ienp8tUt/Sm0078ERbmat
         kqcw==
X-Gm-Message-State: APt69E0i5lXI+pXBiCovEQ4JBb9jCPCvD5LzFBq0Ge0pxeoN2jRqJaYr
        n4QsjRelaYvKbywLbWNcwYo=
X-Google-Smtp-Source: ADUXVKKCIo4xyWw6htseAoC56FNbqqPNn7oLLwJEf5PYyHGI6aue7NHIJG10lc9n/lDe9GhTwAOwjg==
X-Received: by 2002:a63:7b1e:: with SMTP id w30-v6mr6238478pgc.402.1529197916277;
        Sat, 16 Jun 2018 18:11:56 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id h8-v6sm13207119pgq.35.2018.06.16.18.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 18:11:55 -0700 (PDT)
Date:   Sun, 17 Jun 2018 10:11:53 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-kbuild@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] Resolve -Wattribute-alias warnings from
 SYSCALL_DEFINEx()
Message-ID: <20180617011153.GA24595@lianli.shorne-pla.net>
References: <20180616005323.7938-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616005323.7938-1-paul.burton@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 05:53:19PM -0700, Paul Burton wrote:
> This series introduces infrastructure allowing compiler diagnostics to
> be disabled or their severity modified for specific pieces of code, with
> suitable abstractions to prevent that code from becoming tied to a
> specific compiler.
> 
> This infrastructure is then used to disable the -Wattribute-alias
> warning around syscall definitions, which rely on type mismatches to
> sanitize arguments.
> 
> Finally PowerPC-specific #pragma's are removed now that the generic code
> is handling this.
> 
> The series takes Arnd's RFC patches & addresses the review comments they
> received. The most notable effect of this series to to avoid warnings &
> build failures caused by -Wattribute-alias when compiling the kernel
> with GCC 8.
> 
> Applies cleanly atop master as of 9215310cf13b ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
> 
> Thanks,
>     Paul
> 
> Arnd Bergmann (2):
>   kbuild: add macro for controlling warnings to linux/compiler.h
>   disable -Wattribute-alias warning for SYSCALL_DEFINEx()
> 
> Paul Burton (1):
>   Revert "powerpc: fix build failure by disabling attribute-alias
>     warning in pci_32"
> 
>  arch/powerpc/kernel/pci_32.c   |  4 ---
>  include/linux/compat.h         |  8 ++++-
>  include/linux/compiler-gcc.h   | 66 ++++++++++++++++++++++++++++++++++
>  include/linux/compiler_types.h | 18 ++++++++++
>  include/linux/syscalls.h       |  4 +++
>  5 files changed, 95 insertions(+), 5 deletions(-)

Hello Paul,

I tested the series out with the new OpenRISC 9.0.0 port and the
-Wattribute-alias warnings are gone.  Thank you.

Using toolchain binaries from:
  https://github.com/stffrdhrn/gcc/releases/tag/or1k-9.0.0-20180613

For the series:

Tested-by: Stafford Horne <shorne@gmail.com>

-Stafford
