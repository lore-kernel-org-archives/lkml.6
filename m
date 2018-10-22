Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264B9C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CF120890
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVW7nwuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CF120890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeJVTZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:25:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45245 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeJVTZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:25:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id c24-v6so3549763lfi.12;
        Mon, 22 Oct 2018 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Gada67H4Jd9QGAjDfvKygVjXwikJjIDttAG0aOjuMc=;
        b=SVW7nwuvV8faSuwXjHgcAg+cbaAg4qvM1m7dbNdvvgy1li6ZjEdVgSPdx6ABuysHfP
         Cnv+++CXEocixzUMTe46/i18vQIoxrBbmM4p3dut+cnKmAagVS8kzaSuGxTkhQygpmso
         PFQ2EiwBR2M406LA5gQkI9A8RcLklhT30dxiMa9lachwdXR2bhffKBKe0DFHby3pNe5m
         cwnV2yqyqFqc7Tg4jHXosQMVfmTFnJJCZKYBt88CloeItI18k0VtLxiQRCj78OzWRcFm
         zDkOXbf98Telv/rTfBccPnXtElVkIjvY7li7TIY6TeABpYjDEA86wvgJL/JYEyJp1Ppg
         SIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Gada67H4Jd9QGAjDfvKygVjXwikJjIDttAG0aOjuMc=;
        b=iENM+/9QbgXCCvH7QPvR3W3vhPPmv9xRBud19EcwdH1OXd7gQejFXKgZgpps0wNWyw
         sFws8UizYQBdOzk/kogWUpxzrPtsIBGFht57Lph0EpdevH6TN2mNcjjxjGPW4anqEwcl
         Ca61FLfuoOaWfT2W8/Yl7QzJ4KIJ203+7mhkJXKmpgDQIu5jBk5cGvaWD9jngaRtjSdV
         +NJ40OtxDPZTrJ9Q7Wy0KYCpttLrJbbWqU4MHG/d4rNc/ldXRu3lXoaSVOXxv78bKT4v
         WHpk+Ha5Crmp+8yjyJGduZnXEQBoWaUSLc6Wr/fvYrL3MPVJvdawmoGFhQ8674pmtwDt
         NACQ==
X-Gm-Message-State: ABuFfoijOyyqtx2k5iK7YJrMbXH9FASPVGdRKS5zPQIW6HPxIvFbTdGX
        UydKjLtqCzeA/oMDTxLl5HO4Wr1NywIo8++sISQ=
X-Google-Smtp-Source: ACcGV61fXU5RtZ3OmDnAFx+yerN8EXm+MQxt1ThZXxVvCKh+9RvYNbXG9kVbVQm87xstmVrBFmym7xL/8RAsqP+acFU=
X-Received: by 2002:a19:185b:: with SMTP id o88mr9856918lfi.102.1540206465562;
 Mon, 22 Oct 2018 04:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <8fb78062-b6d4-6f2d-d943-44bec6b95ff0@petrovitsch.priv.at>
 <20181022102743.nua5fgbscyeymzal@mwanda> <1474d995-1b5a-2efb-f077-33eb4a5d9e31@petrovitsch.priv.at>
 <20181022105314.j6djkrpwbnokhai5@mwanda>
In-Reply-To: <20181022105314.j6djkrpwbnokhai5@mwanda>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 13:07:34 +0200
Message-ID: <CANiq72=ioYcRA-yq38+Z4i6iVDNm6C2-+b4feRmnvEiekuR7dA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Dan <dan.carpenter@oracle.com>
Cc:     bernd@petrovitsch.priv.at, "Ted Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 12:54 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Doing both is super ugly.  Let's just do comments until Eclipse gets
> updated.
>
> I had wanted to move to the attribute because that would simplify things
> in Smatch but it's not a huge deal to delay for another year.

I can re-send them later on, no problem. On the other hand, doing the
changes will push tools to get updated sooner ;-)

If tools were doing something as fancy as comment parsing for
diagnostics, they should have been updated with the attribute support
(either gcc's or C++17's) -- it has been more than a year now since
gcc 7.1 and the C++17 final draft. (Note that this does not apply for
things like clang, since they weren't doing comment parsing to begin
with.)

Cheers,
Miguel
