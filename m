Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415A9C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2C7208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugUIh/eV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2C7208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeIWL5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 07:57:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40827 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeIWL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 07:57:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so7706531plp.7;
        Sat, 22 Sep 2018 23:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HE/9J+1oCMN1iMTytl9day00KIaAVdxKpoLXQg5wK8s=;
        b=ugUIh/eVZExX53nQN1Ap08I6H/4OaI1iotyh6ulW9fbcAAtc1910MbkSgguMSLdVJk
         ZvSbHgGVmKsPeXqpOqrfoi8cS/qRRsZ9n11R2qzKR6XtQMt0f8KFTDyeWNTYvicfzLKe
         +iHUsbK+cwlgnTATpmkMIDj7cRslK2RJtSlm8xMvCLfTuGvklgLDlH0etN3Wtj3RZfOZ
         RaSQ9GheaYGTKkvRWhoQWvAvEu9RYVWAODIJwWWJFBfsMZTCiR3epjxbwQyq+LRCY/t2
         Fcaq1YxPaeaWYGo+FgGAmSFDB+8vnrQemyi5bbTdgXyKmUJEfLEzp+Cs75zbGna+YRG4
         x7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HE/9J+1oCMN1iMTytl9day00KIaAVdxKpoLXQg5wK8s=;
        b=emIWcs6U7V7uXUVpghMFU1pjfsvVcCyOEJmFWeFP2Wn6MHd2xYR2gETY1dBbdhAg6o
         VX4Hzsj3avoAnsh96cjI5QgUXf6JwW5kFk6rrtrPaJ3IQ81WF6RwJEB4zFrj5VoBU30F
         5YdXxmXL0hkrgf6wCkyMYlaHQ3j4cjLhvEpSNHfQzg3EebWH670sCLgiV5nBXhOf+Iih
         dLq4JC+lmoGt6KJjb2Fp+bpdeeOHTRcyouGvsGAhd7FyQGWX4a7TI9WrDAneAkAHG2xG
         GslDe264vfnyu3s8wPSEBDrqrwJ5NYtsBQIytLPEUo9+HOekbYCt05KBGmDuqieo2KMZ
         tXKA==
X-Gm-Message-State: ABuFfoh9bZsr62Mu+WYNgQt+wvFaqTlbnhkqb6zOAPB3zhtMQm8Pi9JI
        b+G6dVx31Hl3MPrjjEosGcA=
X-Google-Smtp-Source: ACcGV61G58PQ6wtbxd0KkqocGDdyKun2XDGm4MFDX2lHblz8/fzsHhx0PbP/I3sSGr7h1lzR9KtiAA==
X-Received: by 2002:a17:902:b682:: with SMTP id c2-v6mr3560040pls.171.1537682485927;
        Sat, 22 Sep 2018 23:01:25 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 77-v6sm2355742pfw.159.2018.09.22.23.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 23:01:25 -0700 (PDT)
Date:   Sat, 22 Sep 2018 23:01:21 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180923060120.GA8872@Asurada-Nvidia.nvidia.com>
References: <20180923041118.8743-1-nicoleotsuka@gmail.com>
 <20180923041118.8743-2-nicoleotsuka@gmail.com>
 <353ccbbd-94c8-72eb-eb98-8a0507431e15@roeck-us.net>
 <20180923053151.GB9960@Asurada>
 <ce76fdf2-2894-96ad-d2f5-b2c25f197ee4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce76fdf2-2894-96ad-d2f5-b2c25f197ee4@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 10:45:49PM -0700, Guenter Roeck wrote:
> On 09/22/2018 10:31 PM, Nicolin Chen wrote:
> > On Sat, Sep 22, 2018 at 10:19:42PM -0700, Guenter Roeck wrote:
> > > > +2) child nodes
> > > > +  Required properties:
> > > > +  - input-id: Must be 1, 2 or 3
> > > > +
> > > > +  Optional properties:
> > > > +  - input-label: Name of the input source
> > > > +  - shunt-resistor: Shunt resistor value in micro-Ohm
> > > > +  - status: Should be "disabled" if no input source
> > > > +
> > > > +  Example:
> > > > +
> > > > +  input1 {
> > > > +          input-id = <0x1>;
> > > 
> > > We'll have to find a better name for this. Feel free to look up examples in the
> > > existing devicetree descriptions. The one that seems to be used most of the time
> > > to indicate a channel index or id is "reg". It should also start with 0 - there
> > > is no real reason for it to start with 1; it only makes the code more complex.
> > 
> > The reason is that the port start from 1 in the datasheet.
> > 
> 
> Maybe, but for me I'll want to have something that we can reuse for other chips.
> Having the index start with 0 for one chip and with 1 for another would be
> confusing. It is bad enough that we have in[0..n] for voltages and temp[1..n]
> for temperatures. I would not want to see the same in devicetree files,
> and much less so on a per-device basis. It is also pretty common to start
> channel numbers with 0 in devicetree files.

Understood. I search a bit and saw most of "*-id" start from 0,
although I cannot be sure whether their Datasheet/RM/schematics
are counting from 0 or 1.

And I also found a transposing example:
    Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt

Probably should be better to wait for doc maintainers' input.

Thanks
Nicolin
