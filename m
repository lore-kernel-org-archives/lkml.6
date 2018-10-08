Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265B0C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D166920878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwN+SCdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D166920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJHSOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:14:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37712 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJHSOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:14:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so13622892lfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFfpJUJVpqGihzjfeoGJXZ5dNoZ4J7ntdboh0RwB/Kg=;
        b=EwN+SCdfP8rwhThi/rJNkOmmq9x0Bc5umkZrauQ7SDqQyfF6UTxvX2HVhZ/5TkjqmR
         5t6uZPT3XxvI6yKFQRRoFJ03kgUg+nmh/kPoxdNQy/ecc2I4+BEUdQpnuXAeesUMDwRK
         yBUAg0EhsCutXCqS3Z4CYiyJkcEKD3+Wadv38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFfpJUJVpqGihzjfeoGJXZ5dNoZ4J7ntdboh0RwB/Kg=;
        b=Gn7Pb+xZuq3+iO+PJfSz3l2BDJWf8wuiStgppfKF17dIrwO0ww4+ZMnsye85hq+HQg
         9Mw29kd17gAEDuKxYGf9EY9jXyOTYmUs1zARj6vc7ROP26T0UktMiR8CtyqYHDj2uRlh
         dwYcktswlGypGSY2byNDL+ss0vOeHRg3P8EZKEhHoq8bqR1Hsc+GHZQNHGu7pk6smGq/
         HY29XUAs3Zbx1JTkFSBvMp7QthC1ohRRVuB0YlNfMs0NVmi4EqcZ+x+SaqK5V3qjffQS
         HkftakK7Mx+waWz7FjkPT4/bBlf7DpGhF3hOvG2dOQog8ciDiTsBqVLZi7p5P/AQ7r5O
         ATyw==
X-Gm-Message-State: ABuFfoiZpilj2ZaZPixH1ToQjeDbj57FXtJaAfqdGxESi3k0L6ah7YBg
        9+5ddFA/s0D6nGxjp6LxosIKRXpkIUocb/r0J+gnBw==
X-Google-Smtp-Source: ACcGV62KyBr0egO3QbORUFQInOtDQbAnnI2biSr04zj+bhx0oi/E2IltPloSBkRsGga9DLQ5it7oqVRiJqpeWbvt430=
X-Received: by 2002:a19:1709:: with SMTP id n9-v6mr12078525lfi.74.1538996620623;
 Mon, 08 Oct 2018 04:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181003123402.GA15494@hirez.programming.kicks-ass.net> <tip-3a387c6d96e69f1710a3804eb68e1253263298f2@git.kernel.org>
In-Reply-To: <tip-3a387c6d96e69f1710a3804eb68e1253263298f2@git.kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 8 Oct 2018 16:33:29 +0530
Message-ID: <CA+G9fYuLJH6XVsS14xjhSqJsUGZ9NXdyytseT2Pr0hoxOeWfAg@mail.gmail.com>
Subject: Re: [tip:x86/boot] x86/kaslr, ACPI/NUMA: Fix KASLR build error
To:     Ingo Molnar <mingo@kernel.org>, hpa@zytor.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, m.mizuma@jp.fujitsu.com,
        open list <linux-kernel@vger.kernel.org>, bhe@redhat.com,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-tip-commits@vger.kernel.org, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next build for arm64 failed due to
numa.c:34:10: fatal error: asm/kaslr.h: No such file or directory

On Wed, 3 Oct 2018 at 19:52, tip-bot for Peter Zijlstra (Intel)
<tipbot@zytor.com> wrote:
>
> Commit-ID:  3a387c6d96e69f1710a3804eb68e1253263298f2
> Gitweb:     https://git.kernel.org/tip/3a387c6d96e69f1710a3804eb68e1253263298f2
> Author:     Peter Zijlstra (Intel) <peterz@infradead.org>
> AuthorDate: Wed, 3 Oct 2018 14:41:27 +0200
> Committer:  Borislav Petkov <bp@suse.de>
> CommitDate: Wed, 3 Oct 2018 16:15:49 +0200
>
> x86/kaslr, ACPI/NUMA: Fix KASLR build error
>
> There is no point in trying to compile KASLR-specific code when there is
> no KASLR.
>
>  [ bp: Move the whole crap into kaslr.c and make
>    rand_mem_physical_padding static. ]
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

<trim>

> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 3d69834c692f..4408e37600ef 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -32,7 +32,7 @@
>  #include <linux/numa.h>
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
> -#include <asm/setup.h>
> +#include <asm/kaslr.h>

kernel-source/drivers/acpi/numa.c:34:10: fatal error: asm/kaslr.h: No
such file or directory
 #include <asm/kaslr.h>
          ^~~~~~~~~~~~~
compilation terminated.
kernel-source/scripts/Makefile.build:295: recipe for target
'drivers/acpi/numa.o' failed
make[4]: *** [drivers/acpi/numa.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC      lib/win_minmax.o
  CC      drivers/base/soc.o
kernel-source/scripts/Makefile.build:520: recipe for target
'drivers/acpi' failed
make[3]: *** [drivers/acpi] Error 2
