Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA7EC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621DE21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621DE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJIRDd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:03:33 -0400
Received: from ozlabs.org ([203.11.71.1]:37367 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeJIRDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:03:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42TspQ6x3vz9s2P;
        Tue,  9 Oct 2018 20:47:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     linux-next <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        sachinp <sachinp@linux.vnet.ibm.com>, keith.busch@intel.com,
        bhelgaas@google.com
Subject: Re: [linux-next][bisected e3fbcc7c] build error at
 drivers/pci/pcie/aer_inject.c:444:6: error: =?utf-8?Q?=E2=80=98struct_pt?=
 =?utf-8?Q?=5Fregs=E2=80=99?= has no member named =?utf-8?Q?=E2=80=98ip?=
In-Reply-To: <1539069292.17569.7.camel@abdul.in.ibm.com>
References: <1539069292.17569.7.camel@abdul.in.ibm.com>
Date:   Tue, 09 Oct 2018 20:47:20 +1100
Message-ID: <87woqr1mfr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> Greeting's
>
> Today's linux-next fails to build on ppc with below error
>
> drivers/pci/pcie/aer_inject.c: In function ‘aer_inject_ftrace_thunk’:
> drivers/pci/pcie/aer_inject.c:444:6: error: ‘struct pt_regs’ has no
> member named ‘ip’
>   regs->ip = (unsigned long) hook->function;
>       ^
> make[3]: *** [drivers/pci/pcie/aer_inject.o] Error 1
> make[2]: *** [drivers/pci/pcie] Error 2
> make[1]: *** [drivers/pci] Error 2
>
> Machine: Power 9
> kernel version: 4.19.0-rc7-next-20181008
> gcc version: 4.8.5 20150623
> config attached
>
> Recent code changes from these commits:
>
> c79ad38b36dd4967d67f83fc48bade37ee041a47 PCI/AER: Abstract AER interrupt handling
> 7b23285f930a8dedcbf749661cd0f2cc27f79be6 PCI/AER: Reuse existing pcie_port_find_device() interface
> e3fbcc7c4b130f81ea586183db561fa3ce9c6447 PCI/AER: Covertly inject errors with ftrace hooks

I don't see this commit in today's linux next (20181009) so presumably
someone else has noticed and dropped the commit?

cheers
