Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3B7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5554A20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfBDLr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:47:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:21552 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfBDLr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:47:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 03:47:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="115115028"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga008.jf.intel.com with ESMTP; 04 Feb 2019 03:47:25 -0800
Date:   Mon, 4 Feb 2019 13:47:24 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
Message-ID: <20190204114724.GB26799@linux.intel.com>
References: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
 <CAHk-=whOU=Ek3C6=r2xkTtdv==He=KxUjz_8x2Jo3nJJiDW3VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whOU=Ek3C6=r2xkTtdv==He=KxUjz_8x2Jo3nJJiDW3VQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 09:49:05AM -0800, Linus Torvalds wrote:
> On Fri, Feb 1, 2019 at 3:33 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > Thus, it makes sense to fix this also in tpm_crb, not least because
> > the fix can be then backported to stable kernels and make them more robust
> > when compiled in differing environments.
> 
> Ack, looks sane to me, and should help both the backport and probably
> generate better code too.
> 
> In the meantime, I've committed the iomem.c change with a *long*
> commit message. For all we know, there might be other cases like this
> lurking somewhere else that just happened to work. Plus it's the right
> thing to do anyway.
> 
>                Linus

Great!

Umh, so, should my tpm_crb change committed to 5.0 with the minor changes
implemented suggested by Tomas or not? Can also include it to my 5.1 PR.
Either WFM.

/Jarkko
