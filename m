Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933575AbeCGWCy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:02:54 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38286 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeCGWCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:02:52 -0500
X-Google-Smtp-Source: AG47ELuT0aQkIFPibnqGzpioeMFihDAWB2vNIzhpimtVZaApnXAAkITAUuknDhNe643AjbEvFX9Xuw==
Date: Wed, 7 Mar 2018 16:02:50 -0600
From: Rob Herring <robh@kernel.org>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 3/4] rtc: isl1208: add support for isl1219 with tamper
 detection
Message-ID: <20180307220250.pfaboby7ax7baxp2@rob-hp-laptop>
References: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
 <1520246373-19023-4-git-send-email-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520246373-19023-4-git-send-email-Denis.Osterland@diehl.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 10:43:52AM +0000, Denis OSTERLAND wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> We add support for the ISL1219 chip that got an integrated tamper
> detection function. This patch implements the feature by adding
> an additional timestamp0 file to sysfs device path.
> This file contains seconds since epoch, if an event occurred,
> or is empty, if none occurred.
> 
> The devicetree documentation for the ISL1219 device tree
> binding is added with an short example. It is not a trivial
> device, because it supports two interrupt souces.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  .../devicetree/bindings/rtc/isil,isl1219.txt       |  28 ++++

While preferred to separate, I'm not going to ask for that if there are 
no other changes on the binding.

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/rtc/rtc-isl1208.c                          | 160 ++++++++++++++++++---
>  2 files changed, 171 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt
