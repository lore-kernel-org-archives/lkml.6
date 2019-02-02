Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A429DC282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ECB20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubrvmD3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfBBGYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:24:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42501 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfBBGYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:24:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so7640690lja.9;
        Fri, 01 Feb 2019 22:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DnqhF5gHFk9bMSL9GD67HmROWlsKxBC1bzf9JrN1XCo=;
        b=ubrvmD3uckj2KzpyqiRYstsKIHHL4PU7r/ICpItC7EC71ugEFSt0W9b74JZVl9Brzt
         tPSJzEw1ZBs+JxG+mgX2OghVmZ3BgCH/OwOLqla+HTA7l5Nr6FSCeeziNnD9/w91rei9
         E5Ngl9Wa6Aeu9qp53URjxj1TbHomtOPRLJu4HNMoRLtGT7o7opcQGTLgeftu/woBVlCM
         xo9R5i2tdDazBUcKwOtCTtz2JH9GRY0FSo7SHa9q1EhOfN0wOMpG45/FWImzZXnpsvrK
         wo4xaAQZXOLRd6xIFn9wN22n7AGdW1J/3QO3cYSrD9bSoQ47hhkSUlQZYw8gXQVODrze
         J4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DnqhF5gHFk9bMSL9GD67HmROWlsKxBC1bzf9JrN1XCo=;
        b=Qk0tZ+bFf7Esya2jgN2F59fmSiPMuffwp9nP47LJHDdrnhky7vCiE1o3p/ILQ7+tIl
         upC6B4aBsnNMqVoBFSMMyRrGljBhKGIcQJWVSndhXa0uVhKzFwCIM+Ob6WI+BVbjkNPR
         HRp5doaHVKWcoQ8byYg5exIa2nLDaXFr97frDmEXQbZcAt6IZTMEc2tRx9CAd7MoLfYx
         eSieJg9JOFD+sgQ8Mf37CCmMflIrXxT+ZqgHdU5fIML+s9dmPDitE2tjSYKi3bc1wcU6
         t6q1b3KL58rHBEm2mqwwG2BCERPczh2Mwar7MgNipkcNCMztrBVuZbsysP4iH3yuz4lJ
         R/bg==
X-Gm-Message-State: AJcUukcgd5QK9gcKMuF3vbhR8e5xv8XH4MoJtoLZDAMJwdlcAZVJiWJB
        JIFgB9KgEU9xvAdy1DjNTjI=
X-Google-Smtp-Source: ALg8bN40TPqxYk9GVXUCrZKAgXOrSrg9XQQtRuKHexWKZpTDDmEm6aDE6rieDgIW81ZkCFIYJKPloQ==
X-Received: by 2002:a2e:2a06:: with SMTP id q6-v6mr31904304ljq.37.1549088672871;
        Fri, 01 Feb 2019 22:24:32 -0800 (PST)
Received: from im-mac (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id l17sm1745045lfk.40.2019.02.01.22.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 22:24:32 -0800 (PST)
Message-ID: <ff595624f9cfbd12aa197c5713870c600247fa00.camel@gmail.com>
Subject: Re: [RFC PATCH 0/4] watchdog: hpwdt: Fix NMI-related behaviour when
 CONFIG_HPWDT_NMI_DECODING is enabled
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Jerry.Hoemann@hpe.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Sat, 02 Feb 2019 11:24:29 +0500
In-Reply-To: <20190116022242.GC18342@anatevka>
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
         <20190116022242.GC18342@anatevka>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 19:22 -0700, Jerry Hoemann wrote:
> On Mon, Jan 14, 2019 at 07:36:13AM +0500, Ivan Mironov wrote:
> > Hi,
> > 
> > I found out that hpwdt alters NMI behaviour unexpectedly if compiled
> > with enabled CONFIG_HPWDT_NMI_DECODING:
> > 
> >  * System starts to panic on any NMI with misleading message.
> 
> hpwdt doesn't start to panic on any NMI.  It starts to panic on:
> 
> 1) NMI_SERR		associated with NMI
> 2) NMI_IO_CHECK		associated with IO errors
> 3) NMI_UNKNOWN		NMI unclaimed by all local handlers.
> 
> On Gen10 going forward we plan to restrict to just iLO
> generated NMIs.
> 
> There is a long history on hp/hpe proliant systems where hpwdt
> was handler of general IO errors (at least ones that would cause
> NMI to be generated) and we chose to panic in these situation
> as the errors were generally quite serious.
> 

I would prefer to have this at least configurable by some module
parameter.

> Yes, this has caused some problems in the past as Linux has
> overloaded NMI and some subsystems didn't claim the NMIs that
> they generated (think profiling.)  But, I haven't seen these
> types of problems for several years now.
> 
> The more modern platforms have more robust error handling built
> into them and to linux so going forward we'll restrict hpwdt to a more
> traditional WDT role.  But we're retaining the more conservative
> approach for legacy platforms.
> 

I've seen NMI panic on my old ProLiant BL460c G6 at least once.
hpwdt.ko "handled" this NMI by disabling watchdog before hanging the
system 8). mynmi was equal to zero.

That is why I decided to check the code and try to understand how
exactly it works.

> How would you suggest that the message be enhanced?
> 

Maybe mention that "false positives" are possible and the actual reason
of NMI is not always logged in OA/iLO/etc. logs.

> 
> >  * Watchdog provided by hpwdt is not working after such panic.
> > 
> > Here are the patches that should fix this.
> > 
> > This is an RFC patch series because I am not sure that patches are
> > correct. Questions:
> > 
> >  * Are "mynmi" flags always set on all supported iLO versions when iLO
> >    is the source of NMI?
> 
> Unfortunately no.
> 
> hpwdt is a dual purpose driver.  It handles the iLO watchdog timer
> and the "Generate NMI to System" button.  These are closely related
> hardware wise.
> 
> However, some platforms generate NMI for "Generate NMI to System" button but aren't
> signaled via iLO registers.  These will show up as NMI_UNKNOWN, hence while
> hpwdt still claims these.
> 
> There are also some systems that do not set the nmistat bits correctly.
> 
> So as to not break legacy platforms, the use the nmistat bits for
> control will be for Gen10 going forward.
> 

It seems that iLO 2 sets these bits correctly. Bit 1 is set on
pretimout NMI, bit 2 is set on "iLO web button" NMI.

> 
> 
> >  * Is it safe to reset "mynmi" flags to zero if code decides to not panic?
> 
> The reading of the registers is itself destructive (sets to zero)

Could you elaborate what exactly you mean here?

I tried to read nmistat register multiple times using ioread8(), and
every time returned value were the same, with one of mynmi flags set.
Even with mdelay() between calls.

>  but the real
> issue is that some proliant systems lack the ability to acknowledge the NMI so
> only one can ever be received.  So returning is not advisable as no
> further NMI will be generated via this path.  A reset through firmware
> is required to restore the feature.
> 

Yes, I noticed this.

> 
> > Ivan Mironov (4):
> >   watchdog: hpwdt: Don't disable watchdog on NMI
> >   watchdog: hpwdt: Don't panic on foreign NMI
> >   watchdog: hpwdt: Add more information into message
> >   watchdog: hpwdt: Make panic behaviour configurable
> > 
> >  drivers/watchdog/hpwdt.c | 45 ++++++++++++++++++++++------------------
> >  1 file changed, 25 insertions(+), 20 deletions(-)
> > 
> > -- 
> > 2.20.1

By the way, is it possible to implement something like this
(pseudocode):

*******
bool handle_unknown_nmi_on_old_systems = true; // module parameter

int nmi_handler()
{
	if (mynmi_flags_supported(current_hw)) {
		if (mynmi & MYNMI_PRETIMOUT_FLAG) {
			if (pretimout) {
				hpwdt_stop();
				panic("hpwdt pretimout");
				return NMI_HANDLED;
			} else {
				warn("pretimout flag set, but pretimout
is not enabled, ignoring");
			}
		}

		if (mynmi & MYNMI_BUTTON_FLAG) {
			panic("iLO button pressed");
			return NMI_HANDLED;
		}
	} else if (handle_all_nmi_on_old_systems) {
		if (pretimout) {
			hpwdt_stop();
			panic("maybe hpwdt pretimout");
		} else {
			panic("unknown NMI, see OA/iLO logs...");
		}
		return NMI_HANDLED;
	}

	// Proceed with regular NMI handling code.
	return NMI_DONE;
}
*******

Or such logic does not make sense?

