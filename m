Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F613C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C962087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/BDEYEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C962087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeGIS3u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:29:50 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35871 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754516AbeGIS3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:29:48 -0400
Received: by mail-oi0-f65.google.com with SMTP id r16-v6so37729941oie.3;
        Mon, 09 Jul 2018 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9xkIWwJiFmYDbjco3x7+8Tcg7sxxXqwzbre/vftAUwE=;
        b=W/BDEYEhn4RJjalusDKTg9Hr9eb3RQPh7m0yEbVhFnxvKuQoj/KV3yraGaKzcYhixG
         u0HacG97XdK2ZpNuyryvZxB4FeQWYywKNi3cQ9KRe/WaO+RdKZ52HKgNPciVNNtHPxVM
         r9S2Fdcbxk+pfh+LY4Ys3NuHESPucOXfrGyWirt915D16mbCPMisGZlRVwS6Ftkf8RdV
         4wOgUv9oAICUR/x+8rKoSfCwmhQdFUkL1FqD7L0N85zG0OXJfinu4nWoX8/Sr/EZxXJC
         OnYQO8i+dHTLJ8tFAUG6SN9rvLcEA4KU7WnNwmAwietn4BpA6H+QYuV2oxrg0/fOh7En
         gTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9xkIWwJiFmYDbjco3x7+8Tcg7sxxXqwzbre/vftAUwE=;
        b=mj71Aid1uCWfk8nLAKfUh/K0U2EEij7GD9XoUwiPNT5zZJXrT4ixPdWwuhTjyAT780
         iPmfUG/fffvBGfJwQjR8Kzxq6+LZaNS8SGfa+sqpiqU6f/2yJNcFQTk7DGuB/Mrbrsf7
         /Gkb6TJtyKOXCO54Rl+OYHm2tjyOBHaeMnjSxjfb4WCpLEbtvfbRBl2wEXJECSj3mQ8F
         7I6FLFHr9WvmMidqTOcGrKgIj8h+ZIllOlXSmWQjvcR9TwNhT2t0Qjq+DNYVK9zCfUHQ
         IEm2gWro4gSHxkQRAaxiGOnCx4mYTdxeQwh5hArt8gTQTMwA/9E5W21AAvmTuC4kGuIb
         FNWQ==
X-Gm-Message-State: APt69E16F5ooY5Zxt23WJbYpDkNffyG099OS8XFCL5qq3/9E9e0y61x9
        30VxpS0qs76JD+jW2iLmQeQ=
X-Google-Smtp-Source: AAOMgpeyVeHGTdCaxTSPADLOZG0kkWLSArozac478q5QF6lJ/ubHlfNfC76opSnlHNytiSa2HFwM7w==
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr26797890oif.71.1531160988129;
        Mon, 09 Jul 2018 11:29:48 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b63-v6sm12487742oia.4.2018.07.09.11.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 11:29:47 -0700 (PDT)
Date:   Mon, 9 Jul 2018 11:29:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: Build/qemu test results for v4.18-rc4
Message-ID: <20180709182945.GA31159@roeck-us.net>
References: <20180709175550.GA7469@roeck-us.net>
 <CAGXu5j+rn+69QiLR=Rbd6ys7atL8Z8THyazW_T3Z=CAw0n8xzg@mail.gmail.com>
 <3207f3de-0a10-f575-f24f-210a2a926c4c@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3207f3de-0a10-f575-f24f-210a2a926c4c@de.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 08:16:04PM +0200, Christian Borntraeger wrote:
> 
> 
> On 07/09/2018 08:06 PM, Kees Cook wrote:
> > On Mon, Jul 9, 2018 at 10:55 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> >> s390:allmodconfig:
> >>
> >> arch/s390/kernel/als.o: In function `verify_facilities':
> >> als.c:(.init.text+0x24): undefined reference to `latent_entropy'
> >> als.c:(.init.text+0xae): undefined reference to `latent_entropy'
> >> make[3]: *** [arch/s390/boot/compressed/vmlinux] Error 1
> >> make[2]: *** [arch/s390/boot/compressed/vmlinux] Error 2
> >> make[1]: *** [bzImage] Error 2
> >>
> >> This problem is only seen when using a compiler which has the relevant
> >> plugins enabled. Bisect points to commit 1658dcee3d43ed ("gcc-plugins:
> >> allow to enable GCC_PLUGINS for COMPILE_TEST") as the culprit. I don't
> >> know if a fix for v4.18 has been submitted. The s390 boot code in -next
> >> has been rearranged and the problem is no longer seen there.
> > 
> > Hm, that would imply that mm/page_alloc.o wasn't visible during the
> > als.o linking? But ... if the problem is gone, I guess... good?
> 
> als.o is used to detect if the kernel was compiled for a newer generation
> than the hardware that we are running on (very early). So it is compiled
> without gcov, kcov,ubsan and with a different march -in other words special.
> In linux-next we moved the als part to the decompressor which avoids all
> these kind of special handling. As this is part of a bigger patch set it 
> would be  non-trivial to backport that for 4.18.
> So unless we want to have it fixed for 4.18 I think we are fine.
> 

Fine with me. Please let me know if the problem won't be fixed, and I'll
disable allmodconfig test builds for s390 images in v4.18.

Thanks,
Guenter
