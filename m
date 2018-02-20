Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeBTIcY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:32:24 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55377 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbeBTIcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:32:23 -0500
X-Google-Smtp-Source: AH8x226GleKCmS5bnriUaYwLjtPk21EfcASdY5LDlF+LXYV49uWbJVcd4y2FQUGvUGNeEihRFDpXyg==
Date: Tue, 20 Feb 2018 09:32:11 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: mingo@elte.hu, tglx@linutronix.de,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: Re: [PATCH RESEND] x86: consider effective protection attributes in
 W+X check
Message-ID: <20180220083211.s5wr5r7ocpzzizgp@gmail.com>
References: <5A8BDF3602000078001A96CD@prv-mh.provo.novell.com>
 <20180220081042.wgriecqneizg3df7@gmail.com>
 <5A8BE8C602000078001A9729@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8BE8C602000078001A9729@prv-mh.provo.novell.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <JBeulich@suse.com> wrote:

> >>> On 20.02.18 at 09:10, <mingo@kernel.org> wrote:
> > * Jan Beulich <JBeulich@suse.com> wrote:
> >> Using just the leaf page table entry flags would cause a false warning
> >> in case _PAGE_RW is clear or _PAGE_NX is set in a higher level entry.
> > 
> > Under what circumstances did you see false positive warnings?
> 
> As explained in the 2-patch series this was originally part of, there
> continues to be that W+X warning when running under Xen, as
> commit 2cc42bac1c ("x86-64/Xen: eliminate W+X mappings") has
> to make the necessary adjustment in L2 rather than L1 (the
> reason is explained there). I.e. _PAGE_RW is clear there in L1,
> but _PAGE_NX is set in L2.

This would make an excellent additional paragraph of the v2 changelog.

Thanks,

	Ingo
