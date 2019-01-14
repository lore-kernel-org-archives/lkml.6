Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7818620651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="T99i/9z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfANTVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:21:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANTVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:21:53 -0500
Received: from zn.tnic (p200300EC2BC4CA000555087DEC7D7788.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:555:87d:ec7d:7788])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F0031EC0230;
        Mon, 14 Jan 2019 20:21:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547493711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mkDPutUIcOOoei5m4JrbziQzip8YrilmtQCS07y9ISE=;
        b=T99i/9z5nKeCUwtQI92pWGmUGDzHyD8yy5cJMorRPy22n0R9aHkTd7JjbHgHXrabFFHahH
        gNpB8WvNWjvZ+/1N+FrwBBLB5z9vZPxzb8vdLsHI2KKlZJi3+YXKZJbGZ2B0W5/nal4wl6
        qoHJkDaS6t9fhKZGaIxAZSjO9FWMMw8=
Date:   Mon, 14 Jan 2019 20:21:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Anderson <anderson@redhat.com>
Cc:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190114192144.GQ2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com>
 <20190111123300.GE4729@zn.tnic>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp>
 <20190114180142.GO2773@zn.tnic>
 <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 01:58:32PM -0500, Dave Anderson wrote:
> Preferably it would be left as-is.  The crash utility has a "crash --osrelease vmcore"
> option that only looks at the dumpfile header, and just dump the string.  With respect
> to compressed kdumps, crash could alternatively look at the utsname data that is stored
> in the diskdump_header.utsname field, but with ELF vmcores, there is no such back-up.

Well, there is:

00000000  4f 53 52 45 4c 45 41 53  45 3d 35 2e 30 2e 30 2d  |OSRELEASE=5.0.0-|
00000010  72 63 32 2b 0a 50 41 47  45 53 49 5a 45 3d 34 30  |rc2+.PAGESIZE=40|
00000020  39 36 0a 53 59 4d 42 4f  4c 28 6d 65 6d 5f 73 65  |96.SYMBOL(mem_se|
00000030  63 74 69 6f 6e 29 3d 66  66 66 66 66 66 66 66 38  |ction)=ffffffff8|
00000040  34 35 31 61 31 61 38 0a  53 59 4d 42 4f 4c 28 69  |451a1a8.SYMBOL(i|
00000050  6e 69 74 5f 75 74 73 5f  6e 73 29 3d 66 66 66 66  |nit_uts_ns)=ffff|
									 ^^^^
00000060  66 66 66 66 38 32 30 31  33 35 34 30 0a 53 59 4d  |ffff82013540
							     ^^^^^^^^^^^^

This address has it.

> What's the problem with leaving it alone?

The problem is that I'd like to get all those vmcoreinfo exports under
control and to not have people frivolously export whatever they feel
like, for obvious reasons, and to get rid of the duplicate/unused pieces
being part of vmcoreinfo.

I'm guessing removing OSRELEASE would simplify the kernel a bit by
getting rid of the VMCOREINFO_OSRELEASE define and export, and userspace
can read out the kernel version from init_uts_ns which is also exported.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
