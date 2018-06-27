Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB5C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5A226580
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5A226580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeF0IkK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:40:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34251 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933417AbeF0IkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:40:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id l12-v6so962912lja.1;
        Wed, 27 Jun 2018 01:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hmor54vYfmT/MQVY9F0IPhn69l0+u9uxhjzZK1NK4ZY=;
        b=b06kJAiLDkb61NtQOqeTPI9BgM/9HPQwxB0RtVOZelS5QKivQn1mv47jWoc1k+/Cxz
         6BhqQDVPhZDyH92GqAhD8a5aJJ71D+Sb2nGrRLA+LXEhs7+CdS+GSh0KHfb5aCjCyW27
         Qwty2A+sL4dsQh6z9AI6izH/5+i35nx26sqsb4DRyTF5O4reKgwv8QUfRsfRva03Rn+Y
         yzPr8kTSVoHz83IG1dyCP1hvYCpupP2+H+tzyfojhy94U2I/Siqam50oakZC0FsH14cL
         eAu6qEqamICNbkzpezLIK1Qk+ftCCq6CmriBlhztU30eAcUf7HAC0KzoIs/oNN09AduB
         4tOw==
X-Gm-Message-State: APt69E2pKkKEULDSwAN1u9aqJCHUlgEUyMv0OmOHsblRoQsuNtMQmdAr
        //kp8+QtMDwwzxSmZHTsvHI=
X-Google-Smtp-Source: AAOMgpfSO+T0T9QO4bqZUwZzZKQpWTtZxz1IT87TrrZZR96YaSP9Fkz/zb8bUYmUNgqoWipl1szsfQ==
X-Received: by 2002:a2e:1101:: with SMTP id f1-v6mr1200895lje.75.1530088804146;
        Wed, 27 Jun 2018 01:40:04 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b85-v6sm132036lfl.29.2018.06.27.01.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 01:40:03 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:40:00 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>, broonie@kernel.org,
        lee.jones@linaro.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Message-ID: <20180627084000.GE2118@localhost.localdomain>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
 <20180612082354.GG20078@localhost.localdomain>
 <20180613130338.GH20078@localhost.localdomain>
 <152997038474.143105.3390705878521933864@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152997038474.143105.3390705878521933864@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On Mon, Jun 25, 2018 at 04:46:24PM -0700, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-06-13 06:03:38)
> > On Tue, Jun 12, 2018 at 11:23:54AM +0300, Matti Vaittinen wrote:
> > > 
> > > I see. This makes sense. I need to verify from HW colleagues whether
> > > this chip has internal oscillator or not. I originally thought we have
> > > on-chip oscillator - but as you say, we do have XIN pin in documentation.
> > > So now I am not sure if the test board I have contains oscillator driving
> > > the clk on PMIC - or if the PMIC has internal oscillator. I'll clarify this.
> > 
> > It really turned out that the PMIC just acts as a clock buffer. So I do
> > as you suggested and add lookup for parent clock to the driver. I
> > planned to do it so that if no parent is found from DT - then we assume
> > the 32.768KHz clock (as described in documentation). Eg, something along
> > the lines:
> > 
> >         init.parent_names = of_clk_get_parent_name(pdev->dev.parent->of_node, 0);
> >         if (init.parent_names) {
> >                 init.num_parents = 1;
> >         } else {
> >                 /* If parent is not given from DT we assume the typical use-case with
> >                  * 32.768 KHz oscillator for RTC (Maybe we could just error out here?)
> >                  */
> >                 c->rate = BD71837_CLK_RATE;
> >                 bd71837_clk_ops.recalc_rate = &bd71837_clk_recalc_rate;
> >         }
> 
> You can also add a clk directly in this driver in that case there isn't
> one in DT with the rate and name of your choosing. Then the logic is the
> same and we don't need a c->rate variable.

So you mean that I should use clk_hw_register_fixed_rate and create new
clk if parent is not found? Isn't this a bit of an overkill? Downside is
that then we do need remove/cleanup functionality for deleting this
parent clock - and I didn't find devm support for fixed clock. Furthermore
I guess that since it is parent, it can't be removed before child is removed.

Or did you mean something else but creating a fixed rate clock as parent
here?

Best Regards
    Matti Vaittinen

