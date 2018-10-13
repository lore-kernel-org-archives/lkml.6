Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F14C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C87B214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C87B214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJMQ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:56:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbeJMQ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:56:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D38B0F;
        Sat, 13 Oct 2018 02:20:18 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFCCD3F5D3;
        Sat, 13 Oct 2018 02:20:12 -0700 (PDT)
Date:   Sat, 13 Oct 2018 10:20:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Pavel Machek <pavel@ucw.cz>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Joseph Myers <joseph@codesourcery.com>,
        linux-arch@vger.kernel.org,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Andreas Schwab <schwab@suse.de>,
        Alexander Graf <agraf@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Lin Yongting <linyongting@huawei.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Wookey <wookey@wookware.org>, Mark Brown <broonie@kernel.org>,
        nd@arm.com, linux-arm-kernel@lists.infradead.org,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20181013092009.gzxorufk4tqrzked@mbp>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad>
 <20181010141017.GA2881@asgard.redhat.com>
 <7aac1a08-8948-1a04-cbd3-fbc6a53f9ff0@arm.com>
 <20181013020731.GD21972@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013020731.GD21972@asgard.redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 04:07:31AM +0200, Eugene Syromiatnikov wrote:
> On Wed, Oct 10, 2018 at 03:39:07PM +0100, Szabolcs Nagy wrote:
> > On 10/10/18 15:10, Eugene Syromiatnikov wrote:
> > >  * What's the reasoning behind capping syscall arguments to 32 bit? x32
> > >    and MIPS N32 do not have such a restriction (and do not need special
> > >    wrappers for syscalls that pass 64-bit values as a result, except
> > >    when they do,  as it is the case for preadv2 on x32); moreover, that
> > >    would lead to insurmountable difficulties for AArch64 ILP32 tracers
> > >    that try to trace LP64 tracees, as it would be impossible to pass
> > >    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.
> > 
> > but that's necessarily the case for all ilp32 abis:
> > the userspace syscall function receives 32bit
> > arguments so even if the kernel abi takes 64bit
> > args you cannot use that from c code. (the libc
> > does not even know which args should be sign or
> > zero extended.)
> 
> glibc's syscall() prototype has kernel_ulong_t as its arguments (more
> specifically, to __syscall_ulong_t, which is 64-bit wide on x32; it
> should also have kernel_long_t as its return type instead of long,
> but that's another story), so it works perfectly fine in case of x32.

This would have been my preferred approach but the libc community were
not entirely happy with it as it breaks POSIX compatibility:

https://sourceware.org/bugzilla/show_bug.cgi?id=16437
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/323348.html

(there are other threads around x32 and people arguing whether POSIX is
wrong)

Some sometime around version 4 or 5 of this series, we made the move
(back) to compat-like ABI.

-- 
Catalin
