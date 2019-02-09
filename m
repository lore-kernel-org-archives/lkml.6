Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A392C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123DC218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBILux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 06:50:53 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:27248 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfBILux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 06:50:53 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 1D73719F5A6;
        Sat,  9 Feb 2019 12:50:12 +0100 (CET)
Subject: Re: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not needed
 by UFS device"
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <CGME20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c@epcas4p4.samsung.com>
 <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
 <5f2a8378-1f22-6a52-356d-56d3b393ab1d@samsung.com>
 <05d2d193-4181-12ce-b4fb-4e8dec5aef27@free.fr>
 <7610c262-1451-9bb2-48a6-4daf6f534f6c@free.fr>
 <42c86292-22e9-4c5e-d64d-bc6107af45bf@free.fr>
 <740e6332-b54f-ab62-915a-0aec6be450d3@samsung.com>
 <2a59c11a-037f-c8c3-235a-9b21183a0801@free.fr>
 <90f24b35-89b0-cea0-1ab3-13c2a419b138@samsung.com>
 <81b85f39-49b5-901b-ec79-19708509965e@codeaurora.org>
 <2c0e5f03-0bb8-e5db-b5de-790da439fcfe@samsung.com>
 <349da668-6bb5-fcf4-c3f2-f7f7e113ed67@codeaurora.org>
 <fb4c17d4-977f-7737-6c2c-016b9f024d6c@samsung.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <e66235a3-1bf8-1120-9391-8d3f647ab303@free.fr>
Date:   Sat, 9 Feb 2019 12:49:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <fb4c17d4-977f-7737-6c2c-016b9f024d6c@samsung.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding DT & regulator maintainers.

FTR, we are discussing the revert of patch 60f0187031c0
in the UFSHC driver.

On 09/02/2019 09:42, Alim Akhtar wrote:

> On 08/02/19 8:29 PM, Jeffrey Hugo wrote:
>
>> The evidence seems simple.  We have properly described in DT all the 
>> regulators that are consumed by the UFS host controller, and by 
>> extension, the UFS storage chip as well.
>>
>> By default, with no kernel changes, UFS does not work.
>>
>> Marc and I debugged the issue, and found that the VCCQ regulator was not 
>> being handled properly, and reverting the change we are discussing fixes 
>> the VCCQ regulator issue, and, as a result, UFS works.
>
> OK, fair, before we revert this patch, Marc can you try below patch,
> or let me know if you have already tried this and share your 
> result/observation:
> 
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -212,6 +212,7 @@
>                  vreg_l26a_1p2: l26 {
>                          regulator-min-microvolt = <1200000>;
>                          regulator-max-microvolt = <1200000>;
> +                        regulator-always-on;

This property will make _regulator_disable() be (mostly)
a NOP for vreg_l26a_1p2. So the UFSHC driver will not
be able to disable vccq, and UFS will work.

I tested something similar by making regulator_disable()
a NOP which returns immediately. That's actually how I
found the issue in the UFSHC driver ;-)

But this is not a proper solution. This makes it impossible
to disable l26, even when there is no UFS driver, or when
the UFSHC goes into sleep mode.


>> Our analysis is that VCCQ is required and 60f0187031c05e
>> prevents the proper configuration of VCCQ, thus a required
>> resource (VCCQ) is not in the proper state.
>
> Not in proper state or vccq regulator is disabled?

The improper state is being disabled, instead of enabled.

Regards.
