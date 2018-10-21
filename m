Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B685ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AC12083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 15:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AC12083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJUX2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 19:28:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43102 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeJUX23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 19:28:29 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T-_q2N-APWE6; Sun, 21 Oct 2018 17:13:31 +0200 (CEST)
Received: from zn.tnic (p200300EC2BE60200329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be6:200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95F631EC01A8;
        Sun, 21 Oct 2018 17:13:31 +0200 (CEST)
Date:   Sun, 21 Oct 2018 17:13:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>,
        peterz@infradead.org, x86@kernel.org, eranian@google.com,
        kan.liang@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/cpufeature: Add facility to match microcode
 revisions
Message-ID: <20181021151319.GD26247@zn.tnic>
References: <20181010162608.23899-1-andi@firstfloor.org>
 <alpine.DEB.2.21.1810171151010.6000@nanos.tec.linutronix.de>
 <20181019234743.GA27951@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1810201017070.1651@nanos.tec.linutronix.de>
 <20181020143857.GC27951@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1810210954440.1651@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810210954440.1651@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 12:20:47PM +0200, Thomas Gleixner wrote:
> struct x86_cpu_check {

Btw, if we have to be precise, this struct is no "check" struct either.

> 	u8	vendor;
> 	u8	family;
> 	u8	model;
> 	u8	stepping;
> };

If anything, it is a x86_cpu_type or x86_cpu_desc(riptor) or so -
basically a tuple of items which determine a CPU type uniquely.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
