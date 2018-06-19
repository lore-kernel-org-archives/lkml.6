Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B84C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D753B2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D753B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756613AbeFSJMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:12:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37186 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756212AbeFSJML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:12:11 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mEx7vSJF31Hx; Tue, 19 Jun 2018 11:12:10 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD1DD00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:dd00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E4271EC0077;
        Tue, 19 Jun 2018 11:12:10 +0200 (CEST)
Date:   Tue, 19 Jun 2018 11:12:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        hpa@zytor.com
Subject: Re: [PATCH] x86/microcode/intel: Ensure new microcode processor
 flags match with cpu's pf
Message-ID: <20180619091205.GA30870@zn.tnic>
References: <7d20be40-4c15-4e15-a4d0-cd2efda6d701@default>
 <20180618195619.GH24921@zn.tnic>
 <ed92d414-9869-cd06-eee1-1035cc574cf4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed92d414-9869-cd06-eee1-1035cc574cf4@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:49:40PM +0800, Zhenzhong Duan wrote:
> Imagine kernel already found a microcode blob A with extended sig/pf
> matching current cpu, then another microcode B is checked which doesn't
> match current cpu...

Do you see the

	if (!microcode_matches(mc_header, uci->cpu_sig.sig)) {

call a couple of lines earlier?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
