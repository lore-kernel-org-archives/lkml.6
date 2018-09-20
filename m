Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9C5ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896F621529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKV3aPr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896F621529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbeITSB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:01:59 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:45464 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbeITSB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:01:58 -0400
Received: by mail-qt0-f182.google.com with SMTP id l2-v6so3055804qtr.12;
        Thu, 20 Sep 2018 05:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OlL9K9hZoSF9Q3fiI6DYCgMaSJxliM/tCILT1RClCik=;
        b=dKV3aPr95D6vObchkrJnJmo1SFA3I7KqTD5JaJsVQL+Sdja9Qk/ItGqZckMUVOYRSk
         zMcWQLbvxHxyEsQ0Ip2GkErbcqbA0/n90eBueVnf8NwpDpfe+qpQOj6VgELlLJiTt6tP
         jotNcVoQLjY//loX/1wbrhtosCSOVzlYumD9K8jbchOfK43kRGvzFn4JI50zBBHOpxIP
         4WB4qWM/7M1X9P9CWY/7txKE3Q3ohUE4gBUOVDaL7rIOHVqTNWFZtgYFUYfL8i2W7FgT
         PEWs0pEyAByePym7BADMvCjJgspJqN4r/DcKJ9VKP2hEzdeqPBCzVJK8s/xXpgFAmsX+
         DrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OlL9K9hZoSF9Q3fiI6DYCgMaSJxliM/tCILT1RClCik=;
        b=kspFKMUADrvyPMvatda9yWjfg1l6qGELKGFTywMZXxwgGiz8oecdgazuNGHdpzR5Ss
         hnZl6vVn95ixmaVwIhUd49xWBs/BwI9r+XFhHX82I5L0fxN0cOHxsfyBSZipRuCVAxuI
         mvUdlOiF94VqCneaygbH2M8ha6VeKk1gHHjCNyLzROGxp+nohrrtd43WP9N4Zo+d3Jsq
         6O9clT1AdTY6UE2CXvrEWfVRAMi1ky3nhCVwu4pBacGNXmAD1SSgjB2Qi7kToOsGK2z7
         UT7CdJ+oGA5IkAcV3BgfHaE2jf6cOKEs/UYnD8pyiWoqbU4FYQ/XKuOToCvdPPpE5KmE
         wQUw==
X-Gm-Message-State: APzg51BSPvgwdOeUo/1nNcy3T6+MlX2cloynTYRqs1zqLuoM33PBOmuc
        kElA+N2Qzr4QJG7jllzkoQ0v2Rs9+4nuGVidfF0=
X-Google-Smtp-Source: ANB0VdYspyxwoEclTVK+yM+MeWkjZzWPvfZDXoVPcN+7+l1w3e6fMkioNFWKgxp2g4Dixw18+hIKjshqEhTSTJVVhcA=
X-Received: by 2002:a0c:abca:: with SMTP id k10-v6mr27477364qvb.140.1537445925140;
 Thu, 20 Sep 2018 05:18:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 05:18:24
 -0700 (PDT)
In-Reply-To: <20180920072205.GC11963@kroah.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com> <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com> <20180919230504.GA20280@nautica>
 <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
 <20180920001024.GD20280@nautica> <20180920072205.GC11963@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Sep 2018 14:18:24 +0200
Message-ID: <CANiq72nkQBYnDM2QLKJvAaMJ6iCB=oXg1UZRbpXbf732f1OyZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
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
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 9:22 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> For this instance, I think we should just revert the offending patch,
> which should resolve the issue for everyone and then you can try to redo
> your series to get it right the next time.
>
> Sound good?

On one hand, "reverting & retrying" is a good default policy. On the
other hand, we are already in -rc4 (i.e. we lose the testing done
until now --- note that in this case the revert implies a global
change). So whatever makes you guys feel more comfortable.

Cheers,
Miguel
