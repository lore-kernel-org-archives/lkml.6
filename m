Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC07C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490CA208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMgdXHSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490CA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbeHAKl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:41:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50308 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeHAKl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:41:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so6079209wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3aV3Vj0gZjmjeW6ZNcwf2EDhfaMM3/G2dZeV5z+0Z4s=;
        b=aMgdXHSZUUsolk8dPRRgYqzdgoLvTo5jgrjsoRxwHa364jV+okA9REktdMFctMaHpE
         KF6fCiIza0WtBcE7yyD+phDMvnagxG2savB1bQ1v9ZkNAXkTlt/4dsFV5lPMbVIbi9BH
         CQqV9z1kA8nQOeZHr3wioZ/2RtZBfflj8eYvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3aV3Vj0gZjmjeW6ZNcwf2EDhfaMM3/G2dZeV5z+0Z4s=;
        b=KEifz1lqfiu1EO6A41EqL2c44bDEq2uGwJZeSfvnf2io8748ojEO0W4OliJ3uVlDb/
         SuG73qbvKTChp3Zj8EXkVuvowQ5HHo9mm6RvGKV7sS23HcTrsyhOTpENtPkHQyrW/Akf
         k/PBaKemH1TeF2+hP4ELEc77XWp22m2tgOuG76tvoflY6qTIyHYPbWYQ7r0LCLTh4twz
         dFIPC4BjmMMEgiisA8RHculTFwgK+hCs4Aa3pa9/uahO3Cm8e4ijrH3kZpc4qF8JO1vg
         efjBgjXGra8kHAfSoeaJfSnMzd3EMOEFRIlL/dWTRwWDwF3t5b50MpJQJg1Suvz8LgxC
         HErw==
X-Gm-Message-State: AOUpUlH6ijzvz0aNjNKRIKqSG4EIDOvjoX+SO/wqrlDx7AYZjLVyKSlN
        Oe1iEmXF5Whbh2jacIkEYnKP3A==
X-Google-Smtp-Source: AAOMgpc7Zeja3x7QXBDyrC52ik7TUh3EJqv8Yrr9oPgRAKR0FGYZR/fhs1CNBh3vJjQ5O4CmL6a8RA==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr2192160wmd.77.1533113834475;
        Wed, 01 Aug 2018 01:57:14 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id c129-v6sm8290362wmh.2.2018.08.01.01.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:57:13 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] ASoC: wcd9335: add basic controls
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-7-srinivas.kandagatla@linaro.org>
 <20180731171654.GL5719@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bbee4cb6-286d-c774-9b44-267d0af25af3@linaro.org>
Date:   Wed, 1 Aug 2018 09:57:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180731171654.GL5719@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On 31/07/18 18:16, Mark Brown wrote:
> On Fri, Jul 27, 2018 at 01:18:02PM +0100, Srinivas Kandagatla wrote:
> 
>> +static const char * const wcd9335_ear_pa_gain_text[] = {
>> +	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB",
>> +	"G_0_DB", "G_M2P5_DB", "UNDEFINED", "G_M12_DB"
>> +};
> 
> This is fairly clearly a volume control so shouldn't be an enum.  I
> don't think we have a standard control that enables you to skip values
> in a regular volume control (we do for enums which you should've used
> rather than having the undefined entry) so you'd have to have custom get
> and put operators but that's better than abusing an enum.
I agree, this can be a TLV, I will fix any such instances in next version.
> 
>> +static const char * const rx_hph_mode_mux_text[] = {
>> +	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI"
>> +};
> 
> Use a SOC_VALUE_ENUM to hide the invalid option from users.
Yep.
> 
>> +	wcd->comp_enabled[comp] = value;
>> +	sel = value ? WCD9335_HPH_GAIN_SRC_SEL_COMPANDER :
>> +		WCD9335_HPH_GAIN_SRC_SEL_REGISTER;
> 
> Just write normal if statements unless there's a reason not to, it's
> easier to read.
Will do that in next version.

thanks,
srini
> 
