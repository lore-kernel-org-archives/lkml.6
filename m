Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA987C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9919F20666
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cemDmHwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9919F20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeI3RuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:50:21 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:44653 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbeI3RuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:50:21 -0400
Received: by mail-qt1-f171.google.com with SMTP id c56-v6so6266881qtd.11;
        Sun, 30 Sep 2018 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJmq3ECnKPvq4Xp2mc62/SjlViC0OuENvyYYz20zMaQ=;
        b=cemDmHwqmyNs10hnm1fimLrE/iI/0e9H75XCrann6aU6TPI7tGaFpjwFcxiCseZyl+
         ShnPX6G04sJwVqrB9LDoC8T13HZrqD8MEMOuyhCkg1XHODX5K1tDKtMyph7LoMy+CkDv
         K6VS5XwjRbpSI3xPZvYZGbXyMemKuIMjMF3BvlviPH1tM5we5CfixhDY3olm1DAz3LzK
         zDNH3RFdOp1y5WdbyOU9lW260F3mXbbUObbsaO/N75CwbQhT13k2fn8d7X+PVgZ9o4Iv
         sIOXm7Fx0reCqzvgySWzm1e37qaUM7yumjHmrPITIARi77CFYLFLaoGnlTWU/ZMFPJyV
         SsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJmq3ECnKPvq4Xp2mc62/SjlViC0OuENvyYYz20zMaQ=;
        b=eWxcp1MWmW5afLPECMwWRkIzgRR+fWe+RXuRh2sHtXSRaeK5WTHByiNPnkwag2lutz
         JxOFya5ME+QG7F9AYdmNPowps7fWr/YFEV2Nge/RvrX2gTzRivPQAVLdnF0OExvSTjlE
         XzhzuJoXMdZZnREFE2hBKBAh8xRfMbVTbpFSY/tS8NTC3MiQKJZnrj4Fivj/bfvjD+Ii
         9Sct7LTpHQaGeGSXbfkDnPqAVGZDiPSMm8kvLphtDaKZde3tyFSZuO//AvafbDMIDQVT
         VsaIidQCEVSnSmkN1nvuIrEPykd4vwJQ8ZlkHezSXMNblsY47AdJQhUqVSuXR+KOpaPm
         GFJw==
X-Gm-Message-State: ABuFfohKEHif2BSumZKS1UuBGKjFCrEzVk9LiFKlu3jx677s0Sgmhjkg
        NU6tYsX90QCvhFTuqHpQOR9523UlBLRNFlmV5WY=
X-Google-Smtp-Source: ACcGV60Lagfu4j2GSBGJzg/SM1QJwJXMHlxJL+BRoUuvfv0Pdy0/HjuQn1JeL8F/xgoQHo6XKnG+Mr6PYsZyule0pmc=
X-Received: by 2002:ac8:34ce:: with SMTP id x14-v6mr4958762qtb.115.1538306264155;
 Sun, 30 Sep 2018 04:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
 <20180920172301.21868-14-miguel.ojeda.sandonis@gmail.com> <CAGXu5jKZYEK7Asy4KwtfVVxHLFbpeqpWWEOM-60h7h4gj3JZrw@mail.gmail.com>
In-Reply-To: <CAGXu5jKZYEK7Asy4KwtfVVxHLFbpeqpWWEOM-60h7h4gj3JZrw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 30 Sep 2018 13:17:33 +0200
Message-ID: <CANiq72nvZZAF445cBTiLCX-4EOLD6OsRo0TP8eXgwvBAzakgOA@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] Compiler Attributes: enable -Wstringop-truncation
 on W=1 (gcc >= 8)
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
        Jonathan Corbet <corbet@lwn.net>, "Ted Ts'o" <tytso@mit.edu>,
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

On Thu, Sep 20, 2018 at 9:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> Yessss. :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Done! Thanks! :)

Cheers,
Miguel
