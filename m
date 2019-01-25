Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98401C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E5C2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jg+mY4fZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfAYQVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:21:36 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59710 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAYQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fb6QfXnDya57aIllN8OrBHEzgweeEhiGtjzhT0asteg=; b=Jg+mY4fZd4Fh38o/VC9Ln2xfb
        JN3U08pa9jgQaUkC9++KAWmKjLgpzUEBx35I75q4QyMFkgorfHmpgnMPnZDwsLxk30AnWeLDKkcgw
        t6YNTJS4cjCz1xF4o4zbIyr/kj25p4WOZhvftqtGwu1UfwwMXq5O6ec68tvt8EGnndrvg=;
Received: from e5254000004ec.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55400 helo=shell.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gn4E8-0003Ku-Bh; Fri, 25 Jan 2019 16:21:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gn4E6-0001p0-Sr; Fri, 25 Jan 2019 16:21:06 +0000
Date:   Fri, 25 Jan 2019 16:21:06 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mattst88@gmail.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/29] ARM: add kexec_file_load system call number
Message-ID: <20190125162106.axfhoxxdutkmaeh3@e5254000004ec.dyn.armlinux.org.uk>
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-8-arnd@arndb.de>
 <20190125154359.GG25901@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125154359.GG25901@arrakis.emea.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 03:43:59PM +0000, Catalin Marinas wrote:
> On Fri, Jan 18, 2019 at 05:18:13PM +0100, Arnd Bergmann wrote:
> > diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> > index 86de9eb34296..20ed7e026723 100644
> > --- a/arch/arm/tools/syscall.tbl
> > +++ b/arch/arm/tools/syscall.tbl
> > @@ -415,3 +415,4 @@
> >  398	common	rseq			sys_rseq
> >  399	common	io_pgetevents		sys_io_pgetevents
> >  400	common	migrate_pages		sys_migrate_pages
> > +401	common	kexec_file_load		sys_kexec_file_load
> 
> I presume on arm32 this would still return -ENOSYS.

Yes, I already checked.  If CONFIG_KEXEC_FILE is not set, then
kernel/kexec_file.c is not built, and we fall back to the stub
in kernel/sys_ni.c.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
