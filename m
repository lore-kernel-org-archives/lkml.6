Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8320C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B299720811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B299720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeLMI3i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:29:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:33680 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLMI3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:29:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 00:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="98409523"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.251.85.148])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2018 00:29:34 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Pavel Machek <pavel@ucw.cz>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20181212182902.GA7380@amd>
Cc:     bp@alien8.de, hpa@zytor.com,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, jani.nikula@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        chris@chris-wilson.co.uk
References: <20181108175803.GA10785@amd>
 <154279919462.20217.14259089584802660420@jlahtine-desk.ger.corp.intel.com>
 <20181121115449.GA32455@amd>
 <154296105546.7930.1457928786446716358@jlahtine-desk.ger.corp.intel.com>
 <20181124152352.GA9548@amd> <20181208111346.GA5535@amd>
 <20181208112447.GA9663@amd>
 <64409c484c0601e7504ccc0cf8d211b3bb524ebe.camel@linux.intel.com>
 <20181212182902.GA7380@amd>
Message-ID: <154468977288.4945.12937975200892746470@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: 4.20.0-rc6-next-20181210, v4.20-rc1: list_del corruption on thinkpad x220,
 graphics related?
Date:   Thu, 13 Dec 2018 10:29:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel Machek (2018-12-12 20:29:02)
> Hi!
> 
> > > > > > > > There's one similar for nouveau in Bugzilla, but it seems like a genuine
> > > > > > > > memory corruption (1 bit flipped):
> > > > > > > > 
> > > > > > > > https://bugs.freedesktop.org/show_bug.cgi?id=84880
> > > > > > > > 
> > > > > > > > Any extra information would be of use :)
> > > > > > > > 
> > > > > > > > Regards, Joonas
> > > > > > > > 
> > > > > > > > PS. Could you open a bug to Bugzilla, it'll help to collect the
> > > > > > > > information in one consolidated place:
> > > > > > > > 
> > > > > > > > https://01.org/linuxgraphics/documentation/how-report-bugs
> > > > > > > 
> > > > > > > I prefer email... certainly for bugs that can't be reproduced.
> > > > > > 
> > > > > > By adding it to the Bugzilla it may be recognized by somebody else
> > > > > > who is experiencing a similar issue. Internet points are not deducted
> > > > > > for submitting bugs in good faith, even if they get closed as
> > > > > > NOTABUG.
> > > > 
> > > > Well, your documentation suggests you'll deduce my internet points:
> > > > 
> > > >   Before filing the bug, please try to reproduce your issue with the
> > > >   latest kernel. Use the latest drm-tip branch from
> > > >   http://cgit.freedesktop.org/drm-tip and build as instructed on our
> > > >   Build Guide.
> > > > 
> > > > :-)
> > > 
> > > I'd prefer not to run drm-tip. I'll update to 2.6.20-rc5+ and see if
> > > it re-appears (but it takes long time to reproduce :-().
> > 
> > If we can or can not reproduce the issue with drm-tip, is a very useful
> > datapoint for us. If we can not reproduce, it'll be possible to bisect
> > which commit fixed it, and backport that. On the other hand, if it's
> > still reproducible, we know we're not spending time on something we
> > already fixed, and the priority gets a bump.
> 
> bisect ... is not practical on something that takes 2 days to reproduce.
> 
> > > If you think it is useful, I can try to update my machine to
> > > linux-next.
> > 
> > linux-next is closer to drm-tip, so it's better. Do you have some
> > specific reason for not wanting to run drm-tip (but linux-next is still
> > ok)?
> 
> I already have build/update scripts for -next, and I trust -next not
> to store screenshots of my desktop in my master boot record :-).
> 
> Anyway, it does happen with -next. This time, chromiums were running,
> and crash happened minute? after I exited flightgear. It can be seen
> in the logs.
> 
> Oh and I might want to mention -- machine was rather deep in swap this
> time, as in "mouse jumping when starting fgfs" and "could feel the
> chromium being swapped back in". I might have had this situation
> before, and just powercycled the machine "because it is so deep in
> swap that it will not recover".
> 
> top says:
> 
> top - 19:18:24 up 2 days,  8:03,  2 users,  load average: 3.02, 3.45,
> 3.21
> Tasks: 141 total,   1 running,  86 sleeping,   0 stopped,   2 zombie
> %Cpu(s): 18.8 us,  7.6 sy,  3.0 ni, 68.4 id,  1.3 wa,  0.0 hi,  0.9
> si,  0.0 st
> KiB Mem:   5967968 total,   663244 used,  5304724 free,    48876
> buffers
> KiB Swap:  1681428 total,   170904 used,  1510524 free.   446280
> cached Mem
> 
> ....but of course that memory is free once everything died.
> 
> Any ideas? Should I go back to v4.19 to see if it happens there, too?

linux-next includes very much the same code as drm-tip. There's nobody
magically reviewing the code more than it is reviewed for inclusion into
drm-tip, when it is fed into linux-next. So thinking linux-next would be
some way safer is an illusion.

It sounds like having memory pressure expedites the corruption, which
should make it easier to reproduce and thus fix.

So if you could please try drm-tip reproducing AND open a bug in Bugzilla.
If you are unwilling to do that, it is very difficult to help you more.

Regards, Joonas

> 
> 
>                                                                         Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
