Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53FEC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3072C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/prikuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3072C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeJWBN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:13:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40579 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJWBN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:13:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id o14-v6so3580503pgv.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8cmPZrGRMo0J2wzmUeELFcmTDZd1pKGdJMqmndjEdk=;
        b=S/prikufPsgp7CDFHp1vLGIE6cWbzKY72J5VsSAGg9njlpBWqaaEsmAc9f5Kx+yYiW
         +BSmD/MrgyF8OqHNYasXNYHVmhn0h+p/t8PmT0dp5CiNvZxlBB9zZRZD2k9RDRgtl+1Q
         BiLXmdeEXHSZRzFTikEwQQENcNM3jGzfn43HAAXnbdyjKaHy3oL7ONg5vwBnMPqvKnR6
         A47C0hbYMxLB1YKCr9k9jQk+TIGXsqOJXkvBuEOigQ6jVgl0fEKo7zDVRzAzQRuTQoix
         +6GAdn4INGy690qfYyL4p5Q1lowRFkaGVNtKtXkH2eBpf8bd95idK7WEXz3iZXecR5G1
         XtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8cmPZrGRMo0J2wzmUeELFcmTDZd1pKGdJMqmndjEdk=;
        b=G0Zf4cjlX7yoh6kTh3NlgVoLeCvJGB5D4oS5tRmu+n/3xKz53nDptGhs3XM36M0zY0
         IHISpNHSEpwHGQuptRbvjUCCxCjhooiT2Bapum1BLExUGuSJbUhWEBJF8Qa/NVDDhFIp
         +ccARS8cNgyLBHzddvIs9kAcBmu/CmAfiSvL6O/pGU54Ewd//kM4UEdmKwGrB4qE248M
         D6tAJ0lhYqwFQ5UbcFeYrbk6E1SvYx1L4JwX2IDc5hByPlAhKJZDP8luK6ngONGbyKQ/
         XBaqEQytnI0re3cKDrLp/L4dpZvQv/3EFgjAiJetXkEiOdfEiuixfRkrZRr0EVzCaQkj
         U2PA==
X-Gm-Message-State: ABuFfojGSHgH3v8XAGHEwd+YC6efQ54wcH35gogNghIkNsHDwKab37Iu
        ZNNsKpUgkr6F72UL4TfSxt5vHKpyyyCOAwHexXYbQA5u
X-Google-Smtp-Source: ACcGV62mr4xbVj7AWWPJoHqbyMeulVaGWZvjfq30075bzQV8GRmS2j7gedlEtHaTUXAW1EBM3QfwstmQ1+Bk8z3F9hM=
X-Received: by 2002:a62:4b09:: with SMTP id y9-v6mr46361227pfa.93.1540227279339;
 Mon, 22 Oct 2018 09:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021182926.GB6683@kroah.com> <CANiq72kOE0a4M0oCmmiWO9xTFJsybEirwUyb_ZTXpJJhc7O_TA@mail.gmail.com>
In-Reply-To: <CANiq72kOE0a4M0oCmmiWO9xTFJsybEirwUyb_ZTXpJJhc7O_TA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Oct 2018 09:54:27 -0700
Message-ID: <CAKwvOdn9hOcF01eOmwfnrH_ciFZ4fPaspSzMPiY68o3B0En-VQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Compiler Attributes: __fallthrough
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@oracle.com,
        adilger.kernel@dilger.ca,
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
        "Theodore Ts'o" <tytso@mit.edu>,
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

On Mon, Oct 22, 2018 at 2:48 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Oct 21, 2018 at 8:29 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Will this work with all of the static tools that are currently looking
> > for the comment instead?  I know coverity handles that, what about
> > others?
>
> I will also contact the different tools about this.

Let's contact the authors of these tools if they don't parse the
attribute.  I prefer to have the attributes rather than specifically
formatted comments.

I do think this may be tricky to provide backwards support for though;
Miguel, do you have info on which versions of GCC support comments vs
attribute?
-- 
Thanks,
~Nick Desaulniers
