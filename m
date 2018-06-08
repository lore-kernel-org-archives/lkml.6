Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BYk7LLmJGlvuHgAAmS7hNA
	; Fri, 08 Jun 2018 13:52:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF13B607E4; Fri,  8 Jun 2018 13:52:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="Ij+JFfrO"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A3912606FA;
	Fri,  8 Jun 2018 13:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3912606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeFHNv7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:51:59 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:58407 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeFHNv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YhR9kSeFbeTWy66AhH59XCT/TdbXBZ1mvkQ57DZYpqY=; b=Ij+JFfrOppGqhEoI9Df97Z4hVc
        vg5a0w4p72ovO40DAC0YRvwN+7eLrAKBSHAubpKuvayDNntZuemf7LYoS/RIggLQCdZFOvqk4w0XK
        VAO1LgxcA3hAGShzzVq5XMtDa/qAAIerF7hCup8EhyJi3Tou9swZ681BBOf7DBzM3UTJM+7d9Ue1n
        O8BWpkJlmJydeHD1QtA5SMhx8ukMXxNWpq27snvJoWGCA3sb2oDC7k40rzNx3DmZlGYAhLnw//ErF
        wH6M/IutqlvvPFHyRdpmy8QKjlZqOScnlqpq6jmldAH+g1mv2HBnua0MDcth0dSpGnabfcDDBfcUL
        gJpz2iKw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:46392 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fRHo4-003lPO-BM; Fri, 08 Jun 2018 13:51:57 +0000
Date: Fri, 8 Jun 2018 06:51:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Helge Eichelberg <kernelorg@elchenberg.name>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Disable fan support for Dell XPS13 9333
Message-ID: <20180608135155.GA30453@roeck-us.net>
References: <20180605173833.27003-1-kernelorg@elchenberg.name>
 <20180606152134.sw77aborznfy6mrj@pali>
 <20180607080455.daccaaab8a7e2f2a35b68873@elchenberg.name>
 <20180607082542.gvc7oz7qvrpodkus@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180607082542.gvc7oz7qvrpodkus@pali>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 10:25:42AM +0200, Pali Rohár wrote:
> On Thursday 07 June 2018 08:04:55 Helge Eichelberg wrote:
> > On Wed, 6 Jun 2018 17:21:34 +0200
> > Pali Rohár <pali.rohar@gmail.com> wrote:
> > 
> > > On Tuesday 05 June 2018 19:38:32 Helge Eichelberg wrote:
> > > > Calling fan related SMM functions implemented by Dell BIOS firmware on Dell
> > > > XPS13 9333 freeze kernel for about 500ms. Until Dell fixes it we need to
> > > > disable fan support for Dell XPS13 9333.
> > > 
> > > Hi! Have you reported this firmware bug to Dell?
> > 
> > No, I haven't.
> 
> Mario (from @Dell) wrote on github, that we should start reporting
> firmware bugs to Dell as "voice of the customer is the most important".
> https://github.com/dell/libsmbios/issues/48#issuecomment-393527813
> 
> > > Also we should probably match also BIOS version and do not apply this
> > > blacklist quirk for BIOS versions in which Dell fixed it.
> > 
> > The BIOS hasn't been updated since 08/31/2015 and I'm running the latest version (A08). I wonder if Dell cares anymore about the 9333 which has been replaced by the 9343 in early 2015. Nevertheless, should I add a line matching the BIOS version and should it look like this?
> 
> Ok, I was in impression that it was fixed or was going to be fixed. This
> looks like that laptop does not have any support. In this case would
> need to blacklist it for all bios version and forever. So no match for
> bios version. Maybe you should re-phrase commit message to indicate that
> Dell probably does not fix it. Or drop that sentence "Until Dell...".
> 
Those would just be assumptions and not add any value to the commit log.
I don't recall similar comments for previous patches either, and it is not
as if Dell stopped supporting Linux only recently. I'll apply the patch
as-is; I don't see value in a respin.

Guenter

> > DMI_EXACT_MATCH(DMI_BIOS_VERSION, "A08")
> > 
> > Helge
> > 
> > > > Via "force" module param fan support can be enabled.
> > > > 
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=195751
> > > > Signed-off-by: Helge Eichelberg <kernelorg@elchenberg.name>
> > > > ---
> > > >  drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > > > index bf3bb7e1adab..9d3ef879dc51 100644
> > > > --- a/drivers/hwmon/dell-smm-hwmon.c
> > > > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > > > @@ -1074,6 +1074,13 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
> > > >  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Vostro 3360"),
> > > >  		},
> > > >  	},
> > > > +	{
> > > > +		.ident = "Dell XPS13 9333",
> > > > +		.matches = {
> > > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > > +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS13 9333"),
> > > > +		},
> > > > +	},
> > > >  	{ }
> > > >  };
> > > >  
> > > 
> > > -- 
> > > Pali Rohár
> > > pali.rohar@gmail.com
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com
