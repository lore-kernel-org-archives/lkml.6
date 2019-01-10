Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB102C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72072075C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKhAzcTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAJAUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:20:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40110 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfAJAUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:20:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so4434589pfo.7;
        Wed, 09 Jan 2019 16:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZuaEJlWJAsmA6Yme6jr3Jz0UyrN0atFAVMh8hCLaKU=;
        b=QKhAzcTfUUa5nVLayD9NAzCyjYMjV/2zfSSkXiPCSMl//5LNJDTa/os5KvIUIHn5ni
         4pRu86X80h/ewLbwSmpmojTXXu3OAF0BcaYcMSRsHPf4E4P7u13jTLfbfZXMk/OIppL+
         l49OuuVBtV9wNJF8aIMNUEYtdOELmF8wpRXPiRAnQo1Nfa5tlRgzDHa27abU1jIS/iob
         lcOmtF8+fn5/eEr/uJlQMN2WLvqQwvjbbrMSMf7FZgfM2SDG5KqSZ4Qhi8OBPL845Aeq
         p7Xf5B4uPpjewnKXqBxDsnE8tYtKavmUxBIotkcQIJi8izgj8ps8IIIYDVQL8XtbesBQ
         brXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZuaEJlWJAsmA6Yme6jr3Jz0UyrN0atFAVMh8hCLaKU=;
        b=lipvQokF4FMfmDYVoCsPHL5SXYz83XX7FKC5tMebRzAeBebqeyaGq41Vsq/5VteujY
         AoZBifAIOPcFefgTJMLHWNoHnhDrMRp/GHen7UWUzpwGW2t071MQBX2pLI3RJwhKmCdD
         PcgbVc5zFLWkJFOUJTbkEbaktZOyqFe2j1O7QEMHcPeEPK/T+/lNG0ttAuP0AAAu2MEs
         bradytAkW7i1we1Y6YCc/nJ9pBgQcyZyUB9GQ3sIdUupytC7MywIldayKFIGgtWKWP2M
         2raUyU0oaw6GPT8QphBMwo0JrzwupU6Ivi70DB9LRwVJIbakeEaV9kqR5C3R2VmcKIO1
         PXyA==
X-Gm-Message-State: AJcUuke5zcCNzoR9y7ZQUz11JRIVfU43HULrKq33qW2Mn/tXdxudm0Hv
        ER06BBpcOJQ4RnL+0rh8BW7MYJT32APd4zu0BEQ=
X-Google-Smtp-Source: ALg8bN4PyWJiNbt1hK/ZjK3m7jSpv5W88y+q8p9bCvpAjIy6IfH+EVFzk3kWbTGD1VWMLiwFUnNQhrCQC5Uj207QdOg=
X-Received: by 2002:a63:f615:: with SMTP id m21mr7518086pgh.428.1547079605352;
 Wed, 09 Jan 2019 16:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20190109154022.23551-1-andriy.shevchenko@linux.intel.com> <20190109100414.4de13e06ecbdeb89cb8c4e40@linux-foundation.org>
In-Reply-To: <20190109100414.4de13e06ecbdeb89cb8c4e40@linux-foundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jan 2019 02:19:53 +0200
Message-ID: <CAHp75VfZq7NhDX8c9EGa_4v-5nApiqF5RLbw49HO--H6h-YWnQ@mail.gmail.com>
Subject: Re: [PATCH v1] seq_file: convert mangle_path() to use string_escape_str()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 8:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed,  9 Jan 2019 17:40:22 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > Since string_escape_str() does not support overlapping buffer first we check if
> > there is enough room in the buffer and then update a path. The side effect of
> > this change is in case of failure the buffer is left unchanged.

> >  char *mangle_path(char *s, const char *p, const char *esc)
> >  {

> > +     size_t len = p + strlen(p) - s;
> > +     int ret;
> > +
> > +     ret = string_escape_str(p, NULL, 0, ESCAPE_OCTAL, esc);
> > +     if (ret < len)
> > +             return s + string_escape_str(p, s, len, ESCAPE_OCTAL, esc);
> > +
> >       return NULL;
> >  }

> Confusing.
>
> I think the objective of the patch is to use an existing library
> function rather than open-coding, but the library function doesn't
> support in-place operation on the string.  So the old mangle_path() was
> OK with in-place conversion, but the new mangle_path() is not.  Is that
> correct?

As long as source buffer wouldn't be changed during conversion. Here
the same technique is used as in kasprintf(), i.e. first iteration we
would like to check if the buffer has enough size for the output, on
second do actual conversion.

Probably I need to add some test cases.

>  Do we know that all existing mangle_path() callers are OK
> with this?  Please make all this clear in the changelog.
>
> Also, the identifier `ret' is widely understood to mean "the value
> which this function will return", but that is not the case here.
> Please use a more appropriate identifier.

The meaning of it is a destination length. I will rename it.

-- 
With Best Regards,
Andy Shevchenko
