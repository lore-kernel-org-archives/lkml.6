Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32A7C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1092241D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1092241D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeGELvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:51:52 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41262 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbeGELvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:51:50 -0400
Received: by mail-lf0-f68.google.com with SMTP id y127-v6so6704554lfc.8;
        Thu, 05 Jul 2018 04:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bSS0sP5fUtqwjXQBqoHqwBLkY+qtBivDZjv2eqbREGo=;
        b=LO2rAvf867XJF6F4XrQAsNLbj9ndD1dU2gwjnyVUKKNGuFoDOwTpR34ITspk7T/G3M
         9rPGegtCCgHDuPB8CjurrmpBJV7ow8zB/fEHjgMVgv/K+DO1a0OSao1jSCj8o87XtW8Z
         DP6g+B4L40bsd8AwucRtEF/wM5jk6W56K4iNxrxmL1vX6G42Gc6vmtlN9zVSXsRJ50vG
         2IEAJAygTyKAG9TyyJIQHstlmQxhzbZPhZsGc4qbseJRhBC7QAeUZSUF9kbfnecJWfd6
         jT8qsvgT8+g2vtFZTuOXqUBDW8dw+n6HO38hL/tNAwE1be+3ILi3bG4UuNcLM2OSMQZ4
         kdsQ==
X-Gm-Message-State: APt69E1v4H+BWI4YkXB2hEh9hYGaIa52AzZZtueRhqcC8fsRVUME7zcA
        spN2FVvH0V+Mh5BkpEPV7D0=
X-Google-Smtp-Source: AAOMgpeMP9G5pU9SgZ7nP4lrxC3dF5Q6CJHdrm/UwGWkvZULI46N2e9e85HuYCzK36Bdnp2wdFH+TA==
X-Received: by 2002:a19:2887:: with SMTP id o129-v6mr4378381lfo.95.1530791508167;
        Thu, 05 Jul 2018 04:51:48 -0700 (PDT)
Received: from localhost.localdomain (82-203-190-162.bb.dnainternet.fi. [82.203.190.162])
        by smtp.gmail.com with ESMTPSA id m66-v6sm1396347lfi.17.2018.07.05.04.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 04:51:47 -0700 (PDT)
Date:   Thu, 5 Jul 2018 14:51:43 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org,
        chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v9 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180705115143.GC8426@localhost.localdomain>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <87cc68c82c3c95e82797e0ce3d401a4f1d6daf25.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <20180705092444.GL496@dell>
 <20180705103919.GB8426@localhost.localdomain>
 <20180705104919.GM496@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705104919.GM496@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 11:49:19AM +0100, Lee Jones wrote:
> On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> > On Thu, Jul 05, 2018 at 10:24:44AM +0100, Lee Jones wrote:
> > > On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> > > 
> > > > Document devicetree bindings for ROHM BD71837 PMIC MFD.
> > > > 
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 67 ++++++++++++++++++++++
> > > >  1 file changed, 67 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> > > > +		clock-names = "my-clock";
> > > > +		clocks = <&pmic>;
> > > > +	};
> > > 
> > > Do you have a real example to give?
> > 
> > For clock consumer? Sorry, no I don't.
> 
> Might be better to drop it for the time being then.

I have tested the clk driver using this dummy consumer. So in a sense it
"works" and can be used as an example on how to write a real clock
consumer node. Thus I see some value in this example node - even if it
does not match to any real world HW. If I had to use the clk from this
PMIC and write HW description I would appreciate this dummy exaple. I
can drop it if you insist - but I would at least like to hear what is
the downside on having it here?

Best regards,
    Matti Vaittinen
