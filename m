Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935267AbeEYFIl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:08:41 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39709 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeEYFIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:08:38 -0400
X-Google-Smtp-Source: AB8JxZpZX9EUL3lqnxsRql8j/54XkoNnM0nfsZIthvu0RixwvO741mBLPeqd6eDmTSd6Kxfoog9Rwg==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Fri, 25 May 2018 08:08:25 +0300
To: Mark Brown <broonie@kernel.org>
Cc: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH 8/9] regulator: bd71837: BD71837 PMIC regulator driver
Message-ID: <20180525050825.GA16888@localhost.localdomain>
References: <20180524060036.GI4249@localhost.localdomain>
 <20180524141427.GU4828@sirena.org.uk>
 <042F8805D2046347BB8420BEAE397A4016C06B60@WILL-MAIL002.REu.RohmEu.com>
 <20180524175940.GC4828@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524175940.GC4828@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 06:59:40PM +0100, Mark Brown wrote:
> On Thu, May 24, 2018 at 05:51:27PM +0000, Vaittinen, Matti wrote:
> 
> > > what is the lock doing and what is this wrapper function intended to do?
> 
> > This was the other spot which I was unsure how to handle. Datasheet for
> > the chip says that if voltage is to be changed, the regulator must be
> > disabled. Thus my voltage changing function checks if regulator is enabled
> 
> Ugh, this chip is not very good is it?
I am not the correct guy to judge that as I don't have too wide
experience on PMICs. (This is first PMIC I have been working with).
Probably this chip has some other advantages and is thus used.

>  Don't bounce the supply to
> change the voltage silently, that's clearly a bad idea - the devices
> using the supply are going to get very upset when the power gets removed
> just because they changed the voltage.  Instead implement a custom set
> operation that returns an error if the user attempts to change the
> voltage while the regualtor is enabled.

Makes perfect sense. I will change the operation to this.

Br,
    Matti Vaittinen
