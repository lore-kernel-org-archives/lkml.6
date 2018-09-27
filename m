Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6A0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CFD216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/INWqYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CFD216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeI1FDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:03:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37509 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeI1FDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:03:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id x26-v6so2890727pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lLEi+m7iTYand9+DA/CRXb4bxxLn/neQsM8Qpm26J0=;
        b=k/INWqYmnr/j7hkASBl82dUqvlmDjcMO0x4udkiV0kIgsz+HGl72LiFzkwF+8LDroD
         FR/vRIKTPv46gC6Ew6uLGb6aqTpS70eLx6lgHzY3UFQwzxgqC0845YRsgONtCzaS9jqb
         P/pqiWvdSiDWkUhEeOlM0Cy3RyDpvb8qXwNTeBnNRmaDRW0K+Bp6+uVmIzBsJufi+/Il
         2Yh0Y/SJafDUY2jwQRKSiD2lTHBjm8J1/P1w5GzNqwjmAuWYEt2besjlva9xOODIHWuS
         YBbbSJHwfjwxhiOSeWeSawfARjX2YAEWySpC9SrBrsWqAEDN5ZHNpOzTV137zX8CQWkC
         oUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lLEi+m7iTYand9+DA/CRXb4bxxLn/neQsM8Qpm26J0=;
        b=VkqxvpjSNusM6TiBHTRmGWGRsEoaYbLQ1IQuomYqsNyL4zGwB8D60MZC3d7rD6IATk
         4z53zyofrJj6hux6m+yshhN2h/5lan42fBEykU8BFehqMGGNzCCmi7R9c6yaNDK337Sx
         xvYa/MRI5xr+5ZidfCuci1ezk7CGlCQnAyi2peALyzVseZdXvJtFSgg1JWdBTd/ITNxC
         7bke/oPIdVkc2q7TsRsFHpjGJ1YcNvDQ1ohkzu0QaDoMQHtWfha0rjjz0+FEGn34pDvt
         /23eLDDCYTR+3r0/B+Df4gBiUrS0gkRdXah20MyCHxIui9cDLiAjFDyIvkbJAC2dGelL
         U+kA==
X-Gm-Message-State: ABuFfogQH3I8M/ooni6Yv0EmwI/ioV0SYYAych2PCy6cn3Oa0ooqkVTM
        IpEo3dkqpyL7MtLps8kUZnaXUHkFzC24wPtK1moT3Q==
X-Google-Smtp-Source: ACcGV62Hy+lHk/yC+v2y7gM8zUVu+fws2I4+mj5sx9KBEBxrItMXUvU8LmFFYkccHRpK6SwBcDTshhD5jGDw0wJkOks=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr12502331pgl.302.1538088155842;
 Thu, 27 Sep 2018 15:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
 <20180924222737.GA26973@flashbox> <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
 <20180925023722.GA32600@ziepe.ca> <20180927010803.GA7640@flashbox>
 <20180927044826.GC24889@ziepe.ca> <CAKwvOdnmg2XY6K-8jTna3EKR1Nx04gOm6ZoywUwQO_CSANR_jg@mail.gmail.com>
 <20180927202849.GA11120@flashbox> <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
 <20180927222821.GC28301@ziepe.ca> <1538087622.226558.8.camel@acm.org>
In-Reply-To: <1538087622.226558.8.camel@acm.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 15:42:24 -0700
Message-ID: <CAKwvOd=qNZsfSFJUFZqBbSYt4T_T7TudohzhTqpigvDAHek78A@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
To:     bvanassche@acm.org
Cc:     jgg@ziepe.ca, Nathan Chancellor <natechancellor@gmail.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 3:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Thu, 2018-09-27 at 16:28 -0600, Jason Gunthorpe wrote:
> > On Thu, Sep 27, 2018 at 01:34:16PM -0700, Nick Desaulniers wrote:
> >
> > > > Neither ib_qp_create_flags nor mlx4_ib_qp_flags have negative values, is
> > > > signedness necessary?
> > >
> > > enums are by default restricted to the range of ints.
> >
> > That's not quite right, the compiler sizes the enum to be able to fit
> > the largest value contained within, today that is int, but if we added
> > 1<<31, then it would become larger.
>
> Hi Jason,
>
> Are you perhaps confusing C and C++? For C++, an enumeration whose underlying
> type is not fixed, the underlying type is an integral type that can represent
> all the enumerator values defined in the enumeration. For C however I think
> that enumeration values are restricted to what fits in an int.
>
> Bart.
>

To quote the sacred texts (ANSIIISO9899-1990):

6.5.2.2 Enumeration specifiers
The expression that defines the value of an enumeration constant shall
be an integral constant
expression that has a value representable as an int.
-- 
Thanks,
~Nick Desaulniers
