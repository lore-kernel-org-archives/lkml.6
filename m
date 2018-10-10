Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C476C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC4E2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC4E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeJJVcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:32:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbeJJVcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:32:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 764E381107;
        Wed, 10 Oct 2018 14:09:54 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-26.brq.redhat.com [10.40.200.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A03C86B8C0;
        Wed, 10 Oct 2018 14:09:44 +0000 (UTC)
Date:   Wed, 10 Oct 2018 16:10:21 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wookey <wookey@wookware.org>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20181010141017.GA2881@asgard.redhat.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724173957.GA22106@yury-thinkpad>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 10 Oct 2018 14:09:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 08:39:57PM +0300, Yury Norov wrote:
> Hi all,
> 
> + Pavel Machek, Palmer Dabbelt, Wookey.
> 
> On Wed, May 16, 2018 at 11:18:45AM +0300, Yury Norov wrote:
> > This series enables AARCH64 with ILP32 mode.
> > 
> > As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> > option that is enabled for existing 32-bit architectures but disabled
> > for new arches (so 64-bit off_t userspace type is used by new userspace).
> > Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> > 
> > Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench,
> > CPUSpec.

> This is the update of the series based on 4.17 kernel
> https://github.com/norov/linux/tree/ilp32-4.17

Hello.

I have some questions regarding AArch64 ILP32 implementation for which I
failed to find an answer myself:
 * How ptrace() tracer is supposed to distinguish between ILP32 and LP64
   tracees? For MIPS N32 and x32 this is possible based on syscall
   number, but for AArch64 ILP32 I do not see such a sign. There's also
   ARM_ip is employed for signalling entering/exiting, I wonder whether
   it's possible to employ it also for signalling tracee's personality.
 * What's the reasoning behind capping syscall arguments to 32 bit? x32
   and MIPS N32 do not have such a restriction (and do not need special
   wrappers for syscalls that pass 64-bit values as a result, except
   when they do,  as it is the case for preadv2 on x32); moreover, that
   would lead to insurmountable difficulties for AArch64 ILP32 tracers
   that try to trace LP64 tracees, as it would be impossible to pass
   64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.

Thank you.
