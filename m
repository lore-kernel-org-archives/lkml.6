Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D67C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F91A20898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R55dIruw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F91A20898
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeH1Qpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:45:35 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39724 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1Qpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:45:35 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so2590991oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VhuPjqUcE2fnwKEMiyQ5suCaFvItXEpYSihBClHoLSE=;
        b=R55dIruwHtZ6Faa9Xa8bHA+Jr6j6vMLnpiRPKvx+EcXSakmtogIV/hB3ZIZ4Zb/Gto
         tsDrVRO0cowU5ejFaUqcggkZlEvp29TAZVZnqIBG/uekLNth7TSgZmloDKQd9lsxKSCN
         zJwBdGgb994Jwd6chhG0JabEGdRsk6q2tCESOsaiUjuEdvqP482eTYUYtox+dl+7rKWn
         xnZ+cDSJwpKAtEcBB3cWAkbahXATbDe1XPpskEKqnoEWLSSAWxx0jy8XBh+VCSnGsGg2
         /QWLkXSaCqfhcHqdQLFQJDHNdSXtE9iiWmeo9ZbhJJ7qPgTgbTgBjNsqvU5CO9TGG90h
         nwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhuPjqUcE2fnwKEMiyQ5suCaFvItXEpYSihBClHoLSE=;
        b=nDt+mmwPt8OWIQ3+F8VNKb/XbC9U71AtNQ4x0y49OkUL0N6Z30RoeLiCJp3oXZKT0d
         0JU5go0cwYtgme9vqN2bAaYcZ/VApiDXWkG+PHxL6tC1roXBqafMMH2lYcVvpHxRdXVt
         rHeROXOGX4G6/iKJRqMXiXbmeEVXybbk/Yts9OhJSUqv2EARiNXJQw8A12hgBBD3acUu
         NWVcYBJfzHh3/3bKY1mIwsplntXBO8sfL3vSyC3Kv5bmrOE4MUYqqFETqCMenY0VLvzb
         RJLtEEp/4B5g7pnvl023Y+vVE5qlz/PW9t10VLsNVTKMVaclY0r2nfJgP/pTxV6XI4SQ
         /LuA==
X-Gm-Message-State: APzg51AHT85xCb5MK2kTvWZq4fpzOPpi7/++WErSnJAAp12RwWstreTw
        Z9+A0VowACNO9GZDrXOnLn7wHsJGE71hkNci26WKSg==
X-Google-Smtp-Source: ANB0Vdbcp/cKk4oBzErCTqNMunmrMTi4/ziP/y3u3u7jz7VI5Zw3aK8yZEMP7ap+gr0nxcdslwR0Lm51LciS57yOFek=
X-Received: by 2002:aca:3882:: with SMTP id f124-v6mr1304257oia.195.1535460842135;
 Tue, 28 Aug 2018 05:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180824235826.62741-1-jannh@google.com> <0897d173-6a30-09df-f16a-76322384fe0d@virtuozzo.com>
 <CAG48ez1zYqx8-1We3JkDBmYREksUMoUe7VBeAOv2JH98gVWcKw@mail.gmail.com> <daba9c5b-b5c6-beaa-ca96-81cf6af760b9@virtuozzo.com>
In-Reply-To: <daba9c5b-b5c6-beaa-ca96-81cf6af760b9@virtuozzo.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Aug 2018 14:53:35 +0200
Message-ID: <CAG48ez2u9gH8skjFcNR-cBctxCEdfZckDjvej07-hooiCvBO8A@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: wipe KASAN stack shadow in rewind_stack_do_exit()
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 1:33 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> On 08/28/2018 01:38 PM, Jann Horn wrote:
> >> Why this has to be done in the rewind_stack_do_exit()?
> >> Are there any problems with calling the kasan_unpoison_task_stack(current) from oops_end(), before the rewind_stack_do_exit()?
> >
> > Ooh, good point! I didn't see that KASAN instrumentation is disabled
> > for dumpstack.c.
>
> It doesn't really matter. This would work with instrumented oops_end() as well.
> kasan_unpoison_task_stack() will unpoison everything including oops_end's stack.
> It would be also ok if kasan_unpoison_task_stack() instrumented,

But then that would rely on ASAN implementation details, so I'd be
hesitant to do that.

> or calling any number of instrumented functions
> in between kasan_unpoison_task_stack() and rewind_stack_do_exit(). As long as we return from these functions before
> the rewind_stack_do_exit(), the stack will be unpoisoned on return.

Yeah, I understand that. :)
