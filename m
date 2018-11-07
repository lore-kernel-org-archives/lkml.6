Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8478AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6BD20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyGzcWbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6BD20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbeKGXqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:46:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51324 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeKGXqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:46:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so14160458wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 06:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yK6NzDx4sIyotlD6DesYMrbO0KdE1/+hr0cPwWXbrfA=;
        b=fyGzcWbc7HO3XkpkOW3hNqQsKN5jtXvP+ivBt4RnyBrJYDrGM8SxvzZEwjYrFe2h7j
         XHnYd3gkHrV5ucevF2l5nJjfy4QOWbQj7f7UNpDAmApBZp9ySYjK5lRlOSKPbbTnrg+G
         vPDfT9TbgI1nA00V5nrcLWfz913beb+QNBPNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yK6NzDx4sIyotlD6DesYMrbO0KdE1/+hr0cPwWXbrfA=;
        b=TMYx5YR8j0WMgW/bgXjuXuVtgHRWYEfdV0+2uxn7o+EAe5PFE/VrfLsXZOLhzLclnP
         LtrV1rDJ1XtcXjBPTt5Aal0yO638stE7c1qSJxAYvOMcJ6ieYitE0J4rEErpLwhoIMm7
         8lUWsckkKNfSJUo0h5MUHzU7hWuyTSIx7xWAiVWcfuSwq3CaF9PXOsku+9WgbboZ9zka
         zWEgFFXKhhiT7TeR4IV+RONIZKoBCCGCXctPZ1CLjd/X+XYOKnfMta+9IwRyOaWmXUyU
         GWkLi8RqreNMRjVhXoFMb88rGqO4nGaE8lSJaTHR51MamH2PIeKMX6pE+hYak+BOFtQk
         bXPw==
X-Gm-Message-State: AGRZ1gKyzbW63LHmJHOMbtw+F1e+FpFyEVm56q3WaW6M3v1kGtpEgyx6
        okmSp20DJaoro3be3SBzvtlMFzmjccs=
X-Google-Smtp-Source: AJdET5d2AawtJH61W7c271fcEAM/Y6SZa3IeJcsbOsZ8suZ4MOl0Qx+mD9u9HO/SWcnkTwXzG6eI9A==
X-Received: by 2002:a1c:a8cf:: with SMTP id r198-v6mr309947wme.147.1541600135163;
        Wed, 07 Nov 2018 06:15:35 -0800 (PST)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id x142-v6sm2192875wmd.20.2018.11.07.06.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:15:34 -0800 (PST)
Subject: Re: [PATCH v2] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
To:     Greg KH <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-kernel@vger.kernel.org
References: <20181015183218.GA16900@kroah.com>
 <20181015194441.10475-1-niklas.cassel@linaro.org>
 <20181107135911.GA23393@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f6e9ae15-b52b-b8c5-3d16-3b67b8977c38@linaro.org>
Date:   Wed, 7 Nov 2018 14:15:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181107135911.GA23393@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/18 13:59, Greg KH wrote:
> Really?  I do this and then I get this build error on x86:
> 
> drivers/slimbus/qcom-ngd-ctrl.c: In function ‘of_qcom_slim_ngd_register’:
> drivers/slimbus/qcom-ngd-ctrl.c:1333:63: warning: dereferencing ‘void *’ pointer
>    data = of_match_node(qcom_slim_ngd_dt_match, parent->of_node)->data;
>                                                                 ^~
> drivers/slimbus/qcom-ngd-ctrl.c:1333:63: error: request for member ‘data’ in something not a structure or union
> 
> 
> So I can't take this, something else must be wrong here...
That is fine!
Yes, there seems to be one more issue here, on non DT platforms 
of_match_node is set to be NULL, which is why we are seeing this error I 
guess!

I will fix this up, do some test and send both the fixes together.

thanks,
srini

