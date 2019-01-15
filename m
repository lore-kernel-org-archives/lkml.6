Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4354CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E9020651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfAOKf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:35:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41989 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfAOKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:35:59 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjM4K-0003Fl-7L; Tue, 15 Jan 2019 11:35:40 +0100
Date:   Tue, 15 Jan 2019 11:35:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juergen Gross <jgross@suse.com>
cc:     peng.hao2@zte.com.cn, bp@alien8.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/mem_encrypt_identity : fix error useage to
 sizeof
In-Reply-To: <alpine.DEB.2.21.1901151124160.1865@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1901151134340.1865@nanos.tec.linutronix.de>
References: <201901071946365174691@zte.com.cn> <alpine.DEB.2.21.1901151109070.1865@nanos.tec.linutronix.de> <cc31816f-a4b1-b694-dcac-ac13f4442508@suse.com> <alpine.DEB.2.21.1901151124160.1865@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019, Thomas Gleixner wrote:

> On Tue, 15 Jan 2019, Juergen Gross wrote:
> > On 15/01/2019 11:13, Thomas Gleixner wrote:
> > > On Mon, 7 Jan 2019, peng.hao2@zte.com.cn wrote:
> > > 
> > >>>> Fix error usage to sizeof. It should not use sizeof to pointer.
> > >>>
> > >>> .... because?
> > >>>
> > >>> The commit message needs to explain what the potential issue could be
> > >>> and why it doesn't matter in this case.
> > >> I see the definition of pte_t may be more than sizeof(unsigned long).
> > >> So I think sizeof(pte_t) is safer.
> > > 
> > > What exactly is the difference between:
> > > 
> > > 	pte_t	*p;
> > > 
> > > 	sizeof(*p)
> > > 
> > > and
> > > 
> > > 	sizeof(pte_t)
> > > 
> > > and what is safer about the latter?
> > 
> > Please note that the current code is using sizeof(p) instead of sizeof(*p).
> 
> Ooops. That's wrong indeed, but we should not change it to sizeof(pte_t)
> and change it to sizeof(*p) instead.

Which is what the patch actually does. Just the above reply:

> > >> So I think sizeof(pte_t) is safer.

confused the hell out of me. -ENOTENOUGHCOFFEE
