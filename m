Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D0DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FBA208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgG76QHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FBA208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbeGLPVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:21:10 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38210 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbeGLPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:21:10 -0400
Received: by mail-lf0-f66.google.com with SMTP id a4-v6so24553876lff.5;
        Thu, 12 Jul 2018 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gBJLHm43nmxR0fb5MnbyEfA4qtmlrJntl9eWUpdy+Xs=;
        b=WgG76QHNNRaKV+0jm7mvK5Iy7ghEJWDi0aqvnGeHbx2BmSu5Nit9N1ZvzZ03xpDjHy
         TSk9q4zwAl5l6Pm9Gd4XqtM/rEwbooMr9nxluZT4RtJ+4yXHGKAwriGG/ylAh4YhDQA+
         RIkYPq0lSGOm8V1FxDIlPEFkzUbXgDUsQA9DaW00xv4JMjvrKyhRUTx46GjypOqWoJ4d
         C9yVKpXNZC0XGTssG9CMbp9ThWh3ie8OT26LKF/sSlVpjb4yA+Ppe5wIjJFm9wNyei48
         eBevILGNMvr2INFdcrQmxgntRaxKuaAYvu4dSm4pAbEhfLgyZQH3ynqSPfuZAPSMrVD2
         k7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gBJLHm43nmxR0fb5MnbyEfA4qtmlrJntl9eWUpdy+Xs=;
        b=uRQ0r4N/q8TdWG9s3efu/frxOhP5Fu6QkyB8ENk+kgzwnZ6tWcIdkPV/ILx3iYFdXx
         aER2diFgtWVijrkxHboQtrm54m67b9LVa8C5LPta5M0h+DRfuVMFSGaHYybLa36z/tnk
         v43OttDaWg1N+VuKUh4AC0OihIOR0RkgIegSM3YPmAthq4ZcDHKgIf3ZF4VN947TrsPh
         eQ7ioUFuUQAIRHLmv0ydtUiogiuT8YxsrSZkG4QMxFWcHDcn6ZhuTwYZV0Noww346UT6
         bHryI/bDoz3cnay8bvBzzBHxROhJ3yDSlXFGCNDiTgXWvd8Q9qNw++gUbJc7E0DKccm6
         Eonw==
X-Gm-Message-State: AOUpUlFBA/b97BLCNH0QBYHpWEonnlbI/yG+4EtBcCecaGel2aLJV429
        7AyZoUwonCb1uu6HqYs5NbqtWu1FvgVqW4j0fjE=
X-Google-Smtp-Source: AAOMgpcJTcXbNzNgEY7oq6QDksvx/tbelQ6DOkwJKmB6RSOfJQG5PPnXdSBvoV7T+9qKI/u5kN0dlaSrDuS8P+LoTys=
X-Received: by 2002:a19:a705:: with SMTP id q5-v6mr2327141lfe.148.1531408269849;
 Thu, 12 Jul 2018 08:11:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 08:11:09
 -0700 (PDT)
In-Reply-To: <20180711203619.1020-14-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-14-keescook@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Jul 2018 17:11:09 +0200
X-Google-Sender-Auth: LpGsEEoSFAYl13IewekLrvCe6Co
Message-ID: <CAK8P3a1k+cy9wAVNQMWE4tdA4aV8tiu6K3haLc+kMPt0iiUQ9Q@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] rxrpc: Prepare to remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:36 PM, Kees Cook <keescook@chromium.org> wrote:
> Two uses of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
> (when less than 2048) once the VLA is no longer hidden from the check:
>
> net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>
> This bumps the affected objects by 20% to silence the warnings while
> still providing coverage is anything grows even more.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

(adding David Howells to cc)

I don't think these are in a fast path, it should be possible to just use
skcipher_alloc_req() instead of SKCIPHER_REQUEST_ON_STACK() here.
From what I can tell, neither of the two are called in atomic context, so
you should be able to use a GFP_KERNEL allocation.

      Arnd
