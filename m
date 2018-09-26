Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B108C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FD82152B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oTi5xGum";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ez+ddkIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FD82152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeIZWCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:02:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeIZWC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:02:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0E686607F4; Wed, 26 Sep 2018 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537976934;
        bh=XCB+hcsaN3LhqKB5Z+qk53eKE36nHH6SfYyUF0xZHWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oTi5xGumd7smOI6pzApvSbR/ujLDtYNydntvADdpIQO/v1o68gInGlfYICsP+VA0s
         yvVsPn7sPx2mut8eyxZVnBOv0322Xb+gEDwNxym/sH6IA5uzbU60fvAQAi3bg71YYL
         iaJCJCwiXY7k4zd9+bFAv4Ocp6dQh+GTy0rbb8jc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 63968607F4;
        Wed, 26 Sep 2018 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537976933;
        bh=XCB+hcsaN3LhqKB5Z+qk53eKE36nHH6SfYyUF0xZHWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ez+ddkIVneZ7eYPyVUWNaBnYmHWiq3MAiCd5O47CUCgxLz46wilMexi83/HAuwIgO
         Mqhs/YcZz8HlYRvharNdWIyX8UiuQVVpzywOReAeogsPASQygPlI3VMopwxLzo/2gy
         9NDAzb6QgYJc44weUGJMkJgkWpFtMO1EPxw4DWz4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Sep 2018 21:18:53 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: pas: Add QCS404 remoteprocs
In-Reply-To: <20180925233550.GB27436@tuxbook-pro>
References: <20180920172237.30965-1-bjorn.andersson@linaro.org>
 <f0887494a9957496399046bac9b1fa32@codeaurora.org>
 <20180925233550.GB27436@tuxbook-pro>
Message-ID: <78799383c083420b8109455c463fc730@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-26 05:05, Bjorn Andersson wrote:
> On Tue 25 Sep 03:18 PDT 2018, Sibi Sankar wrote:
>> On 2018-09-20 22:52, Bjorn Andersson wrote:
>> > diff --git a/drivers/remoteproc/qcom_adsp_pil.c
>> > b/drivers/remoteproc/qcom_adsp_pil.c
>> > index da2254ea1135..fcbb816a9698 100644
>> > --- a/drivers/remoteproc/qcom_adsp_pil.c
>> > +++ b/drivers/remoteproc/qcom_adsp_pil.c
>> > @@ -362,10 +362,22 @@ static const struct adsp_data slpi_resource_init =
>> > {
>> >  		.ssctl_id = 0x16,
>> >  };
>> >
>> > +static const struct adsp_data wcss_resource_init = {
>> > +	.crash_reason_smem = 421,
>> > +	.firmware_name = "wcnss.mdt",
>> > +	.pas_id = 6,
>> > +	.ssr_name = "mpss",
>> > +	.sysmon_name = "wlan",
>> 
>> Shouldn't the sysmon name be "wcnss" instead of "wlan"?
>> 
> 
> I derived this from the downstream kernel, perhaps I got it wrong?
> 

I could see that the label is "wcnss" and glink-label is "mpss" 
downstream.

> Regards,
> Bjorn

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
