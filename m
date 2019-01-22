Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3531C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A1C20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Ywpn1+5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfAVMYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:24:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38364 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfAVMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:24:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so19134993ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 04:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WDzuFUHSX6vXpT7QnZl7MicYAODMAFUnE9JqCVZVK2M=;
        b=Ywpn1+5tslgR4BwDyp0KFHkNXzN3iZtiBGxXggTpMFgqexw7qUZHYhaLt0orI9UPqw
         CxoTZjmD/lleppdlvobHaJjMjANdFz/C3ocKDBv/bmhCo89C3yzUfEmp6AU7NB0yYRYD
         lPLiCrHn8gpEazKg0AZGiFInowooLA/8n6O/xrTNVqUi5YE/RD+xscFK73YRmcFqv34h
         uehuf1knj+f+/zdIoAu27QORdwCaEgyKv6P49godK2yqObzU0SgJBdZWEnhmnck3xq7h
         IxVhVoHYiqghIMLAoNE1jW0+H4W3vrfGjj7DIiNcLla48bGyE6T++/nGFqZ02B5PYgLk
         9k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WDzuFUHSX6vXpT7QnZl7MicYAODMAFUnE9JqCVZVK2M=;
        b=g8El2pIMmjkliiDTeNBLlJU42vBjbL3Gg7GfHGtLpm/LoOGtS5ZpzWJhtqh8k4Tst9
         IXK45z0MZ7jP+PogVFsYs8R5+1TVUq+yAvCUzCtbB3WDS1bWlsYapdI3ih6dCkopc57V
         9q8E4sh15UC2UlAkHtVaG82JzDxpV5ZYdbpkCfL0w3pQey2dpv886NnyrE9Q/Fyai5p9
         7hWWP9UrPX5kMtnd6B+zJN+Zb8y1pd/tLYuh2apD8xNzi72DtKmQSJEmOwE0/NFk6wFc
         ZPUWpwysgK/6LuFil+gPWQ5MxxTY9lHyAhvO/1WkUGtayl1waRhwM1LSsVpUAbuoPzvk
         XZVg==
X-Gm-Message-State: AJcUukdb3V+Gnute+c+IvxNc5DTqKf0KJ60Y/08byQmkh5RCqid0dISv
        y7t4RYPD0HjPlilhs3x6o0sRLQ==
X-Google-Smtp-Source: ALg8bN4HvNVKedZN3qrX/7fNxTQiC31fEGL5vD3Gqzj5qgh9FX/E2eKGoO+ttcL6YR71aeSyln5BTQ==
X-Received: by 2002:a17:906:4d2:: with SMTP id g18-v6mr28047891eja.182.1548159861880;
        Tue, 22 Jan 2019 04:24:21 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id v43sm9932126edc.18.2019.01.22.04.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 04:24:21 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:24:20 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Message-ID: <20190122122419.b7lmm4j25w5cbmcx@brauner.io>
References: <20190121202328.rgrv54lybilsvitu@brauner.io>
 <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
 <20190121224811.gbvg22vg4kgg4kbs@brauner.io>
 <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
 <20190122093146.kmckcgdbvo2e7v3c@brauner.io>
 <20190122103009.vu2a67kviqhcb3cn@brauner.io>
 <CAK8P3a0EW6ZSMoo6FsRQ=XvyhJe50SR7YtpCtuHcPr=JO3fCtA@mail.gmail.com>
 <20190122105747.6gxvghn7n5dxa65w@brauner.io>
 <CAK8P3a0HJX6+1vks=ZCqNymLwWFS+Wt5PPuYnLedpMo=aVSwKA@mail.gmail.com>
 <20190122114656.joasjhlpwo3vy7hg@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122114656.joasjhlpwo3vy7hg@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:46:56PM +0100, Christian Brauner wrote:
> On Tue, Jan 22, 2019 at 12:42:44PM +0100, Arnd Bergmann wrote:
> > On Tue, Jan 22, 2019 at 11:57 AM Christian Brauner <christian@brauner.io> wrote:
> > > On Tue, Jan 22, 2019 at 11:48:12AM +0100, Arnd Bergmann wrote:
> > 
> > > > Do you mean the asm-generic uapi header? In my current series, I do that:
> > >
> > > Yes. My idea was to only change pidfd_send_signal's entry to 424 and
> > > leave the other ones untouched:
> > >
> > >  #
> > >  # x32-specific system call numbers start at 512 to avoid cache impact
> > > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > > index b77538af7aca..4d86d0787d99 100644
> > > --- a/include/uapi/asm-generic/unistd.h
> > > +++ b/include/uapi/asm-generic/unistd.h
> > > @@ -740,7 +740,7 @@ __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
> > >  __SYSCALL(__NR_rseq, sys_rseq)
> > >  #define __NR_kexec_file_load 294
> > >  __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> > > -#define __NR_pidfd_send_signal 295
> > > +#define __NR_pidfd_send_signal 424
> > >  __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
> > >
> > > and also leave
> > 
> > Yes, that looks good.
> > 
> > > #undef __NR_syscalls
> > > #define __NR_syscalls 296
> > >
> > > Does that work to avoid the merge conflict or do you need something
> > > more?
> > 
> > You need to change __NR_syscalls to 425 as well. This will
> > clearly create a conflict, but then the resolution will be to pick
> > the correct (a.k.a. highest) number, rather than remembering
> > to update it manually.
> 
> Hm, ok. Wasn't sure if that would confuse people.
> 
> Ok, when I sent my PR I will make a note in the PR that this branch is
> aligned to create only minimal conflicts with your y2038 branch. The
> patch carries your ack already so this should be good.

Arnd, in case you care to take a look
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next

Thanks!
Christian
