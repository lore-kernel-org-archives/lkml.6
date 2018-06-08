Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gEiLFk9JGlu+LQAAmS7hNA
	; Fri, 08 Jun 2018 09:15:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4EC0E607E4; Fri,  8 Jun 2018 09:15:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D030C602FC;
	Fri,  8 Jun 2018 09:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D030C602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeFHJP4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:15:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49598 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeFHJPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:15:54 -0400
Received: from 79.184.253.104.ipv4.supernova.orange.pl (79.184.253.104) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 01a1c7a6629070fa; Fri, 8 Jun 2018 11:15:52 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: linux-next: build warning after merge of the pm tree
Date: Fri, 08 Jun 2018 11:14:54 +0200
Message-ID: <2704837.jejCyCdvyd@aspire.rjw.lan>
In-Reply-To: <20180608103035.266fa61b@canb.auug.org.au>
References: <20180608103035.266fa61b@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 8, 2018 2:30:35 AM CEST Stephen Rothwell wrote:
> 
> --Sig_/ncqmE76IGCiWNItKgM.lURc
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi all,

Hi,

> After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> WARNING: vmlinux.o(.text+0xc5b83a): Section mismatch in reference from the =
> function __intel_pstate_cpu_init() to the variable .init.rodata:intel_pstat=
> e_hwp_boost_ids
> The function __intel_pstate_cpu_init() references
> the variable __initconst intel_pstate_hwp_boost_ids.
> This is often because __intel_pstate_cpu_init lacks a __initconst=20
> annotation or the annotation of intel_pstate_hwp_boost_ids is wrong.
> 
> Introduced by commit
> 
>   f50f70793d78 ("cpufreq: intel_pstate: enable boost for Skylake Xeon")

Thanks for the report!

I've dropped the __initconst annotation from intel_pstate_hwp_boost_ids[].

Thanks,
Rafael
