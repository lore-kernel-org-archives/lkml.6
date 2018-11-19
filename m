Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E32C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5272147A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WB0euYxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5272147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbeKTEsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:48:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40704 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbeKTEsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:48:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so9524820pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6eTt6w/LuB095P436kTBH910gkLGVpLCmsSoUkWLn3U=;
        b=WB0euYxMP45OoIrEnJjLbG9wuqZThS5SpWOGKe9zj9EbQiSk9AwaYNpGg9Zq2KG6rJ
         iivylMXHVYYRUD1eOianf90cBnnQ/ldqyzbAGlbopEXmJHgAnxFC9BFxGnNj9eLjl3Fh
         Xi+HdWsfOE4WP+PPnYWFE12txGFRJ3DcWGPxT0MXLZPJ/hLV8Gzcd8PBf7kfTphB/uKq
         zBGqZNzQ5t2gNDoPTwW0XbxjW2p8I6Sd6Pgc9y4co6vd6LAvgr0uodz8PsN3eFT88ptP
         wJzjJTJ/rLJfj/T1sSRQxBap4A2uVox0nFeSsQaUPtV4bvit3KuQHHUfMk2ga+ienw/b
         ElWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eTt6w/LuB095P436kTBH910gkLGVpLCmsSoUkWLn3U=;
        b=pcpf29RL82RaWgCcgWfeLvAGn8DaUBbJaLf1vOsaW+/VqkPWR29r98Xq2FoTJlVnz9
         6nsv6YviL8rnuF/SZPZeu4sswd1TgYdl08rL3U/VjnyCE/iywvdR0VZizyFYV25mUheS
         nPozDhOU/IdUIkXTOMYfMBHotoehDnvKExb3p9HvRoIG0KUXWmDuc4MGoG8mx30zKguL
         TBy+trZfFUQbYhTb8qjAtUcDhH+lC+S8CSdiIIzXWW1W+NGP1EstciPtU1i/aqUlx9bG
         T4Y4NwWAEPs1ZCYjKHSee+X4f8/F5GhByjOG7ebF909dkHtlDZWLW9xRUt6SQJB7iByJ
         ic3w==
X-Gm-Message-State: AGRZ1gIPb88sOI4duClYqsmWZaCWNHAOWOjBSGjl0+AbKt+ww67jHdHP
        UcwGuh+zkEOQLjAagwuTXQJ4Qw==
X-Google-Smtp-Source: AJdET5esYj259RwVqLgg1i8EwRUwwTzjnpYgv2Hq4UkE30B8AEp7JdqmvJA7+PJpGG6Qs0lOQAdMsw==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63-v6mr23649165plb.241.1542651807435;
        Mon, 19 Nov 2018 10:23:27 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id m20sm37134100pgb.56.2018.11.19.10.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 10:23:26 -0800 (PST)
Date:   Mon, 19 Nov 2018 19:23:18 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119182314.fbhnmv5xyt5gy3za@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119171053.GA28067@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119171053.GA28067@asgard.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 06:10:53PM +0100, Eugene Syromiatnikov wrote:
> On Mon, Nov 19, 2018 at 11:32:39AM +0100, Christian Brauner wrote:
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> > index 3cf7b533b3d1..e637eab883e9 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -398,3 +398,4 @@
> >  384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
> >  385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
> >  386	i386	rseq			sys_rseq			__ia32_sys_rseq
> > +387	i386	procfd_signal		sys_procfd_signal		__ia32_sys_procfd_signal
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index f0b1709a5ffb..e95f6741ab42 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -343,6 +343,7 @@
> >  332	common	statx			__x64_sys_statx
> >  333	common	io_pgetevents		__x64_sys_io_pgetevents
> >  334	common	rseq			__x64_sys_rseq
> > +335	common	procfd_signal		__x64_sys_procfd_signal
> 
> You have wired up the syscall on x86 but have not added the syscall number
> to the generic syscall header (include/uapi/asm-generic/unistd.h), why?

Oversight on my part, sorry.
