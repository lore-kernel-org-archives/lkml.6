Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966443AbeEYLbi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:31:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33890 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965907AbeEYLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:31:35 -0400
X-Google-Smtp-Source: ADUXVKLXvUWHOCBO9qu6teRnnWbQ/NlKMuWjPxQCDNNVEPl2upAuhvI+pat9yqVd6iznnsXfkz7hIg==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Fri, 25 May 2018 14:31:30 +0300
To: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH 4/9] regulator: bd71837: Devicetree bindings for BD71837
 regulators
Message-ID: <20180525113130.GD16888@localhost.localdomain>
References: <20180524055752.GE4249@localhost.localdomain>
 <20180524140118.GS4828@sirena.org.uk>
 <042F8805D2046347BB8420BEAE397A4016C06B47@WILL-MAIL002.REu.RohmEu.com>
 <20180524175721.GB4828@sirena.org.uk>
 <20180525055430.GB16888@localhost.localdomain>
 <20180525102458.GJ4828@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525102458.GJ4828@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 11:24:58AM +0100, Mark Brown wrote:
> On Fri, May 25, 2018 at 08:54:30AM +0300, Matti Vaittinen wrote:
> > On Thu, May 24, 2018 at 06:57:21PM +0100, Mark Brown wrote:
> 
> > > You can look at the regulators node within the parent device, you know
> > > that in Linux the parent device will be the MFD.
> 
> > So I should parse the device-tree in MFD my driver in order to locate
> > the regulators node? Isn't that somewhat like code dublication? If we
> > rely on compatibles we can avoid device-tree parsing in MFD driver,
> 
> No, there's no need to do this - the child can just look at the of_node
> of the parent since it can never be instantiated otherwise.
> 
> > right? An in-tree example of this is:
> 
> There are some bad examples (and some where the same regulators can get
> used with multiple different parents) but that's no reason not to follow
> good practice.
Fair enough. I guess you may still know regulator subsystem better than I
do with my one month of experience ;) I'll follow your suggestion and
cook-up new patches.

Br,
    Matti Vaittinen
