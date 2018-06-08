Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WyjQEoqLGlsfKwAAmS7hNA
	; Fri, 08 Jun 2018 13:58:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 30F8C607E4; Fri,  8 Jun 2018 13:58:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efbZyI3K"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 807AD60590;
	Fri,  8 Jun 2018 13:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 807AD60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeFHN6b (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:58:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38157 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeFHN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:58:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so3936475wmf.3;
        Fri, 08 Jun 2018 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KxfyuhdAqC5qT7B1/lRSmwGtyVfEnauWoZtcu5T+Ucs=;
        b=efbZyI3KoSVuQFHY8K+JX0qsNvvfwIyJ3k+7rl0PnE8vFNvoK/FCZW5XF+AerVTWgc
         PLtLzknBHHasst9BIkZnoW7sLFz8IN33F66OhqvCx7GC75OScvYQLPfvguAe/NUMqFND
         8ueQcFAPf9iLh4Q5LgcEPkaPEUflnLtbWEQcpRdC6mqxg2e2ip8Hm1eJDvViGwLadlpd
         DEs7x6XTu0trDORe8XMbC3G62thqAGndlPd6dQovQf/Gi7j7et4mvU5vT3Wn6WcL+lO3
         5K+vMSEIqkGIanPbl3qMdnnz9Ql18XeuRVWRygTN7qZFJp/ljDnzWu2PvBKf24gwrRQz
         bJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KxfyuhdAqC5qT7B1/lRSmwGtyVfEnauWoZtcu5T+Ucs=;
        b=sZs+b3hTaQPQ2oQTumxWp3qho0eAVmA5YogrA9wX1850s5Sm5gXHIQfH7G1BunVm2c
         /3D9awsLtwtgr1dwmD0C9uj21sS1KXfwJLVII9C9hODbfrF+2wRQ1ju6EkMdTkelx58n
         aWOEAb+IUB9b6fFYbTFPetfsM46DGYykx259Qm7i4ApKJkE39voXN9aU6xTKb2UjjSLo
         tlRMD1f9XmWAw/ZaoBL5Ns9b+w/8ppKsBCC9iGph9+xbaFjyAh/wfRX81CQqGPDxzeGK
         HNzbnBVOFUaH15kRir+QK/J6DGKZQsH5KbiIZyQhMsmmDVO1y97kJNP8RfNO1GdJqDLu
         mkFw==
X-Gm-Message-State: APt69E2VgNgu58bMGVaUVmQgn5rG7WaXK3Gv6NjKi4XPq8HYTYV8enEi
        dCNhp+dcpjkWisv/v1LpHqg=
X-Google-Smtp-Source: ADUXVKIi24q5YEO1kdjNTkTrtLr10DjLb8804vqJcyzKkRo9mb7ARuRNB3Se4mB4Xvp+bFarEe0ifA==
X-Received: by 2002:a1c:30d7:: with SMTP id w206-v6mr1551195wmw.153.1528466307753;
        Fri, 08 Jun 2018 06:58:27 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t17-v6sm11395637wrr.82.2018.06.08.06.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 06:58:26 -0700 (PDT)
Date: Fri, 8 Jun 2018 15:58:26 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Helge Eichelberg <kernelorg@elchenberg.name>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Disable fan support for Dell XPS13 9333
Message-ID: <20180608135826.u22gb4ggvgfnifzq@pali>
References: <20180605173833.27003-1-kernelorg@elchenberg.name>
 <20180606152134.sw77aborznfy6mrj@pali>
 <20180607080455.daccaaab8a7e2f2a35b68873@elchenberg.name>
 <20180607082542.gvc7oz7qvrpodkus@pali>
 <20180608135155.GA30453@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180608135155.GA30453@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 June 2018 06:51:55 Guenter Roeck wrote:
> On Thu, Jun 07, 2018 at 10:25:42AM +0200, Pali Rohár wrote:
> > On Thursday 07 June 2018 08:04:55 Helge Eichelberg wrote:
> > > On Wed, 6 Jun 2018 17:21:34 +0200
> > > Pali Rohár <pali.rohar@gmail.com> wrote:
> > > 
> > > > On Tuesday 05 June 2018 19:38:32 Helge Eichelberg wrote:
> > > > > Calling fan related SMM functions implemented by Dell BIOS firmware on Dell
> > > > > XPS13 9333 freeze kernel for about 500ms. Until Dell fixes it we need to
> > > > > disable fan support for Dell XPS13 9333.
> > > > 
> > > > Hi! Have you reported this firmware bug to Dell?
> > > 
> > > No, I haven't.
> > 
> > Mario (from @Dell) wrote on github, that we should start reporting
> > firmware bugs to Dell as "voice of the customer is the most important".
> > https://github.com/dell/libsmbios/issues/48#issuecomment-393527813
> > 
> > > > Also we should probably match also BIOS version and do not apply this
> > > > blacklist quirk for BIOS versions in which Dell fixed it.
> > > 
> > > The BIOS hasn't been updated since 08/31/2015 and I'm running the latest version (A08). I wonder if Dell cares anymore about the 9333 which has been replaced by the 9343 in early 2015. Nevertheless, should I add a line matching the BIOS version and should it look like this?
> > 
> > Ok, I was in impression that it was fixed or was going to be fixed. This
> > looks like that laptop does not have any support. In this case would
> > need to blacklist it for all bios version and forever. So no match for
> > bios version. Maybe you should re-phrase commit message to indicate that
> > Dell probably does not fix it. Or drop that sentence "Until Dell...".
> > 
> Those would just be assumptions and not add any value to the commit log.
> I don't recall similar comments for previous patches either, and it is not
> as if Dell stopped supporting Linux only recently. I'll apply the patch
> as-is; I don't see value in a respin.

Ok. I have no objections. That was only suggestion. Also you can add my

Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

Anyway, if last version of Bios was released 3 years ago, I really doubt
that something is going to be fixed...

> Guenter
> 
> > > DMI_EXACT_MATCH(DMI_BIOS_VERSION, "A08")
> > > 
> > > Helge
> > > 
> > > > > Via "force" module param fan support can be enabled.
> > > > > 
> > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=195751
> > > > > Signed-off-by: Helge Eichelberg <kernelorg@elchenberg.name>
> > > > > ---
> > > > >  drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > > > > index bf3bb7e1adab..9d3ef879dc51 100644
> > > > > --- a/drivers/hwmon/dell-smm-hwmon.c
> > > > > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > > > > @@ -1074,6 +1074,13 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
> > > > >  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Vostro 3360"),
> > > > >  		},
> > > > >  	},
> > > > > +	{
> > > > > +		.ident = "Dell XPS13 9333",
> > > > > +		.matches = {
> > > > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > > > +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS13 9333"),
> > > > > +		},
> > > > > +	},
> > > > >  	{ }
> > > > >  };
> > > > >  
> > > > 
> > > > -- 
> > > > Pali Rohár
> > > > pali.rohar@gmail.com
> > 
> > -- 
> > Pali Rohár
> > pali.rohar@gmail.com

-- 
Pali Rohár
pali.rohar@gmail.com
