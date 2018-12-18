Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68486C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EEB205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbeLRJWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:22:13 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:32861 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbeLRJWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:22:11 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 0299A13F866;
        Tue, 18 Dec 2018 10:21:42 +0100 (CET)
Subject: Re: [PATCH v1 1/1] MAINTAINERS: update list of qcom drivers
To:     Kalle Valo <kvalo@adurom.com>,
        Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1545063166.git.amit.kucheria@linaro.org>
 <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
 <87r2ef701w.fsf@purkki.adurom.net>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <4be46ec9-4d0c-7380-021d-d03d0ab0c9df@free.fr>
Date:   Tue, 18 Dec 2018 10:21:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87r2ef701w.fsf@purkki.adurom.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2018 08:42, Kalle Valo wrote:

> Amit Kucheria wrote:
> 
>> Several drivers didn't have a specific maintainer (other than the
>> subsystem maintainer). Switch to using the 'qcom' and 'msm' regex
>> patterns to capture all of them and add exceptions to the couple of
>> drivers that contain 'msm' but are not related to qcom hardware.
>>
>> Thanks to Marc for the idea to use the N regex.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  MAINTAINERS | 14 ++++----------
>>  1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3318f30903b2..c9376030f77a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1929,20 +1929,14 @@ M:	Andy Gross <andy.gross@linaro.org>
>>  M:	David Brown <david.brown@linaro.org>
>>  L:	linux-arm-msm@vger.kernel.org
>>  S:	Maintained
>> -F:	Documentation/devicetree/bindings/soc/qcom/
>> -F:	arch/arm/boot/dts/qcom-*.dts
>> -F:	arch/arm/boot/dts/qcom-*.dtsi
>> -F:	arch/arm/mach-qcom/
>> -F:	arch/arm64/boot/dts/qcom/*
>> +N:	qcom
>> +N:	msm
> 
> IMHO this is pretty fragile in the long term. For example only due to
> historical reasons qualcomm wireless drivers currently under ath
> directory but who knows if at some point we switch using qcom (or
> qualcomm) directory.

I am failing to follow your logic.

(IIUC, you are talking about drivers/net/wireless/ath/ath10k)

The fact that the "qcom" or "msm" nomenclature is not used for this driver now
just means that an explicit F entry is required. The fact that it could be renamed
in the future just means that the entry would need to be updated or folded into a
more generic matching pattern. What am I missing?

> Also the wireless drivers might easily have filenames containing
> strings like "msm" or "qcom" (which I assume would match with "N"
> rules above).
Any driver (not just wireless) might match "msm" or "qcom". These could be excluded
with an X directive (as the proposed patch does, in fact).

Regards.
