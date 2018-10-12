Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6F0C67879
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871B32064E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2FUTOBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871B32064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJMAj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:39:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeJMAj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:39:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id v133-v6so6130174pgb.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+uYe5JtXUXHeB9Dhce/DF3JebhJRFmtQIPeP5zgdEU=;
        b=F2FUTOBLjRyIeCtztc9CRPMhYFABQ65+hsaW3juhrG4jRzglqnOKhjBL1oHvF63ULl
         SCL8tpo0LLthdlgtLmK++wgY42ltN/r1eJIJPmuUicNiKKkrCg2u81qsFv+e/jiYxZBe
         r3i4wOVQE2rQfnHQVcRrqbyzp/p8ExG+XvAuG/J1XVnOH3ahm992/N+rflGQtvtpPPHG
         S7aLBTHOF4kpbIRzglZ6eFw6AAyaY9iKBSYQmLadxj3XcVpShLg0x8gxPl37Rsw3LZXR
         LdMoJI6qTmemQHBx1iPxK0O/6Q1hFJyPkV1QhF0Uji+wc/kVyJhh8J4VcZKXWIYEElhJ
         6qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+uYe5JtXUXHeB9Dhce/DF3JebhJRFmtQIPeP5zgdEU=;
        b=a0Rh7+WusHuiLCGA69+NjZKyQUa+pkoG0A1eEWtZSfXGmwLXcA+JBJ1qk8ed72ULjo
         nJ9LbqRMh03ZHhZaU1IdPDROLqtTpQe9U5/uVosNDmp8hgEIbT+HQY5wGJBhatNgaUfI
         2oQqvjlZqdz9+yIqp7rbPZIZUFynwfKI15KWAW9jLWYJNh97MBdyrj8+nBFDeE/SdO+L
         JCeIgBgbUmX0LkJb3/cOnquOSVyBBLl3RhX+Oxl/hAptqN7oMaKEMuXxW6igpV9GyNVR
         RJKnwTseuNRAJBb5JsLCnvT7Kefpl/5dK50979LTkTkZ7Zvl8n/FLEy62uUoastyd1QZ
         jHIw==
X-Gm-Message-State: ABuFfoh7Z+uTT/HD+v0Fatiq8KPgBvQxGV9pw8GaGPFlKLzPU0uEjckh
        WyZLz/kfPDipBwLyXKR9MnyC08R3mgHjcBz1pC4hZw==
X-Google-Smtp-Source: ACcGV63zLk5gJw3X+I85ltyY/ebixCCNUy9mvklRRFgijyvHthqMLeuRqxjyzfPD1srrppRREpgZRileXfrtnR/k64Y=
X-Received: by 2002:a63:9e02:: with SMTP id s2-v6mr6379313pgd.302.1539363959493;
 Fri, 12 Oct 2018 10:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com> <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
In-Reply-To: <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Oct 2018 10:05:48 -0700
Message-ID: <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To:     denkenz@gmail.com
Cc:     jejb@linux.ibm.com, dhowells@redhat.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 8:14 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi James,
>
> >> So can't we simply use 'bool' or uint32 as the type for h3 instead
> >> of re-ordering everything
> >
> > The problem is the standard is ambiguious.  The only thing that's
> > guaranteed to work for all time is a char *.  If you want to keep the
> > order, what I'd suggest is inserting a dummy pointer argument which is
> > always expected to be NULL between the h3 and the varargs.
>
> So maybe I'm misunderstanding something, but the issue seems to be that
> unsigned char is promoted to 'unsigned char *' by Clang and probably
> unsigned int or int by gcc.

No. This is extremely well defined behavior in C.  In C, integral
types are NEVER promoted to pointer to integer types, only to larger
integral types through rules more complicated than the correct flags
to pass to `tar`.
https://xkcd.com/1168/

>
> So instead of having unsigned char h3, can't we simply have bool h3 or
> unsigned int h3?

int is the default argument promotion. Proposed:
https://github.com/ClangBuiltLinux/linux/issues/41#issuecomment-428365339

>
> Regards,
> -Denis
>


-- 
Thanks,
~Nick Desaulniers
