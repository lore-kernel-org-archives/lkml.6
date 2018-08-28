Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4249C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBDB2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9irWPQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBDB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeH2Cfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:35:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37242 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeH2Cfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:35:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so1329899pfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ve6eCWQoQNtveQ/B7CGs09jEgAiSKiGYUlvzQeDDHy8=;
        b=t9irWPQWqiG6cF60o6APGSAX5dhGrdBBcNkd+HynNIXdGjfv+2hK8HfLelpllqtX7I
         0kwEZQzu8krBLRJOBUG8eGqH8/XTmxU75GMHzPmMGoZeRvJuEdXGlNaRgVacj5q70b+6
         /QEVbRjgGwYl8jc+jczE1cHl1hbZ06D2ftmKS+Mu4mxgPXmhfdxtPr4/3kS2xAr4tVD9
         MRZcGxy6ETNXn2CDSpVJBGSH/+7rEx+FBLk12g+5/fr8TVLtYODrLrOS2OLQCiwWIs+z
         0apIh8svilTHWy/+4+Dr4wmFZxK5iXWBjMeCtorG9q3TyCLpA9iYGJuQJ0tWTcXojq9n
         DhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ve6eCWQoQNtveQ/B7CGs09jEgAiSKiGYUlvzQeDDHy8=;
        b=CEX5+yBn/dqyyPNOjnNGsh7N8Gsn/y8JBC6pIvacydx3TIRXrlOJitpWOXNRiz6TX9
         hEEprI8dsADlI2ZWkXbBR6/wJUqbnJmsezekjWrj+pqMwVwfniU63BbhwTSOpB/LWBKP
         ZPh/xbZuE3XTRlpQCJF6LEyix13oRsWcOGmAGU9ZkWo3y6ny4wnF/ud9CHJF7RLTM8z1
         4EzcHI95qFDSxJWn3K0c5NK+3xbKFRUTWmBbJoTk5iPtTfoxpqZdEWd/Wx35JBY+J6Sb
         5Ec2xwIa3xxTORvEwghEb7vaJVs4KTKypPxES0oAv6JQPVTop+WdTRC2gJ7akf5EJYip
         83vg==
X-Gm-Message-State: APzg51ASqLjljlt5hTuPr2oZoJlxxs8Mz6yqb/OZ2WPrbxCVvxDxdXTd
        nfT9SoJuh6rf7Kz6kOAOUmH+4lKLlI/ePe5QNVHJHA==
X-Google-Smtp-Source: ANB0Vdbbr4vYEk4YGkwETxYh0JGEAWuUCxsysaPheefMQgYwj+r3EdUt6UmpVLY7N5eFmmfnN66zkw6ila9ak8aswg4=
X-Received: by 2002:a63:c245:: with SMTP id l5-v6mr3305662pgg.255.1535496126911;
 Tue, 28 Aug 2018 15:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180827214011.55428-1-ndesaulniers@google.com>
 <20180828051300.GB2107@kroah.com> <5c949906-ae9d-2848-d5d0-f402aed4b9f3@suse.com>
 <20180828124329.GB14243@kroah.com>
In-Reply-To: <20180828124329.GB14243@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 28 Aug 2018 15:41:55 -0700
Message-ID: <CAKwvOd=P40t4u4PoMj4spKYXiTNJyJ2BS6OfMHLtrn6t1_K1ww@mail.gmail.com>
Subject: Re: [PATCH] x86/irqflags: mark native_restore_fl extern inline
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jgross@suse.com, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, stable@vger.kernel.org, hpa@zytor.com,
        x86@kernel.org, boris.ostrovsky@oracle.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 5:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 28, 2018 at 08:02:37AM +0200, Juergen Gross wrote:
> > On 28/08/18 07:13, Greg Kroah-Hartman wrote:
> > > On Mon, Aug 27, 2018 at 02:40:09PM -0700, Nick Desaulniers wrote:
> > >> Fixes commit 208cbb325589 ("x86/irqflags: Provide a declaration for
> > >> native_save_fl")
> > >>
> > >> This should have been marked extern inline in order to pick up the out
> > >> of line definition in arch/x86/kernel/irqflags.S.
> > >>
> > >> Cc: stable@vger.kernel.org # 4.18, 4.14, 4.9, 4.4
> > >> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > >> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > >> ---
> > >>  arch/x86/include/asm/irqflags.h | 3 ++-
> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> > >> index c14f2a74b2be..15450a675031 100644
> > >> --- a/arch/x86/include/asm/irqflags.h
> > >> +++ b/arch/x86/include/asm/irqflags.h
> > >> @@ -33,7 +33,8 @@ extern inline unsigned long native_save_fl(void)
> > >>    return flags;
> > >>  }
> > >>
> > >> -static inline void native_restore_fl(unsigned long flags)
> > >> +extern inline void native_restore_fl(unsigned long flags);
> > >> +extern inline void native_restore_fl(unsigned long flags)
> > >
> > > This looks odd to me, but my coffee hasn't kicked in yet this morning.
> > > Why do you need both lines here?  Shouldn't the actual function be
> > > sufficient?  If not, a comment explaining this would be nice.

That's a valid concern.  I did hesitate while writing the commit
message whether to describe that part or not.  The reason to include
the seemingly-additional-declaration was to prevent another case of
commit 208cbb325589 ("x86/irqflags: Provide a declaration for
native_save_fl").  It doesn't hurt to provide more info in the commit
message, so next time I'll prefer to explain more in my commit
messages than less.

Thanks Juergen and Greg for reviewing the patch.

-- 
Thanks,
~Nick Desaulniers
