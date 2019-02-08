Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D037C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B59820863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFiR3T0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfBHO0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:26:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46223 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbfBHO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:26:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so3717004wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VZ+rC7hQyVwUa+Vbl3yTPLmFGElJWRgYslTe4aOTfUw=;
        b=kFiR3T0bct3f+S0Efqirruv+xWLVOQEsaVEJsd8viwYTDjFBSWLNngQUZ+dTKBMP+u
         +pfT6qNPn9bzLDOqFeGNSurpFkOxItG9+3RQi/QZjDuQm+co5QIAYUOH+Tp+xZy80zKa
         tn7hgFZCXSroZleKHoQR2UOIvwO6kOy2tEQw/xGQ8mps6HkPP8NPmbWl0wntmZRjXaah
         LAbUWL2PvxDOQf6dfK7Lf8EDFpfOOCxMEySWf3KHyPjEDbDfcB/eU5em+O2QYhuXet8a
         WobtrZS3fQQ/TQmIIq4FGq3dHiH8E4gwhitOdcySVSg9Y7FNVlX3BpcAq0rDU6bYZLPM
         Uuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZ+rC7hQyVwUa+Vbl3yTPLmFGElJWRgYslTe4aOTfUw=;
        b=aO2CfxZSWvMkO3k/ruVZc95g8L0W4rYiLPzO74w1d397FSKdlp9rXarDklvn87LVwt
         /fXESjmwM/PuIjl6HdLgY7Kla17fp62b2Ry5pvuZprAUNFp6c04W8u/DtaiyTcdCYYv6
         zS2rIGDn2bh+N8c4MHNZMdgQ7wem7WeStD8BjsLU2Ij6U0uTWk9wyMyuhQcPGYXJW0zS
         jLZDJ3TW1LE+PCzXHGOKmJNtpjqrasHJS1ZUq9YrZOgLc1halwjrhbsaDrKGIj7LOvh8
         tM43pH+ittWqAZcUWp52zTx3EpqMcxnDxndIYYy4BPf0RtJZ1nnTGrC8g3HmYX+DG/EH
         uX/w==
X-Gm-Message-State: AHQUAubgIA5OvWjOC4bMI7TF1lOJZXdgp1I98yVTsD6kO9p9LkjpfSkn
        zbwmJfO7n+hWIYUXSxu+v3iwlg==
X-Google-Smtp-Source: AHgI3IYvZJOB+9WoIUzMFAgq/GCIFpnVG+YGqJZkpnLF8bE/eTMHvEpJNEhyWVKm+s3ZoK5VIu+T8Q==
X-Received: by 2002:adf:ca13:: with SMTP id o19mr16495463wrh.148.1549635993856;
        Fri, 08 Feb 2019 06:26:33 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y185sm2284824wmg.34.2019.02.08.06.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:26:33 -0800 (PST)
Subject: Re: [PATCH v6 3/5] misc: fastrpc: Add support for context Invoke
 method
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
References: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
 <20190208132306.12571-4-srinivas.kandagatla@linaro.org>
 <20190208135514.GA23406@kroah.com>
 <b60a0c35-6e5a-4166-9dd8-3891fce1cd0b@linaro.org>
 <20190208141120.GA9516@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <32aac00f-39f5-34a7-e1e3-a0eef62daa3f@linaro.org>
Date:   Fri, 8 Feb 2019 14:26:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208141120.GA9516@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2019 14:11, Greg KH wrote:
>> On 08/02/2019 13:55, Greg KH wrote:
>>>> +
>>>> +		/* Make sure reserved field is set to 0 */
>>>> +		if (args->reserved) {
>>>> +			kfree(args);
>>>> +			return -EINVAL;
>>> Am I wrong in that you are only checking the first reserved field in
>>> this array of args?  Don't you have a whole bunch of them here (nscalars
>>> of them)?  Don't you need to check them all and not just the first one?
>> My Bad, there should be a loop here!
>> I will fix this in next version!
> No, you don't need to loop it here, check it in the call that evaluates
> the individual args, which will catch the issue when people send
> "internal" commands.
> 
Yes, that makes more sense. We can avoid a loop here and do the check in 
  fastrpc_get_args().

> Which reminds me, what happens if a sequence has problems half way
> through the list of args?  Do you "roll back" to the beginning, or just
> abort?  What happens to the internal device state then?

We should abort the invoke if this check fails.

All the arguments are passed in a single invoke call to dsp, so if the 
sanity fails we should not even attempt to send it to dsp.

fastrpc_context_put in fastrpc_internal_invoke() should take care of any 
mappings created half way thru this checks.

--srini



