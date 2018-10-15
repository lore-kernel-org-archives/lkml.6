Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2400E208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCxV9RqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2400E208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJPCw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:52:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33621 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeJPCw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:52:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so18550871ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYEY5CM4UvtFM7HS4ZvtoZnV+DZrS+4uXnp8zoybaJY=;
        b=pCxV9RqPadZd+ztJButAkWHppMY7Pqbb7tw6vIsQGelmAwZCnDu5fiitgC/SveW5hd
         TpidruKzgFAizKRMe14Ree2shtuKn0N6mMh57M24xTg840YtP5cxy/1NjODfHKLWqexA
         IqqB4DF6XscdmFHWlGUk02oHr6WX6u0PAPILM++PyT5eBlCrWxmfEXqNIweMDRrZM+Dp
         virnSRVNepMpusIpUlLqR1uFsbokiea7qDztQ0VpsL/4LUdS1yXjt92UhC7zJP7k/H4D
         GyhlEsGADb1rNZYF3OeH7LIX5apBQMad7DCyzzGIEvsaKs6njrvkD39ivUrnm4UInP7b
         RoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYEY5CM4UvtFM7HS4ZvtoZnV+DZrS+4uXnp8zoybaJY=;
        b=WYKE+oC8vTzFiYm56k+jwrbYdM3CCZ4Xk0aQaK5Vy1GKheSMEdMlf8WdJTxuyI435h
         SR/489PDFZpQt6EIxjs/EFY6ZqJLSFR75FD0h7iGKnE3nkrLt9JWO+KeDisLrsT2KVC9
         zTjv7jHmHt4+JNP4+o8aTxgD/n2oohDfaI431lIo16hsTO047LBuB1XCyGgCyS50n5sE
         bYE0hTMpaPMO8OhKPZSpchO1bVQhFeYp7rBEtTGj4gWTIMVdtoTlSAKJwAKSAZchESee
         Xk0QxyU2lD7ModeJdl4toJF62E+YcXlikVmIvLUBWEam3uUaaQakHTd1AXw0jF+h4Tvm
         XSvw==
X-Gm-Message-State: ABuFfohG7EpTzVNF06jnwL0LJQO/Az3zqMElzC0GjG+0E80YuMe9fcIX
        sN+GgleErlvUK0RhZtuFX16aKt0gp8LlLJDtzIlOKki3Qb8=
X-Google-Smtp-Source: ACcGV619fw6GeSy/8FgbEaxDcZlbNkrbSshd5gOjGgCL5E7aOcZTV2bFOJU5Gwl1V3xwK/MwOLbj0yOtZimlXVbqGy0=
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr12785590ljc.14.1539630384053;
 Mon, 15 Oct 2018 12:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com> <20181003171720.169953-6-rkir@google.com>
 <20181015183458.GA28454@kroah.com> <CAOGAQerzTxLEcFjqCqjGvFDaK79LWw7kuGqprw4mEj6gmcm6tA@mail.gmail.com>
 <20181015185611.GA5201@kroah.com>
In-Reply-To: <20181015185611.GA5201@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Mon, 15 Oct 2018 12:06:12 -0700
Message-ID: <CAOGAQerxP0hsVF2ArpXJ4HrPj=-XKfdqvAdUGoC4xo+sc4UYvw@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] platform: goldfish: pipe: Move memory allocation
 from probe to init
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > probe does not know what memory to allocate. We have several versions
> > of the driver (with different init) and different versions allocate
> > different state.
>
> I only see one driver here.

It will be added in "PATCH v3 15/15". There will be two init functions
allocating
different states.

> Why does probe not know what to allocate?  That is exactly when the
> device is bound to the driver, you have _way_ more information than you
> do at init time.

We have two versions of the driver. Probe asks for the version and
calls the init function for this version.
I don't want probe to know everything about all versions.

> > >, not init time as what
> > > happens if the hardware is not present yet your driver is loaded?
> >
> > init will have to rollback what it allocated.
>
> But those resources it will sit there wasted until unload happens.  And
> unload _never_ happens on a system unless you are a developer working on
> the module.

If probe fails I expect the kernel to release all resources. Is this
not the case?
