Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83054C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451832229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436655AbfBNIXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:23:46 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40279 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbfBNIXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:23:45 -0500
Received: by mail-lf1-f65.google.com with SMTP id t14so3883354lfk.7;
        Thu, 14 Feb 2019 00:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MSh+xL7lUIQ+jIOC3psLj/44rfqn2K6Nq1QXFuVwvo0=;
        b=JKKWugC23GCwqd2f07c3IXYwBepcLN2xlITSEv6KO+MGiOT4dprDxVhdT+uFbNTi/l
         Dsmi9nmL1dvlTk+nUUjgvJyEaz41+AnBoD11K9SpQ35nEh8fEEhMHWn2uQyAurRjHDdI
         gfCgMB8PzlOWX/m7dqAQdLEqxkLxK1IuTpJ0WMMJgcWgFe96xsaVYJtJkgWxxQhqEjlg
         l3tLphdEnWAZBRIFNezzGQcdchyIBx/AmrE9m9jcZzvYckEFNWb8ljjRNplpdCBoutFq
         HDDELv+5Ustdun+qzjk0IHEBvMZdIMlrSeMEkdp36vWqpLK+Ja7nPLXdBCk1eq5teHzk
         xIag==
X-Gm-Message-State: AHQUAuYKGPAg3a+vPQQzc4I5LCAia8UbaUtOMEtY81kiX+mQ88Aqezms
        X1ougFGWz4aNDs3JHIOpaQ8=
X-Google-Smtp-Source: AHgI3IbnQhLnR4QZ82PQW5/7lIB+f9ziVYiapzlHfmm2SoKyIMfMGmYWceOeZ5qq2Hj+lUsZgU/Xdw==
X-Received: by 2002:ac2:4243:: with SMTP id m3mr1469127lfl.5.1550132622696;
        Thu, 14 Feb 2019 00:23:42 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h22-v6sm307465ljh.89.2019.02.14.00.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 00:23:42 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:23:39 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, mazziesaccount@gmail.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v9 8/8] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Message-ID: <20190214082339.GF12247@localhost.localdomain>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <5aab97a1d68d131d0c5d37e0a78d3c8147a52e9e.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <f11554b9-1842-13bc-7ceb-ca7589eb4518@roeck-us.net>
 <20190214081849.GI1863@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214081849.GI1863@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 08:18:49AM +0000, Lee Jones wrote:
> On Wed, 13 Feb 2019, Guenter Roeck wrote:
> 
> > On 2/13/19 5:37 AM, Matti Vaittinen wrote:
> > > Initial support for watchdog block included in ROHM BD70528
> > > power management IC.
> > > 
> > > Configurations for low power states are still to be checked.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > > 
> > > I maintained the ack from Guenter as only change is to use function
> > > exported by MFD instead of pointer to function provided by MFD. Please
> > > let me know if this is not Ok.
> > > 
> > 
> > NP. With functions exported by MFD, my choice would have been to handle
> > locking there as well with respective locking/unlocking functions exported.
> > But that is your call to make, not mine.
> 
> FWIW, I agree.

Allright. I'll do lock/unclock functions in MFD side and cook up v10 =)
Linus Walleij found something to fix from GPIO too :) Thanks guys.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
