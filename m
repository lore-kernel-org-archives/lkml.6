Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD5EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309CE2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmblJhyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309CE2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeLKKui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:50:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40831 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeLKKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:50:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so1706511wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bpXVvzOdnAkEh8osnOAI3Zrp1X3lNrNEFmU07HHZx3M=;
        b=HmblJhyNWAvINaTrze7athjgr3kiBFYSqma+Ou+VwXEgbQl9X+E7mGtXt7tdTIvLTU
         r6HlLUYuPiTUdC+gqu+WBTULItOQskTZjXrs7wncj7hNjh7Cl0zVMTgXcS1kAGKvopsE
         LRA7Htnm9fKWaJuFFMem6nKgDOweG0qUBjqnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpXVvzOdnAkEh8osnOAI3Zrp1X3lNrNEFmU07HHZx3M=;
        b=PuyBQl+3CnUqXG/6dRzozUHkBpMgDRRZlKgdh/Uzf2COrPAG8razRvsVJJTV5NStUe
         hklH6hkzlwI3lOsBi1gX9nTzYPxKqELyj40IIBcQrVZkrVQM9Ls/QfTxX/ksFl8toKbe
         pnjyeX2mkOeO+1iHF293UFw+MsC62sYMazTJJnJE3FMgQnsYmKD4YN9tMWrre1bENp9s
         oOkSbBIf6Eb8SERFmu91t1EobL0LWKtPBqUpiPwJQus0oWz3YGxP8HbkTDzdREZv65nG
         ytkgyLme0eN9g2GIpNa/Qgg/GTT02StjTNj35X/oASLjThjC7oyaUDfCzewl8UnjsYLn
         unxA==
X-Gm-Message-State: AA+aEWa0+B1L0Q+Wcc6Np2DJaeXZ+ZscDvgZq7e6N1z7OTF20EzxD+zN
        W3brcoyHTBIEBTUpc2HtfFC2qA==
X-Google-Smtp-Source: AFSGD/XHJmpJUHXPV92VlFPaqqkZychbgm21u79iqD6Hku0nK1sAa59JJHGGP8nksymYueue+xg1yA==
X-Received: by 2002:a1c:d74a:: with SMTP id o71mr1807669wmg.73.1544525434921;
        Tue, 11 Dec 2018 02:50:34 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s16sm16721965wrt.77.2018.12.11.02.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 02:50:34 -0800 (PST)
Subject: Re: [PATCH v2 1/6] misc: dt-bindings: Add Qualcomm Fastrpc bindings
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-2-srinivas.kandagatla@linaro.org>
 <20181207182327.64mtkfx6v4wlwccz@lakrids.cambridge.arm.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <72b8d2b7-b4ef-448f-4e2c-e4c555c1f908@linaro.org>
Date:   Tue, 11 Dec 2018 10:50:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181207182327.64mtkfx6v4wlwccz@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/18 18:23, Mark Rutland wrote:
>> +	cb@1 {
>> +		compatible = "qcom,fastrpc-compute-cb";
>> +		reg = <1>;
>> +		iommus = <&lpass_q6_smmu 1>;
> These iommus should be associated with the device (i.e. the DSP itself).

Are you referring to implement this using "iommu-map" and 
"iommu-map-mask" bindings on remoteproc/rpmsg bus?

--srini
