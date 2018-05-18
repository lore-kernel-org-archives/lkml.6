Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeERJi0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:38:26 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50067 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeERJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:38:24 -0400
Date: Fri, 18 May 2018 11:37:38 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Cc: Ingo Molnar <mingo@redhat.com>, linux-rpi-kernel@lists.infradead.org,
        Eric Anholt <eric@anholt.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <1863838560.56771.1526636258081@email.1und1.de>
In-Reply-To: <d6b6f632-2051-a239-3e44-4750f2ac89d5@arm.com>
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
 <alpine.DEB.2.21.1805171233500.7984@macbook-air>
 <307323036.63872.1526576126537@email.1und1.de>
 <20180517180758.GK12198@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1805171422450.8529@macbook-air>
 <alpine.DEB.2.21.1805171530080.8529@macbook-air>
 <0a643984-1586-8c56-6627-430f0c2a4ba8@gmail.com>
 <d6b6f632-2051-a239-3e44-4750f2ac89d5@arm.com>
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:oS9dzkFAPra85Bcveg7tFXMl4HqNZYWH8OiENfvqzpycxTjbZNJ
 667zmYTSpXhNvj68M0knbv6EnBhlU/i8Fi/vaToKpnBKLKzjexpUtGNSPXyCUDaUfGpLciP
 ktr1G0ypCRfAjui/LCaSM1b7usnuhaDacVrqZSZay/gXajgeY1OebwqRgGiXX82Yu7JJIwV
 mWi3Ekt5fr5AMmAyl8J+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sQqMkJOga5o=:tD1Y9NC8MfdBffXLRcUaef
 CN9EvkkWDJ4bx7u4NT8Qgzv8KCcCeLg8+PGMGHlXQoEey18anI1b02u6z9AxvdCXRSTrmgPf4
 t8yBojGPTMwbg2GFF+2mqlP5Dj4dW5s2fezZA6MwHC5C4vMb6d8s6bul9Z/wVRVOhYLOwGHyf
 xIUPKrGVCmfCRYly8za0uYHVRVMwcyZoPXaX/lHOE0H960dCFHPiO4igJc1vUkxyTY+U8Qm2Q
 aPXv+Sr0hoWQvUCapuqKYyeBEhAuk8hyrxvPNLDy0VI8WOjZD8KiHcryR7OMbkxQYtZfDQ8qf
 bLd6gq7Zq3h5Qwb6+lVYwtSr9U7MbvdVJiLGyLNpAeXUtvEcxTj8UH2SkaHoYuLoE9b0Dkd+M
 Yyl1bvsN4wsJVGTSlVeu5BQs2g2zmItfauerZb+S9ZkxJN14lcevxvcVLa3dWJvs0h85ik4kH
 wiopyHkHx8Y0CXwp3Mi4LpXI8uSOOjkhHIre8M69u//oEc4+vfyQx2v9bBTvqg3EPynZi8syX
 BCOplkXA/eFU8QNkyMbb85U6vY+N7rErVzjEwPMAK2xWuymfBJtjCIGc6ndo8j2P8QdxOaYRs
 VKkRPo+A7m/Lw68ZfXZdb2e22rR+cCMgwS2I3lKMkabNIBKiz7TjnVw1DISunMrgK6LnY00Ys
 T3YSPh6GRGjFOmtdFDzcYOnC6+RdsZpwVFlu8JF1mZgUb+210163Tso2oMAz8pmuCovzfdimF
 A+EfZfJSOkPvuPoY
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> Marc Zyngier <marc.zyngier@arm.com> hat am 18. Mai 2018 um 10:07 geschrieben:
> 
> I have a pretty simple series[1] which I used to profile 32bit guests on
> an arm64 KVM host. Nobody really cared about it because running a 32bit
> kernel on 64bit HW is a bit odd, to say the least, and I'm probably the
> only one actually running 32bit VMs.
> 
> > FWIW, Broadcom STB chips, even when 64-bit capable or often used with an
> > 32-bit ARM kernel, so having the ARMv8 PMUs work under a 32-bit ARM
> > kernel would be great. The downstream solution we have sued thus far is
> > to find the closest compatible string to represent those, which is not
> > great...
> Ah, so you're *really* doing that? I'm not going to ask why, I'm scared
> of the answer... ;-)
> 
> Anyway, I can repost that series if that will prevent people from having
> that kind of silly hacks.

yes please. But there is a minor nit: some patches introduce new files without SPDX tags.

Thanks
Stefan

> 
> Thanks,
> 
> 	M.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm/pmuv3-32bit
> -- 
> Jazz is not dead. It just smells funny...
