Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD88C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B5B206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546971169;
	bh=j1H36OVh23EJOg2MGZcHeuE5bNUb7/x6+SiW28utNec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zY9hkM0x/Ag/ywTyR7d1DCu//xX9bGYE8wLlz0MqKeijCXgnxVsLPt+9ujYXXseat
	 a/ZQk8v0jON9OUS/0jHgdttExeIk4tpS/AwXN5MEh0hbkStDf0Bx3gj6TYJLmHxdZb
	 ctJ619OC9DQ0IKupOOS54FY2Y1DUO66Z2oKQfQpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfAHSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:12:48 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42826 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:12:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so2292067pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xIwGZn5p4UNs0CHbjtKpbE8QyH9TRkeLLqHxwJ20E7o=;
        b=KgKAbE671sG93Q87eE3/79kzbIngXa2F+cPoaLzXi1JUKm7+2k6cT6oaoSKnaJQTlU
         sDjQvmHKfkdfg7NUE1v/d1j6gPiJ8+9OuMcK6RufuGTBfbwBOUcNEIBWgbxknMFDE8L7
         3aS1MRs9Jp5T0eMipruiLAzMOxO22BNNUlU5CgBYTifc9dAFa9ARiJpCY8DseufZ4wbG
         kMNLK6dXRt2nLL/aX+9TWccd00URi7hpx7vqBJytB5XLXrj+l+PK3RSbCaV2HzapTcRI
         YLKG3s8l+0AhIjxsEoYqnCJwK7bXXAZcza8/0oZmgJOo77z+jo1/usiThLLizBciVVZM
         pTaA==
X-Gm-Message-State: AJcUukeX/yOMZQwcD2OiZUumz8Rf5DVfiFMr9XEPcfMwDsin7XEdr36O
        /liZZ2pv7EiuO2h9U0mo83B2Xawnj/86Ww==
X-Google-Smtp-Source: ALg8bN6KAsfX0KMXUKu7DKl9Y5zBQhMcWTeYaNIAd5fPiq8ev7Ol8y9cU5s0AMW+/jvlmArSl/5zyg==
X-Received: by 2002:a62:9657:: with SMTP id c84mr2818439pfe.77.1546971166312;
        Tue, 08 Jan 2019 10:12:46 -0800 (PST)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id l5sm113167136pgu.86.2019.01.08.10.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:12:45 -0800 (PST)
Date:   Tue, 8 Jan 2019 10:12:44 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, moritz@ettus.com,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2] platform/chrome: Add cros_ec_readmem() helpers for
 I2C/SPI based ECs
Message-ID: <20190108181244.GA2767@archbook>
References: <20190108035638.9685-1-moritz.fischer@ettus.com>
 <27c7db25-51c0-c283-c4bb-4a65df9b2105@collabora.com>
 <CABXOdTdsuWdVWAev6KHqVZRsRyNsfdSmL4HYQWsuCZSA1v37ow@mail.gmail.com>
 <7e3d7606-6816-18bb-481d-803cfbc3f5d6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e3d7606-6816-18bb-481d-803cfbc3f5d6@collabora.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 08, 2019 at 04:00:58PM +0100, Enric Balletbo i Serra wrote:
> Hi,
> 
> On 8/1/19 15:34, Guenter Roeck wrote:
> > On Tue, Jan 8, 2019 at 6:28 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> Hi Moritz,
> >>
> >> Many thanks for the patch,I've one concern on this, and I'd be also interested
> >> on Benson and Guenter opinion ...
> >>
> >> On 8/1/19 4:56, Moritz Fischer wrote:
> >>> From: Moritz Fischer <mdf@kernel.org>
> >>>
> >>> Add cros_ec_readmem() based helpers for I2C/SPI based ECs.

That sentence also should probably get reworked on my end :)
> >>> Unlike the LPC based ECs the I2C/SPI based ones cannot just directly
> >>> read the mapped region.
> >>>
> >>> This is useful for things like accessing fan speeds or temperatures.
> >>>
> >>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> >>> ---
> >>>
> >>> Hi all,
> >>>
> >>>
> >>> I had submitted this back in May 2017 [1] and then somewhat forgot
> >>> about it. So here's a new version :)
> >>>
> >>> As to why is this required? we're using this in some of our devices
> >>> [2] that run a modified firmware based on Chromium-EC.
> >>> I've been carrying the patch downstream in our tree for a while and
> >>> it would be nice if we can merge this upstream so I can stop rebasing
> >>> this :)
> >>>
> >>
> >> Right, if we merge this you'll probably reduce your downstream patches but
> >> actually, if I am not wrong, there is no user for this. There isn't an upstream
> >> driver that uses the new functions so we will end up having upstream dead code.
> >> IMO if you want to have this upstream you should also upstream the drivers that
> >> use that code. Makes sense?

Sure, see below.
> >>
> > 
> > He has a hwmon driver which I think uses it. 
> 
> Nice, sorry Moritz because the hwmon driver was not on my radar, I missed it.
> The patch needs some rework I guess so would be nice have all together in the
> same patch series.

My fault, sorry, the reason there is that we have a bunch of versions of
this driver internally (some of them thermal drivers, some of the hwmon
drivers). All of them are open source and in our meta-ettus yocto layer,
just need cleanup on our end first.

> 
> > Question would rather be
> > if that is an acceptable use or if it exposes EC internals, ie non-API
> > data. Comments, anyone ?
> > 
> 
> Yes, that's the question. We have similar command for devices that use the lpc
> bus.  On my side I'll take a deeper look. More Comments ?

Yeah basically one comment from my side: The cros_ec_readmem only
exposes a bunch of 'virtual' registers on I2C/SPI based ECs so it's
not like you're leaking non-API data, but merely brings functionality
for I2C/SPI based ECs to parity :)

Thanks for considering, I'll take another look at the Kbuild issue

Moritz
