Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED685C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A094C205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rODn+uu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A094C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeJWBph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:45:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39523 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbeJWBpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:45:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so20250541pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uc26wvlO9uSCh/ATf1Fj7RkrCzIc/n2/k3zGe3rfx9c=;
        b=rODn+uu0x8ErLKdAmBMax1j2cquvLGThv4G//Sn3m6CrzKGGbDmSZSnyJQPBZHhZC6
         ofPYu2wVC/3BSPrkFqhKkWhrS3YTVNfCVKzLWJhs1zTZnrmaXciKVAGs2iiQwkX4jinl
         JpcZe4sq74nYqFFCYE/BN7jlCDXkpjq3Qk9CqtHEiU9WPuTZ8BFDZltyDJdLXVuNefUg
         KRZ4YAq+8v1EA2pdUBB/mXFruR8CaJNJW7HHqQANxOkdDrmwUe7pMPN8QbmPbFkRMOjB
         J1QlTB52H4JKkSyOUd271vOOXTUhohpe1yuaMHN8GPF/LaDieY2UDQCICKtbYrjKtbdy
         ob/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uc26wvlO9uSCh/ATf1Fj7RkrCzIc/n2/k3zGe3rfx9c=;
        b=M9Rprwp337b9jo92v2qBvTutQ3i95rJH0SJKjMuw7bxMCyFjwPgGyw8dGoiUgV4yAs
         Tx37U58Pr+6vEdnl5P5aNbkNHIE/fpWkB2B03gE5Ubw6zLjOCkwwtjXQpVSqMYjurpqP
         B1waD9S/yMNmpGuvMy5RTb5/yW1YSgnMXF9kbrnN8LMJUp4FjmSf6BCuXihNx6H9CKag
         h5GTO4oBbn8x8OHNAI/l0V2FCULqo5UFElnJ8e+w4EgvuQTvrBqx3AfXT5nfzhFS0TAC
         a7U7H1CAhjxOKtGZthlSAsVOmAjDR0biEq107dWDWm2QE8Gp7p8YCVKo1UDQYQBCHHvO
         6dUw==
X-Gm-Message-State: ABuFfojW236amRwxvZ2hzbIotPTjIdHe2OZ8RViIdR6RVrY2wYRCY9um
        b18dsdzhL0Yn2+C/m1dYS1gbaPO2rEVSr7fOK9LjvQ==
X-Google-Smtp-Source: ACcGV62lMMOculE+zgthQroeJnnOF0GSCCDi9qvyBZuSdAYwaVTPQdG7UBsZaKhJKo0OGF4HZM7uO/6Hv/b+QRctnMs=
X-Received: by 2002:aa7:88c2:: with SMTP id p2-v6mr38874608pfo.32.1540229172220;
 Mon, 22 Oct 2018 10:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <8fb78062-b6d4-6f2d-d943-44bec6b95ff0@petrovitsch.priv.at>
 <20181022102743.nua5fgbscyeymzal@mwanda> <1474d995-1b5a-2efb-f077-33eb4a5d9e31@petrovitsch.priv.at>
 <20181022105314.j6djkrpwbnokhai5@mwanda>
In-Reply-To: <20181022105314.j6djkrpwbnokhai5@mwanda>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Oct 2018 10:26:00 -0700
Message-ID: <CAKwvOd=SUTqfASs-_5--GYFx79bETMcjCzBacw5ujMsxGwU5SQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     dan.carpenter@oracle.com
Cc:     bernd@petrovitsch.priv.at, "Theodore Ts'o" <tytso@mit.edu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, adilger.kernel@dilger.ca,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org,
        mchehab+samsung@kernel.org, olof@lxom.net,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        sandipan@linux.vnet.ibm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        paul.burton@mips.com, David Rientjes <rientjes@google.com>,
        Willy Tarreau <w@1wt.eu>, msebor@gmail.com, sparse@chrisli.org,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, joe@perches.com,
        Arnd Bergmann <arnd@arndb.de>, asmadeus@codewreck.org,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 3:54 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Oct 22, 2018 at 12:45:03PM +0200, Bernd Petrovitsch wrote:
> > It's more like
> > ----  snip  ----
> >       case 3:
> >               frob();
> >               __fall_through;
> >               /* no break - fall through */
> >       case 4:
> > ----  snip  ----
> > as "eclipse" doesn't accept anything else.
> >
> > And yes, it's far from "beautiful" but I hadn't time to dig into
> > eclipses innards to fix that.
> >
>
> Doing both is super ugly.  Let's just do comments until Eclipse gets
> updated.

Eclipse as in the IDE?
https://bugs.eclipse.org/bugs/

>
> I had wanted to move to the attribute because that would simplify things
> in Smatch but it's not a huge deal to delay for another year.
>
> regards,
> dan carpenter
>


-- 
Thanks,
~Nick Desaulniers
