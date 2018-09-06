Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A400C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D557206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAaynUjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D557206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeIGDqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:46:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44122 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeIGDqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:46:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so13023046wro.11;
        Thu, 06 Sep 2018 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dl23JlZFX2N7Sk84NoMV3OPQFJEMkQOyjltXomwmaAk=;
        b=YAaynUjvKkyQfly30qkqyo2Dy1pfAavEQdQJi/KbXzv7XP/vd4xGwfeeBTdcG0e3gj
         5df9MhwkzL2NlkCDOXl2kp5PSHoJdgjS0WKmpwmgAukGR3R6JxfDaHBH7vci/dj7y8R2
         fCfFo2RkWSp1t53mHNkBQ6e4W2AtwGQxyv4ZCSMDjlVb98zKjNQUKvy7zAOqqBmdiVeT
         28z6c9T0068WL+Ik7O5SqO/aIKruRhnHbTHzsoBjIftXznPyhCPzF/srLxzSv/2Lagb5
         GY36rGiFjaxWp5dWee4MbZB835UOmJl9PmSjvn49+5F+iCfDeaq5vMEOIduC9jB54OpM
         9hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dl23JlZFX2N7Sk84NoMV3OPQFJEMkQOyjltXomwmaAk=;
        b=SMDxJBbKBF4A2o+lfr60DG67d2NARqshCNiPwAfmaq4YOKKE/Ca3v+LcueX+IrSkal
         M/qLzZVyhDbWpxRrt2FzyKu2BBJuhr8owcM/V5ssUxDmsQXN4IMNlhxsJqawrfm9hRO5
         KiZixrVcd6RmAKOFOO+yKzgYIf5DyhAfuQyiw7dwglrFcuP2WZstMeVckGmYD8mGBOXA
         jAk1a1b/kXzVrk9zSnVBtIx3Jt5mQ9H+T0PdeijIenPdmEsupUvPhbEj0fmy+NE7mbcV
         yfQ4JPPfJ1S8bmWLlP1MVUfEPBGZbkuQGliuXCBmdm5WEq+7ZaoC8qZwOd6E30tlXajZ
         BSSA==
X-Gm-Message-State: APzg51C5qdlvBdqvU7cRaOeR9hlY/VYC+i5RIiV29254vgibqbZV9ZON
        RqLJbrbPS57rSQw7SLVudYE=
X-Google-Smtp-Source: ANB0VdaFcNuNjPMgJNkhu9lpH7K05NCamFNd8soqY05+Vk7vbCcBPqhiko5L41dp8BfFKZqtJygciQ==
X-Received: by 2002:adf:de85:: with SMTP id w5-v6mr4419021wrl.270.1536275342271;
        Thu, 06 Sep 2018 16:09:02 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:f830:4b56:d713:5075])
        by smtp.gmail.com with ESMTPSA id z21-v6sm3939460wmi.29.2018.09.06.16.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 16:09:01 -0700 (PDT)
Date:   Fri, 7 Sep 2018 01:08:59 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>, eugenis@google.com,
        Lee.Smith@arm.com,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob.Bramley@arm.com, Ruben.Ayrapetyan@arm.com,
        cpandya@codeaurora.org
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
Message-ID: <20180906230858.psedqdai3dw2cvvl@ltop.local>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
 <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 02:16:19PM -0700, Linus Torvalds wrote:
> On Thu, Sep 6, 2018 at 2:13 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So for example:
> >
> > >  static inline compat_uptr_t ptr_to_compat(void __user *uptr)
> > >  {
> > > -       return (u32)(unsigned long)uptr;
> > > +       return (u32)(__force unsigned long)uptr;
> > >  }
> >
> > this actually looks correct.
> 
> Side note: I do think that while the above is correct, the rest of the
> patch shows that we might be better off simply not havign the warning
> for address space changes at all for the "cast a pointer to an integer
> type" case.
> 
> When you cast to a non-pointer type, the address space issue simply
> doesn't exist at all, so the warning makes less sense.
> 
> It's really just he "pointer to one address space" being cast to
> "pointer to another address space" that should really warn, and that
> might need that "__force" thing.
> 
> Hmm? So maybe a sparse change is better for most of that patch.

Unless I'm misunderstanding something, I don't think there is
anything to change for this specific point. Sparse don't warn
(by default) on "cast from pointer with address space to integer",
as it always been the case, I think. I think it's the good choice.

It's just that recently, I've added a new flag -Wcast-from-as [1],
defaulting to 'no', specifically to *detect* these cast because of
these tagged pointers.

Note: I tend to think more and more that __force is simply too
      strong and weaker form, like __force_as and __force_bitwise
      would be more appropriate.


-- Luc Van Oostenryck

[1] d96da358c ("stricter warning for explicit cast to ulong")
