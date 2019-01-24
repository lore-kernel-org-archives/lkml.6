Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6816BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442BE21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfAXHQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:16:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33564 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXHQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:16:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so4312453ljd.0;
        Wed, 23 Jan 2019 23:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LP/avWTvepn7HWKvKZScd337ZUBQpptaYWJEMiVqdw8=;
        b=gXJSjKawLFyKSxMu9knPi8OeEYEt0k2X6LsvZ1rZVf6IoOiIrFdHmGxLWl+nalbF9E
         8P9yoaPTSq4rbiMLoQ5aeq/MEhHGj6cjv3xA6gVufILow/qmvTrPiyYksrwgkChKw+u9
         N4qp/riF2+VYpO4/7j+VrGHYjf9WwFC2YoAHf/4kmBfbMoIOJJij0x3emBSgerFtaMZc
         EEr0B16UFi7zHnqwo5JZ9tdS4DHTg2X515AcAIvJL72hUw4aGnsec9k6JAbYgBqs2ig+
         lnQ+QwLUOi7Y4Rgmg42JHcSpJtauJjf/e6lPeQ3nArf8cFfT2T1/4WmEtDh66fr9CTbp
         TOYA==
X-Gm-Message-State: AJcUukfad0myvBk+qrCjFIg6GEb7J0metZRHnyU3qFTAQsOB4MSMSiUj
        c1Z2ZH551pUGfsgDWtSGWak=
X-Google-Smtp-Source: ALg8bN6YVI1nDjTAHHQcPyrvgygWgP0Klv2vOk1tt7ZLHPFyNSvEzs1wFzosiQXasyg74B91Vn9/IQ==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr4369103ljb.176.1548314198679;
        Wed, 23 Jan 2019 23:16:38 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p10-v6sm849502ljh.59.2019.01.23.23.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 23:16:37 -0800 (PST)
Date:   Thu, 24 Jan 2019 09:16:35 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 03/13] regulator: bd718x7 use chip specific and
 generic data structs
Message-ID: <20190124071635.GE2559@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <3fb3eab3a8a2767404588d0a0a531273fddfc659.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190123155121.GB7503@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123155121.GB7503@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thanks again for looking through my changes =)

On Wed, Jan 23, 2019 at 03:51:21PM +0000, Mark Brown wrote:
> On Tue, Jan 22, 2019 at 11:43:28AM +0200, Matti Vaittinen wrote:
> > Header rohm-bd718x7.h was split to generic and component specific
> > parts. This changed the struct bd718x7. Adapt the regulator driver to
> > these changes.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> Does this need to be squashed into the earlier commit for bisection?

Yes. If we don't want to break the compilation between commits then
the patches 2, 3 and 4 should be squashed into one. I sent them as
separare changes for easier review. I can squash them and send them
squashed if they are Ok to Lee and Stephen. Please just let me know
whose tree I should use as the basis so I can do rebasing if needed.
(Or is there some better way to do changes like this?)

Br,
	Matti Vaittinen 

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
