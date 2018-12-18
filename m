Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA534C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9C92184B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YIXqB/wj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YIXqB/wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeLRGal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:30:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52944 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRGal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:30:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DD4E46071C; Tue, 18 Dec 2018 06:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545114639;
        bh=bYUxVUM8Mr6S/oNgTM+rwe7IcpEfwkI1Vd4kJz969Ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YIXqB/wjTZzaH6dBRc4ZcbHYCMOXw8kZxqEgxPJuzNauuEGoO3H7UE2g5tRe+gFaR
         VXRxv80RVlujLqrIWqOO+9t3LG/JtkWGlLcnzYwl7CiKoQGGBfaw1zFUJ5s5yo5xOA
         mnG5B/klG8tmqeUqfbc3+wR0VUKzhxLK3KM4akvQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1D1E76055D;
        Tue, 18 Dec 2018 06:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545114639;
        bh=bYUxVUM8Mr6S/oNgTM+rwe7IcpEfwkI1Vd4kJz969Ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YIXqB/wjTZzaH6dBRc4ZcbHYCMOXw8kZxqEgxPJuzNauuEGoO3H7UE2g5tRe+gFaR
         VXRxv80RVlujLqrIWqOO+9t3LG/JtkWGlLcnzYwl7CiKoQGGBfaw1zFUJ5s5yo5xOA
         mnG5B/klG8tmqeUqfbc3+wR0VUKzhxLK3KM4akvQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Dec 2018 12:00:39 +0530
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
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: remoteproc: qcom: Add power-domain
 bindings for Q6V5
In-Reply-To: <CAD=FV=UVm=p4Vo7g5-9z0mEN2xD1JXHK-_1tj8WLvxzr04M0RQ@mail.gmail.com>
References: <20181217100724.4593-1-sibis@codeaurora.org>
 <20181217100724.4593-4-sibis@codeaurora.org>
 <CAD=FV=UVm=p4Vo7g5-9z0mEN2xD1JXHK-_1tj8WLvxzr04M0RQ@mail.gmail.com>
Message-ID: <cb9c827c036088736b983323d5c1cf19@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,
Thanks for the review :)

On 2018-12-18 05:31, Doug Anderson wrote:
> Hi,
> 
> On Mon, Dec 17, 2018 at 2:08 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> Add power-domain bindings for Q6V5 MSS on MSM8996 and SDM845 SoCs.
>> 
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> v2:
>>   * Add load_state power-domain
>>   * List cx and mx power-domains for MSM8996
>> 
>>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt | 16 
>> ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 98894e6ad456..50695cd86397 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -80,6 +80,22 @@ on the Qualcomm Hexagon core.
>>                     reference to the pll-supply regulator to be held 
>> on behalf
>>                     of the booting of the Hexagon core on MSM8996 SoCs
>> 
>> +- power-domains:
>> +       Usage: required
>> +       Value type: <phandle>
>> +       Definition: reference to the list of 2 power-domains for the 
>> modem
>> +                   sub-system on MSM8996 SoCs
> 
> This is truly required for msm8996 SoCs?  The code I'm looking at
> doesn't try to get these power domains for 8996 so presumably you're
> breaking backward compatibility with old device tree files by making
> this required now.  I don't personally know how widespread msm8996
> usage is w/ upstream, so I'd let Bjorn comment on whether he thinks
> this is OK.
> 

This is one of the reasons why the dt node
for mss on 8996 has not been posted/merged upstream.
Hence backward compatibility is not broken yet
in mainline :) .. However it will break on official
linaro integration releases (old dt + new kernel)

> As with the other patches in this series, I personally prefer less
> prose and more lists / tables of exactly what is required for which
> compatible string.
> 
> 
>> +                   reference to the list of 4 power-domains for the 
>> modem
>> +                   sub-system on SDM845 SoCs
>> +
>> +- power-domain-names:
>> +       Usage: required
>> +       Value type: <stringlist>
>> +       Definition: must be "cx", "mx" for the modem sub-system on 
>> MSM8996
>> +                   SoCs
>> +                   must be "cx", "mx", "mss", "load_state" for the 
>> modem
>> +                   sub-system on SDM845 SoCs
> 
> I haven't see a patch for using "load_state".  Can you point at it?  I
> guess this was "aop" in your last version?
> 

using load_state was Bjorn's suggestion and seemed
more appropriate than aop

> 
> -Doug

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
