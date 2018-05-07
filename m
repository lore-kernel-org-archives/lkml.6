Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeEGSpj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:45:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46969 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbeEGSph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:45:37 -0400
X-Google-Smtp-Source: AB8JxZq4V/vXSIyx/PnhIPokBlLti6rx/Q1q7zr4Wte2jznX/WH7vX9vd0B52UxTAYtqLCHtKDKVoA==
Date: Mon, 7 May 2018 11:46:59 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tirupathi Reddy <tirupath@codeaurora.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] Input: pm8941-pwrkey: add resin key capabilities
Message-ID: <20180507184659.GG2259@tuxbook-pro>
References: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
 <20180505001039.GA112416@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505001039.GA112416@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 May 17:10 PDT 2018, Dmitry Torokhov wrote:

> Hi Tirupathi,
> 
> On Fri, Mar 23, 2018 at 11:53:12AM +0530, Tirupathi Reddy wrote:
> > Add resin key support to handle different types of key events
> > defined in different platforms.
> > 
> > Signed-off-by: Tirupathi Reddy <tirupath@codeaurora.org>
> > ---
> >  .../bindings/input/qcom,pm8941-pwrkey.txt          | 32 +++++++++
> >  drivers/input/misc/pm8941-pwrkey.c                 | 81 ++++++++++++++++++++++
> >  2 files changed, 113 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
[..]
> >  EXAMPLE
> >  
> >  	pwrkey@800 {
> > @@ -40,4 +66,10 @@ EXAMPLE
> >  		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> >  		debounce = <15625>;
> >  		bias-pull-up;
> > +
> > +		resin {
> > +			interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> > +			linux,code = <KEY_VOLUMEDOWN>;
> > +			bias-pull-up;
> > +		};
> >  	};
> 
> The new key and power key bindings are very similar, I would prefer if
> we shared the parsing code and our new DTS looked like:
> 
> 		power {
> 			...
> 		};
>  
> 		resin {
> 			...
> 		};
> 
> (we can easily keep backward compatibility with power properties being
> in device node).
> 

As discussed here https://patchwork.kernel.org/patch/9751627/ the PON
block does, in addition to providing power and resin key support also
handle the restart reason ("reboot bootloader" in Android).

My interpretation of our conclusion was to come up with a new binding
for the "pon" and a driver for this block that instantiates the power
key device.

It seems reasonable for such binding to describe the two keys, as you
propose here Dmitry, and instantiates the two input devices based on
this.

Regards,
Bjorn
