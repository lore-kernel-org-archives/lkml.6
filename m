Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE930208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8FaLeGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE930208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeHXBcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:32:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37983 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeHXBcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:32:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so3504176pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+h27LPcprQocjCXzwyehDLIiBbICE6D4+EJSkkbqYI=;
        b=A8FaLeGD7Ilpv0znAMTpGbu9k4120VJWcthSvn7G45K0T95Ae9JWS3LgQ+Ly2MSEaU
         h5kvr1c1WhwVDeDRoJe3IXLbTlusPkP7q9smcbL5Fq+97T6eJ/wpL0eHR3ab/gJpDKYB
         uZ/E4KLzY4NzAQzqracuCDI6R7NeJwniNYxT2emrW8GXwyUI5T3sRp8IZKQEHXfs/iWo
         /V67toxPBEQpJtZtUKsnNyfXGOOI8Una81JlQEyZYYrHb51gz+IDErR6pdAwKkR+11Sm
         IJU4vweq+UTxfOxd5gSBH6umjHZ151hkiaRDV/RZ9BrwtMLjP+09yrFLnl7zWMrXfyaK
         lTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+h27LPcprQocjCXzwyehDLIiBbICE6D4+EJSkkbqYI=;
        b=g8Ytdb5TTm2t4GzBlWNXdrq1MK22JEfKcnbSUeMtQqSCfNIKGzc3voD91uyjYHN8pU
         5MK3zH/0so8IJddVzfuUuJ+xK72PgcMoF0n2EydZaxuPg3+DU7/LQ/SBTKBP1oWd6GX2
         4SNK0cDxlBAmhNQBYi8w18eX72d3Yd3I2ZxbfejC6uFnJU5Wp4LXBnsc0SDTKuw/tCU6
         wQXnfau+OMki7rtmJij9sEFgzjNnrJcjFELT6xr5Q+BBhQAKim+Vf/1rqaaY52tAv/uB
         A2VkaHhiKAypRRSiJ8vMo5NN9LDdUCHBTyBsjkyGoC/1mHSg6G3+0nziQGe34+3vZ2JT
         SynQ==
X-Gm-Message-State: APzg51DHOVM/jDKopvcC7GvycxnVFyqCjWe0so/tDk68Pa8CJHxgcB4r
        HbI1Q5qwiSs0QZ4qR1rc0co3ZLLJNNnitI7Id/rt3Q==
X-Google-Smtp-Source: ANB0VdbBBrcPU92m0/2YFJP9IZVM79GoT+En0U2vHWphYka12obobzno6e6iMmrxdIHoP85PeHbg3zQyo7GCVzwunQw=
X-Received: by 2002:a62:4b14:: with SMTP id y20-v6mr12042075pfa.93.1535061626767;
 Thu, 23 Aug 2018 15:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
 <CAMuHMdXPFgp5sLR5-UExEvxNbKSR5H--dk7KMit_XFSFN+1uHw@mail.gmail.com>
In-Reply-To: <CAMuHMdXPFgp5sLR5-UExEvxNbKSR5H--dk7KMit_XFSFN+1uHw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Aug 2018 15:00:15 -0700
Message-ID: <CAKwvOdnNRfK+HiyjSv+OaK-wo5ExcFBc=nK-PMSEXiD0bu_11g@mail.gmail.com>
Subject: Re: [PATCH] Raise the minimum required gcc version to 4.6
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     joe@perches.com, Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, efault@gmx.de,
        Guenter Roeck <linux@roeck-us.net>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 2:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Thanks for your patch!
>
> I'm willing to upgrade. But there's one thing that's holding me back.
>
> Does gcc 8.x gives again the same warnings as my venerable old gcc 4.1.2,
> that no one else seems to see? Or will the real bugs I detect this way stay
> unfixed? Polyculture is a good thing, also in compilers.

Hi Geert,
Just for folks who may be missing context on this thread, like myself,
can you provide links to more information?  If I understand your
question correctly, it seems that warnings were removed from gcc since
4.1.2?  And that bugs have been caught by testing with gcc 4.1.2 (can
you provide commit sha's)?  I assume you've already discussed such an
issue with the gcc maintainers (can you provide links to those
discussions)?  Sorry, if this has already been discussed already on
LKML, but even a post that had all this information would be immensely
helpful in understanding your plight.

-- 
Thanks,
~Nick Desaulniers
