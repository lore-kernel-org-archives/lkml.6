Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04022C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9356218D0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfABJeg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:34:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:48305 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfABJeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:34:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 01:34:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,430,1539673200"; 
   d="scan'208";a="263795505"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.251.83.195])
  by orsmga004.jf.intel.com with ESMTP; 02 Jan 2019 01:34:31 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Pavel Machek <pavel@ucw.cz>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20181227083439.GA30407@amd>
Cc:     bp@alien8.de, hpa@zytor.com,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, jani.nikula@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        chris@chris-wilson.co.uk
References: <20181108175803.GA10785@amd> <20181121115449.GA32455@amd>
 <154296105546.7930.1457928786446716358@jlahtine-desk.ger.corp.intel.com>
 <20181124152352.GA9548@amd> <20181208111346.GA5535@amd>
 <20181208112447.GA9663@amd>
 <64409c484c0601e7504ccc0cf8d211b3bb524ebe.camel@linux.intel.com>
 <20181212182902.GA7380@amd>
 <154468977288.4945.12937975200892746470@jlahtine-desk.ger.corp.intel.com>
 <20181227083439.GA30407@amd>
Message-ID: <154642167000.6261.3235659892574932494@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [regression from v4.19] Re: 4.20.0-rc6-next-20181210,
 v4.20-rc1: list_del corruption on thinkpad x220, graphics related?
Date:   Wed, 02 Jan 2019 11:34:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel Machek (2018-12-27 10:34:39)
> Hi!
> 
> > > > > If you think it is useful, I can try to update my machine to
> > > > > linux-next.
> > > > 
> > > > linux-next is closer to drm-tip, so it's better. Do you have some
> > > > specific reason for not wanting to run drm-tip (but linux-next is still
> > > > ok)?
> > > 
> > > I already have build/update scripts for -next, and I trust -next not
> > > to store screenshots of my desktop in my master boot record :-).
> > > 
> > > Anyway, it does happen with -next. This time, chromiums were running,
> > > and crash happened minute? after I exited flightgear. It can be seen
> > > in the logs.
> > > 
> > > Oh and I might want to mention -- machine was rather deep in swap this
> > > time, as in "mouse jumping when starting fgfs" and "could feel the
> > > chromium being swapped back in". I might have had this situation
> > > before, and just powercycled the machine "because it is so deep in
> > > swap that it will not recover".
> > > 
> > > top says:
> > > 
> > > top - 19:18:24 up 2 days,  8:03,  2 users,  load average: 3.02, 3.45,
> > > 3.21
> > > Tasks: 141 total,   1 running,  86 sleeping,   0 stopped,   2 zombie
> > > %Cpu(s): 18.8 us,  7.6 sy,  3.0 ni, 68.4 id,  1.3 wa,  0.0 hi,  0.9
> > > si,  0.0 st
> > > KiB Mem:   5967968 total,   663244 used,  5304724 free,    48876
> > > buffers
> > > KiB Swap:  1681428 total,   170904 used,  1510524 free.   446280
> > > cached Mem
> > > 
> > > ....but of course that memory is free once everything died.
> > > 
> > > Any ideas? Should I go back to v4.19 to see if it happens there, too?
> > 
> > linux-next includes very much the same code as drm-tip. There's nobody
> > magically reviewing the code more than it is reviewed for inclusion into
> > drm-tip, when it is fed into linux-next. So thinking linux-next would be
> > some way safer is an illusion.
> > 
> > It sounds like having memory pressure expedites the corruption, which
> > should make it easier to reproduce and thus fix.
> > 
> > So if you could please try drm-tip reproducing AND open a bug in Bugzilla.
> > If you are unwilling to do that, it is very difficult to help you
> > more.
> 
> Website says I have to read and agree to two different pieces of
> legalesee, and I'd need to keep track of yet another password... so
> you can "communicate" with me.
> 
> But you can already communicate with me, over email.

I've listed all the reasons why our bug handling process is what it is.

If registering to the Bugzilla is too much of an effort for you, then I
won't be able to help you further on this.

Regards, Joonas

> I verified v4.19 is stable -- it worked ok for way more than two days
> it usually takes to crash.
> 
>                                                                 Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
