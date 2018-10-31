Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB9CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A09A20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nfwEarNh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qh+YyDNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A09A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbeJaOzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:55:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJaOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:55:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9DB42605A2; Wed, 31 Oct 2018 05:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540965512;
        bh=9MnElDSYSY0yEQgIH0BvYY30V27yJAHOHsBiRLpqttU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nfwEarNhZ4h6hU37/FLAVpKOZzgq130G+0GlzqXBDjE4yqr42+vDojKJHxnfIXbJY
         Ti0hw6niv4MrPpxrmMZPTf5uvODnHiM+uuAP6kIKBB1pRufjrtTiRFj7sshG5v+PtJ
         28nKr/LmSPFDeMT4V6jpheJUY7rgjd1kiSagYPQM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D4E9D60112;
        Wed, 31 Oct 2018 05:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540965511;
        bh=9MnElDSYSY0yEQgIH0BvYY30V27yJAHOHsBiRLpqttU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qh+YyDNuDi5W3vh9xava3TOhGhRWtLNmzURA6SlBSD0wjY6B5Le+JZd+6HA5mx1qO
         6K9l0G7mj0c+uLvqYyXZyblTeUkp20zCwPIlsoIIa+wTHcmmkFZo4T3gE7Me8eZAG1
         Z09QkYxh42xehg3/annFYU59igDEZ+0o2Ma0Fl3E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 Oct 2018 11:28:31 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>, benchan@chromium.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add reserve-memory nodes
In-Reply-To: <CAD=FV=Xf7NXTV_OtBePn9QUQbzdkMxdYg-yRua_6SbV-av3P+g@mail.gmail.com>
References: <20181026122745.5094-1-sibis@codeaurora.org>
 <CAD=FV=Xf7NXTV_OtBePn9QUQbzdkMxdYg-yRua_6SbV-av3P+g@mail.gmail.com>
Message-ID: <d2648e22591576fd01b311feca99112f@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,
Thanks for the review!

I noticed both the quirks just after sending it out :(, will fix them.


On 2018-10-30 00:07, Doug Anderson wrote:
> Hi,
> 
> On Fri, Oct 26, 2018 at 5:28 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> Add reserve-memory nodes for mpss and mba required for
>> remoteproc mss pil.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi 
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index d3fe012ad84e..f74892e447f9 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -88,6 +88,16 @@
>>                         reg = <0 0x86200000 0 0x2d00000>;
>>                         no-map;
>>                 };
>> +
>> +               mpss_region: reserved-memory@8e000000 {
>> +                       no-map;
>> +                       reg = <0 0x8e000000 0 0x7800000>;
>> +               };
>> +
>> +               mba_region: reserved-memory@96500000 {
> 
> nit: All of the other reserved memory in this same section just has
> the node name "memory".  Can you please follow suit?  Also above.
> This is the kind of thing that Rob H. usually cares about doing right.
> 
>> +                       no-map;
>> +                       reg = <0 0x96500000 0 0x200000>;
> 
> nit: All of the other reserved memory in this same section has "reg"
> above "no-map".  It doesn't matter a whole lot, but why not make it
> match everyone else?  Also above.
> 
> 
> -Doug

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
