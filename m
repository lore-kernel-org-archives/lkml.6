Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9183C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538B621480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mr3XcRaL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GDzI7DwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538B621480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeIZLm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 07:42:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIZLm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 07:42:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 535F260B0D; Wed, 26 Sep 2018 05:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537939907;
        bh=k8iyioS1Wtwz/B6pA1wv59ia6NcnP9QwyHlgd7Un9GQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mr3XcRaL15VPMJ20BWTVLURTVNAnTqYH5d7+EvOI0vYZo6xdcJawUIsC2mPvcBamA
         z/SUdK3w/ME1V6XRNC/zPmFkIbWymmeRF46/MSA8qxdugIEfSFqvKIUk2tibxYDFbw
         c5qfwpYY84IUM5odHUpnjvw550XejDBd3MpyBavU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 574A960275;
        Wed, 26 Sep 2018 05:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537939906;
        bh=k8iyioS1Wtwz/B6pA1wv59ia6NcnP9QwyHlgd7Un9GQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GDzI7DwMIu2Chmh4xUd7soXLOpqopCT6R6JzbWNnUBMWweCnzq5fK/JT7n6Hr3DWi
         cSAm9WowfeAhPbv4VfSuwsP4lcBqJ2rnkdOHfO7tzBKbJCTuyhyPZ3gd9ANeb6yDxQ
         tYXF4zjFafuQfMPAuZaW11WLtlvnDVYAgFN1wxOs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Sep 2018 11:01:46 +0530
From:   kgunda@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V4 3/8] backlight: qcom-wled: Add new properties for
 PMI8998
In-Reply-To: <20180903185510.GB3153@tuxbook-pro>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-4-git-send-email-kgunda@codeaurora.org>
 <20180807052355.GA23866@tuxbook-pro>
 <897ab82c450bff71658c1fa32e7e6021@codeaurora.org>
 <20180903185510.GB3153@tuxbook-pro>
Message-ID: <0e127bf34934236d0147bd23a0b400a9@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-04 00:25, Bjorn Andersson wrote:
> On Wed 15 Aug 22:23 PDT 2018, kgunda@codeaurora.org wrote:
> 
>> On 2018-08-07 10:53, Bjorn Andersson wrote:
>> > On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:
>> > > diff --git
>> > > a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> > > b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> > [..]
>> > >  - qcom,num-strings
>> > >  	Usage:        optional
>> > >  	Value type:   <u32>
>> > >  	Definition:   #; number of led strings attached;
>> > > -		      value from 1 to 3. default: 2
>> > > -		      This property is supported only for PM8941.
>> > > +		      value: For PM8941 from 1 to 3.
>> > > +			     For PMI8998 from 1 to 4.
>> > [..]
>> > > +- qcom,enabled-strings
>> > > +	Usage:        optional
>> > > +	Value tyoe:   <u32 array>
>> > > +	Definition:   Array of the WLED strings numbered from 0 to 3. Each
>> > > +		      string of leds are operated individually. Specify the
>> > > +		      list of strings used by the device. Any combination of
>> > > +		      led strings can be used.
>> > [..]
>> > >
>> > >  Example:
>> > >
>> > > @@ -99,4 +146,5 @@ pm8941-wled@d800 {
>> > >  	qcom,switching-freq = <1600>;
>> > >  	qcom,ovp = <29>;
>> > >  	qcom,num-strings = <2>;
>> > > +	qcom,enabled-strings = <0x00 0x01>;
>> >
>> > Nit. I would assume that specifying qcom,num-strings = <2> implies that
>> > the first 2 strings are used, so one would not also specify
>> > qcom,enabled-strings.
>> >
>> Thanks Bjorn for reviewing the series !
>> 
>> "qcom,enabled-strings" need be specified along with the 
>> "qcom,num-strings".
>> Because the enabled-strings can be <0, 2> or <0, 3 > also. The driver 
>> picks
>> the string
>> configuration from the enabled-strings array and enable only those
>> current-sinks.
>> 
> 
> The original binding described qcom,num-strings to mean "the first N
> strings", requiring qcom,enabled-strings now would break backwards
> compatibility with this binding.
> 
> In the case that qcom,enabled-strings is specified we can easily derive
> num-strings from the listed entires. So I would suggest that you look
> for enabled-strings and if not found fall back to checking for
> num-strings.
> 
> Regards,
> Bjorn

Sorry for the late reply. Actually the "qcom,enabled-strings" is 
initialized with
the strings 0, 1, 2, 3 in the driver. Even though this property is 
missing the first
N strings will be still configured with out any issue, based on the 
"qcom,num-strings".

