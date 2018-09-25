Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D35C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF372083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF372083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeIZCot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:44:49 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37510 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeIZCot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:44:49 -0400
Received: by mail-yw1-f65.google.com with SMTP id y14-v6so2650490ywa.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4LNEw9xk8jgE+E6KryL6ayu2cGY+8w2WQHCiD2tA47U=;
        b=TKtV2410alv4Xt89eB1Zu+2ZWLrw+HZuqQGfgt1i9KIcPz1BnohXqiaWZ8mNedaf1v
         9Wj3Qpd5Z7/JoJZZJrdXIbcuU+9RYy5YQuCrfsq/+iz5U43FnDKOV9pbClp0Hq0pT4AT
         /XNEhF3P3enB9XiAZidau0dDGK2ERlUwY5P0tZdNG0rRu6UETdLofBUtC6/FBYrnchGF
         hO2b1zfvw/pc3aEixqF3tNCHJXLtEIX6XJaQhfGRStTHsSWnkzcDCayxPJUu7vJuf6bj
         4/kmWriJk6m5bthrNk71aAFh4NELEnKsG6xdcBgyLndtDvp4Mh60mIWY2AjHVLMWlY2v
         LtyA==
X-Gm-Message-State: ABuFfoiNLyNZEI12OmlGebLik8VCuWDcGfUCqQdmXvSNP2HeIfj1WUnW
        If6LmFNW+p30oGouLHJJQHE=
X-Google-Smtp-Source: ACcGV63mvly5wvRx/Msql9kbjKQvW1XVDDIrQBdcflRfyOAFeJUO5ifY9XsNDdvIet9B40i6Myyiqg==
X-Received: by 2002:a81:5213:: with SMTP id g19-v6mr1521107ywb.53.1537907729548;
        Tue, 25 Sep 2018 13:35:29 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:9734])
        by smtp.gmail.com with ESMTPSA id r126-v6sm1277452ywb.92.2018.09.25.13.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:35:28 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:35:27 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, tj@kernel.org,
        Christoph Lameter <cl@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, psodagud@codeaurora.org
Subject: Re: [PATCH] arm64: percpu: Initialize ret in the default case
Message-ID: <20180925203527.GB61443@dennisz-mbp.dhcp.thefacebook.com>
References: <20180925194459.13088-1-natechancellor@gmail.com>
 <CAKwvOdnzN0E0HD--3GmC9b=20fx3AE-8-x0iZ04-LEXnxh=YoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnzN0E0HD--3GmC9b=20fx3AE-8-x0iZ04-LEXnxh=YoQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Sep 25, 2018 at 01:24:06PM -0700, Nick Desaulniers wrote:
> On Tue, Sep 25, 2018 at 12:45 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns that if the default case is taken, ret will be
> > uninitialized.
> >
> > ./arch/arm64/include/asm/percpu.h:196:2: warning: variable 'ret' is used
> > uninitialized whenever switch default is taken
> > [-Wsometimes-uninitialized]
> >         default:
> >         ^~~~~~~
> > ./arch/arm64/include/asm/percpu.h:200:9: note: uninitialized use occurs
> > here
> >         return ret;
> >                ^~~
> > ./arch/arm64/include/asm/percpu.h:157:19: note: initialize the variable
> > 'ret' to silence this warning
> >         unsigned long ret, loop;
> >                          ^
> >                           = 0
> >
> > This warning appears several times while building the erofs filesystem.
> > While it's not strictly wrong, the BUILD_BUG will prevent this from
> > becoming a true problem. Initialize ret to 0 in the default case right
> > before the BUILD_BUG to silence all of these warnings.
> 
> Clang does semantic analysis BEFORE inlining/optimizations, so I can't
> determine that default is never reachable.  Nathan, thanks for this
> patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 

Thanks for the explanation!
Dennis
