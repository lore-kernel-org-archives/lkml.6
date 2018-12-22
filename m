Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB58C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2550C2192C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BE9SJPFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392913AbeLVXCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:02:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41826 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeLVXCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:02:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so6281372lfj.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 15:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8p9D2+dDghiBPcrfdEl1NXbNHpsU9NOEXgNZSrUgEY=;
        b=BE9SJPFKvRqgmcUUBtNRClUWsCGpu+KcLlxYkstriAQx9QeNsJCzpoh9mlC7+ChkOD
         ZzGEYoq9rZNfMCH4H3uNMg8z222fg2yFQ8pCpdRkogjWA6aZlKd0O4N+1oEn5GzWNG2y
         zmFgFyFpQ5pZMbc/wJ1Hn6Ao8RbhnsDSLErMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8p9D2+dDghiBPcrfdEl1NXbNHpsU9NOEXgNZSrUgEY=;
        b=pX4OjNAFr9XfaNYY4uwp4blYegTpqu5zO+yAeBgiB1cNOPzq+ycAMJv/Pt3xLk2L67
         /i1aRDkQL4MacNECofCFlTMO5zsy5Tzp0kQhfkld4kamJXH+RxU4Lbkl7hpH5jdWi5mc
         KKBHChGxfGTSJYp7xhmkHsvrMl2/nDNOfF9SyDL2mokHEYViQpGQvSGYA4yEh6pTyK+5
         dHWxTDS/TRAElRjPV7nRMoMaP56naNNqj7nJp1Seviyj6XQFl3Oa60PreU7p5TEqyaqS
         6mcp6mIig8AzJ/8XU7COz+kDfOlOMMBTjkvQiJ/IlvwureDzdFT58CBJsb0fyd3hSDIV
         jTKw==
X-Gm-Message-State: AA+aEWZaZB0NrVw6WrgMnKvbnW7ucowvi+PU4IhqZiFniaJQDitDI26i
        L8yDEhf3v2iuQfXCP2BRv1gFJvm/7Rs=
X-Google-Smtp-Source: AFSGD/VuHl8fKFoGwoD1KNdd0YXlLZt60znDhXtiyiTnxconDnh+1SZPTw0HbbvY4D1xBchPyRr1/g==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr3944895lfk.151.1545519732911;
        Sat, 22 Dec 2018 15:02:12 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q3sm5574077lff.42.2018.12.22.15.02.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 15:02:12 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id g11-v6so7795763ljk.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 15:02:11 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr4981776lji.133.1545519731667;
 Sat, 22 Dec 2018 15:02:11 -0800 (PST)
MIME-Version: 1.0
References: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
 <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com>
 <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com> <CAPP7u0Vo6gB86S-hZcOW9Rmki8oKHd=Lyx3x-N9gjPC4JP_YxQ@mail.gmail.com>
In-Reply-To: <CAPP7u0Vo6gB86S-hZcOW9Rmki8oKHd=Lyx3x-N9gjPC4JP_YxQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Dec 2018 15:01:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg-6jYZ=bJWdyBR=n8QOfwHTZZdzSUUPgFW+NGCV-pe2g@mail.gmail.com>
Message-ID: <CAHk-=wg-6jYZ=bJWdyBR=n8QOfwHTZZdzSUUPgFW+NGCV-pe2g@mail.gmail.com>
Subject: Re: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on
 userns mounts, breaking systemd-nspawn
To:     christian.brauner@canonical.com
Cc:     nix.or.die@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        ellierevves@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, seth.forshee@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 2:49 PM Christian Brauner
<christian.brauner@canonical.com> wrote:
>
> To be fair, no one apart from me was pointing out that it actually
> breaks people including systemd folks
> even though I was bringing it up with them. I even tried to fix all of
> userspace after this got NACKED

Seriously, the "we don't break user space" is the #1 rule in the
kernel, and people should _know_ it's the #1 rule.

If somebody ignores that rule, it needs to be escalated to me.
Immediately. Because I need to know.

I need to know so that I can override the bogus NAK, and so that we
can fix the breakage ASAP. The absolute last thing we need is some
other user space then starting to rely on the new behavior, which just
compounds the problem and makes it a *much* bigger problem.

But I also need to know so that I can then make sure I know not to
trust the person who broke rule #1.

This is not some odd corner case for the kernel. This is literally the
rule we have lived with for *decades*.

So please escalate to me whenever you feel a kernel developer doesn't
follow the first rule. Because the code that broke things *will* be
reverted (*).

                    Linus

(*) Yes, there are exceptions. We have had situations where some
interface was simply just a huge security issue or had some other
fundamental issue. And we've had cases where the breakage was just so
old that it was no longer fixable. So even rule #1 can sometimes have
things that hold it back. But it is *very* rare. Certainly nothing
like this.
