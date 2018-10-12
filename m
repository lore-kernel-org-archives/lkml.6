Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A67C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09D220645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09D220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJMBrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:47:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49932 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeJMBrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:47:20 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SRChmGzZdRtL; Fri, 12 Oct 2018 20:13:35 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCC2400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:2400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 834201EC04DE;
        Fri, 12 Oct 2018 20:13:35 +0200 (CEST)
Date:   Fri, 12 Oct 2018 20:13:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ingo Molnar <mingo@kernel.org>, arnd@arndb.de,
        akpm@linux-foundation.org, luto@kernel.org,
        dave.hansen@linux.intel.com, jroedel@suse.de,
        keescook@chromium.org, torvalds@linux-foundation.org,
        toshi.kani@hpe.com, Thomas Gleixner <tglx@linutronix.de>,
        sfr@canb.auug.org.au, kernel list <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: Re: Avoid VLA in pgd_alloc kills boot on 32-bit machines was Re:
 -next20181010,1011 regression: thinkpad x60 (32 bit) dies during boot.
Message-ID: <20181012181335.GG12328@zn.tnic>
References: <20181010195920.GA13860@amd>
 <20181010200331.GA13975@amd>
 <20181011180328.GA6740@amd>
 <alpine.DEB.2.21.1810112208200.1457@nanos.tec.linutronix.de>
 <20181012102459.GA4469@amd>
 <20181012105254.GA114888@gmail.com>
 <20181012181011.GA9098@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181012181011.GA9098@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 08:10:11PM +0200, Pavel Machek wrote:
> And the winner is...
> 
> [1be3f247c2882a82279cbcf43717581ea943b692] x86/mm: Avoid VLA in
> pgd_alloc()

That should be fixed now:

https://git.kernel.org/tip/184d47f0fd365108bd06ab26cdb3450b716269fd

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
