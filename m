Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id owwVK5XrGFunZwAAmS7hNA
	; Thu, 07 Jun 2018 08:25:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 69A7D607F7; Thu,  7 Jun 2018 08:25:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUfVqn9S"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BF7A96063F;
	Thu,  7 Jun 2018 08:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF7A96063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeFGIZt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:25:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53746 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932240AbeFGIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:25:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so16148631wmc.3;
        Thu, 07 Jun 2018 01:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lU+sdzlVqumH4+C8VCK4QagJsAy7XLl5+xziS/yqMHU=;
        b=SUfVqn9SgCqZKpNbXT7wQ5JnyuekhKvYC3GrfGUAFB4v42hGHtr6MPBlslFzInBPFI
         QfU4jneRdbOYdl03QCDU3Nkfmv+E7BXxes0GslXqeQpZ4VMZoE6ClD4M0UHQozVSL5we
         xqU66jfF4Wk3XzWQ/OStQeR0GAXPhJxEZTkNZZRKliGA1xec5ywQvul7AS41j5CHg+A+
         3fl6fQchbWys4RPCuVOEiFrgoH15JnN04GgPT0JUluuXmxSiGrlWDpVvbTlof5M3N6u/
         LD1kBUuf3pf2g48xFI4e8ANR9HKmShxD+HP+aNZuWME1bQIRzB7BU0Ligg7+RXT89sIo
         LsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lU+sdzlVqumH4+C8VCK4QagJsAy7XLl5+xziS/yqMHU=;
        b=LUzFFz3a1gc9cRdl73efLU9R1gRGt+honfRx+ne5NVX/BiLbA1/A/vJzDVvS+hOBvM
         uzfvbBAvErqiDwdc6RowhpFgSxSQJ5aU6lG/df2hoUrzOYycpk5OQj5XOK9NRWPvjh9a
         mY6IBfwz3oTENvmaZy9OJG/ImQHdmlK1QHwhEi/82f61QoSznQWEMTkmVFJyd0hXrw1o
         1gs3QnzmHB8m8sd49l0TdtmuG8uMAtZAzO6EjxeQFX5ZKt+ljrf+tW9w4LJKOT7Mav7p
         DBr7BhEAX61eyfV/Bzy+pwa9q606AqHpimTrMGGhtUlsetgah35U2pQQMYfbJ6xj7YgE
         o+UQ==
X-Gm-Message-State: APt69E1zf+1nEj48SIa0uX+csOawVwTrIJ9jPQUTbXndl4bfeeDmP82m
        zfur6pB24ZuNq2YZCiJMUYkLmQ==
X-Google-Smtp-Source: ADUXVKL4WQWN1FkhwTEaFJTv/8ISyuIiCbDpBGVHPBLxyfBD9KYsqpHF/RCxdqtsB1pN2j/yz3CNmQ==
X-Received: by 2002:a1c:da4e:: with SMTP id r75-v6mr876144wmg.64.1528359944537;
        Thu, 07 Jun 2018 01:25:44 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o138-v6sm1326481wmg.10.2018.06.07.01.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 01:25:43 -0700 (PDT)
Date: Thu, 7 Jun 2018 10:25:42 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Helge Eichelberg <kernelorg@elchenberg.name>
Cc: Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Disable fan support for Dell XPS13 9333
Message-ID: <20180607082542.gvc7oz7qvrpodkus@pali>
References: <20180605173833.27003-1-kernelorg@elchenberg.name>
 <20180606152134.sw77aborznfy6mrj@pali>
 <20180607080455.daccaaab8a7e2f2a35b68873@elchenberg.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180607080455.daccaaab8a7e2f2a35b68873@elchenberg.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 June 2018 08:04:55 Helge Eichelberg wrote:
> On Wed, 6 Jun 2018 17:21:34 +0200
> Pali Rohár <pali.rohar@gmail.com> wrote:
> 
> > On Tuesday 05 June 2018 19:38:32 Helge Eichelberg wrote:
> > > Calling fan related SMM functions implemented by Dell BIOS firmware on Dell
> > > XPS13 9333 freeze kernel for about 500ms. Until Dell fixes it we need to
> > > disable fan support for Dell XPS13 9333.
> > 
> > Hi! Have you reported this firmware bug to Dell?
> 
> No, I haven't.

Mario (from @Dell) wrote on github, that we should start reporting
firmware bugs to Dell as "voice of the customer is the most important".
https://github.com/dell/libsmbios/issues/48#issuecomment-393527813

> > Also we should probably match also BIOS version and do not apply this
> > blacklist quirk for BIOS versions in which Dell fixed it.
> 
> The BIOS hasn't been updated since 08/31/2015 and I'm running the latest version (A08). I wonder if Dell cares anymore about the 9333 which has been replaced by the 9343 in early 2015. Nevertheless, should I add a line matching the BIOS version and should it look like this?

Ok, I was in impression that it was fixed or was going to be fixed. This
looks like that laptop does not have any support. In this case would
need to blacklist it for all bios version and forever. So no match for
bios version. Maybe you should re-phrase commit message to indicate that
Dell probably does not fix it. Or drop that sentence "Until Dell...".

> DMI_EXACT_MATCH(DMI_BIOS_VERSION, "A08")
> 
> Helge
> 
> > > Via "force" module param fan support can be enabled.
> > > 
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=195751
> > > Signed-off-by: Helge Eichelberg <kernelorg@elchenberg.name>
> > > ---
> > >  drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > > index bf3bb7e1adab..9d3ef879dc51 100644
> > > --- a/drivers/hwmon/dell-smm-hwmon.c
> > > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > > @@ -1074,6 +1074,13 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
> > >  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Vostro 3360"),
> > >  		},
> > >  	},
> > > +	{
> > > +		.ident = "Dell XPS13 9333",
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS13 9333"),
> > > +		},
> > > +	},
> > >  	{ }
> > >  };
> > >  
> > 
> > -- 
> > Pali Rohár
> > pali.rohar@gmail.com

-- 
Pali Rohár
pali.rohar@gmail.com
