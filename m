Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481FEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4708320862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jpYTAqs/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gkwp4Yk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4708320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389720AbeKGD0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:26:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbeKGD0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:26:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B69360B62; Tue,  6 Nov 2018 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541527182;
        bh=S72MoXV31HEOEeoiYxnMp29sC4s1M3TFz4LShYrgRzU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jpYTAqs//hN29PyiIDy4OwIn30uI+dcorfxRQvBE93ltLv5zSUnGsHE/tdm3lxVpA
         E9r3NjdasyOy0D/3KF3PCTR0VR7r+Dsl1v/DzDCpjEaCmFcRv42SQrE1A9HnRTZbv+
         uBZiK0uNb69K5lvNgmgJU4QTBiBzWY+W3DK9/pNY=
Received: from [192.168.0.104] (unknown [183.83.73.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A01F601D7;
        Tue,  6 Nov 2018 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541527180;
        bh=S72MoXV31HEOEeoiYxnMp29sC4s1M3TFz4LShYrgRzU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gkwp4Yk1o00efeas2NGsKeoJXmgqgCH5PrNivtfc0C7Pi7giWB1z8KsCjrLK86FSN
         QbA4YsBG/0SXR48sZUuoDA4Gcx6c2egU9j+kPXHWyAfI6DidqxU4d2hCimGL178x0Q
         +9Da373vbFNj79aQKXgFjKGsmzoGtoq7+n0BiMlo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A01F601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V3 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible
 string for SDM845 SOC
To:     Doug Anderson <dianders@google.com>, Rob Herring <robh@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org>
 <1541073999-11752-2-git-send-email-vbadigan@codeaurora.org>
 <CAD=FV=V9AdCgOSonb0tu==DgKRKeZxto+aGwxmdbHAqrmfMrDQ@mail.gmail.com>
 <20181105203657.GA32282@bogus>
 <CAD=FV=VitZ4dyYGxinQ=nsrfM+U7duGbxeN3bdbRxfx-2AWxyQ@mail.gmail.com>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <ccbba1f3-0838-52ce-ce68-38f93ebbe584@codeaurora.org>
Date:   Tue, 6 Nov 2018 23:29:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VitZ4dyYGxinQ=nsrfM+U7duGbxeN3bdbRxfx-2AWxyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/2018 2:41 AM, Doug Anderson wrote:
> Hi,
>
> On Mon, Nov 5, 2018 at 12:37 PM Rob Herring <robh@kernel.org> wrote:
>> On Thu, Nov 01, 2018 at 01:29:54PM -0700, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Thu, Nov 1, 2018 at 5:07 AM Veerabhadrarao Badiganti
>>> <vbadigan@codeaurora.org> wrote:
>>>> For SDM845 SOC, new compatible string  "qcom,sdm845-sdhci" is added.
>>>>
>>>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>>>> ---
>>>>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>> index 502b3b8..f2ffbeb 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>> @@ -7,6 +7,7 @@ Required properties:
>>>>   - compatible: Should contain:
>>>>                  "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
>>>>                  "qcom,sdhci-msm-v5" for sdcc versions >= 5.0
>>>> +               "qcom,sdm845-sdhci" for sdm845 SOC
>>> It's up to Rob of course, but IMO it seems a nicer way forward to
>>> include both the SoC-specific string and the "version" string in all
>>> cases.  I'd write this for the full text:
>> Fine by me if you update all the dts files.
> Done and done.
>
> https://lkml.kernel.org/r/20181105210921.253707-1-dianders@chromium.org
> https://lkml.kernel.org/r/20181105210921.253707-2-dianders@chromium.org
>
>
>>>   - compatible: Should contain a SoC-specific string and a IP version string:
>>>        version strings:
>>>             "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
>>>             "qcom,sdhci-msm-v5" for sdcc version 5.0
>>>        full compatible strings with SoC and version:
>>>             "qcom,apq8084", "qcom,sdhci-msm-v4"
>>>             "qcom,msm8974", "qcom,sdhci-msm-v4"
>>>             "qcom,msm8916", "qcom,sdhci-msm-v4"
>>>             "qcom,msm8992", "qcom,sdhci-msm-v4"
>>>             "qcom,msm8996", "qcom,sdhci-msm-v4"
>> I assume you meant to append '-sdhci' here?
> Oops, yes!
>
>             "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
>             "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
>             "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
>             "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
>             "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"

Thank you. Will update the documentation.

> -Doug


