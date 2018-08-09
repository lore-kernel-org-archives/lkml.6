Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5A0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CB1217D2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uX0QfZOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CB1217D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbeHIOsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:48:01 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36160 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:48:01 -0400
Received: by mail-qk0-f194.google.com with SMTP id x192-v6so3851988qkb.3;
        Thu, 09 Aug 2018 05:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JWa2dmS+u0K35wwBg6g2CQcYIp9EMbqB5NsXVRU3VZo=;
        b=uX0QfZOlqRmRrohnt1I8o6Ce8QFANtMOOEhxWWTPXkLITcVqHTm9WD/P17kQ5YFclP
         R0ZIG6+pT+ml+J+kIgel5NT9It7NxYhQTyzfLXweY1CVBKQ5UOpMkv72rlqp1Cf2f95d
         JmpjEcYcTK+Am6XWpGMU0H1HV5f2ZTSRuIEDlHipUD7TnqUkiRNSauNsw8p7rSNsjASX
         Y/tp5IyOQtpPXMJxDQBF1GMZxnwh5H/2/MG0mHFjVMZ7lrkZoAdnGAeymtGGCxUR0FZw
         00zFGT4g/RV9Hyd6lEm+B+TPj/7hPuSYbLzW60nyPKTeK3Yb3eZqGcySVEfrztentgW8
         E1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JWa2dmS+u0K35wwBg6g2CQcYIp9EMbqB5NsXVRU3VZo=;
        b=qH+M45iM/PWVyOE7aXJ3Jo/nQjvHFarNlvNSoD6y9hBbwTmUiHCDwPqaRUD28+9H2q
         BzFGgHU39BXHOVg4mZYg9rJwOh43TglxaNdl6ua5m+xF3VMXPVayMgXhAOz0rGOYnrlb
         TbO3SUZvivSL8IQyzOjiT/du8C7MJQi0u0r7Rm0fBUh1ozjRIaF8pGrXMEMujpL3BsS7
         k46fEpNpB2+tJzKr3arujybnFKo/nxmcHn2C5kVkbmSP0iesG1sFAhDiL5acJ+qOtte6
         uj5BJYxydgR74a4RmrjqSHHOq93SPYUxPXOkHe4q57/Op4H+GeB/mXolT+8cnRUzR7Op
         qM4g==
X-Gm-Message-State: AOUpUlG3owkC8a/gvzZ/TzaEaxcYoJRP8Ty6MV2YIb3gF2TsNeEqUmVb
        CGI7cy8GRAXGplcQoGT+AW9RPpgrbn4=
X-Google-Smtp-Source: AA+uWPw+NU+LD8VPSOOj/0hUSnDbtglKDTNcKDpTha9AlqxisW7R50oxef32Wc6U+zWrSGTVbUEPjA==
X-Received: by 2002:ae9:e812:: with SMTP id a18-v6mr1619796qkg.57.1533817401276;
        Thu, 09 Aug 2018 05:23:21 -0700 (PDT)
Received: from [192.168.44.96] (107.sub-174-204-8.myvzw.com. [174.204.8.107])
        by smtp.gmail.com with ESMTPSA id u21-v6sm3581102qka.88.2018.08.09.05.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 05:23:20 -0700 (PDT)
Subject: Re: [PATCH 5/8] arm64: dts: tegra186: Add SDMMC4 DQS trim value
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-6-git-send-email-avienamo@nvidia.com>
 <20180809114922.GN21639@ulmo> <20180809150226.64657f56@dhcp-10-21-25-168>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <03fc6726-25ff-20de-d271-ebae19b753c7@gmail.com>
Date:   Thu, 9 Aug 2018 08:23:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809150226.64657f56@dhcp-10-21-25-168>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2018 08:02 AM, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 13:49:22 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
> 
>> On Tue, Aug 07, 2018 at 05:00:01PM +0300, Aapo Vienamo wrote:
>>> Add the HS400 DQS trim value for Tegra186 SDMMC4.
>>>
>>> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
>>> ---
>>>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> index 6e9ef26..9e07bc6 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> @@ -313,6 +313,7 @@
>>>   		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
>>>   		nvidia,default-tap = <0x5>;
>>>   		nvidia,default-trim = <0x9>;
>>> +		nvidia,dqs-trim = <63>;
>>>   		status = "disabled";
>>>   	};
>>>     
>>
>> Isn't this technically dependent on the board layout and as such would
>> belong in the board DTS file? Or does this value work on all existing
>> Tegra186 platforms?
> 
> This value is specified as part of the controller initialization
> sequence in the TRM. I've understood that this (and other tap and trim)
> value(s) are used for compensating the propagation delay differences
> that are caused by the internal SoC layout.
> 
>   -Aapo
> --

The Tegra2 and Tegra3 TRMs also specify recommended DQS values, and I am 
working on at least one device that differs in the platform data from 
the default value.
I see that you mentioned this is for the newer devices that support 
HS200/HS400 modes, but does it enable setting DQS on older devices?
