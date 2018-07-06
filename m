Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19641C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0BF23F04
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0BF23F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeGFKXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:23:21 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42067 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeGFKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:23:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id u202-v6so9385749lff.9;
        Fri, 06 Jul 2018 03:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKx696gi/IcWcKTDbP6NFqRJcF1odzbkd16gNlFOoE0=;
        b=Jqd3X1ccGIs5LhOP9MPtu5DmXRa+Ohn4CopZLGTXnNVIuiYVPCPE5Q+LGoD6wE72QM
         vU8pZc4g13DXqGLkMQ2N/Bh6DgwOWm+4g+HVogwrjN71RE3iXL0av6Anr8SA+gYFLViH
         QrEP3eXjyAQLrvFgord1jeqhfrUfpguVCn0hi6y/6r7BPlrrjxzZ6kbcTJ+lXKSUiu8n
         kciltIEAeovaRw9J97gTTinKk6WeTCXxXDfLnu/KuVzofnJdMgZZATAJo/WLWgzXHUzp
         k6M0O2O9KSu0XvryLiC670BdGGns+6akScERDPp+ZFCEcBby1pOqskQpr7udaUe2JF3b
         2B+A==
X-Gm-Message-State: APt69E3JT26RTpnBqMRECDZhJiVLz8tE6nf/A1NwoNg0OFhPSkIv+UIb
        Bw6ed9EP48a66beIWnSyDyk=
X-Google-Smtp-Source: AAOMgpfCOu9lW4u/i+xOsmvhCO/r8G/Q6ppoHN21jP4oTt04jROAjKWRBL1FhJWDCZnHx2+hVxfR7w==
X-Received: by 2002:a19:dd5c:: with SMTP id u89-v6mr6819573lfg.83.1530872596730;
        Fri, 06 Jul 2018 03:23:16 -0700 (PDT)
Received: from localhost.localdomain (82-203-172-137.bb.dnainternet.fi. [82.203.172.137])
        by smtp.gmail.com with ESMTPSA id m29-v6sm1987270lfj.45.2018.07.06.03.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 03:23:16 -0700 (PDT)
Date:   Fri, 6 Jul 2018 13:23:12 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v10 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180706102312.GB11209@localhost.localdomain>
References: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <e737bb13d17b75ea5e55f59005ef3181d428e704.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_53DbfFTRt2xST6RXg_qu0+LayXjQL2y024We1LHGB3yQA@mail.gmail.com>
 <20180706060913.GU496@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706060913.GU496@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:09:13AM +0100, Lee Jones wrote:

[snip]
'
> page trying to find your response was a little painful.  TIA.

Acronyms can be confusing for non native english speakers like me.
Luckily we have the internet =)

https://www.acronymfinder.com/Slang/TIA.html

From these options I would go for:
"This Is Awkward" or "That Is Alright" - depending on my mood =] Or
maybe it was "Today I Ate"?

--Matti
