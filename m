Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690742081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690742081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeLJI2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:28:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:59686 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeLJI2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:28:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 00:28:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="124518134"
Received: from jlahtine-mobl.ger.corp.intel.com (HELO jlahtine-mobl.fi.intel.com) ([10.237.66.147])
  by fmsmga002.fm.intel.com with ESMTP; 10 Dec 2018 00:28:40 -0800
Message-ID: <64409c484c0601e7504ccc0cf8d211b3bb524ebe.camel@linux.intel.com>
Subject: Re: v4.20-rc1: list_del corruption on thinkpad x220, graphics
 related?
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     bp@alien8.de, hpa@zytor.com,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, jani.nikula@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        chris@chris-wilson.co.uk
Date:   Mon, 10 Dec 2018 10:28:39 +0200
In-Reply-To: <20181208112447.GA9663@amd>
References: <20181108175803.GA10785@amd>
         <154279919462.20217.14259089584802660420@jlahtine-desk.ger.corp.intel.com>
         <20181121115449.GA32455@amd>
         <154296105546.7930.1457928786446716358@jlahtine-desk.ger.corp.intel.com>
         <20181124152352.GA9548@amd> <20181208111346.GA5535@amd>
         <20181208112447.GA9663@amd>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-08 at 12:24 +0100, Pavel Machek wrote:
> On Sat 2018-12-08 12:13:46, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > There's one similar for nouveau in Bugzilla, but it seems like a genuine
> > > > > > memory corruption (1 bit flipped):
> > > > > > 
> > > > > > https://bugs.freedesktop.org/show_bug.cgi?id=84880
> > > > > > 
> > > > > > Any extra information would be of use :)
> > > > > > 
> > > > > > Regards, Joonas
> > > > > > 
> > > > > > PS. Could you open a bug to Bugzilla, it'll help to collect the
> > > > > > information in one consolidated place:
> > > > > > 
> > > > > > https://01.org/linuxgraphics/documentation/how-report-bugs
> > > > > 
> > > > > I prefer email... certainly for bugs that can't be reproduced.
> > > > 
> > > > By adding it to the Bugzilla it may be recognized by somebody else
> > > > who is experiencing a similar issue. Internet points are not deducted
> > > > for submitting bugs in good faith, even if they get closed as
> > > > NOTABUG.
> > 
> > Well, your documentation suggests you'll deduce my internet points:
> > 
> > 	Before filing the bug, please try to reproduce your issue with the
> > 	latest kernel. Use the latest drm-tip branch from
> > 	http://cgit.freedesktop.org/drm-tip and build as instructed on our
> > 	Build Guide.
> > 
> > :-)
> 
> I'd prefer not to run drm-tip. I'll update to 2.6.20-rc5+ and see if
> it re-appears (but it takes long time to reproduce :-().

If we can or can not reproduce the issue with drm-tip, is a very useful
datapoint for us. If we can not reproduce, it'll be possible to bisect
which commit fixed it, and backport that. On the other hand, if it's
still reproducible, we know we're not spending time on something we
already fixed, and the priority gets a bump.

> If you think it is useful, I can try to update my machine to
> linux-next.

linux-next is closer to drm-tip, so it's better. Do you have some
specific reason for not wanting to run drm-tip (but linux-next is still
ok)?

Regards, Joonas

> 
> Best regards,
> 									Pavel
> 
-- 
Joonas Lahtinen
Open Source Graphics Center
Intel Corporation

