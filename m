Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5521ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 18:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171BB2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 18:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaiW+p4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171BB2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeIWAl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 20:41:29 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:34413 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeIWAl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 20:41:29 -0400
Received: by mail-pl1-f169.google.com with SMTP id f6-v6so7379436plo.1;
        Sat, 22 Sep 2018 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O4G79cfQl39IIcoPKzysjvTlS/OFLnC+acQiKVBt+x4=;
        b=SaiW+p4gAlmEPHbnsW2CI2ufFSDwQ5HWgagtSrcpThw1dUIe+8xrkb0i8+uLhFDRqi
         Lm1V0vUKTm8JTne8WYemRxryefq98JQ3rXQFN+ZouWlaiQoPJHESNjFYVbCX64c1eJsY
         qwFuQKJvhZSE2aW381JbaVVdVOW2t58yThj0etWLhpqih/Jo6GiqUSgNZd58mrpRf3yy
         Q8pciE+jIcRZMWWpN3xMG1v6Ve38+264CIbILE6tt9jb+jUzj0QEv4G4KVsa04oCctz6
         UgKzEvXAlD8PoIcNjTpwowxNxHlpm2txQC0xuELMTNBhPhq1bmmb9KQGZn621CT04bab
         fI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4G79cfQl39IIcoPKzysjvTlS/OFLnC+acQiKVBt+x4=;
        b=Dy7YthPxI04D9nO8kG9HlefC09i3YlC3D1fp32KE3IeBb74UQBPmn8m0/WTBZfzY9T
         DXlI/s2pU9bHOwIJwtJCgUUDk5uRRNTY480OzjNr/MsN8ESUf4Hh3ueTK2qurDSZ8/yR
         dyD6UQiUSTq1BHW3+UaXqCa8mVbNgkY8/NSvIrksB/lUXxEmTB2+Gf8wwLxOIDA/jI5l
         KxTOzOA2JD6ODP1dZHl8S5VB+g5p6oPYnmejFsCPlwSrEAycNym+uw1+SaKKtLjb3Ykc
         2J5dGNrxiyobLs+b5Q6Y7xAlI7P3AqzSBgURGDdfmRidi0yvORlF7XmFpCc5nOBP4TUY
         bhfg==
X-Gm-Message-State: ABuFfog5F6LQP+q5xDQ+AVK0fdPjQk6Ey8JctMRycFraC9CPd3i/Fm87
        t6o9yPqDr1HqeUdmEAzzMK4=
X-Google-Smtp-Source: ACcGV60PJBrtpDuYZXOmP7fWxly/hbf8NC50fe1wmegs2SkhXRnsdTmOOf5r0f2t6vZvoiMVa1NPFQ==
X-Received: by 2002:a17:902:7c96:: with SMTP id y22-v6mr3658238pll.332.1537642015730;
        Sat, 22 Sep 2018 11:46:55 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id f11-v6sm46350974pfa.131.2018.09.22.11.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:46:55 -0700 (PDT)
Date:   Sat, 22 Sep 2018 11:46:51 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: ina3221: Read channel input source info
 from DT
Message-ID: <20180922184650.GB9092@Asurada>
References: <20180921223216.634-1-nicoleotsuka@gmail.com>
 <20180921223216.634-3-nicoleotsuka@gmail.com>
 <a7e6c311-eba4-e9b2-df64-9d02882a1dcb@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e6c311-eba4-e9b2-df64-9d02882a1dcb@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >This patch adds a new structure of input source specific
> >information including input source label, shunt resistor
> >value and its connection status. It exposes these labels
> >via sysfs and also disables those channels where there's
> >no input source being connected.
> >
> 
> I see you have decided to just display the disconnected channels.
> This is misleading, and I can not accept it. Please either use the
> is_visible callback to not display those channels at all, or have

I will add is_visible. I have almost finished it while waiting for
the v3's review comments. Will test it and include in the v4.

> the _input attribute of disabled channels return -ENODATA (see
> 'in[0-*]_enable' attribute in the ABI). If you implement the latter,
> I would suggest to also implement the _enable attribute.

I will also add one separate patch for in[0-*]_enable after these
two changes pass the review and get applied.

> As mentioned in patch 1, I can not accept an implicitly mandatory
> label attribute. The property defining the label attribute will
> have to be optional and well defined to ensure that it matches
> the ABI.

I replied this in the PATCH-1. Let's discuss this topic there.

> >+	/* Disable channels if their inputs are disconnected */
> >+	for (i = 0, mask = 0; i < INA3221_NUM_CHANNELS; i++) {
> >+		if (ina->inputs[i].disconnected)
> >+			mask |= INA3221_CONFIG_CHx_EN(i);
> >+	}
> 
> Consequently, you should also _enable_ channels which are not explicitly disabled.

The register has enabled all channels by default. So I felt it'd
be neat to have disabling code only. My v1 actually had enabling
part as well, but I can add it back if you think it'd be better.

> This can be tricky since you'll have to distinguish non-DT and DT configuration
> and retain the original configuration if no channel configuration data is available
> from devicetree.

I don't quite understand this comments. Would you please elaborate
it?

For non-DT configurations, input->disconnected is always false by
default unless someone adds config for it (through platform_data).
If regmap_update_bits only does disabling like this version does,
non-DT configurations will not get affected since mask = 0. Or if
we change it to do both enabling and disabling, regmap_update_bits
will still ignore since there's no register value changed, though
it won't really hurt even if regmap writes correct configurations
to the register.

For DT configurations (without channel input source defined), it's
like the same as non-DT configurations. As we have platforms only
enabled ina3221 via DT while they don't have this new DT binding,
the driver has to be backward compatible, so my change only sets
input->disconnected=true when a status="disabled" is present, i.e.
those platforms are treated as all channels getting enabled until
they update their DTs.

Thanks for the review
Nicolin
