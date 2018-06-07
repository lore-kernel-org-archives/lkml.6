Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6W6dKA/LGFvmcgAAmS7hNA
	; Thu, 07 Jun 2018 06:05:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 948926089E; Thu,  7 Jun 2018 06:05:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AE1EA602FC;
	Thu,  7 Jun 2018 06:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE1EA602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=elchenberg.name
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeFGGFB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:05:01 -0400
Received: from kopff.uberspace.de ([185.26.156.73]:42690 "EHLO
        kopff.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeFGGE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:04:59 -0400
Received: (qmail 27220 invoked from network); 7 Jun 2018 06:04:57 -0000
Received: from unknown (HELO xps13) (95.91.213.155)
  by kopff.uberspace.de with SMTP; 7 Jun 2018 06:04:57 -0000
Date: Thu, 7 Jun 2018 08:04:55 +0200
From: Helge Eichelberg <kernelorg@elchenberg.name>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Disable fan support for Dell XPS13
 9333
Message-Id: <20180607080455.daccaaab8a7e2f2a35b68873@elchenberg.name>
In-Reply-To: <20180606152134.sw77aborznfy6mrj@pali>
References: <20180605173833.27003-1-kernelorg@elchenberg.name>
        <20180606152134.sw77aborznfy6mrj@pali>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018 17:21:34 +0200
Pali Rohár <pali.rohar@gmail.com> wrote:

> On Tuesday 05 June 2018 19:38:32 Helge Eichelberg wrote:
> > Calling fan related SMM functions implemented by Dell BIOS firmware on Dell
> > XPS13 9333 freeze kernel for about 500ms. Until Dell fixes it we need to
> > disable fan support for Dell XPS13 9333.
> 
> Hi! Have you reported this firmware bug to Dell?

No, I haven't.

> Also we should probably match also BIOS version and do not apply this
> blacklist quirk for BIOS versions in which Dell fixed it.

The BIOS hasn't been updated since 08/31/2015 and I'm running the latest version (A08). I wonder if Dell cares anymore about the 9333 which has been replaced by the 9343 in early 2015. Nevertheless, should I add a line matching the BIOS version and should it look like this?

DMI_EXACT_MATCH(DMI_BIOS_VERSION, "A08")

Helge

> > Via "force" module param fan support can be enabled.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=195751
> > Signed-off-by: Helge Eichelberg <kernelorg@elchenberg.name>
> > ---
> >  drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > index bf3bb7e1adab..9d3ef879dc51 100644
> > --- a/drivers/hwmon/dell-smm-hwmon.c
> > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > @@ -1074,6 +1074,13 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
> >  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Vostro 3360"),
> >  		},
> >  	},
> > +	{
> > +		.ident = "Dell XPS13 9333",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS13 9333"),
> > +		},
> > +	},
> >  	{ }
> >  };
> >  
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com
