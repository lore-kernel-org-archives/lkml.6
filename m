Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A04C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D2B20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D2B20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbeGZLFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:05:34 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48077 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbeGZLFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:05:34 -0400
Received: from [192.168.178.69] ([109.104.45.192]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0LcgwZ-1gRtwK1fCZ-00k8xz; Thu, 26 Jul 2018 11:48:51 +0200
Subject: Re: [PATCH v8 0/6] provide power off support for iMX6 with external
 PMIC
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        yibin.gong@nxp.com, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-imx@nxp.com,
        kernel@pengutronix.de, "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <650c8289-f3a1-8bb1-2e4b-876100f9ae21@i2se.com>
Date:   Thu, 26 Jul 2018 11:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726092220.17250-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:TGbvXDBQsjAgxHG6A0qdj/ZgAIMPbeIwfVyvQCMSNXbKshMh4Nm
 Cpo+Zs1C3Wnc6MOra8+rgLsHkXJMnGYKzAKhLEX2DcijEBDgaHUsNc5InKExDYGrqsf2+6x
 ceUcWUjhhG2JR8wOXFuBg0p1aWTlUUFia6R+B22R3tizuJSJ3SUItMFiwVYtp0lKfHUDhiu
 CywP6EDCMt0vx5z5VQvTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zgRDaKK/RxI=:i6Xbb7TG5WV+0jGzrCxyyC
 iBPMNtVNYwi9Ha8GEikr8i9p+o85Fw7dvqI+jwwZ3rkn8KKcGrKt7WAeVV5DXXft+DXEChyws
 8yAqXchaFk9L7VACoSUg/Zr6yE9pwFaoo/YRPs7lhWuurPuz2sgcfxcMj7PokqwNVWXlSNHhk
 ddk+DCMhR13/Ca6YTjMDbN+DNYiq5NchKKSjNQe3vihjfsFmqJOtm0muVVv9EfwU8rd5GV/rO
 DqsyWMCyYxUFUM/5cfOmXPoTgJTkC5VrPh64tVfdhSw684F56o8GZ6sYheV6yplKjDhz6p8pI
 jvPbWVItq8mp+U8McboSeeXm729KF3ruE4ce4bu60vMit14wtbu2uPt2jzHRRQvB83g44Z4FT
 VEnors3KzWcqSo7nRYrcVvQwkPduDe5DnH27zUt4t7dY5/i15s2nJzbP6cjXZG4prKqxuYy74
 V84rTNubw7y9YXYd7CS6/+C5ON32qDnOyJNloqCbVss92Avya9tYnCvXKDKaEOc6ZglJLVd+o
 PP9BZKNXG43E+Fs5Gn0KS2iI+TGlQanS94HmFuGvXBR9ube96EpA+Uzc0DUUyzUoB6OZZ9nBs
 lOSAvh7LVDdRH3gaZ/sTAN87T+eOmeLwGTyH2V1wzQZAtlJynf2a7Eglto1bucd9wplJBysLb
 2i+HWPVl+gpSr5tF+rEGKoX2RRhi99sFHxqXT5t1HWaxAtlDid97QKaSv9kXM4mVRfxDQJuJ5
 Lshwm9aFoatZL0D2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

Am 26.07.2018 um 11:22 schrieb Oleksij Rempel:
> 2018.07.26:
> v8 is a rebase against kernel v4.18-rc6. No other changes are made.
> Added: linux-imx@nxp.com and yibin.gong@nxp.com to the CC.

your patches won't apply to regulator-next or linux-next because 
"regulator: pfuze100: add pfuze3001 support" has been merged before.

Since the pfuze3001 doesn't support standby, it would be nice to make 
the driver take care of this.

Best regards
Stefan
