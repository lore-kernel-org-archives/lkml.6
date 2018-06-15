Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34362C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D884D20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPfTsogB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D884D20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756277AbeFOQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:55:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40285 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755310AbeFOQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:55:21 -0400
Received: by mail-it0-f67.google.com with SMTP id 188-v6so3579105ita.5;
        Fri, 15 Jun 2018 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=llWdQfbg81SZfMzu6lFYXVcWDTvb7NKuzb2Z5HrFs/c=;
        b=HPfTsogBqkQ28tgNuzIXyToNTxYkPY392l3PmFPXPjF0/0y0hUDTinXNu49tbASWRo
         2s6ydJinvEGmlPgpjoZhrAyxe+qWFbeVJbpbRp93xZ202QiR11pdjngbXculcqB9ofrd
         VfEorDXRyBEzTj+kIzPQ85Socz0C/L4l9onyg6eeQEbiMsJrQIdn8/+EMG4DWqhR4wVa
         HCI7rA8iQJYzESQNF9qlw1VAd8fseo1pteqgJYfSp8VUe8Q+7jKOTsSjYIFXM/UxsFjo
         SngZ/OVu9DQAitjzUm0O5mDe32a5cCvo0TqPYqsTyjQxYVG6JJ8hTf9mXxM9DtHzi+74
         mX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=llWdQfbg81SZfMzu6lFYXVcWDTvb7NKuzb2Z5HrFs/c=;
        b=cuWHRtRNy+QRNlXK+/j2DvszA80WpaSmJQ4InXzTusCWy8+OLR+ROYUoAAe3wTd8iB
         WF5q6/U/iW9jf8g9rAQplztJBKhiXEdul41j3VtLxUaa+v9R3lhuXqr+Ta0yO+4pda9r
         2xcK69B1k19rJLj0YtFnBnW1pm2hjegXhFXynrTOKOFgtnOVUuD0IpRML292Ts2u2Bx5
         U0MiMMNPStp9Ik59zJl0/GasSqOU6S5SJT3gLt0S2Rj4z3LPudKuZ7FouaIu2IlEMkQA
         xv481ZCaxMmKGS9v6a2vgrfb+4a/LdWCTIVoe9Wl+v96WSDRUPRH7boihpnH79ogZ5fe
         DTcQ==
X-Gm-Message-State: APt69E02/UBT+EjYHcZIOUVwvQH7niwSOJ0CFaZciP/IH92GGyEvuNso
        ZYC6lKlF+bM5No7TuYXfEmsdDkuTVufpqOj+y3I=
X-Google-Smtp-Source: ADUXVKIVL1Ue+4FEbDyyQdzaUSG6MbmJGeQAbjToabvWfzHWgvg/SwngU01O0xOdhQtj7bmgQAkpam3x0m6Kg+z4c64=
X-Received: by 2002:a24:2f12:: with SMTP id j18-v6mr2007035itj.28.1529081720642;
 Fri, 15 Jun 2018 09:55:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:7b26:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 09:55:20
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1806122111400.1592@nanos.tec.linutronix.de>
References: <20171228152710.891701433@linutronix.de> <20171228153308.286787253@linutronix.de>
 <alpine.DEB.2.20.1712282315030.1899@nanos> <CADRPPNTK1x_47fnk4Tor5QSPk2DEuEwNUQQ4dGu1P3QkQDyZeQ@mail.gmail.com>
 <alpine.DEB.2.21.1806122111400.1592@nanos.tec.linutronix.de>
From:   Yang Li <pku.leo@gmail.com>
Date:   Fri, 15 Jun 2018 11:55:20 -0500
Message-ID: <CADRPPNQzy+v8wqGJj=yhTDT2gCWiSmbs=VTfin_mwby-wJoF7A@mail.gmail.com>
Subject: Re: [patch V5 01/11] Documentation: Add license-rules.rst to describe
 how to properly identify file licenses
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <rob.herring@linaro.org>,
        Jonas Oberg <jonas@fsfe.org>, Joe Perches <joe@perches.com>,
        linux-xfs@vger.kernel.org,
        Charlemagne Lasse <charlemagnelasse@gmail.com>,
        Carmen Bianca Bakker <carmenbianca@fsfe.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 2:27 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Yang,
>
> On Tue, 12 Jun 2018, Yang Li wrote:
>> On Thu, Dec 28, 2017 at 4:17 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Thu, 28 Dec 2017, Thomas Gleixner wrote:
>> >
>> > Sorry for the spam. I somehow missed to refresh the patch before generating
>> > the mbox. Find below the correct version of that one which has ALL braces
>> > removed which we don't need.
>
>> I'm not sure how we reached the conclusion that we should remove ALL
>> braces?  I cannot find related discussion in the archive except for
>> the "WITH" case.
>
> https://lkml.kernel.org/r/CAOFm3uEpM_tBErkOvqghcy+wbw0i4mSnafPBRC3HYZVQjsSyMw@mail.gmail.com

Thanks Thomas,  But this email is mostly discussing the "WITH" case as
I said, and it does mentioned that braces is (weakly) needed for other
cases.

>
>> This is conflicting with the current SPDX spec at
>> https://spdx.org/spdx-specification-21-web-version quoted below and
>> also the explenation in your own file.
>>
>> Quote from SPDX spec 2.1: More expressive composite license
>> expressions can be constructed using "OR", "AND", and "WITH" operators
>> similar to constructing mathematical expressions using arithmetic
>> operators. For the Tag:value format, any license expression that
>> consists of more than one license identifier and/or LicenseRef, should
>> be encapsulated by parentheses: "( )".
>
> This is not relevant here:
>
>    For the Tag:value format, .....
>
> The kernel does not generate SPDX files in Tag:value format. The kernel
> uses SPDX license identifiers to reflect the actual license of a file.

I'm not sure if I understood the Tag:value term correctly.  But it
looks like to me that the "SPDX-License-Identifier: <SPDX License
Expression>" is a tag:value in the SPDX spec.

"The tag should appear on its own line in the source file, generally
as part of a comment.

SPDX-License-Identifier: <SPDX License Expression>"


>
>> > +   A <SPDX License Expression> is either an SPDX short form license
>> > +   identifier found on the SPDX License List, or the combination of two
>> > +   SPDX short form license identifiers separated by "WITH" when a license
>> > +   exception applies. When multiple licenses apply, an expression consists
>> > +   of keywords "AND", "OR" separating sub-expressions and surrounded by
>> > +   "(", ")" .
>>
>> Conflicting with the example
>
> No, The keyword is 'separating sub-expressions'. It does not say license
> identifiers.

But the first sentense declared that an expression can just be a short
form license identifier.

And the examples provided in the spec also proves it:

"Examples:

SPDX-License-Identifier: (GPL-2.0 OR MIT)
SPDX-License-Identifier: (LGPL-2.1 AND BSD-2-CLAUSE)
SPDX-License-Identifier: (GPL-2.0+ WITH Bison-exception-2.2)"


>
> So these examples are completely compliant with the documentation:
>
>> > +      // SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>> > +      // SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note
>> > +      // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>
> Two license (exception) identifiers plus a operator. That's perfectly well
> defined.
>
>> > +      // SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT
>
> This is actually a case where you need parentheses and they separate the
> sub-expression 'ID with EXC'.
>
> Adding extra parentheses around any simple 'ID operator [ID|EXC]'
> expression is really overkill and does not make stuff more
> readable. Likewise in programming languages. Why would anyone write:
>
> C et al.:       a = (b || c);
> Pyhton:         a = (b and c)

I think I agree with you that not having parentheses in these cases
probably make more sense.  But I think we are having a conflict with
the spec now, probably we should update the SPDX spec to be aligned?
Actually a lot of the current SPDX tags in kernel tree are following
the spec to use the parentheses.  We should do something to avoid the
confusion in the future IMO.

Regards,
Leo
