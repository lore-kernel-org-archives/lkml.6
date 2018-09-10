Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A35C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3E820870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3E820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeIJV5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:57:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40061 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeIJV5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:57:47 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzPaG-0005Ir-84; Mon, 10 Sep 2018 19:02:44 +0200
Date:   Mon, 10 Sep 2018 19:02:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
In-Reply-To: <20180910164631.GV5565@intel.com>
Message-ID: <alpine.DEB.2.21.1809101857510.1419@nanos.tec.linutronix.de>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com> <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de> <20180910140710.GR5565@intel.com> <alpine.DEB.2.21.1809101816320.1419@nanos.tec.linutronix.de> <20180910164631.GV5565@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1759614852-1536598964=:1419"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1759614852-1536598964=:1419
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 10 Sep 2018, Ville Syrjälä wrote:
> On Mon, Sep 10, 2018 at 06:23:49PM +0200, Thomas Gleixner wrote:
> > 1) My workflow makes things tagged as BUG and REGRESSION urgent
> >    automatically while [PATCH] just is queued to the normal pile of
> >    backlog, i.e. at the end. It just sprang into my eyes by chance, but in
> >    general you might just get the contrary of what you are looking for.
> 
> Ah. Might be nice to document that somewhere. I might have to type up
> that git-regression tool for myself, because I'm lazy.

Well, it's probably different between maintainers, but it's common practice
to have '[REGRESION] sub/sys got fubarred' in the subject.

> > 2) A proper bug report with proper information (it's documented what should
> >    be provided), is way more worth than a patch with a mostly useless
> >    change log, which forces me to ask for the proper information instead of
> >    having it right away.
> 
> I do agree that not having to ask for more information would be nice,
> but hard to generalize because every subsystem needs different things.
> 
> In this case you asked for the dmesg, which isn't even mentioned in
> Documentation/admin-guide/reporting-bugs.rst as far as I can see.
> So I'm not quite sure which documentation you're referring to here.

I didn't look, but I expected dmesg to be part of it and a lot of people
provide it as well as the start point of their bisection. Again, I had to
do a shot into the dark and ask you whether it's fixed in -rc3. bisect
start would have told me.

So again. That revert patch habit does not make my life easier at all.

Thanks,

	tglx
--8323329-1759614852-1536598964=:1419--
