Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BA62077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RP3ASxPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfBUXQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:16:30 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33779 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBUXQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:16:30 -0500
Received: by mail-vk1-f193.google.com with SMTP id l62so94447vkh.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 15:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOWBgOHj+0kj+OurkCxjDDUrLW9YXil6Aww2BJupKaY=;
        b=RP3ASxPSuvST0JzDeDt9dMtwN+Lws2lFjByIhKITFkVSD3Dm66Ka89DRIAg8DmNWnD
         LG/j+ULKhlwiKx13U6ZMXXE84oYbdT/UDzYNGS3wYb4U1OrSNLOOLNgZr2qCpdIoNdc5
         ZUOMLUjZm5H6zopH1D/Y7oS5Ec8NseggVLGus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOWBgOHj+0kj+OurkCxjDDUrLW9YXil6Aww2BJupKaY=;
        b=Lzd5khYLO6Woftz3g/Z98XmeEFb9XslDrNTTF5XfrUkpiDRqk1tQ6iutragzd7MYZM
         TYMc1Kk9ySWGDjTpKx6PbGUJIxOMu3xcSspLmU7CeYIx+FCtIcRV7fejzBK0T0WT2Xjb
         sGTHJWF4bwW0HrqeZ0u9qwh52+FT8Kk3O+OcwcrMjArJC3C1KrPy59V7RnbVvnum/PVL
         A1vgjKvg2PZ+biLsUnmD6LCghKyttOnyUBj7He/xykPTUYzsRFpZTizGaB2UmhmWI+IE
         iGbMN8N42bU57o5OzWu7flXVBkFSqcO+3B0PjBO9iczd6+zyjpfXfTT3rc6iIZDMjXcY
         5lMQ==
X-Gm-Message-State: AHQUAuaG9GWjMduHlNc6AhWl93E3OEtSuupHs1sT/7j/FXeTiFeHZfBB
        EWFdQa51y07W5+K0gJEgr1bCAj3sF5U=
X-Google-Smtp-Source: AHgI3IYzwlrRHIw3p2ae/FOjJHcQ8x54JrgR/p/Y7rqmC0Mo5/JuG7/34dhjz1LGf2xn3fCean8/uw==
X-Received: by 2002:a1f:f8b:: with SMTP id 133mr653440vkp.79.1550790988081;
        Thu, 21 Feb 2019 15:16:28 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id p80sm57099vkd.38.2019.02.21.15.16.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 15:16:27 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id l136so92418vke.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 15:16:26 -0800 (PST)
X-Received: by 2002:a1f:998d:: with SMTP id b135mr725001vke.44.1550790986458;
 Thu, 21 Feb 2019 15:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
 <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
 <20190221052435.GF11758@eros.localdomain> <CAGXu5j+Mf2D5LgkEmps7VVBhmNGt=49y4caP1y1E0OBURJEeXQ@mail.gmail.com>
 <20190222072652.2441e8a2@canb.auug.org.au>
In-Reply-To: <20190222072652.2441e8a2@canb.auug.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 15:16:14 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLbcqDJWvn1cES3OvWMvnd3OArFKLOJMqWc=youte5Haw@mail.gmail.com>
Message-ID: <CAGXu5jLbcqDJWvn1cES3OvWMvnd3OArFKLOJMqWc=youte5Haw@mail.gmail.com>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jann Horn <jannh@google.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:27 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Kees,
>
> On Wed, 20 Feb 2019 22:02:32 -0800 Kees Cook <keescook@chromium.org> wrote:
> >
> > What I can't quite figure out yet is how to find a way for sfr to flag
> > newly added users of strcpy, strncpy, and strlcpy. We might need to
> > bring back __deprecated, but hide it behind a W=linux-next flag or
> > something crazy. Stephen, in your builds you're already injecting
> > -Wimplicit-fallthrough: do you do W=1 or anything like that? If not, I
> > think we need some W= setting for your linux-next builds that generate
> > the maintainer-nag warnings...
>
> I just have a set of compiler flags that my build scripts explicitly
> enable by setting KCFLAGS.

Okay, so you could include some -D option to enable it. I'll see if I
can cook something up.

-- 
Kees Cook
