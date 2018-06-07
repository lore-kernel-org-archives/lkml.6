Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LtFWDpfBGFu9OgAAmS7hNA
	; Thu, 07 Jun 2018 05:28:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5C8BE6089E; Thu,  7 Jun 2018 05:28:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B16C7607DC;
	Thu,  7 Jun 2018 05:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B16C7607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeFGF2x (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:28:53 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50930 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeFGF2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:28:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 33D0729B32;
        Thu,  7 Jun 2018 01:28:49 -0400 (EDT)
Date: Thu, 7 Jun 2018 15:29:11 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/11] macintosh/via-pmu: Replace via-pmu68k driver with
 via-pmu driver
In-Reply-To: <CAMuHMdWQsHLGoxf4_2xtSi4fVc+Lxxa3KXP9VntFYu85YVC0tQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1806071514460.12@nippy.intranet>
References: <cover.1527909627.git.fthain@telegraphics.com.au> <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au> <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au> <878b389293851359e53de186bf302ce52d95ad95.1527909627.git.fthain@telegraphics.com.au> <adba0545c06cd6c67e26c433990d036b0d7e968c.1527909627.git.fthain@telegraphics.com.au>
 <166b4c3a7347fe27f12bda86d50533cd01ee11b9.1527909627.git.fthain@telegraphics.com.au> <73507a3e9444da17c222cf74df41842ce30d15ee.1527909627.git.fthain@telegraphics.com.au> <de8edb03dbd2fd25b53d0bdf9c6d65adf9aa0aa3.1527909627.git.fthain@telegraphics.com.au>
 <CAMuHMdVheowFa8bx0fg-_Dvx+TMZhPbvouTs82Y3tq1gtSpRMQ@mail.gmail.com> <alpine.LNX.2.21.1806061619240.8@nippy.intranet> <CAMuHMdWQsHLGoxf4_2xtSi4fVc+Lxxa3KXP9VntFYu85YVC0tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018, Geert Uytterhoeven wrote:

> So 4.17 mac_defconfig won't work on PMU_68K_V1 machines? Perhaps that 
> should be fixed first.
> 

AFAICT there's nothing to fix.

$ grep PMU arch/m68k/configs/mac_defconfig 
CONFIG_ADB_PMU68K=y

This works fine for PMU_68K_V2 machines. But if you try to boot a 
PMU_68K_V1 machine, you will have trouble starting the kernel. Sometimes 
you can boot by fiddling with ADB devices, but not always. This is not a 
new problem. The via-pmu68k driver has never worked on PMU_68K_V1 
machines.

So as far as PMU_68K_V1 is concerned, there's no need to bisect any of the 
changes under review. To answer your question, "Shouldn't that be a 
separate patch?", all I can say is "not to my knowledge". But I'm probably 
missing something.

-- 
