Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784BCC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCCD25ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLzE6VtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCCD25ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934275AbeFYRMb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:12:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39429 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934051AbeFYRM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:12:26 -0400
Received: by mail-pg0-f67.google.com with SMTP id n2-v6so2916456pgq.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fk4vkscyIjUgNMcMCHjIIaASWli/XNsHAgNBHoC/m6o=;
        b=hLzE6VtS3tH1gnmRloz+QctDgS5ZYeoR1NtG5R0xbHa6ZQxH/b+pnyGzg8hsn/QVs8
         232LFVcXkveZL8Eqe1YBCnhSKXaLB1IPBIn6k2M6F/GCiSDOtR72tG6eluJK7peuTm3i
         DNF64Hg3Fje6BsnriVYOWQyzgDHTtMv4sFWJ91CSt6ceJJy8kku+Ba6wQEYxaedzK9+6
         kZK+7XciD1ab899EHST1/kzLdjRa/lB/a2YWb+SdZCMIPBjhGEET/8VpGyUyFyqZeOk4
         4SCA9hzBWoq/47ejQzRoEOP6P9mNpThvQJjiRqDw26/yepR8p90KHiIMMPpP3Rlu7IoX
         sCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fk4vkscyIjUgNMcMCHjIIaASWli/XNsHAgNBHoC/m6o=;
        b=l4n3VNnmDqJroALXUibdMudS/KEM0BrJ2JsH0KPfImt1CFtYiQ9o3WCBhlpkdcnRaL
         XhNfqNwATtZIIrh670UI4Nez6XPNgLtnqvfkbGQvLjHnfWAuJ5YU/68yk1rESahxVr/g
         4Ti6myqGc8D5Dzz4cb/Qfl8hf7SrORC4EtRQVo2Zy4Y+zt0qBvJqNTGV+s/Hp/eZ+ED5
         lL3HSLS5bqvlkr+a3NanUZa+jjaz2/j8HJNC3muY2xrjvZo54/QUCKbE3siSzbO/EiEN
         sjvsTeFaCSur1LVmsp+m2TZNOzQBFk00H/eENRZsKWdCU8XE9eTsM+HG8p6ZOffNOuS+
         GQtA==
X-Gm-Message-State: APt69E3ry4a1zOZWx/YPjoyVTij2DlqGCu/3/bdMKVuB8ZjfPCKg1/6u
        0YmADLoBYh1QJKOYYAz+mciccoY1dWwZjJT/yAJTvA==
X-Google-Smtp-Source: ADUXVKK98xJvTHbEV6EOKGKkAqs8OnWOBysbieI0iyVEd7MBlgDWwuW0NQygBePkkzI32sDTz4zjbcZaTM/Jf08G8PU=
X-Received: by 2002:aa7:810c:: with SMTP id b12-v6mr13768495pfi.79.1529946745466;
 Mon, 25 Jun 2018 10:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180619192504.180479-1-mka@chromium.org> <4dd99306-4fea-24b2-4bea-5b7927ea5e79@redhat.com>
 <CAKwvOdmmv9EtPB-jhwVruLASFve5d4h0+wx-6iY=ve=T9hbNdg@mail.gmail.com> <ca7719d7e917623bcd0bfd508add4d1f43c42d53.camel@perches.com>
In-Reply-To: <ca7719d7e917623bcd0bfd508add4d1f43c42d53.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jun 2018 13:12:13 -0400
Message-ID: <CAKwvOdknKQaKL=GLLktmx6h5UE1waiKED-F=_7h+keGq9jx4dQ@mail.gmail.com>
Subject: Re: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in update_permission_bitmask()
To:     joe@perches.com
Cc:     pbonzini@redhat.com, Matthias Kaehlcke <mka@chromium.org>,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 1:05 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2018-06-25 at 12:47 -0400, Nick Desaulniers wrote:
> > On Mon, Jun 25, 2018 at 12:05 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > On 19/06/2018 21:25, Matthias Kaehlcke wrote:
> > > > update_permission_bitmask() negates u8 bitmask values and assigns them
> > > > to variables of type u8. Since the MSB is set in the bitmask values the
> > > > compiler expands the negated values to int, which then is assigned to
> > > > an u8 variable. Cast the negated value back to u8.
> > > >
> > > > This fixes several warnings like this when building with clang:
> > > >
> > > > arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
> > > >   (aka 'unsigned char') changes value from -205 to 51 [-Werror,
> > > >   -Wconstant-conversion]
> > > >     u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> > > >        ~~                               ^~
> > > >
> > > > (gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
> > > > doesn't seem to be universally enabled)
> > > >
> > > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > > Changes in v2:
> > > > - negate the bitmask at initialization and rename variables to not_X
> > >
> > > The patch is not that bad, but I'd like to get confirmation that other
> > > maintainers are applying fixes like this.  Honestly I'm not really
> > > impressed by most new clang warnings, these days.
> >
> > Here's an actual bug this warning caught applied to drivers/input/:
> >
> > dae1a432ab1f ("Input: mousedev - fix implicit conversion warning"):
> > https://patchwork.kernel.org/patch/9753771/
>
> What bug is that?
>
> $ cat test.c
> #include <stdio.h>
> #include <stdlib.h>
> #include <memory.h>
>
> int main(int argc, char **argv)
> {
>         static const signed char a[3] = {0x60, 3, 200};
>         static const unsigned char b[3] = {0x60, 3, 200};
>
>         printf("a and b are %s\n",
>                memcmp(a, b, 3) == 0 ? "identical" : "different");
> }
> $ gcc test.c
> $ ./a.out
> a and b are identical
>

Good point, poor choice of example on my part.
-- 
Thanks,
~Nick Desaulniers
