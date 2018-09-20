Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8FFECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BA121526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thC0HCPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BA121526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbeITV4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:56:03 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37829 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeITV4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:56:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id c13-v6so5107717qkm.4;
        Thu, 20 Sep 2018 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=py9yTrq3BSJHxQrk8hTMkN6Xeb9hokKh0CJVlUR5eM8=;
        b=thC0HCPaWCqYP8ZMJGOxJSYZVuiRl7FkEqESuxXWkEMEbuzEzlI12bKZ1Ccec3tXf9
         V7CuUhCfg8ZUXuguKaC3PiWf92q3TEIBKlYQRmHWSXxbMW/8BdaalVhKwYB3csA99oAA
         EnDiWQxxUVlFSm1DOMqCMQuF32mV0oFzaKR/0MJCqKdesoXo+/ODyOeWNPMQOsrTzGWq
         x3Eb3wYg3xg8GHgwkyVz7YaL3fcpDewrJZcPsoVMXPM6tpXhJixQ5+ml+iwUeJfTgUrs
         3uE1BHcYsdWGI0Wsh3qIDZF8Xkf4bdkGeoxKEEwhJUUOIC1ALB/VO36UjaXVb09+7P7E
         pkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=py9yTrq3BSJHxQrk8hTMkN6Xeb9hokKh0CJVlUR5eM8=;
        b=twDB17N9/F/STdBRJG3vcaO98sO/zn/S9srlFyRTpRj22/XOml5yckV9h0Ji7oyU+9
         L2hxA666pHzlKGhw6SfiwmiiRKi3p3KpKobsyLtIckFCo1QapMxDTcg9S99epm3n+KfU
         KpwB3c8dtkaT16gENukmxf0jSu+EXkgy4Mp74kIZdNpZyS8y8WE1gaM7C3I39+FY6PjD
         lDDwPKHzltlLQhrBSjcrf4WUEqVmF/7XlflJrWJidO/iZ2VReRRtHepQ0q+Q48xKUMXk
         36//zSOeOOku4DVqkcvMHMYi/X2NE/LjK+2nGpZpyUgh9lhzYGLJ+FIreNL/1n9CEyiU
         RlEg==
X-Gm-Message-State: APzg51BJvJpraR+nZwD7cwiggv7pnDFi8pJRZzYcXL7l0D5sgOKloUPs
        T1oTPIA9mehqWgtt1WqWevQ/k7BwzeVG114sf8g=
X-Google-Smtp-Source: ANB0VdYvgoJc5j9oNOx+YBb2SNZMYM1/RwdgPB/ikD1WltZN4qyXF0hL7824RauHQy6DoJwMGMOqYdunKWCpL6OYBHQ=
X-Received: by 2002:ae9:c218:: with SMTP id j24-v6mr3526480qkg.129.1537459911135;
 Thu, 20 Sep 2018 09:11:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 09:11:30
 -0700 (PDT)
In-Reply-To: <20180920073650.GA6001@nautica>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com> <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com> <20180919230504.GA20280@nautica>
 <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
 <20180920001024.GD20280@nautica> <20180920072205.GC11963@kroah.com> <20180920073650.GA6001@nautica>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Sep 2018 18:11:30 +0200
Message-ID: <CANiq72mB3O-bogor8hAeST4yexXFyYswfTXpaAyqE+KWRC=kVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 9:36 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Greg Kroah-Hartman wrote on Thu, Sep 20, 2018:
>> Why not just route these through Andrew?  He takes lots of stuff like
>> this for this very reason.
>
> That works for me (although it might have helped if Andrew had been in
> Cc at any point in this discussion...), but part of the discussion was

Cc'ing him (and Luc too) now. I have put a bigger list of Cc people
for v5 (and will simply Cc everyone for all patches).

> about seriously maintaining these files, and Miguel stepped up to help
> with that so it could make sense to have his own tree.
>
>
> Frankly, after this whole episode I'd find quite helpful if "compiler
> stuff" (or headers maintainance in general) were to grow its own mailing
> list and start being considered like a proper component of the kernel.

Yeah, the compiler headers have seen quite some changes in the last ~3
years compared to the time before so it might be a good idea:

  https://ojeda.io/uploads/compiler-headers-file-size.png

>> It does impact quite a few people, and it's neigh-impossible to review
> this stuff as things are right now with a hand-picked list of CCs, no
> matter how large it is -- I don't mind if it goes in -next through its
> own branch or through Andrew, but a proper place where folks interested
> in these could subscribe and test/review the patches would be awesome.
>

I guess compiler folks would like that too.

Cheers,
Miguel
