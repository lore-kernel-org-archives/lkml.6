Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeBVV4O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:56:14 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:37913 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbeBVV4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:56:13 -0500
X-Google-Smtp-Source: AG47ELuKjQ+qsyuT6wx1NYPlrInJ28U3pncm+n+naB02aBYQoWbXtTB7cRheh/YFeqwZcm6wJWH/ARgBaZ2gAXpNAnU=
MIME-Version: 1.0
In-Reply-To: <21797175-11f5-d87e-bc3e-35ca3547627f@prevas.dk>
References: <20180222174140.GA3154@beast> <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
 <66556bf7-3e67-5793-081e-76a01f598374@prevas.dk> <21797175-11f5-d87e-bc3e-35ca3547627f@prevas.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2018 13:56:12 -0800
X-Google-Sender-Auth: kg-yk8RgUJKkzyPz-kIz2PexeHU
Message-ID: <CA+55aFz_ww8ohU68Jz34pg_x7gpGpJ+FC-dmS_Rm_VvY01GGpg@mail.gmail.com>
Subject: Re: [PATCH v3] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
        Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 1:34 PM, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Hm, we should probably make sure that kconfig.h is always on the
> dependency list in .o.cmd, but just exclude it from being processed for
> the CONFIG_ pattern.

That sounds sensible to me.

Not that this likely has ever bit anybody outside of this one case,
but when missing dependencies cause a missed re-compile, the resulting
bugs can be _really_ subtle.

           Linus
