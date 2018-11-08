Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44A0ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9E520827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YW49QpB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9E520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeKIB6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:58:30 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37568 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeKIB63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:58:29 -0500
Received: by mail-it1-f196.google.com with SMTP id j79-v6so2491284itb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJatf1SYn/FvaC1RYDdgmhgiDS3qWSlKrIj2bmEua5E=;
        b=YW49QpB+WN/vrgzqIrW6opoRIjJH7L65p4FM+okzvotUU2zGCJCrp2MFh9zc7Txyi9
         DSaWX5362r1ytwQLR16Yh5UqdgKvDDTEQVh9shlwZODcZdwzdwMLkTEy7tl41bjSLu6O
         FNzEyWvdHcHVrjuVERdINvXBy/jUrngX71/UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJatf1SYn/FvaC1RYDdgmhgiDS3qWSlKrIj2bmEua5E=;
        b=uhdZ0EkuDRyHi34mb8CAFGri2LKSJrGntEEt4V9a4VekQjdkYtZURo1Wkq75KYV6tz
         qg90KtBBO7dtRCyJ7wrx5/5rmv8TCrsVZpQqtnBujvQ2CL/6nqZ5TvIRsvD6ipHat981
         uVVwoVZ0p+MehpNlsLGwecdY+sS5w9wHTjz2/pNKGnu5ACulffV44DjXayZpyNREBiOJ
         qqlLQSDzemvU5JzFHUDDss0nif8eU3dAMessJnqQV0SpprDAcqDwS3mrf8Jlvj7a+n0D
         dh+XYj+O5OgHLtouFWAFj/mZIEyZWYWLu3ugmeMkVi77VjuCAnpnWuTITBSmOArwkkUc
         11ag==
X-Gm-Message-State: AGRZ1gIauGQrURdD47fE5YHt/65duS6124eEzy2Cv584bjFE9QO1talA
        3eJ2IAEk8V52MOOgl5v+e3soGpkFpOs=
X-Google-Smtp-Source: AJdET5d29stiP/cX+K5EJ61bp+4zCYsdcIOpSgtqkRorHu/KQeQTQPdDoLfKaGj40OuX0cTtK+vFrg==
X-Received: by 2002:a24:4052:: with SMTP id n79-v6mr1504106ita.99.1541694135124;
        Thu, 08 Nov 2018 08:22:15 -0800 (PST)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id o131-v6sm2049666itb.37.2018.11.08.08.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:22:14 -0800 (PST)
Subject: Re: [RFC PATCH 12/12] soc: qcom: ipa: build and "ipa_i.h"
To:     Randy Dunlap <rdunlap@infradead.org>, davem@davemloft.net,
        arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syadagir@codeaurora.org, mjavid@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-13-elder@linaro.org>
 <cebe0d3c-4a24-60a4-88c8-5195a5d0da4b@infradead.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <dd788545-a369-684e-3d57-b0b8a98b407a@linaro.org>
Date:   Thu, 8 Nov 2018 10:22:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cebe0d3c-4a24-60a4-88c8-5195a5d0da4b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 6:40 PM, Randy Dunlap wrote:
> Hi-

Thanks Randy, I've fixed this in my own tree.	-Alex

> 
> On 11/6/18 4:32 PM, Alex Elder wrote:
>> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
>> new file mode 100644
>> index 000000000000..f8ea9363f532
>> --- /dev/null
>> +++ b/drivers/net/ipa/Kconfig
>> @@ -0,0 +1,30 @@
>> +config IPA
>> +	tristate "Qualcomm IPA support"
>> +	depends on NET
>> +	select QCOM_QMI_HELPERS
>> +	select QCOM_MDT_LOADER
>> +	default n
>> +	help
>> +	  Choose Y here to include support for the Qualcomm IP
>> +	  Accelerator (IPA), a hardware block present in some
>> +	  Qualcomm SoCs.  The IPA is a programmable protocol
>> +	  processor that is capable of generic hardware handling
>> +	  of IP packets, including routing, filtering, and NAT.
>> +	  Currently the IPA driver supports only basic transport
>> +	  of network traffic between the AP and modem, on the
>> +	  Qualcomm SDM845 SoC.
>> +
>> +	  If unsure, say N.
>> +
>> +config IPA_ASSERT
>> +	bool "Enable IPA assertions"
>> +	depends on IPA
>> +	default y
>> +	help
>> +	 Incorporate IPA assertion verification in the build.  This
>> +	 cause various design assumptions to be checked at runtime,
> 
> 	 causes
> 
>> +	 generating a report (and a crash) if any assumed condition
>> +	 does not hold.  You may wish to disable this to avoid the
>> +	 overhead of checking.
>> +
>> +	 If unsure doubt, say "Y" here.
> 
> 

