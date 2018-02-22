Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeBVURH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:17:07 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:36313 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeBVURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:17:06 -0500
X-Google-Smtp-Source: AG47ELvRRbKlZwZJsqG/tKJfdpeNBAmJvhWBBJMtSKJyWNR3W2BvoLOdg6vVl6tVcvB1YD9lD80tqkQKzDKhKc5JnJ4=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJZh+LJYULPO=xqwz9ADm8Z3k+mKKnHXQYD2KWtwfxqbg@mail.gmail.com>
References: <20180222174140.GA3154@beast> <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
 <CAGXu5jJZh+LJYULPO=xqwz9ADm8Z3k+mKKnHXQYD2KWtwfxqbg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2018 12:17:05 -0800
X-Google-Sender-Auth: nXAkBS2-SMaAlSkCgPIa6E4Dj-g
Message-ID: <CA+55aFzrNCsJr=Ca19oZcCEg+tR+TZNN2wkr94PyzWd5w9PT7w@mail.gmail.com>
Subject: Re: [PATCH v3] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Kees Cook <keescook@chromium.org>
Cc: Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 11:57 AM, Kees Cook <keescook@chromium.org> wrote:
>
> Hmm. But does that mean deps for kconfig.h are broken too? That seems
> silly. I'll take a look...

Yes, kconfig.h itself shares the same problem, but it has generally
been just about the config option testing itself, so you'd normally
never care.

I'm not saying that fixing that too would be wrong, I'm just saying
that linux/compiler_types.h tends to have way more subtle stuff in it,
and get changed in ways that are not directly related to the config
options that we track other ways (ie our dependency making script very
much is all about those config options).

              Linus
