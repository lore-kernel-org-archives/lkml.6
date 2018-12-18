Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD742C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96590214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WZlrHpt8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DlOkQzWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeLRGun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:50:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60670 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeLRGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:50:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2946E601C3; Tue, 18 Dec 2018 06:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545115842;
        bh=H0DaZ3BE67kziDVoq5JA1Dy8n7BbXWVnTKzqbDCIEEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WZlrHpt8yI4Srlgay/lL1UiTkIoFrTXuS21E0EfxEz7AFTlgYqnQ01JAOq4oWYrSF
         /7E7uNsT91kb1xhhCEoTgLkNQX8IVywu0BifdJUKZs6hLQf0XFi2/2YzmyRh5rtfoR
         7jY0D59uVK5uz4W14FKf4QpoVL9qWimi2j4Ti224=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4F8DA601C3;
        Tue, 18 Dec 2018 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545115841;
        bh=H0DaZ3BE67kziDVoq5JA1Dy8n7BbXWVnTKzqbDCIEEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DlOkQzWZ1LDj58GrYV6fA82WsvFG2EiMq2enY3J4mL8husqEF+vuyFBTz3Fe3avOA
         KMbIWbgAWBrs+d0vgDdzMuMT/sk/BFyS0Sw87vKmmWl2dg3FUiRep1tb5XSuf3z9es
         fQqN0JD/rlkp53KH8YSHvIft2YFtHGWyQqZpeiyM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Dec 2018 12:20:41 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: remoteproc: qcom: Fixup regulator
 dependencies
In-Reply-To: <CAD=FV=XNZ5CzKXHogKEGTHgPVg_nbXxVEJR0e9F9usEY3YKEiQ@mail.gmail.com>
References: <20181217100724.4593-1-sibis@codeaurora.org>
 <20181217100724.4593-3-sibis@codeaurora.org>
 <CAD=FV=XNZ5CzKXHogKEGTHgPVg_nbXxVEJR0e9F9usEY3YKEiQ@mail.gmail.com>
Message-ID: <13e6d8d6bb46dfc31b5bca927b71223f@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,
Thanks for the review :)

On 2018-12-18 05:30, Doug Anderson wrote:
> Hi,
> 
> On Mon, Dec 17, 2018 at 2:08 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> Fixup regulator supply dependencies for Q6V5 MSS on MSM996 SoCs.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 780adc043b37..98894e6ad456 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -76,7 +76,9 @@ on the Qualcomm Hexagon core.
>>         Usage: required
>>         Value type: <phandle>
>>         Definition: reference to the regulators to be held on behalf 
>> of the
>> -                   booting of the Hexagon core
>> +                   booting of the Hexagon core on MSM8916 SoCs
>> +                   reference to the pll-supply regulator to be held 
>> on behalf
>> +                   of the booting of the Hexagon core on MSM8996 SoCs
> 
> The prose gets in the way and doesn't add anything.  I also don't
> understand what you're saying for msm8996.  You're saying that
> "pll-supply" is required there but none of the others?  That doesn't
> seem to be true in the code I have in front of me, but maybe I'm
> missing some patch.  For me, I'd write:
> 

AFAIK, only the exceptions are captured. But your
suggestion seems more simple/complete. Perhaps I'll
replace SoCs instead of compatibles? Anyway
I'll wait for Bjorn/Rob's preference.

> For the compatible strings below the following supplies are required:
>   "qcom,q6v5-pil"
>   "qcom,msm8916-mss-pil",
>   "qcom,msm8974-mss-pil"
> - cx-supply:
> - mss-supply:
> - mx-supply:
> - pll-supply:
> Usage: required
> Value type: <phandle>
> Definition: reference to the regulators to be held on behalf of the
>     booting of the Hexagon core
> 
> 
> ...and if msm8996 actually needs "pll-supply", you could add in...
> 
> For the compatible strings below the following supplies are required:
>   "qcom,msm8996-mss-pil"
> - pll-supply:
> Usage: required
> Value type: <phandle>
> Definition: reference to the regulators to be held on behalf of the
>     booting of the Hexagon core

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
