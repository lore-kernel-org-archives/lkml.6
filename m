Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FF4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE4F20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfAQFyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:54:43 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:52668 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbfAQFyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:54:43 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 0D/51-12934-E98104C5; Thu, 17 Jan 2019 05:54:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRWlGSWpSXmKPExsVy8+3OTbpzJRx
  iDLp+WFtMffiEzWL+kXOsFqe2NzFZ3P96lNHi25UOJovLu+awWcxe0s9isfT6RSaL1r1H2C32
  X/Fy4PJYM28No8e3r5NYPHbOusvusWlVJ5vHnWt72DyO39jO5PF5k1wAexRrZl5SfkUCa0bPz
  FVsBX2cFUc7/7E2MO5l72Lk4hASeMoo8W15F5DDCeRUSLR/WcMKYrMIqEr0nOwAs9kErCR2r1
  nM0sXIwSEioCJx7o05SC+zwFomie1NNxlBaoQF3CR6f04Bs3kFdCSW/TzOArFgLaPEnT1fWSE
  SghInZz5hAbGZgYoW7P7EBjKUWUBaYvk/DpAwp4CWxLV778DKuQV4Jc5vWMMMUiIKtPfVwXqI
  M7Ukrv47CHayhICCxLn125hASiQE4iQu92dDhDUlnu94yghh20tMf3+VGcI2lPg+6xsLhG0uM
  ef9NFYI20bi0N9WNgjbVGLF3MvMExglZiG5eRaSm2ch3LyAkXkVo0VSUWZ6RkluYmaOrqGBga
  6hobGusa6loV5ilW6iXmqpbnJqXklRIlBSL7G8WK+4Mjc5J0UvL7VkEyMwFaQUMkfvYFyxNP0
  QoyQHk5Ior/cB+xghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKEry8wNQiJFiUmp5akZaZA0xKMGkJ
  Dh4lEd5WcaA0b3FBYm5xZjpE6hSjLsfD1s9zmYVY8vLzUqXEeV+LARUJgBRllObBjYAlyEuMs
  lLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHlPgqziycwrgdv0CugIJqAjLjywBzmiJBEhJdXAmL
  d0t6SG5+Pr91X/qW7SWpa6OVLjb2fmkz/mWwIitv4wNH4rPsG0ujin4/yd6qSEIono4q9vKrP
  1i6q6TIr9DhQaNzrkGaYFi/e83Du79f2Do4uPPVBRa12R7Pz/JqfufOv/ryYcYLJrrGr7WZNe
  wGcZsCMh/s7uJ4pTTXsW75osc2jKpARXJZbijERDLeai4kQA+cQeTYsDAAA=
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-5.tower-223.messagelabs.com!1547704477!232952!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21975 invoked from network); 17 Jan 2019 05:54:37 -0000
Received: from unknown (HELO SVEX01012.wago.local) (217.237.185.178)
  by server-5.tower-223.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 17 Jan 2019 05:54:37 -0000
Received: from lc010965.wago.local (10.1.101.138) by SVEX01012.wago.local
 (10.1.103.230) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Thu, 17 Jan
 2019 06:54:37 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)
        id 12A131702965; Thu, 17 Jan 2019 06:54:37 +0100 (CET)
Date:   Thu, 17 Jan 2019 06:54:37 +0100
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mfd: tps65218.c: Add input voltage options
Message-ID: <20190117055436.GA4213@wago.com>
References: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1547453794-18770-3-git-send-email-Christian.Hohnstaedt@wago.com>
 <20190116141336.GG23399@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190116141336.GG23399@dell>
Keywords: Old
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.1.101.138]
X-ClientProxiedBy: SVEX01012.wago.local (10.1.103.230) To SVEX01012.wago.local
 (10.1.103.230)
X-KSE-ServerInfo: SVEX01012.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 17.01.2019 03:18:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: deb34f4f-1670-42da-9b53-f8c7bceb0e0a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 02:13:36PM +0000, Lee Jones wrote:
> On Mon, 14 Jan 2019, Christian Hohnstaedt wrote:
> 
> > These options apply to all regulators in this chip.
> > 
> > ti,strict-supply-voltage-supervision:
> >   Set STRICT flag in CONFIG1
> > ti,under-voltage-limit-microvolt:
> >   Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
> > ti,under-voltage-hyst-microvolt:
> >   Select 200mV or 400mV UVLOHYS in CONFIG2
> > 
> > Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> > Tested-by: Keerthy <j-keerthy@ti.com>
> > Reviewed-by: Keerthy <j-keerthy@ti.com>
> > ---
> >  drivers/mfd/tps65218.c       | 89 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/tps65218.h |  4 ++
> >  2 files changed, 93 insertions(+)
> 
> This looks like regulator code.
> 
> Why aren't you placing it into the regulator driver?

This code manages properties of the chip, affecting all regulators.

The regulator-driver has no hook to be called once for the chip.
Even if I put this code into the regulator driver file,
I will have to call it from here.

This would introduce a dependency from the mfd to the regulator code.


Christian
