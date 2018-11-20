Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F23C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3672520684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3672520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeKUEUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:20:40 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:46111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeKUEUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:20:40 -0500
Received: from oxbaltgw04.schlund.de ([172.19.246.10]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MIxBc-1gAEre48Da-00KOw1; Tue, 20 Nov 2018 18:49:33 +0100
Date:   Tue, 20 Nov 2018 18:49:31 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Message-ID: <1299453058.112996.1542736171394@email.ionos.de>
In-Reply-To: <20181120172000.15102-1-eric@anholt.net>
References: <20181120172000.15102-1-eric@anholt.net>
Subject: Re: [PATCH 0/8] BCM2835 PM driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev46
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:KsSxJ0gAOjhP67rlh2xuwUvmHleWXmxCGRz23BuBi/5+vPOzrR5
 8QzDI9uI3py43It0AOar2XHRRkX0ZFwKk3a+AVJEIxgTszPz/xySLR/qjYWg3lMqTPKNVRm
 BiKcrI4NAz9ICjqpOOKzvnw6vuUaWk2nD9haCPxhkSYFBMGRTS9Ar9n6FpsEv00LI3xWHqj
 z72Cnt1BZJeJCtdf73x2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PZ1ONvE14Qc=:gaTG8ja9PRAl9sDTOqBdsR
 QfdlHdDYw/Y+z+M8B3eFxfmN6V13K1EyygnxL3923lEbiVyLII6VYjfaphcJWW7lSO5gy6Ky/
 Si8f7fAZ0tm+eLNRR8/RtpAQHK8gAYV83ZFy9sHBZqJFbjNmJPWgeYD/uloo4y6SoLslnDxpt
 vvY1BnbLs8Gr5yib8q1crrcq1NjecCij0rOg6X8UESSfpiAZzkukWfzHKLi/bDWaY7QJ+46o9
 1d8XjT3T7uEDrcCWKQ7HBkG4RsOF6ClWRtDEZWLzvc2hiWUHR084pSQ7Ibs2iM/qLlH+Fx9/x
 7OynLSgmBIcsJhXY6vxBPeCiVYU5LCa98oAp/rtIqPcbiGpTzP3+kooWjPr0I0gYUe01iW3ZA
 rGuWMRWlQnynXnVa5OVr6xpFqdmwOECrN2XQ5mZwWUY22nZMTnSuF7zrN4Zp9dgt+tozBMM+b
 WRvldPP/BoU1WIPvi4PZSgrxd8+tW0CLB/sGR88HRUZF6i9jcmgCy1+Bg54dOoOSZMLM33H2n
 LQ1rmXa/w+LY3o9ElqkA0awzrOFWFj6DY871zK5Vhn/vjaVL4X+zt7oXlFximYgYiD8M00c6z
 6HQ+Noiv9eUf2JXpVQ4CT6AsyKktqP6/78Uus2ExTJChlyVd7EqhxhsIsy1P5EfdUGqkdx3t0
 u9GTacd55EC+yIbcrbVDKfKBYUVjZ3NIpyeFAJzholBF+RvTkVk+4yrLAbmoOkvIx4Rxan7ga
 VL71XgVx0mYWcIIyV6qmaW7dUYOmx01eBVQlNWAr+zvSkIt+EnQKnefOLwMTVJ0CwqpBvvgVY
 ELZVLtOMqymqPsOyVZzf2DgOsEAJNmhA3aAgcgvA8d/q+y091A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 20. November 2018 um 18:19 geschrieben:
> 
> 
> This series moves the BCM2835 WDT driver that controls a fraction of
> the PM block out to soc/ and adds most of the rest of its
> functionality.  My motivation has been to have V3D be functional
> without firmware calls, probably improve its interactivity (since
> we'll be able to power on/off without RPC to the firmware that may be
> busy with other tasks), and (in a patch not submitted in this series)
> extend its binding to use the reset controller instead of trying to
> reset by toggling its power domain.
> 
> I've tested V3D with a few hours of running a V3D test, sleep(1) (to
> trigger PM domain off); running a GPU hang job (to trigger reset);
> sleep(1).  The non-hanging success-case job always passed, and dmesg
> had no complaints from bcm2835-pm.  The other power domains are not
> tested, but I've done my best.
> 
> This series will probably also be of interest to the
> https://github.com/christinaa/rpi-open-firmware project for enabling USB.
> 

apologize to give you my feedback after you send out the series.

I know you won't be happy about it, but i think we need a little more complex but future proof solution for this power driver. According to the register definition of the PM block, we have multiple functions here (power domains, watchdog, pads/pinctrl, ...). Since this is common for ARM SoCs there is a subsystem called mfd (multi function device) [1] to abstract all resources of the IP block.

This has the advantage that we don't need a monolithic driver which takes care of all functions.

According to this approach we would have the following drivers:
mfd/bcm2835.c
soc/bcm/bcm2835-power.c
watchdog/bcm2835_wdt.c

Best regards
Stefan

[1] - http://events17.linuxfoundation.org/sites/events/files/slides/belloni-mfd-regmap-syscon_0.pdf
