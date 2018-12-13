Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62502C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2529C20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8b3Xknq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2529C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeLMJFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:05:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35938 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeLMJF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:05:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id a18so1533200wmj.1;
        Thu, 13 Dec 2018 01:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTSFJzRPWMJo7f0gP5ps9ryxqinyS9oZMOUiYnsWyTY=;
        b=O8b3XknqakrbrdMHAn/pOQcIarD+F26yqLqLqZJaV2kHBOZvhLZrzlxIJW17NdJbkF
         pAd73CIpD+p56HV5N20oulFxnkQI8q8WAvOhDFQ4fYeX6jXwZtTtHO7OFXghkvUMf6za
         EFt4x6ulHqI/mJVXuMcReGLZOjj6W7Xt76ArV76DCpCkazchvkeAvEID6gmUoUdkuqXu
         PaVuLEvZN27i0IprcnzhqzkwAXnCQj1Uxsb2kuvE6Ha4fcPe1Xp/Qqm8hT48mlDrwiQH
         F9tOvlJOVlIbWq6D5sV+Oc7wJwL5XHMQWStYo87P5IGf9vFB4cRKB1dzAMBnvGZ7zIwz
         tceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTSFJzRPWMJo7f0gP5ps9ryxqinyS9oZMOUiYnsWyTY=;
        b=S9aGneFtnWKcAoo4CSYFBvYX39djkaWhGh8Vdqh0Bhdj+aBWpDhGj0uyr/HxRXJJJG
         NfstRIfvkJMTEXUK8ZisNVcvcIyqPspZCLcKWXAgHlMcDoftYjoRFONy6FkrYszbppsL
         2yDi7dGA3XukPZgY1zAwzMfqN1/GIaMhv5gct/S4xInoWg9ykn1jr5tdXjGyhVQMDX60
         QqbdQ+M/ONMn+GkaC38i4sFwm+mk2pmyEvG0Y6rX3uj0LOHT49LRMbA1PxzcCUtq2SB2
         u96j67n/QP4nXGQ0+/8RwnnIgG0gCfGrn57L/ga7hCDtoVtpXvlyktAqDvIKS57nYMKX
         kwvQ==
X-Gm-Message-State: AA+aEWYlF7NK6lfsaFjj4Vl/5V6WnPu5hNLEiWzLJyCXrNIo4N4+DDCr
        BRmSom9Mu4TURxBvkMK7r1xJDgrEMVicE4tV49PC2w==
X-Google-Smtp-Source: AFSGD/Xuxkd6dF0Hq92yo+Qoam1UQ7ArQJCh2V9TU3KzPi9WDjxJIqjJFP5Ua4QsBkdmVjosZve3HNC6O/mZudq0AFs=
X-Received: by 2002:a1c:b14:: with SMTP id 20mr9614097wml.103.1544691927776;
 Thu, 13 Dec 2018 01:05:27 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de> <20181213050313.GA21201@ip-172-31-15-78>
In-Reply-To: <20181213050313.GA21201@ip-172-31-15-78>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 13 Dec 2018 10:05:14 +0100
Message-ID: <CAFLxGvy2sMW1nyMpxGN7xHPdUea713g89MdE3EcUNHJDCvZ3jA@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     kevin@guarana.org
Cc:     glaubitz@physik.fu-berlin.de, Andy Lutomirski <luto@kernel.org>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, fweimer@redhat.com,
        Mike Frysinger <vapier@gentoo.org>,
        "H.J. Lu" <hjl.tools@gmail.com>, dalias@libc.org,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 6:03 AM Kevin Easton <kevin@guarana.org> wrote:
>
> On Tue, Dec 11, 2018 at 11:29:14AM +0100, John Paul Adrian Glaubitz wrote:
> ...
> > I can't say anything about the syscall interface. However, what I do know
> > is that the weird combination of a 32-bit userland with a 64-bit kernel
> > interface is sometimes causing issues. For example, application code usually
> > expects things like time_t to be 32-bit on a 32-bit system. However, this
> > isn't the case for x32 which is why code fails to build.
>
> OpenBSD and NetBSD both have 64-bit time_t on 32-bit systems and have
> had for four or five years at this point.

They can also do flag-day changes and break existing applications, Linux not.

-- 
Thanks,
//richard
