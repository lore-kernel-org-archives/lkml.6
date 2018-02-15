Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033704AbeBOPIv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:08:51 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:44481 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033445AbeBOPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:08:50 -0500
Date: Thu, 15 Feb 2018 16:08:45 +0100
From: Lukas Senger <lukas@fridolin.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pps-gpio: Set echo GPIO pin via devicetree
Message-ID: <20180215160845.72da12c3@dinghy.localdomain>
In-Reply-To: <eb34d5ef-2e99-5983-8bdd-bf6fd0dc8bd2@enneenne.com>
References: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
        <20180215125921.29494-1-lukas@fridolin.com>
        <20180215125921.29494-3-lukas@fridolin.com>
        <eb34d5ef-2e99-5983-8bdd-bf6fd0dc8bd2@enneenne.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:CYr+lGsynp2hCkM4J/lKeDeuZIRxFDUhseUFMZiMzEBvPisZf8P
 0NJgM6NeCeoC0TnDabf9CuN2XMfLUczJNtPDWenGY2LRPDqS3AF8IrUxYxOdmDoQafEcO29
 oSjZX4zi5QLAEn9D/Mf84fjK6MWbN//3i+7hF2txOGNaa/cX7ixCt3MvKs1GWHLgTLdBZnB
 1GhyqXX2Rszw9GnsF8LVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d3+EZ7IB0Rw=:KwJsUOASAVYdlo4ReZwkiO
 z8y5t6uZCmJQpLOxnir4A5vougIs9nSaF+Jd/C73nIz7/CW5oRcIx30b75NdcQOjjLjJRKNZH
 HjMduWCBdyWjSAyX71cMOAgfe5Vz+u4j6sNi2rYeKJYFQ/CJ5DemcS5wkDkn1YvwxHGIP8P5G
 1ytOuqNAxAlYb7PzmT8LJDpxrSVFIwkmK6J3MIJtaumydtJD4zoEVXivpB7kvOLz2RX0b6whH
 5nAvm3Q08IEXzLQ/hfGgHF7LNzUFUNB0axbUEd2vcSBU6G4hcQs6ur20Y4xuYdMUyeUD6e8TS
 rURmzXdiR4SXVvyiVYJa0HU44u9o5jHkUwEkfyGZx/z9hyWJLliYPSMZPJ+0ViwsYk8luoSWv
 VzrHgvbJBi44yCByHTBNurINu+LjW4uM6wjqa7NAecAqeoBCd0hZ23OVNbcKins8zX6c0PJ/a
 acD/tEtMmdzuW/ODCRrRx/rexUd+koJYRJpmD+LmMiavSLEaAcVAK8bF3v6p26NoHPsmF4th1
 9x0Q4Ob3NhcXb1z+BHq6M8wef+2US3c0/9Cmc2v5yWXVBufpBvTXJRWMNczS5dpfsrpVAQ3vg
 /Uzu0muVu4z4lUM7froGSuZOdwHfGEYhwdze6TWosnTqzcuK8ptuKGqfow7sewPvS/HxfQH+o
 LfexHOXprLOklbV+FfMDnGr0PFrDbt0Qe1TKtw0zrbVKeoqSSunzxz2wdvCQl4kwUlAYFFOBg
 NCehKEOJfjkhtKQ+ztSopADh4Tx/3uaICAy2KwB7bxIecJ1WWBTegsj+PYs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -20,18 +21,20 @@
> >   		target = <&gpio>;
> >   		__overlay__ {
> >   			pps_pins: pps_pins@12 {
> > -				brcm,pins =     <18>;
> > -				brcm,function = <0>;    // in
> > -				brcm,pull =     <0>;    // off
> > +				brcm,pins =     <18 17>;
> > +				brcm,function = <0 1>;    // in
> > out
> > +				brcm,pull =     <0 0>;    // off
> > off  
> 
> These modifications are not PPS related.
> 
> >   			};
> >   		};
> >   	};
> >   
> >   	__overrides__ {
> > -		gpiopin = <&pps>,"gpios:4",
> > +		gpiopin = <&pps>,"in-gpios:4",
> >   			  <&pps>,"reg:0",
> >   			  <&pps_pins>,"brcm,pins:0",
> >   			  <&pps_pins>,"reg:0";
> > +		echopin = <&pps>,"out-gpios:4",
> > +			  <&pps_pins>,"brcm,pins:4";  
> 
> Ditto.

I don't understand why these modifications are unrelated. Especially
the echopin-option should exist, shouldn't it?

Cheers,
Lukas
