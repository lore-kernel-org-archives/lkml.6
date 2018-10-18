Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F09C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7144921473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7144921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeJRTPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:15:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36078 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbeJRTPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:15:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74137A78;
        Thu, 18 Oct 2018 04:14:44 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1213B3F5D3;
        Thu, 18 Oct 2018 04:14:38 -0700 (PDT)
Date:   Thu, 18 Oct 2018 12:14:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Joseph Myers <joseph@codesourcery.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Andreas Schwab <schwab@suse.de>,
        Alexander Graf <agraf@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        "Manuel A. Fernandez Montecelo" <manuel.montezelo@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Lin Yongting <linyongting@huawei.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Nathan Lynch <Nathan_Lynch@mentor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Miller <davem@davemloft.net>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20181018111435.GA237391@arrakis.emea.arm.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <CALCETrVuabkb5ZQOSgQQTEq8CrS602NBpAkE2=4n982r1f5reQ@mail.gmail.com>
 <CAK8P3a1Yhhv1TcQTcF0MinicGovgp_0g_sXqADe3fjVTtOK_aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Yhhv1TcQTcF0MinicGovgp_0g_sXqADe3fjVTtOK_aw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 09:49:01PM +0200, Arnd Bergmann wrote:
> On Sat, Oct 13, 2018 at 9:36 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > On Wed, May 16, 2018 at 1:19 AM Yury Norov <ynorov@caviumnetworks.com> wrote:
> > >
> > > This series enables AARCH64 with ILP32 mode.
> > >
> > > As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> > > option that is enabled for existing 32-bit architectures but disabled
> > > for new arches (so 64-bit off_t userspace type is used by new userspace).
> > > Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> >
> > Second, ILP32 user code is highly unlikely
> > to end up with the same struct layout as ILP64 code.  The latter seems
> > like it should be solved entirely in userspace by adding a way to
> > annotate a structure as being a kernel ABI structure and getting the
> > toolchain to lay it out as if it were ILP64 even though the target is
> > ILP32.
> 
> The syscall ABI could be almost completely abstracted in glibc, the
> main issue is ioctl and a couple of related interfaces that pass data
> structures (read() on /dev/input/*, mmap on /dev/snd/*
> or raw sockets, fcntl).

There is another case on struct siginfo which has some pointers and it
wouldn't look like an LP64 structure at all (and glibc doesn't normally
intercept the sighandler call to rewrite the structure). We could add
padding around void * members as the kernel zeros them, I don't recall
the kernel reading these pointers from user. Anyway, using something
that resembles compat_siginfo looked the simplest for ILP32.

-- 
Catalin
