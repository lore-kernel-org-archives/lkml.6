Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A9FC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B80E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="QNo/35Gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfAUTNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:13:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34637 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfAUTNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:13:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so6859852wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 11:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pT7yG+ZIRuSsRQUlc7aUe2hsaluY9tnGkzf/an0YTfs=;
        b=QNo/35Ghwy8YrbjlXgzkAHbT/cPII4d+dbRzz6M5QgCONEZzVv4i22HTr0DlpocVo5
         xICPO2gybcl3KRfqVUaUuK0sE6nUDCWkBkadKIwfFKW64NeHaCrXD9qDJZ8CTNlWpz76
         BrRNTQVApfvC2WDSzqfOmyGX+GvHbKOg+VkQ/zKwMDdqiul6RpUYQYDXXt1XcAToOHKb
         rpyj3nDiGD4mBUVL5WQhaeigISa548GbKpH7BNG+IZ9fwBZJk76FIlNKMcCwWEPnGkKi
         Oar15uFLjplquq1ICMgFIvq0fXCm6qDuugtElMBHWqA3IMefdgrTRSssJ53Ewdua/jIC
         O//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pT7yG+ZIRuSsRQUlc7aUe2hsaluY9tnGkzf/an0YTfs=;
        b=VV4DW34Nn3L/yjgdPE2p5CT4RpvKsGTS+JvPig0C4Hv2t21Opi5tTWa2mtIcAwGov9
         ongE13Ca+/+IshhTgPibQZ3T5aj0h6EHr0qjCKIvdWMGBapTJpbkeKEe+jbAwTFtDZ4w
         b+UtVzuuFQ8KRniQYZdWxLcog0KEWIrVP4ZhM59Fy07dzNhpqkRmkwCC8uZinD/Cm8vM
         PVdEajXWYfnTg/r0/yQAFSTzpc283urLoRVzsj7xlUonTqtoRoWi5pwalYUpH1vihM2P
         jSVmRMgtR5r+bk/vUN07POc3M7g15Hrasy3IWSh4nRaljLXiy4mCJsyM90ea9J9t5U2i
         FEIA==
X-Gm-Message-State: AJcUukdqDAjeNSGMdMS4irz6ARJirquSggQfKRUIgWbRS1OeCYQsQbTU
        /pxzHaN3Trg1EuxeQt50qBNy419jn/GcgQ==
X-Google-Smtp-Source: ALg8bN6TDEU0e5rFft6bxXVKl7nJwiZQT49V6Iq6wF0MbBWLiTObGoKxAiSgFOloFvw7//bUBQkAew==
X-Received: by 2002:a1c:cf0d:: with SMTP id f13mr620495wmg.70.1548097989996;
        Mon, 21 Jan 2019 11:13:09 -0800 (PST)
Received: from brauner.io (p200300EA6F1466E194736B39AFAF14D4.dip0.t-ipconnect.de. [2003:ea:6f14:66e1:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id x10sm116951978wrn.29.2019.01.21.11.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 11:13:09 -0800 (PST)
Date:   Mon, 21 Jan 2019 20:13:07 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Message-ID: <20190121191306.ifga5aw5atu2vvb7@brauner.io>
References: <20190121143951.68956db3@canb.auug.org.au>
 <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the pidfd tree got conflicts in:
> >
> >   arch/x86/entry/syscalls/syscall_32.tbl
> >   include/uapi/asm-generic/unistd.h
> >
> > between commit:
> >
> >   10a9a4dd92e6 ("arch: add split IPC system calls where needed")
> >   b1788424aa2e ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
> >
> > from the y2038 tree and commit:
> >
> >   3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")
> >
> > from the pidfd tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Hi Stephen,
> 
> >  +385   i386    io_pgetevents           sys_io_pgetevents_time32        __ia32_compat_sys_io_pgetevents
> >   386   i386    rseq                    sys_rseq                        __ia32_sys_rseq
> > + 387   i386    pidfd_send_signal       sys_pidfd_send_signal           __ia32_sys_pidfd_send_signal
> >  +# room for arch specific syscalls
> >  +393   i386    semget                  sys_semget                      __ia32_sys_semget
> >  +394   i386    semctl                  sys_semctl                      __ia32_compat_sys_semctl
> 
> >   #define __NR_kexec_file_load 294
> >   __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> > - /* 295 through 402 are unassigned to sync up with generic numbers */
> > + #define __NR_pidfd_send_signal 295
> > + __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
> > ++/* 296 through 402 are unassigned to sync up with generic numbers */
> >  +#if __BITS_PER_LONG == 32
> >  +#define __NR_clock_gettime64 403
> >  +__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
> 
> If we merge my patches, then any other system calls should get numbers
> above 423 on all architectures. Part of what I did in my branch was to
> add all missing calls on architectures, and then move up to a common
> number for the newly added ones. Your merge works correctly, but
> it works against that idea by adding new numbers that conflict with
> existing ones on other architectures, e.g. 387 is already assigned
> on arm, microblaze, powerpc, and sh, and 294 is assigned almost
> everywhere other than the asm-generic version.

Hey Arnd,

I plan on sending the pidfd branch with the new pidfd_send_signal()
syscall for the 5.1 window. Should we somehow coordinate so that our
branches don't conflict? Any suggestions?

Christian
