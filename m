Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeBTIKs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:10:48 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55359 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeBTIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:10:46 -0500
X-Google-Smtp-Source: AH8x22479m+0cmGiHkeL67iDRLv9HQ4UCWJIImSRJTw0ZHI4miB6BTB+trLX2XNDZ3OiYkeXamQ3eA==
Date: Tue, 20 Feb 2018 09:10:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86: consider effective protection attributes in
 W+X check
Message-ID: <20180220081042.wgriecqneizg3df7@gmail.com>
References: <5A8BDF3602000078001A96CD@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8BDF3602000078001A96CD@prv-mh.provo.novell.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <JBeulich@suse.com> wrote:

> Using just the leaf page table entry flags would cause a false warning
> in case _PAGE_RW is clear or _PAGE_NX is set in a higher level entry.

Under what circumstances did you see false positive warnings?

> Hand through both the current entry's flags as well as the accumulated
> effective value (the latter as pgprotval_t instead of pgprot_t, as it's
> not an actual entry's value).
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/mm/dump_pagetables.c |   92 ++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 35 deletions(-)

Could you please rebase this on top of latest tip:master, which changed 
arch/x86/mm/dump_pagetables.c non-trivially due the dynamic 5 level paging 
changes?

Thanks,

	Ingo
