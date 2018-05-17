Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeEQQHg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:07:36 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52633 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeEQQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:07:34 -0400
Date: Thu, 17 May 2018 18:06:32 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Eric Anholt <eric@anholt.net>, Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <385156660.62726.1526573192894@email.1und1.de>
In-Reply-To: <alpine.DEB.2.21.1805171007260.7820@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net>
 <alpine.DEB.2.21.1805171007260.7820@macbook-air>
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:d+yeZnuF6vdu4Wtgi3zpquTs7bZk+7kA9kro0knYgcl7YRyiIz/
 XtLmSKMs6jTbn+KJY7r/3ScVdT6waROMo6aeTfFcHmoSpKQ6kFIb8hdizBs4rjN5CjdKiFQ
 A8TU5bZPb62BMfqpQC+jMVH2x4bZLtE/xmrdQeLeJ96lGM+ww3bdHxM8Ks/OG5Fc5WDK7xH
 twsK5a2y8G2TpREo1gP9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZNbQc3oHAGI=:sA+Wj4l9Mame8b9ETlhzzj
 YL4dYSwLQ66CHuicL8F0nSS28RUrKCLEnCNcJb2PJHnDhMAQC/D9s2q/pdoUAPxIYkDQbPekh
 NoCW1EKvOLd3XtrW9HMANKzBvi8ddP5j4pUS2U/w5CIg/WlKktKTGp0PYd42s7h04vUvRwWLn
 9XbvOLPOrjMt3aWKOCHQTxakSBeknIZ1G18aRKp0ItnhxH1O4fsQfXlzAI+vxbggCZyM0vvJd
 i/3SFjaj7HrcrJEtSpCw7k6v4pluMkaa8xuyu1T0zojWwdSA160mRM9EqYDRH8XaQyQph1Tt1
 2g1MQNqbDKxiogwPcoIy2+XRPc9ER/44L+C/nfZcudezMfYgZDVG58mIsUZRLtib6ZWk455dr
 4x0Vn0/XrBT4TRzUwm1+eJADSbO8Tvi+GA9b6rptP+lv5bZETH70dlHmCqNcxA1Mc6eawPuz1
 pH83B8lNXzmUN5A1BfOfCmHMFF2t9M86TNe0K8Smo+e2feyS/2mhmt7yNNmgjE2GppKGCvYfH
 OId4UJfG44N8YsGob10LudIgXKF+1JGYqL5ijoI3kqQGgRrt10qHXLZlaBWU/EN+/v/RWV1SE
 AgSmb+wbuA0sC/JPTgjxyEwTlmaS0Orx7pT0sbVfyzCRdwGeVihzfiCba1a0OmycWMVmMNsRo
 fWxHbv0WcD4UT9c1uEVpPMp11gY7KuzPgTmpAACjku/h2WAn50BlQONKOFDnEoeJp0EtH7H5y
 V0n89bNUYvHX1KLy
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Vince Weaver <vincent.weaver@maine.edu> hat am 17. Mai 2018 um 16:11 geschrieben:
> 
> 
> On Thu, 17 May 2018, Eric Anholt wrote:
> 
> > diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
> > index 7704bb029605..1f5e5c782835 100644
> > --- a/arch/arm/boot/dts/bcm2837.dtsi
> > +++ b/arch/arm/boot/dts/bcm2837.dtsi
> > @@ -17,6 +17,12 @@
> >  		};
> >  	};
> >  
> > +	arm-pmu {
> > +		compatible = "arm,cortex-a53-pmu", "arm,cortex-a7-pmu";
> > +		interrupt-parent = <&local_intc>;
> > +		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> 
> why this and not
> 
> arm-pmu {
> 	compatible = "arm,armv8-pmuv3";
> 	interrupt-parent = <&local_intc>;
> 	interrupts = <9>;
> };
> 
> which works, though when I didn't get very far when I submitted the patch 
> to add this last August.

Eric's variant is more specific so we better chose this. The init code diverse between the general arm,armv8-pmuv3 and arm,cortex-a53-pmu.

> 
> Vince
> 
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
