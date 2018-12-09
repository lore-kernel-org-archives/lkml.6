Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1ACC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C8F20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C8F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLIMOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 07:14:54 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:54003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeLIMOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 07:14:53 -0500
Received: from oxbaltgw09.schlund.de ([172.19.246.15]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MYNW6-1h1Qtt2V4E-00VPZx; Sun, 09 Dec 2018 13:14:03 +0100
Date:   Sun, 9 Dec 2018 13:14:01 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Message-ID: <53380420.68255.1544357641824@email.ionos.de>
In-Reply-To: <20181130202743.20585-2-eric@anholt.net>
References: <20181130202743.20585-1-eric@anholt.net>
 <20181130202743.20585-2-eric@anholt.net>
Subject: Re: [PATCH v3 1/5] dt-bindings: soc: Add a new binding for the
 BCM2835 PM node.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:mhi5VNbh49HU3iPYNttRAeK16mzFVlsMEWX2Jr0BKNDmRDYir9C
 T9nxyptjo0mPkH03bjT7OTl518XTHw5TE0HOSujf1M8b8wCG7lbD1LkOJsb/rdgAGDqhBEf
 /f39FzD6cQN5ZyGkuImO4nJ2gdl8CbRorirUauCwMbJ1d1qagF/0xI5NWS4r3yHur7XMM8t
 TrPBfNBwGTB4jNw+OU9LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mTBE6MxyVeI=:CwhDgGnxhEBETMdvQmE88J
 qW4i88hqGr3+cymJIsWpmfVDsxV6bjimh9z3/5PMA5yz1WBEp/RsU7ZrTRNvdrzdwUfxUMKCB
 pX5FaJwS+bgPFHOk0oEnFp/Bx+FlZ3nXwvbMr1WrpV6zzRuVYjENV9mqSQ/e0i2y74bUWdxVK
 hhiT9v5jElD2LeT37MTyh8yQInUfggYDIsflMOS84tgZnkFo0F2KlN7SrkIiYnWIn0iq3MTnM
 eqagHwYAVwMe6UW3FqxtTeKnM3PAOrtUnPbRZ2kfbgNzvQiGVxI1qexEhTWW+qo7UzQKf0JEB
 IeYJUABDkRscwMBIuBHUuGva/AcWLJDhneL4o1HT9PdE0AOV95HGrsMyRimsRKwkaGsQWaeQV
 KvaX2ed1GXmTz3tm9L9mLpG9WjwppyuIlmIEj65a9UiWneapgQ9EbFDCmQCup9wp41WrWp0rb
 YOfptK0SBC70VYLR/HP884+Yz0ky6X5qhtR5k3kU3Ut65pNHmL2WOmLNMfBYZSV0ti4ojZ0/a
 eZFSZFm5CaZ9mWmshMo3/GS5GpCsvRi4jypzBfWayjq8gRDR2P8FpGf3EPamAEhyIozk1qq4O
 qvGAbzV5X3OyPvLpxEcMl8VKtwO6kwtUZ3wgm8c8MZH75NR181X8XXpz7Hnmi3S7lp2ALIxlO
 6CHP6Wn6JUyDjVd2pM3mZIJvTjWGZQwgbhguynG0rez96sVf2xy/wSVGMmMa3+fQ0mWYdQrVr
 VAdzn3lfiQhSvYUSlJwVMrUjuw1nDGktZ/H1aMR0vArOh8Y4YLfGU+fLzzU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

[add Sebastian]

> Eric Anholt <eric@anholt.net> hat am 30. November 2018 um 21:27 geschrieben:
> 
> 
> This binding supersedes the bcm2835-pm-wdt binding which only covered
> enough to provide a watchdog, but the HW block is actually mostly
> about power domains.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> new file mode 100644
> index 000000000000..7818d33a158f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> @@ -0,0 +1,42 @@
> +BCM2835 PM (Power domains, watchdog)
> +
> +The PM block controls power domains and some reset lines, and includes
> +a watchdog timer.  This binding supersedes the brcm,bcm2835-pm-wdt
> +binding which covered some of PM's register range and functionality.
> +
> +Required properties:
> +
> +- compatible:		Should be "brcm,bcm2835-pm"
> +- reg:			Specifies base physical address and size of the two
> +			  register ranges ("PM" and "ASYNC_BRIDGE" in that
> +			  order)
> +- clocks:		a) v3d: The V3D clock from CPRMAN
> +			b) peri_image: The PERI_IMAGE clock from CPRMAN
> +			c) h264: The H264 clock from CPRMAN
> +			d) isp: The ISP clock from CPRMAN
> +- #reset-cells: 	Should be 1.  This property follows the reset controller
> +			  bindings[1].
> +- #power-domain-cells:	Should be 1.  This property follows the power domain
> +			  bindings[2].
> +
> +Optional properties:
> +
> +- timeout-sec:	Contains the watchdog timeout in seconds
> +
> +[1] Documentation/devicetree/bindings/reset/reset.txt
> +[2] Documentation/devicetree/bindings/power/power_domain.txt
> +

sorry for my late reply. I hope we can take the opportunity of a new binding to fix an old issue of the bcm2835-wdt driver. The watchdog driver sets the pm_power_off callback without checking for "system-power-controller" property [3]. As a result we can't use another poweroff controller like e.g. gpio-poweroff. In downstream this has been workarounded by an additional devicetree property for the gpio-poweroff driver [4]. But this isn't the right way because the issue is in the bcm2835 watchdog driver not in all the other reset controller.

Suggested pseudo code:

if (!pm_power_off) {
    /* Preserve the old behavior of watchdog driver in case of old DTB */
    if (!of_device_is_compatible(dev->of.node, "brcm,bcm2835-pm") ||
        of_device_is_system_power_controller(dev->of.node))
        pm_power_off = bcm2835_power_off;
}

Best regards
Stefan

[3] - https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/power/power-controller.txt
[4] - https://github.com/raspberrypi/linux/commit/f86dcfac0a4e478fee40b5a3729ff1b159ae91ee
