Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeCNT4p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:56:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52124 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeCNT4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:56:44 -0400
Date: Wed, 14 Mar 2018 20:56:41 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kani, Toshi" <toshi.kani@hpe.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gratian.crisan@ni.com" <gratian.crisan@ni.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86/mm: remove pointless checks in vmalloc_fault
In-Reply-To: <1521056327.2693.138.camel@hpe.com>
Message-ID: <alpine.DEB.2.21.1803142054390.1946@nanos.tec.linutronix.de>
References: <20180313170347.3829-1-toshi.kani@hpe.com>  <20180313170347.3829-3-toshi.kani@hpe.com>  <alpine.DEB.2.21.1803142024540.1946@nanos.tec.linutronix.de> <1521056327.2693.138.camel@hpe.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Kani, Toshi wrote:
> On Wed, 2018-03-14 at 20:27 +0100, Thomas Gleixner wrote:
> > On Tue, 13 Mar 2018, Toshi Kani wrote:
> > 
> > > vmalloc_fault() sets user's pgd or p4d from the kernel page table.
> > > Once it's set, all tables underneath are identical. There is no point
> > > of following the same page table with two separate pointers and makes
> > > sure they see the same with BUG().
> > > 
> > > Remove the pointless checks in vmalloc_fault(). Also rename the kernel
> > > pgd/p4d pointers to pgd_k/p4d_k so that their names are consistent in
> > > the file.
> > 
> > I have no idea to which branch this might apply. The first patch applies
> > cleanly on linus head, but this one fails in hunk #2 on everything I
> > tried. Can you please check?
> 
> Sorry for the trouble. The patches are based on linus head. I just tried
> and they applied clean to me... 

Hmm. Looks like I tried on the wrong branch. Nevertheless, 1/2 is queued in
urgent, but 2/2 will go through tip/x86/mm which already has changes in
that area causing the patch to fail. I just merged x86/urgent into x86/mm
and pushed it out. Can you please rebase 2/2 on top of that bracnh and
resend ?

Thanks,

	tglx
