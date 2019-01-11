Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3ED02084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqtPIG4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfAKIzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:55:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44275 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfAKIzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:55:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so12205581lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZnwS0UuAawby2xTYVAS4ESIHWQAdYQ5XXXYonUNREA=;
        b=gqtPIG4r0RBPfFa2sTmSIB5c/MyMrQkRqTamIESgg92BqpNdDDzIZyrG44i9mLsZhF
         ENffpyM4t82ohFfRBXU87F7VkQxF9amHyA2Qz/ysYdXd6bMIx+J1b/aFl768II0p26fI
         cB5Ajl+L/HMsHFezgYtNXbs5lwBgVsY0nMsDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZnwS0UuAawby2xTYVAS4ESIHWQAdYQ5XXXYonUNREA=;
        b=ExN9DzS7onFgmARnVPBMuC9kcVl8ygb+ALfi9qUaY+IDMSGygfzNpYSysRoFclVlrn
         +kDcWOU08+MczuLHVj7rCxk1Ay7FxyfzCBtg9zZKkyaBFQwE2UZKwiADS8dGvgdrwg18
         weCW+wVqkkoEhpYp1eqJsIAYOANPs6w+GcwOUUZtVFpyFRiJpq1qkPNDxE1SHdmsGtdt
         GkfT8dx0hvUbexf+Kmv9KNgeP46oan/nZzHu4GVzx8pvHRgJ6kO8GQ2weMNlFRO8xiQB
         NIvsNjHz0I5rR/C4+185ADCkIrUJFQn9DmCHMPKDO1zNgsUM/Gz/OL2bWqgdftjFboWN
         wDeg==
X-Gm-Message-State: AJcUukfNKzAwJ3oyxBdJCmpMROVE/yofDlvONLu+kIkej1+Xa6VRt/nP
        72wBX6HY7R/vW93hbOTRfAs5T/Bp8gRk1t55xt+LXw==
X-Google-Smtp-Source: ALg8bN78YAkfv9ZwqXO+lDtEo+CCYFX9gLiVY9lAo21GPQ/x3WxwEKGO7/SbTwoEml6LnqpCcjUgl+grueS2ztsUI8A=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr7992150ljg.23.1547196899051;
 Fri, 11 Jan 2019 00:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20181221173259.8372-1-gregory.clement@bootlin.com>
In-Reply-To: <20181221173259.8372-1-gregory.clement@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 09:54:47 +0100
Message-ID: <CACRpkdZbano_a1CgF8mzUULZwgUL5rP3bnHPhvm+yB_G=wohbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Few fix for pins configuration on Armada 37xx
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 6:33 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> this small series fixes wrong pins configuration we currently have on
> Armada 37xx.
>
> For now it is especially annoying it we want to enable suspend to
> RAM for PCie.

All three patches applied for next (v5.1) with Miquel's
test tag.

Yours,
Linus Walleij
