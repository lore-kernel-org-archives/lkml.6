Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56244C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B342184D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g8xlttbq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TfxFYDMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbeLRKKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:10:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeLRKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:10:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 615B7609A5; Tue, 18 Dec 2018 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545127802;
        bh=jt7Of7VGwkbgWcEoU/1bkmRBcyROPIno/I0F1pqU/nM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=g8xlttbq9KI/Ko55pgIH4QFxePZMY6wDB8qLRKhlRcob6cfA0bcjjqF9EVRaGZwzl
         LOXjhEiwUvwfmQvuuPIylI0P1P+kXj7BE3F0tJDpOzlFERxeJww0k99K4R7Z1bnOSM
         ZRgqnFw2XZq7Mf/dyOUoABd5+WU2dAfCBooTiQqI=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CEE35605A5;
        Tue, 18 Dec 2018 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545127801;
        bh=jt7Of7VGwkbgWcEoU/1bkmRBcyROPIno/I0F1pqU/nM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TfxFYDMrRXKhEnPbNHfNzeg2RMEgJC6F3q62UQNbH3aaazB7tv3rvWBh/HAduP/Ps
         lFO/oTatkvLKDA1kN7w1kXNYTxf254JNGfTAoX8T7G9NFq9xpgGk5VLs510HmoWGIW
         By9p1kWLU/yoLp3neLJx0veNCSirDMkofWOwFQuE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEE35605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] MAINTAINERS: update list of qcom drivers
References: <cover.1545063166.git.amit.kucheria@linaro.org>
        <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
        <87r2ef701w.fsf@purkki.adurom.net>
        <4be46ec9-4d0c-7380-021d-d03d0ab0c9df@free.fr>
Date:   Tue, 18 Dec 2018 12:09:56 +0200
In-Reply-To: <4be46ec9-4d0c-7380-021d-d03d0ab0c9df@free.fr> (Marc Gonzalez's
        message of "Tue, 18 Dec 2018 10:21:42 +0100")
Message-ID: <87mup36t8r.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Gonzalez <marc.w.gonzalez@free.fr> writes:

> On 18/12/2018 08:42, Kalle Valo wrote:
>
>> Amit Kucheria wrote:
>> 
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1929,20 +1929,14 @@ M:	Andy Gross <andy.gross@linaro.org>
>>>  M:	David Brown <david.brown@linaro.org>
>>>  L:	linux-arm-msm@vger.kernel.org
>>>  S:	Maintained
>>> -F:	Documentation/devicetree/bindings/soc/qcom/
>>> -F:	arch/arm/boot/dts/qcom-*.dts
>>> -F:	arch/arm/boot/dts/qcom-*.dtsi
>>> -F:	arch/arm/mach-qcom/
>>> -F:	arch/arm64/boot/dts/qcom/*
>>> +N:	qcom
>>> +N:	msm
>> 
>> IMHO this is pretty fragile in the long term. For example only due to
>> historical reasons qualcomm wireless drivers currently under ath
>> directory but who knows if at some point we switch using qcom (or
>> qualcomm) directory.
>
> I am failing to follow your logic.
>
> (IIUC, you are talking about drivers/net/wireless/ath/ath10k)

Yeah, my example was just about ath10k and wil6210 as they go through my
tree. But it can apply to any other driver and subsystem as well:
bluetooth, future drivers and what ever works with Qualcomm hardware.

> The fact that the "qcom" or "msm" nomenclature is not used for this driver now
> just means that an explicit F entry is required. The fact that it could be renamed
> in the future just means that the entry would need to be updated or folded into a
> more generic matching pattern. What am I missing?

Not sure, but maybe you are missing the point that keeping MAINTAINER's
file up-to-date is hard and having uncommon rules like Amit and you
propose makes it even harder. Yeah, it should be simple but in practise
it's not, people easily forget to update it.

>> Also the wireless drivers might easily have filenames containing
>> strings like "msm" or "qcom" (which I assume would match with "N"
>> rules above).
>
> Any driver (not just wireless) might match "msm" or "qcom". These could be excluded
> with an X directive (as the proposed patch does, in fact).

Nobody will remember, or even know (for example I saw Amit's patch by
accident), that when adding files with string "qcom" or "msm" in path
you also need to add an exclusion to "ARM/QUALCOMM SUPPORT". That won't
work so errors are likely. It's a much safer approach to use F: rules
just like Joe proposed, that way the risk of people submitting patches
to wrong lists is reduced.

-- 
Kalle Valo
