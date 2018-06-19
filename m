Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF0CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AF220874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AF220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965592AbeFSJf6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:35:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37986 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756382AbeFSJf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:35:57 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YQ5ntIQ2Lym2; Tue, 19 Jun 2018 11:35:56 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD1DD00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:dd00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 634301EC0077;
        Tue, 19 Jun 2018 11:35:56 +0200 (CEST)
Date:   Tue, 19 Jun 2018 11:35:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        hpa@zytor.com
Subject: Re: [PATCH] x86/microcode/intel: Ensure new microcode processor
 flags match with cpu's pf
Message-ID: <20180619093552.GB30870@zn.tnic>
References: <7d20be40-4c15-4e15-a4d0-cd2efda6d701@default>
 <20180618195619.GH24921@zn.tnic>
 <ed92d414-9869-cd06-eee1-1035cc574cf4@oracle.com>
 <20180619091205.GA30870@zn.tnic>
 <a9c21f46-af2c-28aa-b539-a8b6a6fc666b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9c21f46-af2c-28aa-b539-a8b6a6fc666b@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 05:24:20PM +0800, Zhenzhong Duan wrote:
> On 2018/6/19 17:12, Borislav Petkov wrote:
> > On Tue, Jun 19, 2018 at 12:49:40PM +0800, Zhenzhong Duan wrote:
> > > Imagine kernel already found a microcode blob A with extended sig/pf
> > > matching current cpu, then another microcode B is checked which doesn't
> > > match current cpu...
> > Do you see the
> > 
> > 	if (!microcode_matches(mc_header, uci->cpu_sig.sig)) {
> > 
> > call a couple of lines earlier?
> Sure, but it didn't ensure a match in stepping and pf, is that expected?

Do you see the

	if (!has_newer_microcode(data,
				 uci->cpu_sig.sig,
                                 uci->cpu_sig.pf,
                                 uci->cpu_sig.rev))

a couple lines later?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
