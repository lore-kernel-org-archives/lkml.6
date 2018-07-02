Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A81FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA25925A83
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZoMAnWD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA25925A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753665AbeGBIHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:07:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33008 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964824AbeGBIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:07:35 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w62858ba096517;
        Mon, 2 Jul 2018 03:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530518709;
        bh=lDyzjrU/Z+ZtyWwgEB3UYUydFKTlV+5sJYxsQ0XlaxU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZoMAnWD1VIixnxWx6e8HPBoddSbix09TC/T+aIdvkf3f9Y6NeUS97ieqUAAhP46VR
         FU0gkTvHuwwzf4RpC9QKueOpuLKdF2rdPINbKuZseEBsGP/bI1O1U6TiXWN/4wwQii
         EFXVqhgCrYHqO3lSogGYry1uqSatk2vdYkf9JHAI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62858Lf004908;
        Mon, 2 Jul 2018 03:05:08 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 2 Jul
 2018 03:05:08 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 2 Jul 2018 03:05:08 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w628549g012595;
        Mon, 2 Jul 2018 03:05:05 -0500
Subject: Re: [PATCH 5/8] remoteproc: new driver for TI PRU
To:     Derald Woods <woods.technical@gmail.com>
CC:     David Lechner <david@lechnology.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        <linux-kernel@vger.kernel.org>, "Anna, Suman" <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <20180623210810.21232-6-david@lechnology.com>
 <ce87a7dc-ecf6-f3fd-9121-bf99216f7412@ti.com>
 <CA+CtpRhQ07=3UytY7QrfnpWkY06UqHbNVq099Coez3C4H3U5yg@mail.gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <d331a7dc-9fb0-aa05-36e6-3e1373b6fd16@ti.com>
Date:   Mon, 2 Jul 2018 11:05:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+CtpRhQ07=3UytY7QrfnpWkY06UqHbNVq099Coez3C4H3U5yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Derald,

On 30/06/18 22:02, Derald Woods wrote:
> 
> 
> On Fri, Jun 29, 2018 at 5:14 AM, Roger Quadros <rogerq@ti.com <mailto:rogerq@ti.com>> wrote:
> 
> 
> 
>     On 24/06/18 00:08, David Lechner wrote:
>     > This adds a new remoteproc driver for TI Programmable Realtime Units
>     > (PRUs).
>     >
>     > This has been tested working on AM1808 (LEGO MINDSTORMS EV3) using the
>     > sample rpmsg client driver.
>     >
>     > Signed-off-by: David Lechner <david@lechnology.com <mailto:david@lechnology.com>>
>     > ---
>     >  MAINTAINERS                       |   5 +
>     >  drivers/remoteproc/Kconfig        |   7 +
>     >  drivers/remoteproc/Makefile       |   1 +
>     >  drivers/remoteproc/ti_pru_rproc.c | 660 ++++++++++++++++++++++++++++++
>     >  4 files changed, 673 insertions(+)
>     >  create mode 100644 drivers/remoteproc/ti_pru_rproc.c

<snip>

> 
>     We already have a working irq_chip implementation for INTC.
>     https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pruss_intc.c <https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pruss_intc.c>
> 
>     I think we can leverage directly from that.
> 
>     This way pru_rproc or client device nodes can easily specify a pruss_intc interrupt parent and the
>     SYSEVENT number as the irq. Then device drivers can simply use request_irq().
> 
>     example usage here
>     https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/arch/arm/boot/dts/am33xx.dtsi#line986 <https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/arch/arm/boot/dts/am33xx.dtsi#line986>
>     https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pru_rproc.c#line670 <https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pru_rproc.c#line670>
> 
> 
> 
> 
> ​Is this PRU code on a path to be added to the mainline kernel?​ There is an increase in the number of available systems which would benefit from consistent PRU interfaces. If code is not mainlined, or on a mainline path, some may think it is not usable or ready for production. Is this a permanent "out-of-tree" and/or "TI-tree" development. Just wondering.
> 

Yes, we constantly upstream our work. We are currently working to get the PRU support upstream.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
