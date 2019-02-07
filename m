Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A1D2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfBGF6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:58:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37057 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfBGF6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 00:58:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id r10-v6so2509931ljj.4;
        Wed, 06 Feb 2019 21:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NXssaq1OMzv6iiyy2hHxOeyg8lE6RGRWHBL0iIV5jQ=;
        b=r5OWoSt1lUZ/T7jrD5SkGFIUBU9Itz7c5SHOk1ZsKlogahY0SEIpn10bpfcqQ4Yu4v
         NL8N+fNhOg106os07rUaD2abk+C8Jsa+Q0OCFqDcykpHl1XDWtAp/EZ/K63cHjclM93G
         mtM4hQwPuZjswwYbpzpWEtt5C5E+MqC2j4NF/UG2EDDk4uUdgG1Tix01tSp0FK6tcEFJ
         7isxXCbSpEC9o8EKI4V2NTpFFWTiUjl5//s2XBcNf4cKP+aarQDvs/fkYgYw/f0a48CZ
         6qvhxhd5n4fnqDZc/C/ev0lXNBmbhcrbrl3z5W79Fsho4BoKRlOBYU+ZqI64EF35+Mp/
         fKWQ==
X-Gm-Message-State: AHQUAuZIVphaBq4Wh93orbJxEM1y2yWCr2S/5+yVufaakHiOeqWJv9kI
        HG+lVfFG/Wv0oc2fB4FIhho=
X-Google-Smtp-Source: AHgI3IbC+iMzjZRO4bHDREeeUhF9lQmrzYMpX0p97OYOnKikdkEdnFyVm+xyBS3WcJr9FaDjHShIzw==
X-Received: by 2002:a2e:a202:: with SMTP id h2-v6mr8662492ljm.72.1549519131013;
        Wed, 06 Feb 2019 21:58:51 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id g11sm3870013lfg.31.2019.02.06.21.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 21:58:50 -0800 (PST)
Date:   Thu, 7 Feb 2019 07:57:38 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v7 00/10] support ROHM BD70528 PMIC
Message-ID: <20190207055738.GA5798@localhost.localdomain>
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
 <87o97ovke3.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o97ovke3.fsf@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moro Kalle,

On Wed, Feb 06, 2019 at 08:31:32PM +0200, Kalle Valo wrote:
> Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> writes:
> 
> > Patch series introducing support for ROHM BD70528 PMIC
> >
> > Please note that patch 1 breaks compilation without patches 2 and 3
> > Knowing the bd718x7 driver is already in upstream, it might be good
> > if this change went through single tree, right?
> 
> That would break bisect, please avoid that. So after applying patches
> from a patchset one by one the compilation should always succeed.

Right. Thanks for the reminder. Mark did also ask about this earlier.
This split was originally done to clearly point out changes impacting
in-tree drivers on separate subsystems/trees (mfd, clk and regulators).

But you are right, these should be squashed before applying. I have now
received acks from Mark and Stephen so I guess I can squash them even
though Lee has not yet commented anything yet. I guess that 7 previous
versions do already clearly enough point out these changes =)

I will squash them in next version. Thanks for the reminder.

> 
> -- 
> Kalle Valo

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
