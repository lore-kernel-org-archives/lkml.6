Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F71206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfAHOJ6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:09:58 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36748 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfAHOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:09:56 -0500
Received: by mail-vk1-f195.google.com with SMTP id 185so891969vkc.3;
        Tue, 08 Jan 2019 06:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lBYfDnPVXDNQRdMrfaAMpkN7j7FL3/qAK52ZkVu2fys=;
        b=tVmm6bJf8DBwx9JY3qav7scbPj9+lzcv6vcSnYrG9wmsX+alw0aoLlwsr33F8EU8Cl
         W8SXwBKeXe9HnHR3qPU5L1qyKyoY/zLqpgIIEKiSgjBMMIgsNUo/VajRBFNVOW7eay4e
         LBERWxvWrK66tvh2LQ7p7b/f5hI7dm4GBwlzr8AuGzF2YSr3PRo593aNcCZs+4M9OcM0
         iy4ThBw3N+Md0W1TVPu4hc+F2zdP7cqc9vxts0AQ7LuoAra6opiO5Vj+6IdbQbvOJGYx
         ki/vJp/WkeZ952ov4TSMqPhvYZ6VzOmkrHXArm5LXZjF+PjlcMBY8czNaC/k3dh9rRcp
         mgPw==
X-Gm-Message-State: AJcUukcOsDl15n3pw/3oXPKtu1SuOH9fejiuDqp6ELP4C1ieC4UudHE3
        C+tjiRePb+B6fqmrbRMD1gi4JN8pZ8v6SiS0+Zo=
X-Google-Smtp-Source: ALg8bN6qFRYPO2P1ipa2zYPbcOuFnt82aRPxIbNYPlHO+iRlp4rKCHN4pCHhWU67m2C6Fvyml09H4vGTRLlmS2DTITE=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr682873vkh.65.1546956595430;
 Tue, 08 Jan 2019 06:09:55 -0800 (PST)
MIME-Version: 1.0
References: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
 <CAMuHMdXPFgp5sLR5-UExEvxNbKSR5H--dk7KMit_XFSFN+1uHw@mail.gmail.com>
 <1996329d875e1ab5b9cd69db187b7037ad3a0d8d.camel@perches.com> <CAMuHMdW1OqswdSRj2DROFST46dLCmMU5=ki2x0FBn8OjJjgLdg@mail.gmail.com>
In-Reply-To: <CAMuHMdW1OqswdSRj2DROFST46dLCmMU5=ki2x0FBn8OjJjgLdg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Jan 2019 15:09:42 +0100
Message-ID: <CAMuHMdV9W4hDeVW2=jP0YN1vF1mjbr0-4nrcLWi=H1mR214EtQ@mail.gmail.com>
Subject: Re: [PATCH] Raise the minimum required gcc version to 4.6
To:     Joe Perches <joe@perches.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 3:25 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Aug 24, 2018 at 12:00 AM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2018-08-23 at 23:52 +0200, Geert Uytterhoeven wrote:
> > > Reverted locally (incl. the follow-up), applied Andrew's fix, detected new
> > > warnings in v4.18+, and sent patches where it makes sense...
> >
> > Thanks for that.
>
> Given the rise of anonymous unions all over the place, I gave up, and
> have upgraded from gcc 4.1.2 to 7.3.0 for cross-compiling m68k kernels.
> One good things is that the kernel size for an atari_defconfig kernel dropped
> by 3.7% or 163 KiB.
>
> For the record, below is a list of differences in generated warnings.
> Note that the source trees are not identical, as the tree used with
> gcc-7.3.0 did not include any workarounds I needed for gcc-4.1.2.
> All warnings flagged by gcc 4.1.2 should be false positives (iff I did a
> good job during the last few years ;-)
>
> I plan to repeat the exercise with gcc-8.2.0 (after v4.21-rc1 or so).

As promised, gcc-7.3.0 => gcc-8.2.0:

    *** ERRORS ***

    4 error regressions:
      + error: devfreq.c: undefined reference to `strcmp':  => .text+0x9c6)
      + error: ldm.c: undefined reference to `strcmp':  =>
.text+0x1900), .text+0x1964), .text+0x19a0), .text+0x193c)
      + error: proc.c: undefined reference to `strcmp':  =>
.text+0x18c), .text+0x178)
      + error: xattr.c: undefined reference to `strcmp':  =>
.text+0xbaa), .text+0xbf0), .text+0x2e8), .text+0x268), .text+0x97a),
.text+0x9be), .text+0x3d4)

Hmm, time to fix the auto-strncmp-to-strcmp-conversion for good...

    *** WARNINGS ***

    1 warning regressions:
      + drivers/dio/dio.c: warning: ‘strcpy’ writing 69 or more bytes
into a region of size 64 overflows the destination
[-Wstringop-overflow=]:  => 240:17

That's a nice one, it found a 15 year old bug. Patch sent ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
