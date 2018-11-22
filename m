Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C62A20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C62A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406408AbeKWELq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:11:46 -0500
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:46896 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732076AbeKWELp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:11:45 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2018 23:11:44 EST
Received: from [192.168.0.100] (pC19F5E03.dip0.t-ipconnect.de [193.159.94.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by smtp.math.uni-bielefeld.de (Postfix) with ESMTPSA id A0A8E5F438;
        Thu, 22 Nov 2018 18:24:34 +0100 (CET)
Subject: Re: [PATCH 0/6] devfreq: handle suspend/resume
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
References: <CGME20181121180156eucas1p225af7f4341a039264ff26f2a9ad9bb12@eucas1p2.samsung.com>
 <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
From:   Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tjakobi@math.uni-bielefeld.de; prefer-encrypt=mutual; keydata=
 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
 24xKzP1yWf7TCvc+DT6gUl4T65RXUQyTeJ0=
Message-ID: <1d9cf1b6-b625-4b6d-7578-0f02f7efdb8a@math.uni-bielefeld.de>
Date:   Thu, 22 Nov 2018 18:24:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.9.1
MIME-Version: 1.0
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lukasz,

just wanted to say hi and thanks for picking this up. Sadly my work no longer
permits me to spend time working on the kernel.

Anyway, great that this issue finally gets solved! :)

With best wishes,
Tobias


Lukasz Luba wrote:
> Hi all,
> 
> This patch set aims to address the issue with devfreq devices' frequency
> during suspend/resume. It extends suspend/resume by calls to Devfreq
> framework. In the devfreq framework there is a small refactoring to avoid
> code duplication in changging frequency (patch 2) and there are extensions
> for suspending devices.
> 
> It has been tested on Odroid u3 with Exynos 4412.
> 
> The patch set draws on Tobias Jakobi's work posted ~2 years ago, who tried
> to solve issue with devfreq device's frequency during suspend/resume.
> During the discussion on LKML some corner cases and comments appeared
> related to the design. This patch set address them keeping in mind
> suggestions from Chanwoo Choi.
> Tobias's paches:
> https://www.spinics.net/lists/linux-samsung-soc/msg56602.html 
> 
> Regards,
> Lukasz Luba
> 
> Lukasz Luba (6):
>   devfreq: add basic fileds supporting suspend functionality
>   devfreq: refactor set_target frequency function
>   devfreq: add support for suspend/resume of a devfreq device
>   devfreq: add devfreq_suspend/resume() functions
>   drivers: power: suspend: call devfreq suspend/resume
>   arm: dts: exynos4: set opp-suspend for DMC and leftbus
> 
>  arch/arm/boot/dts/exynos4210.dtsi |   2 +
>  arch/arm/boot/dts/exynos4412.dtsi |   2 +
>  drivers/base/power/main.c         |   3 +
>  drivers/devfreq/devfreq.c         | 159 ++++++++++++++++++++++++++++++--------
>  include/linux/devfreq.h           |  11 +++
>  5 files changed, 146 insertions(+), 31 deletions(-)
> 

