Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD1FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD3A2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KoDxIeyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfANUSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:18:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56608 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfANUST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:18:19 -0500
Received: from zn.tnic (p200300EC2BC4CA00255595821D34C4F7.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:2555:9582:1d34:c4f7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3777F1EC0B55;
        Mon, 14 Jan 2019 21:18:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547497098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dMs8Pj0hv0+eSu5zDNdFQcC8A/HHvUZxEu39CidEhTs=;
        b=KoDxIeyjDoOLJm+lcLDqVN3Z/PhzTDsdSTKnveeZ+1Cy3mMN0tccTls2TPY0z7wEATHfGn
        dtosCVcZVWpLv9MtPBoDQZlrB61MIsH2yMNHOpkvoUs4clyUSfX8nwt/d7KCp7KXy3LRgp
        xuCbBzyThiUvkvi22AnL3xFNeBgPlBo=
Date:   Mon, 14 Jan 2019 21:18:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Anderson <anderson@redhat.com>
Cc:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190114201812.GT2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190111123300.GE4729@zn.tnic>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp>
 <20190114180142.GO2773@zn.tnic>
 <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com>
 <20190114192144.GQ2773@zn.tnic>
 <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com>
 <20190114195940.GS2773@zn.tnic>
 <244986363.69770015.1547496453312.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <244986363.69770015.1547496453312.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:07:33PM -0500, Dave Anderson wrote:
> That's what it *does* utilize -- it takes a standalone vmcore dumpfile, and 
> pulls out the OSRELEASE string from it, so that a user can determine what
> vmlinux file should be used with that vmcore for normal crash analysis.

And the vmcoreinfo is part of the vmcore, right?

So it can just as well read out the address of init_uts_ns and get the
kernel version from there.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
