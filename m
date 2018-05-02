Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeEBTKe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 15:10:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50174 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeEBTKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 15:10:33 -0400
Date: Wed, 2 May 2018 21:10:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Borislav Petkov <bp@alien8.de>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-kernel@vger.kernel.org,
        devel@acpica.org
Subject: Re: [RFC PATCH v3 3/3] acpi: apei: Warn when GHES marks correctable
 errors as "fatal"
Message-ID: <20180502191029.hcvf56xbdna7oi4k@devuan>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-4-mr.nuke.me@gmail.com>
 <20180426112057.GB15009@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426112057.GB15009@pd.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-26 13:20:57, Borislav Petkov wrote:
> On Wed, Apr 25, 2018 at 03:39:51PM -0500, Alexandru Gagniuc wrote:
> > There seems to be a culture amongst BIOS teams to want to crash the
> > OS when an error can't be handled in firmware. Marking GHES errors as
> > "fatal" is a very common way to do this.
> > 
> > However, a number of errors reported by GHES may be fatal in the sense
> > a device or link is lost, but are not fatal to the system. When there
> > is a disagreement with firmware about the handleability of an error,
> > print a warning message.


> > +
> > +	if ((sev >= GHES_SEV_PANIC) && (ghes_actual_severity(ghes) < sev)) {
> > +		pr_warn("FIRMWARE BUG: Firmware sent fatal error that we were able to correct");
> > +		pr_warn("BROKEN FIRMWARE: Complain to your hardware vendor");
> 
> Pasting the same comment from last time since you missed it:
> 
> "No, I don't want any of that crap issuing stuff in dmesg and then people
> opening bugs and running around and trying to replace hardware.

We want to see warnings. Maybe they can be toned done. We even have
dedicated distros for firmware testing.

> Good mailing practices for 400: avoid top-posting and trim the reply.

Good mailing practices -- limit use of four letter words on public lists.

     	     	       	  	       	    	   	    	   Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
