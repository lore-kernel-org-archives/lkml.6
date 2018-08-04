Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A32C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 19:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73B1217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 19:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPcW1anF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73B1217CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeHDVJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 17:09:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43405 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeHDVJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 17:09:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so4890097pfi.10;
        Sat, 04 Aug 2018 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HGFlGIQ27fpA2spvGIAR+lEFdhnPZONYQYztn5dLMjY=;
        b=GPcW1anFqktajN10iLUnMCO6dD26mCNLp5KWo6zla9VDO95PTPMMyPM8qwvU38PHLh
         QtxZfcsXP+Wgnw7upN2dVyRWI+AR7pbySsv5OoBudDTgDORd7otg7n96N1GOnUUemH6p
         C0MzZdKvnVUPMnXn2hmD1fGfOBDqq9jcqYIbGcee0FOJbcwt0l//9DO3EQvnZeEETDwi
         sGavm4TV2Lsn8lElILOH3MFirVjn4HciZKlFJN9YYI7OpQ5OfnC3UIPOyDsFwfOG5ynW
         hgl+wqdhYXD/Ma7Oqghrh9jTc1uJJgMzwDjj+E1aIQ8Ra2nwbX5qA5Kxr0lFHH6oxonO
         Q18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HGFlGIQ27fpA2spvGIAR+lEFdhnPZONYQYztn5dLMjY=;
        b=L1uN7+2g5PJLU3u1Y2w6kOHUUS1H/YnuFPhnWoV/WPItSDgmgRvDExCGq3pNFldSDo
         Pxzq0FJP8yke/WtZ5FBG9pDFOk/bY3GETDTdK3y5VPPRgh6bfj2Omxis5nLQbaK+TbPv
         XQp2crDrfD+d6uq6JdpDvAx7ghIve2MGlPIapruE6543PnRnRYbbQtkteMJIBkrT235f
         Mj1Bt6kF3f4JTF44tLepJ/9sugkLcYJXRZqTOXo6tejblgnA5/wHS7pIgC4T6uyr2vRf
         ZeHfVH4PN3LA95b05asq+/qHlj1vFK6yeMhWzHTqnekw6TXDoNB9Alf7c6G2FIjMaEyH
         SymQ==
X-Gm-Message-State: AOUpUlEtP4RUr5gKt0P/xEhMtVZCxrCR1ERI44UeVnH9iMjJR2JglNe7
        6YomHeR89KmQMrrSiOratCl81WKH
X-Google-Smtp-Source: AAOMgpd/75XDhj1UfSSME8golBHA/hu+52gOQ1TyTy0d1xQd8biJbeT4niEx4O6Uuw7pzY5spy7Hig==
X-Received: by 2002:a62:54c7:: with SMTP id i190-v6mr141860pfb.155.1533409699294;
        Sat, 04 Aug 2018 12:08:19 -0700 (PDT)
Received: from [192.168.1.54] (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id u71-v6sm16676280pfk.174.2018.08.04.12.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 12:08:18 -0700 (PDT)
Subject: Re: [PATCH v3 02/14] gpu: ipu-csi: Check for field type alternate
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        "open list:DRM DRIVERS FOR FREESCALE IMX" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
 <1533150747-30677-3-git-send-email-steve_longerbeam@mentor.com>
 <1533202966.3516.9.camel@pengutronix.de>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <46828b08-4866-6204-a0fe-0a8294450ad4@gmail.com>
Date:   Sat, 4 Aug 2018 12:08:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533202966.3516.9.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,


On 08/02/2018 02:42 AM, Philipp Zabel wrote:
> Hi Steve,
>
> On Wed, 2018-08-01 at 12:12 -0700, Steve Longerbeam wrote:
>> When the CSI is receiving from a bt.656 bus, include a check for
>> field type 'alternate' when determining whether to set CSI clock
>> mode to CCIR656_INTERLACED or CCIR656_PROGRESSIVE.
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>> ---
>>   drivers/gpu/ipu-v3/ipu-csi.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/ipu-v3/ipu-csi.c b/drivers/gpu/ipu-v3/ipu-csi.c
>> index caa05b0..5450a2d 100644
>> --- a/drivers/gpu/ipu-v3/ipu-csi.c
>> +++ b/drivers/gpu/ipu-v3/ipu-csi.c
>> @@ -339,7 +339,8 @@ static void fill_csi_bus_cfg(struct ipu_csi_bus_config *csicfg,
>>   		break;
>>   	case V4L2_MBUS_BT656:
>>   		csicfg->ext_vsync = 0;
>> -		if (V4L2_FIELD_HAS_BOTH(mbus_fmt->field))
>> +		if (V4L2_FIELD_HAS_BOTH(mbus_fmt->field) ||
>> +		    mbus_fmt->field == V4L2_FIELD_ALTERNATE)
>>   			csicfg->clk_mode = IPU_CSI_CLK_MODE_CCIR656_INTERLACED;
>>   		else
>>   			csicfg->clk_mode = IPU_CSI_CLK_MODE_CCIR656_PROGRESSIVE;
> this patch is already merged in v4.18-rc7.

Ah, I just noticed that after a fetch from kernel.org, thanks.

Steve


