Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F275C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432402172A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nrvY1lpT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gOUl3mc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432402172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389902AbeHGVrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:47:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389589AbeHGVrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:47:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0D3EF60B74; Tue,  7 Aug 2018 19:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533670308;
        bh=H0FXJFGcH185yY8sxgr3OWF6fOlWR7Fy8HvkZSkTPMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nrvY1lpT8x9p2sXkeS3RX1AqB4FIAouR1x7JTvUBOhVGOk0XN7LqOfVxT4pCAitvY
         i/tI305la0oc/RS+cov7lw4YgKPx1kMh5tgsvF+JZOIztaLbr1YCHSrHDfxBlNtxaG
         RFuvo0KKTloxpVriltZ6jAdsKWLT+WrcTOWD3/iI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2544560B13;
        Tue,  7 Aug 2018 19:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533670307;
        bh=H0FXJFGcH185yY8sxgr3OWF6fOlWR7Fy8HvkZSkTPMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gOUl3mc13eHL4C+UBKw0+t6KJxNxMxgc0QEHf66ru7rdyiT9he6GkxtgTVxiOkW7m
         kP6Yaa8JbQrYY32+/4EdZvZH6LYKFU05jwug5uAAHMLF4DeS5PsuVE43Xr/cEEjoW3
         RlV24SdZzITl7H5Yclew750QoCmcGVxrnLySV/qo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Aug 2018 12:31:47 -0700
From:   skannan@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for interconnect
 bandwidth voting
In-Reply-To: <20180807165103.GA23354@rob-hp-laptop>
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
 <20180807165103.GA23354@rob-hp-laptop>
Message-ID: <d674c9d0d71b3480186de665b2cea356@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-07 09:51, Rob Herring wrote:
> On Wed, Aug 01, 2018 at 05:57:42PM -0700, Saravana Kannan wrote:
>> This driver registers itself as a devfreq device that allows devfreq
>> governors to make bandwidth votes for an interconnect path. This 
>> allows
>> applying various policies for different interconnect paths using 
>> devfreq
>> governors.
>> 
>> Example uses:
>> * Use the devfreq performance governor to set the CPU to DDR 
>> interconnect
>>   path for maximum performance.
>> * Use the devfreq performance governor to set the GPU to DDR 
>> interconnect
>>   path for maximum performance.
>> * Use the CPU frequency to device frequency mapping governor to scale 
>> the
>>   DDR frequency based on the needs of the CPUs' current frequency.
>> 
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/devfreq/icbw.txt |  21 ++++
> 
> Please make bindings separate a patch.

Yeah, I was aware of that. I just wanted to give some context in the v1 
of this patch (I wasn't expecting this to merge as is).

>>  drivers/devfreq/Kconfig                            |  13 +++
>>  drivers/devfreq/Makefile                           |   1 +
>>  drivers/devfreq/devfreq_icbw.c                     | 116 
>> +++++++++++++++++++++
>>  4 files changed, 151 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt
>>  create mode 100644 drivers/devfreq/devfreq_icbw.c
>> 
>> diff --git a/Documentation/devicetree/bindings/devfreq/icbw.txt 
>> b/Documentation/devicetree/bindings/devfreq/icbw.txt
>> new file mode 100644
>> index 0000000..36cf045
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/icbw.txt
>> @@ -0,0 +1,21 @@
>> +Interconnect bandwidth device
>> +
>> +icbw is a device that represents an interconnect path that connects 
>> two
>> +devices. This device is typically used to vote for BW requirements 
>> between
>> +two devices. Eg: CPU to DDR, GPU to DDR, etc
> 
> I'm pretty sure this doesn't represent a h/w device. This usage doesn't
> encourage me to accept the interconnects binding either.

Hasn't the DT rules moved past "only HW devices" in DT? Logical devices 
are still allowed in Linux DT bindings?

Having said that, this is explicitly representing a real HW path and the 
ability to control its performance.

>> +
>> +Required properties:
>> +- compatible:		Must be "devfreq-icbw"
>> +- interconnects:	Pairs of phandles and interconnect provider 
>> specifier
>> +			to denote the edge source and destination ports of
>> +			the interconnect path. See also:
>> +		Documentation/devicetree/bindings/interconnect/interconnect.txt
>> +- interconnect-names:	Must have one entry with the name "path".
> 
> That's pretty useless...

True. But the current DT binding for interconnect consumer bindings 
needs a interconnect name to use the of_* API. I'm open to switching to 
an index based API if one is provided.

>> +
>> +Example:
>> +
>> +	qcom,cpubw {
> 
> Someone in QCom please broadcast to stop using qcom,foo for node names.
> It is amazing how consistent you all are. If only folks were as
> consistent in reading
> Documentation/devicetree/bindings/submitting-patches.txt.

Sorry :(

Thanks,
Saravana
