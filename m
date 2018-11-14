Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF480C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B254422419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B254422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbeKODT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:19:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43623 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKODT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:19:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id r71so27077980qkr.10;
        Wed, 14 Nov 2018 09:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHz0yCVMU206e0kUS3dS54a4/XNAYhpN3p3RpaFMfs4=;
        b=Cr/SrZxDFLyA+Etdm43Whq0/grwGHW8yCt7J5ESQbVIH0C/tyk7qkGld3dQGXkcDT6
         N1HPRGjbm6hFOIU7cBD+srQTlrPAAyFnwswi19n7iQusb3pBf4ARFt6M9HAxxvFfWapp
         UN84EAd3MS4jph4+EpeH1tZL6DySEAticgYFsitgx/MusJDTseJ/0xjbJV41JpdnVEZu
         vGzzgh3mxG+H0MPSfc0zZcldA5c+psJO7BexY/V5QM/CwXVRlfZhzOlfq+C2kDYFEqDv
         ek8t46A2rKYUJArD6D7aPKMDpg7TTAz0/LRzmXT0WZ0ePFOyQjsJ2cX+wCgCT6SBac+e
         yQBg==
X-Gm-Message-State: AGRZ1gKp2s/byKMiMIXv7Mm6af6SgigE73jvVJwyiu16BKCbxcjomlGw
        SZQh6KS3pWbF7JfebrNct8pnFjs8vIK7dcCxewg=
X-Google-Smtp-Source: AJdET5fqxpGq82nCDfCEHwH3itOroPrtEswiOGmhA1os0+3uPpcz5OVnyIdQRO/fQkE3Nifl3sTgHPn0fs5ROJjwFb8=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr2550347qtr.319.1542215752520;
 Wed, 14 Nov 2018 09:15:52 -0800 (PST)
MIME-Version: 1.0
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <20181113193859.GJ3505@e103592.cambridge.arm.com> <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
 <fb340c72-c484-7f55-a2bd-71e072d7f1f5@redhat.com>
In-Reply-To: <fb340c72-c484-7f55-a2bd-71e072d7f1f5@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 14 Nov 2018 09:15:34 -0800
Message-ID: <CAK8P3a1S65QSRruig+hg_03XbcNges1oR0YWivypvcp7r79Lew@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     carlos@redhat.com
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, dancol@google.com,
        nd@arm.com, Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        GNU C Library <libc-alpha@sourceware.org>,
        Firoz Khan <firoz.khan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 6:58 AM Carlos O'Donell <carlos@redhat.com> wrote:
> On 11/14/18 6:58 AM, Szabolcs Nagy wrote:
> > an actual proposal in the thread that i think is
> > worth considering is to make the linux syscall
> > design process involve libc devs so the c api is
> > designed together with the syscall abi.
>
> * Programmatic / Machine readable description of syscalls.
>   This way the kernel gives users the ability to autogenerate
>   all the wrappers *if they want to* in a consistent way that
>   matches this syscall description format.

Firoz Khan is in the process of doing part of this, by changing the
in-kernel per-architecture unistd.h and syscall.S files into a
architecture independent machine-readable format that is used to
generate the existing files. The format will be similar to what
we have on arm/s390/x86 in the syscall.tbl files already.

This is of course only part of the picture, it answers the question
of which syscalls are implemented on an architecture, which number
they have and (ideally) whether they use a standard implementation
or a custom one, but it does not yet relate to the prototype.

Once this work is merged, we can follow up by coming up with a
way to add prototypes and enforcing that the user space wrapper
uses the same argument types as the in-kernel entry point.

      Arnd
