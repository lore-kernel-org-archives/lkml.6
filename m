Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F256BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78CD20645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78CD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeIJVli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:41:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:61146 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeIJVli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:41:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 09:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="79367717"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 10 Sep 2018 09:46:32 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 10 Sep 2018 19:46:31 +0300
Date:   Mon, 10 Sep 2018 19:46:31 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
Message-ID: <20180910164631.GV5565@intel.com>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
 <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
 <20180910140710.GR5565@intel.com>
 <alpine.DEB.2.21.1809101816320.1419@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1809101816320.1419@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 06:23:49PM +0200, Thomas Gleixner wrote:
> On Mon, 10 Sep 2018, Ville Syrjälä wrote:
> > On Mon, Sep 10, 2018 at 02:48:45PM +0200, Thomas Gleixner wrote:
> > > On Mon, 10 Sep 2018, Ville Syrjala wrote:
> > > I asked for that before and I really do not understand why you do not even
> > > make an attempt to report an issue first and allow the developers to work
> > > with you to figure out what exactly is the problem. All you do is to send
> > > an revert patch with a changelog which describes symptoms and probably
> > > breaks more than it cures. Not really helpful, really.
> > 
> > You're reading way too much into this. The revert is just a point to
> > start the conversion. I've found that it's the best way to get the
> > attention of the relevant developers. Other kind of regression
> > reports have an unfortunate habit of disappearing into /dev/null.
> 
> 1) My workflow makes things tagged as BUG and REGRESSION urgent
>    automatically while [PATCH] just is queued to the normal pile of
>    backlog, i.e. at the end. It just sprang into my eyes by chance, but in
>    general you might just get the contrary of what you are looking for.

Ah. Might be nice to document that somewhere. I might have to type up
that git-regression tool for myself, because I'm lazy.

> 
> 2) A proper bug report with proper information (it's documented what should
>    be provided), is way more worth than a patch with a mostly useless
>    change log, which forces me to ask for the proper information instead of
>    having it right away.

I do agree that not having to ask for more information would be nice,
but hard to generalize because every subsystem needs different things.

In this case you asked for the dmesg, which isn't even mentioned in
Documentation/admin-guide/reporting-bugs.rst as far as I can see.
So I'm not quite sure which documentation you're referring to here.

-- 
Ville Syrjälä
Intel
