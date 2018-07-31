Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6708AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D3220841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D3220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbeGaVsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:48:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732373AbeGaVsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:48:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07A838197005;
        Tue, 31 Jul 2018 20:06:52 +0000 (UTC)
Received: from doriath (ovpn-116-231.phx2.redhat.com [10.3.116.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 586E61C701;
        Tue, 31 Jul 2018 20:06:42 +0000 (UTC)
Date:   Tue, 31 Jul 2018 16:06:40 -0400
From:   Luiz Capitulino <lcapitulino@redhat.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Message-ID: <20180731160640.11306628@doriath>
In-Reply-To: <20180731060155.16915-1-alex@ghiti.fr>
References: <20180731060155.16915-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 31 Jul 2018 20:06:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 31 Jul 2018 20:06:52 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lcapitulino@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 06:01:44 +0000
Alexandre Ghiti <alex@ghiti.fr> wrote:

> [CC linux-mm for inclusion in -mm tree] 
> 
> In order to reduce copy/paste of functions across architectures and then
> make riscv hugetlb port (and future ports) simpler and smaller, this
> patchset intends to factorize the numerous hugetlb primitives that are
> defined across all the architectures.

[...]

>  15 files changed, 139 insertions(+), 382 deletions(-)

I imagine you're mostly interested in non-x86 review at this point, but
as this series is looking amazing:

Reviewed-by: Luiz Capitulino <lcapitulino@redhat.com>
