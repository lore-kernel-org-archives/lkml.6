Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F126CC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C22C208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C22C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeIXFsR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 01:48:17 -0400
Received: from ozlabs.org ([203.11.71.1]:39471 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeIXFsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 01:48:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 42JPDb75Wwz9s8T;
        Mon, 24 Sep 2018 09:48:47 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id CE924EE78BF; Mon, 24 Sep 2018 09:48:47 +1000 (AEST)
Message-ID: <a06045cd5f4229113cb301668b2d993060a3ee73.camel@neuling.org>
Subject: Re: [PATCH v8 1/3] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
From:   Michael Neuling <mikey@neuling.org>
To:     ego@linux.vnet.ibm.com
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Sep 2018 09:48:47 +1000
In-Reply-To: <20180921171740.GA12919@in.ibm.com>
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
         <1537464159-25919-2-git-send-email-ego@linux.vnet.ibm.com>
         <d1cf1628ed2641140d3508d355cdc172d6b145e9.camel@neuling.org>
         <20180921171740.GA12919@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-21 at 22:47 +0530, Gautham R Shenoy wrote:
> Hello Michael,
> 
> On Fri, Sep 21, 2018 at 01:02:45PM +1000, Michael Neuling wrote:
> > This doesn't compile for me with:
> > 
> > arch/powerpc/kernel/smp.c: In function ‘smp_prepare_cpus’:
> > arch/powerpc/kernel/smp.c:812:23: error: ‘tg.threads_per_group’ may be used
> > uninitialized in this function [-Werror=maybe-uninitialized]
> >   struct thread_groups tg;
> >                        ^
> > arch/powerpc/kernel/smp.c:812:23: error: ‘tg.nr_groups’ may be used
> > uninitialized in this function [-Werror=maybe-uninitialized]
> > cc1: all warnings being treated as errors
> > /home/mikey/src/linux-ozlabs/scripts/Makefile.build:305: recipe for target
> > 'arch/powerpc/kernel/smp.o' failed
> > 
> 
> I couldn't get this error with gcc 4.8.5 and 8.1.1 with
> pseries_defconfig and powernv_defconfig with CONFIG_PPC_WERROR=y.

I'm using 5.4.0 which is in Ubuntu 16.04 (LTS).

> Does the following the following delta patch make it work?

Yep that fixes it, thanks.

Mikey

