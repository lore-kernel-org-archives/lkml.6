Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0C9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274B22086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG6U1TPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274B22086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbeKPClY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:41:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40431 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeKPClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:41:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so16664629edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 08:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FkHgB5Zcm+nUOZIm7/o1FKY37BlZwi1rM9C5EhqCDZc=;
        b=SG6U1TPlj9KrZJMKr3UtI+ENWOtjgWv7HY34rwoxkV6ueEPmMr3Q4q1Xb/Un8ecrKR
         KPWzowp1XEXBtsloYE+67HqmIAW6xaCffZBCQWXz3AlU6Yr284SQsY3Jz/i1xYd9Hp6m
         vbSXSiP+BRf9ug+be1RCXE7iatbyWTvM+jN8uO7mTSbXrWL1Q+Zak3d7RCzuCJ00fEQp
         YYz+FbaV1oFMc4+KG9k9XQRJND4iucTGqdXuccb9vBewPohlAJF2Kkor6vNIABainlVH
         6ou4oHwU4LNNIfF4zbaxcPOnfxjSggoUFv7YXOHSaeI5Crh95aAhORNgtZwaUwWzjzUZ
         M8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FkHgB5Zcm+nUOZIm7/o1FKY37BlZwi1rM9C5EhqCDZc=;
        b=m2P+NuvTr0GN+20meEZNG30YvW41GzRyKLWWc5cIHTTsgpE6Kd3yEo/L9T47ZD5Yfd
         K89JfQ9uwNLZSVSb3H8ClAvEgl7JDt7E8zVs2drb1nbsshswvJPEaNg19vLSu0y1BIp8
         fo6iRbh6hm3ng8y+ka93Fy4ZbhoZhes3jIp8JyegEkajOxOiOfBTEBlgt6MiTTRAfyu7
         rfYH0cW5BCwTRfpcWo2MFEfsGp4FQ0NJ5ZgvvaUNsf9bweeqWRLn442ANOHsICSdqanU
         aUBg04KYANLi7qLprWcSQqgkK0D1IixxDa4gNaNfgsrq60dlW5Pjqieo8UknRRIRXovW
         95CQ==
X-Gm-Message-State: AGRZ1gI/ujSYdwSinVpqWRsy+3B7nyvXWetBC2CcjeJgHlTdX/SFAunq
        Gp+pM4eHvtWglAfeY4gY9vSW36fs
X-Google-Smtp-Source: AJdET5corVq5F+EHy9orE1VoZGiIiNwx9g0AlEN7MrAE6PzCvm0FyPwe43sY4MrQbhIvpPlVqLOD9A==
X-Received: by 2002:a17:906:be2:: with SMTP id z2-v6mr5936239ejg.170.1542299570982;
        Thu, 15 Nov 2018 08:32:50 -0800 (PST)
Received: from ziggy.stardust ([37.223.147.230])
        by smtp.gmail.com with ESMTPSA id b46sm3647016edc.57.2018.11.15.08.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 08:32:50 -0800 (PST)
Subject: Re: [PATCH v3 5/9] arm64: defconfig: Replace PINCTRL_MT7622 with
 PINCTRL_MTK_MOORE
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>, arm-soc <arm@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <cb016b53-906a-adec-d8c6-019d2c74569b@free.fr>
 <f4cd05f5-3b97-6167-ef42-5b4af41681c0@gmail.com>
 <a098095c-fda2-92f2-73ec-0da3b4464f3c@free.fr>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <6e6486fd-393f-afeb-6953-f343265b9bc5@gmail.com>
Date:   Thu, 15 Nov 2018 17:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a098095c-fda2-92f2-73ec-0da3b4464f3c@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2018 20:59, Marc Gonzalez wrote:
> On 09/11/2018 14:03, Matthias Brugger wrote:
> 
>> On 09/11/2018 02:03, Marc Gonzalez wrote:
>>
>>> Commit e78d57b2f87c ("pinctrl: mediatek: add pinctrl-moore that
>>> implements the generic pinctrl dt-bindings") made PINCTRL_MT7622
>>> depend on PINCTRL_MTK_MOORE.
>>>
>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>> ---
>>>  arch/arm64/configs/defconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 6fe418d72337..725b9471b21c 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -369,7 +369,7 @@ CONFIG_PINCTRL_MSM8994=y
>>>  CONFIG_PINCTRL_MSM8996=y
>>>  CONFIG_PINCTRL_QDF2XXX=y
>>>  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
>>> -CONFIG_PINCTRL_MT7622=y
>>> +CONFIG_PINCTRL_MTK_MOORE=y
>>
>> This would disable pinctrl for mt7622, I don't think that is what we want.
> 
> I don't think so, because PINCTRL_MT7622 is "default y"
> 
> I compared the .config files before and after the patch series
> to make sure no option changed unexpectedly.
> 

Fair enough.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
