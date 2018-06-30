Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C914C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 19:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F4A254C1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 19:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KRwfTlR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F4A254C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeF3Tpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 15:45:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37026 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeF3Tpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 15:45:32 -0400
Received: by mail-io0-f195.google.com with SMTP id s26-v6so11399724ioj.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93baChKvo0kLQnGN470g45eX5iAKo1yJSCX2sk11CA0=;
        b=KRwfTlR1fetS8dp+2lyAWDw4EXgiFO+xygAvBo8HZ/o40s1usabnzMjrEc8by5qdPa
         Ek9zKFZxj1vlZ5P0ZVXu4u4WH0m6pZS/01/ZkhDM+fFdsdsXzVfqJALGSB2eYhasfGJJ
         2AI57GiSWym8geb32dWs170A6IPURaLQPklO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93baChKvo0kLQnGN470g45eX5iAKo1yJSCX2sk11CA0=;
        b=aMEx7z5Z0a5xSUYAY1rZmPy1DKUIIkmmH86K7gxIw7+8RQt4eLOPotGc4sQif+X5KA
         LJq5oyjnGe+BTerCGiDYJnyKvclGJqIU6pYjIJf3PwJhCe1ypbyuFkI8/BdXjN8YTrvk
         d1XeNKxjMmKWZs464UTvBDcqzBVnTVRdAJ+F2Ssn0enPcw/iTLj0ZTZJoNrIXsEN79SA
         in9sCgBVRKI4ICL7qfyLPdHPfPQHncG8qAyKe+P8CfTuVddC/xmNXirHSXnri2MY2RRN
         TElLr4gGXxIfTm/nm7XDQ/9LEeMEq5Q+04TugldYzDnwUWeuuoXL3GlQc2JmCxXj9cDI
         /4lQ==
X-Gm-Message-State: APt69E2+wqeQ1DnaF7tx2YlMJePgrfwREW1O9FfN5IEw46zVNhWBFv13
        AXpd2dBUraJ9klMiIMN6E5/zZTjHe9v6X0qDtuM=
X-Google-Smtp-Source: AAOMgpezs2a1XySz4NWRSP6u+D1GqJxpty1d0mBs5Cfx7018VolAiZ/sCg5gFUpdPny93U4ERVEPWKTlqXY2Qt+7gHw=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr17059832ion.259.1530387931879;
 Sat, 30 Jun 2018 12:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com> <828fb935c0cd04e74a09b8ed2b78aca405d7c5b2.camel@kernel.crashing.org>
In-Reply-To: <828fb935c0cd04e74a09b8ed2b78aca405d7c5b2.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jun 2018 12:45:21 -0700
Message-ID: <CA+55aFwg+j60ZFi7t7kVXbobCT4XHoiZP_w6+Cbm+AeU1ytfNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: core: Don't try to use a dead glue_dir
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 7:21 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Under some circumstances (such as when using kobject debugging)
> a gluedir whose kref is 0 might remain in the class kset for
> a long time. The reason is that we don't actively remove glue
> dirs when they become empty, but instead rely on the implicit
> removal done by kobject_release(), which can happen some amount
> of time after the last kobject_put().
>
> Using such a dead object is a bad idea and will lead to warnings
> and crashes.

So with the other patch in mind, here's my comments on this one. Pick
one of two scenarios:

 (a) it's obviously correct.

     We obviously can *not* take an object with a zero refcount,
because it is already been scheduled for kobject_cleanup(), and
incrementing the refcount is simply fundamentally wrong, because
incrementing the refcount won't unschedule the deletion of the object.

 (b) the patch is wrong, and our "kobject_get()" should cancel the
kobject_cleanup() instead.

There are problems with both of the above cases.

The "patch is obviously correct" case leads to another issue: why
would kobject_get() _ever_ succeed on an object wioth a zero refcount?
IOW, why do we have kobject_get() vs kobject_get_unless_zero() in the
first place? It is *never* ok to get an kobject with a zero refcount
because of the above "it's already scheduled for deletion" issue.

The (b) case sounds nice, and would actually fix the problem that
patch 2/2 was tryihng to address, and would make
CONFIG_DEBUG_KOBJECT_RELEASE work.

HOWEVER. It's completely untenable in reality - it's a nightmare from
a locking standpoint, because kref_put() literally depends not on
locking, but on the exclusive "went to zero".

So I think (b) is practically not acceptable. Which means that (a) is
the right reaction, and "kobject_get()" on an object with a zero
refcount is _always_ wrong.

But that says that "yes, the patch is obviously correct", but it also
says "the patch should be pointless, because kobject_get() should just
_always_ have the semantics of "kobject_get_unless_zero()", and the
latter shouldn't even exist.

Greg? When would it possibly be valid to do "kobject_get()" on a zero
refcount object? I don't see it. But this is all very much your code.

               Linus
