Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F5BC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD2921470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdUbXrOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD2921470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJMCNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:13:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37085 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeJMCNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:13:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so6238516pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lK1p+yKCg807ip8R1qJBOm8Q080zyC38JR2CGpeqQw=;
        b=RdUbXrOOFiufwf5+6cWV+QGczne5bL1DWXSfXGMK8Bnjp5qJmp44NLNbNsXzDrYvY5
         mytnD+v6dKP6IO/jTkWZD2nIGVrGhRi0gTQ2HWFrjVO62CqN7LNW5Ck46HkIzYb/nrM1
         xlVnpbvYPkVr0I3CkElGR9OkV7iM8E7QgYMsQvqyttGERgKOPaUJ7kg3xTCX8cCtA20S
         yaxMfvczTxLnj8JoPb3nZHPYq75OmOkHEkSAKdRkiPjNbmMKssB2JhaA5bUKzX4R6e/U
         /OFuNorwSbWF51B8VsaHJZY4q2CeRc89tZePXbp3YBWA1pBQxzVA6jV2rfeiXyom7MEv
         0aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lK1p+yKCg807ip8R1qJBOm8Q080zyC38JR2CGpeqQw=;
        b=jWUyRdm0fJQjrvsDOK7nz4ATC79ysciYexL3EQRJLQ+3kxDEemskTlUvz4PFMMhlmz
         rrzvj+8bggVN6eDbs0kWBKX6cdD6wca/wZeHvtGYZRNRDM7mjO4fmO6ADpq8iXiZMlg6
         oaovPBA+UBhpI4+eSaBhujC6R3uBFvWurEP2SpP2OhDzg3pZex3HFtKwO8rGadhxBh+O
         7/Yf4RoEPz/RK55l1AuV5DHnuWQRTouXouKNqeD5SDb7JZZV25fAyEGfSVaVBLDwtFwA
         nalkKgceYp2k08Qa3+oqozhwCW3Cv6YsF+HzZ0c02QK5m897ZDKabEbBq/0SKWljONJs
         dUoQ==
X-Gm-Message-State: ABuFfoiiOShS0ALXxrr8Gza0RitzdbmMULvU7hkOmDqc1MSIMWIgxbWg
        4hxrZiGkkXiJGtJpcI+0HmtcvtSYWlieM48nMXfeZQ==
X-Google-Smtp-Source: ACcGV61gFIRhsajAv9g44Q7k3y0Zq4OPAaM0mlksItiteFswcQ454oSMCIt/RD8k2YF2qfUTy18LfvmPWg0GX/Vn47o=
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr6591478pgn.145.1539369599299;
 Fri, 12 Oct 2018 11:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com> <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com> <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
 <80837c90-0425-aadd-38d7-c3c866d29a0a@gmail.com>
In-Reply-To: <80837c90-0425-aadd-38d7-c3c866d29a0a@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Oct 2018 11:39:47 -0700
Message-ID: <CAKwvOdmL0kkZs7m+F5eXutVNqs0tjpKcKy-O4N8+-F2FOkL9gQ@mail.gmail.com>
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

On Fri, Oct 12, 2018 at 10:27 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Nick,
>
> >> So maybe I'm misunderstanding something, but the issue seems to be that
> >> unsigned char is promoted to 'unsigned char *' by Clang and probably
> >> unsigned int or int by gcc.
> >
> > No. This is extremely well defined behavior in C.  In C, integral
> > types are NEVER promoted to pointer to integer types, only to larger
> > integral types through rules more complicated than the correct flags
> > to pass to `tar`.
> > https://xkcd.com/1168/
> >
>
> Ah right.  Thanks for the correction.  So looks like bool won't work for
> the same reasons.  But unsigned int should work right?  But then again
> this is a boolean value and if we want to be paranoid we can simply
> tweak the 'c = h3' assignment to be something like:
>
> c = !!h3;
>
> So in the end, I'm happy with int or unsigned int.

Thanks for the feedback.  I'll wait wait to see if James is also cool
with that approach, and if so, send a v2 based on the next-keys branch
in the security tree as per Nathan, with yours and his Suggested-by
tags.

-- 
Thanks,
~Nick Desaulniers
