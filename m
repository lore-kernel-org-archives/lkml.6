Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6499AC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306D320685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="TLujhgpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306D320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeKUDTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:19:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38202 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUDTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:19:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so1265479plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WFx1J3inb6v7UEw+P0E/R4x3DL6bkDbfnw8yxHPEfyE=;
        b=TLujhgpZc8+Vk4MHalcSCCHQdHu/Pik1yHrCAHLcRY1OSPbTDkbyAPsK/88k3Cq/sM
         MpydZosT8zqEc8CQnrjCP5URsguZljyKTuw57KaI6gkyPUJV0MNM4e5vX8lvJ2cjaMlY
         Olt+1WyjyD+BbtwQC/H43ZkrRZfyXgdqAm/b3lrrhpCioOxE5VLm58vFv8MHdY+I47Po
         V0YaotEqf4dCsFgiNsu3s83WV2qQoIG7RnMDlIhI3TfPY68kT1spy8/sKOffQ4t/3WJ0
         eCa3o9Pr/oDf9hJctS3uX4OHgDUhLu/eFejObfg7Ne9Zp1f/p9rQ7VY8N9LvUzccFz7M
         vHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WFx1J3inb6v7UEw+P0E/R4x3DL6bkDbfnw8yxHPEfyE=;
        b=OhACsEqBr34o9d9ENhB+f4JXW/b0OqvbpPsGMVvlAwtWhEd9IaXMWt3KY+gUz+MhRM
         uSzLDqif735FqavWn5ctzwGXOk0Ls9hXrVw4qzCq+Whcpp7UPuMy9M1u94EKdXA7YGUf
         pMfFagiucnYALkmHb/Z6/FdgSf1qKicBA+IEWQxR8pUBsoaTCI/pohy36xX648KEKcmC
         xAoCVoqSVKAR/fBy19ga7YyiDHC5fdEX5bWcHNIBnWnkLXNcBNBbPEKYNp/Fki7rS3KM
         6/oFjwHA5Z6lTgG5KCFJ45BUE1MPs1qkJkvL1lfD2s202qdkOnjHG22qE2NwxE/Sr3Bh
         R7sg==
X-Gm-Message-State: AA+aEWb7z1xfe7+9doCziYc1Uhc0232AxsIaq6QITmUdSr04U/c1H2fv
        Up6MKR/w4adOa4ztxRBdfHUUNA==
X-Google-Smtp-Source: AFSGD/XUsHCRfptqlgixBTnhTDn8QqcVDpt2joD8Cbq++Xx9U6CbapgDtN+hHuFOBK9PvWzF8ElBfQ==
X-Received: by 2002:a17:902:76c2:: with SMTP id j2mr2979554plt.339.1542732535313;
        Tue, 20 Nov 2018 08:48:55 -0800 (PST)
Received: from cisco ([128.107.241.166])
        by smtp.gmail.com with ESMTPSA id u9-v6sm47247001pfm.175.2018.11.20.08.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 08:48:54 -0800 (PST)
Date:   Tue, 20 Nov 2018 09:48:52 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
Subject: Re: Cleaning up numbering for new x86 syscalls?
Message-ID: <20181120164852.GC4992@cisco>
References: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 04:22:49PM -0800, Andy Lutomirski wrote:
> Hi all-
> 
> We currently have some giant turds in the way that syscalls are
> numbered.  We have the x86_32 table, which is totally sane other than
> some legacy multiplexers.  Then we have the x86_64 table, which is,
> um, demented:
> 
>  - The numbers don't match x86_32.  I have no idea why.
> 
>  - We use bit 30, which triggers in_x32_syscall().  It should have
> been bit 31, bit I digress.
> 
>  - We have this weird set of extra x32 syscalls that start at 512.
> Who wants to bet whether we have no bugs if someone does syscall with,
> say, nr == 512 (i.e. not 512 | BIT(30)) or nr == (16 | BIT(30))?  The
> latter would be non-compat ioctl with in_x32_syscall() set and hence
> in_compat_syscall() set.
> 
>  - Bloody restart_syscall() has a different number on x86_64 and
> x64_32, which is a big mess.
> 
> I propose we consider some subset of the following:
> 
> 1. Introduce restart_syscall_2().  Make its number be 1024.  Maybe
> someday we could start using it instead of restart_syscall().  The
> only issue I can see is programs that allow restart_syscall() using
> seccomp but don't allow the new variant.
>
> 2. Introduce an outright ban on new syscalls with nr < 1024.
> 
> 3. Introduce an outright ban on the addition of new __x32_compat
> syscalls.  If new compat hacks are needed, they can use
> in_compat_syscall(), thank you very much.
> 
> 4. Modify the wrappers of the __x32_compat entries so that they will
> return -ENOSYS if in_x32_syscall() returns false.

This sounds like a great idea independent of all of this.

> 5. Adjust the scripts so that we only have to wire up new syscalls
> once.  They'll have a nr above 1024, and they'll have the same nr on
> all x86 variants.
> 
> Thoughts?

+1. Who wants to do it? :D

Tycho
