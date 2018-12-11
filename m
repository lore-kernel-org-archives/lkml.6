Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D526C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D1C20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVqW6xN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D1C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbeLKTIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:08:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33028 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbeLKTIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:08:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so7081704pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOxMLNfKKQUiexQUX+5DNnxMLV+BE56lTOqnKa+Ttp0=;
        b=dVqW6xN1aQbjKGlg9cCxXBPhxR5rvh0zKsrAAIBSenrupr+CaGDam/KZqz157iSKx9
         +KuLHorDgraNxkyzbBDxPZ92ZljdIrYXg3fZ5FI4z1DMdu+DLrqx6uuVkJxL8xQocTkz
         qgASi0P6ZsUrn0kfXNCnMKdgjIZSZqsD/c63w4g7BSDzBzuHou9wkpUgVwt5u82fmcE6
         wpubodookszY4xMVATXizBTVaBCepWYOJbFMqbEbTQhWU6EHT5/6+l+57VxDZFVdXYC8
         F5d1ZM9+g2+nz6c86uuNC7gMdQpoJpYpA7nlgpv50WH9G3Ge5eUIuqnGIgiTleI/aPDk
         tmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOxMLNfKKQUiexQUX+5DNnxMLV+BE56lTOqnKa+Ttp0=;
        b=W/PDYOhay7E500ti+s9sonHp7X5BnrosRLaG8O+Iso8IPIHl551oRq9OxtZhzLq8xj
         FEkdZiQnx9a3Re/RrXwVZM67nn2WqmMw8xYgv20E5Pe5CC0K/4Rd1HRVJ6B3DI90emuF
         l+Gmrw9pOaXkhwM3uoy1XT4VQDIoIVOou8NCXp00H4gxumsN9ki+h6uYMDYrtNnCQ880
         205HPRK0uVRqu785kNH0iexdo04oHpdB5wqah3oh5wbRpPqoTPo+bFst2R19tyLcuhce
         oENMWfOnSI4L6sqnPIoNsnSzyuxWw6WBauBiQxeYrK9imwXyh7d8WmQBXxXTl1QWlZKT
         h6mg==
X-Gm-Message-State: AA+aEWaQgfGok4WfN6S1ZyPm+8F0VCyTpm+UzFauJo+0bUh1JPZdVBYz
        AAqQ4dn8OVv4o4tLKQDYzemiGlwTw0VbaPxRHSjfMA==
X-Google-Smtp-Source: AFSGD/WduYtQ0e7PffzJ7BztqChWGeFNlRprWmcU2wpjmtlwlblDehQjCHdb4mZCvabv40cmJvHAPCzoXjRIi3yqhHI=
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr16016455pgf.302.1544555322149;
 Tue, 11 Dec 2018 11:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20181206191231.192355-1-ndesaulniers@google.com>
 <tip-f4313ba52f9caccfda6a55f991c84aba6726b88f@git.kernel.org>
 <CAKwvOdmBNvpjiYDdP88c9TZHzqbf-GTcQqPdft+LgJXC+W26Dw@mail.gmail.com>
 <5480353.C3TqP6Wb6x@blindfold> <20181211174658.GN27375@zn.tnic>
 <CAKwvOdnkqbxTYudCWH+Q_nuGbpKp8w3_3zHpxe29nirKKPrpsQ@mail.gmail.com> <20181211180547.GG25994@zn.tnic>
In-Reply-To: <20181211180547.GG25994@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Dec 2018 11:08:30 -0800
Message-ID: <CAKwvOd=OY-qWqxK9gcacKChAEAPqFWyyBbgsQK6-h0zTYTcOgg@mail.gmail.com>
Subject: Re: [tip:x86/build] x86/um/vdso: Drop implicit common-page-size
 linker flag
To:     bp@suse.de, richard@nod.at
Cc:     bp@alien8.de, Masahiro Yamada <yamada.masahiro@socionext.com>,
        mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, hpa@zytor.com, jdike@addtoit.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:06 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Tue, Dec 11, 2018 at 09:53:49AM -0800, Nick Desaulniers wrote:
> > Indeed it was.  I'm forced to use Gmail's clients for this work
> > account and all that implies (no plain text responses when mobile).
>
> Can't you access it over imap?

Personal gmail account, yes. Corporate gmail, no, IIUC.  There was a
pretty big internal thread where all of our kernel contributors got
cut off one day and were scrambling to figure out how to send/review
patches as their workflows were interrupted.  Something is still not
configured right when I send patches (maintainers have merged patches
with my email address but no name, I assume from working with mbox
files).

We have some internal tool that's smtp based but does the two factor
authentication.

>
> > Maybe I can file a bug about this internally...
>
> FWIW, people have looked for ways to report such issues in the past...
>
> But in this particular case, DKIM is pretty good spam protection
> mechanism so enabling it is a good idea.

Internal Gmail developers were able to help me verify that SPF was
setup correctly, but indeed there's no DKIM.  This article has more
info: https://support.google.com/mail/answer/81126?hl=en.  Richard, I
don't know if that's a lot of work on your end, but other folks using
gmail might have the same issue repeatedly with receiving emails from
your domain otherwise.

-- 
Thanks,
~Nick Desaulniers
