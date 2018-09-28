Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9615EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD7321580
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RoUX+SGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD7321580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeI1Tqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:46:52 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56150 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeI1Tqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:46:52 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so2424852itd.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=amRdKKEpjP+mVpMOEiQ08RnVzTzV/GhaIt6h0/7THYQ=;
        b=RoUX+SGVR2vK2dtMDrpqrMBQjfv7wJqfyNl/WiZI8Ano3Gu4aDyiW6cZ3qisjB0qSA
         tNIfq1YiTj27wu13HGTldz4Y0EL0YhkAJLdm2+HSR+3Tifj820SIh7wIvGLLr0+XJIyd
         E3vU8eR12lmFfyMvJDnqdjAdyU7bH2XzeYN4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=amRdKKEpjP+mVpMOEiQ08RnVzTzV/GhaIt6h0/7THYQ=;
        b=iTq0LzBLJ6uWuCIlC4OeI8vrFs1CI3iwL22oUcwrT21HJmYmI2QdvilfSSXqY2HFw4
         sbIE8kPJFMg85cCu++7BG2Z6ds2jg/xhrGyUsDVKNYDqmgoedePwPbQt/C9rTD/Z+ANQ
         4u5pZSnD33f2Z8jmp650z88/HZVxHllVFF8QnwUI4d9MvKXbzqndeQAZv8ztYEsVQw38
         c8wV/SVMmzy+3k/tq2rZPsEjA04fqmrKBmYdYtAYNvobIFyyFhEeD/rHLdDi9AnGdN/+
         pIyUPBxh3bqQutE7p1/kFB7TFWn2ac5lZ/TAT6U+rXPMktqHaCrpzMvbfW2fze2WVhYr
         y72Q==
X-Gm-Message-State: ABuFfogWcVXg6eEHamF2Wvls/zUusMT8/VetFN7aX2XKkSl6D2E5uPEw
        BNvWfu9MxDaTFB5N6sfhn0ju2dlHIz4=
X-Google-Smtp-Source: ACcGV61oPMZ+svw9E1TOkyX7/Ml112Nuv6K+5fPLZPZs/RHkm/zIAH+NWFQgLc1GpeW+AMwB1ofbPg==
X-Received: by 2002:a24:7383:: with SMTP id y125-v6mr1459216itb.146.1538140985412;
        Fri, 28 Sep 2018 06:23:05 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id r126-v6sm952051ita.26.2018.09.28.06.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 06:23:04 -0700 (PDT)
Subject: Re: [PATCH] soc: qcom: qmi: add a prompt to QCOM_QMI_HELPERS
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180427140358.30839-1-elder@linaro.org>
 <ec0e7861-4bf0-f135-a881-1a1de4579277@linaro.org>
 <20180928122616.GA5249@centauri.lan>
From:   Alex Elder <elder@linaro.org>
Message-ID: <4025f206-631a-55e9-9b7a-89dcf3370284@linaro.org>
Date:   Fri, 28 Sep 2018 08:23:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928122616.GA5249@centauri.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 07:26 AM, Niklas Cassel wrote:
> On Fri, Sep 28, 2018 at 06:41:11AM -0500, Alex Elder wrote:
>> Was there something wrong with this patch?  I sent it a long time
>> ago but it still applies cleanly.  I can re-send if you like.
> 
> Hello Alex,
> 
> This patch does not apply on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next

Sorry, I sent this before I tracked down where Andy's for-next
tree was.  It applied OK to linus/master.

> When you don't specify a string for a Kconfig, then you won't be able to
> select it via menuconfig, only through other Kconfigs, e.g.:
> $ git grep QCOM_QMI_HELPERS
> drivers/remoteproc/Kconfig:     select QCOM_QMI_HELPERS
> 
> What Kconfig is it that needs QCOM_QMI_HELPERS?

IPA, which is not yet merged.

The entry in "drivers/soc/qcom/Kconfig" for this option includes
help text, so I presume it was an oversight not to include a
string (prompt).  It is the only non-trivial entry in that file
that does not include one.  Why should this entry not be listed
in menus?

> Why do you need to make is selectable via menuconfig?
> Isn't it sufficient to add a "select QCOM_QMI_HELPERS" to that Kconfig?

I have CONFIG_IPA dependent on CONFIG_QCOM_QMI_HELPERS.  I could
change that to select it instead but I still think this entry
should be changed.

I'll mention that SLIM_QCOM_NGD_CTRL in drivers/slimbus/Kconfig
also depends on--rather than selects--QCOM_QMI_HELPERS.

					-Alex

> 
> Kind regards,
> Niklas
> 
>>
>> 					-Alex
>>
>> On 04/27/2018 09:03 AM, Alex Elder wrote:
>>> Add a prompt to the "tristate" attribute in the Kconfig file in
>>> which QCOM_QMI_HELPERS is defined; I find it doesn't get selected
>>> without it.
>>>
>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>> ---
>>>  drivers/soc/qcom/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index 5c4535b545cc..81a501765cd9 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -36,7 +36,7 @@ config QCOM_PM
>>>  	  low power modes.
>>>  
>>>  config QCOM_QMI_HELPERS
>>> -	tristate
>>> +	tristate "Qualcomm QMI Helpers"
>>>  	depends on ARCH_QCOM && NET
>>>  	help
>>>  	  Helper library for handling QMI encoded messages.  QMI encoded
>>>
>>

