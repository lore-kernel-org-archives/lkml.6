Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4C6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192332145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1Epz5LC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192332145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeLCSZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:25:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33345 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLCSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:25:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so14960253qtp.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8S2GCIBmDhpsr9ffz2NPr17A6UX3yXgBFRtRmtKvOXk=;
        b=J1Epz5LCK4GxDI+tYFXIzr1G5znA7Ywrd/jwMvjYH+3Razy48sX2k5ylAs5+NNshc+
         B68SO1IlcCVuArI+oE7+iKpqZw6Uve56gWqG9WHO4RBU4qDDJd5y4Kl5N0andDZMsPy0
         f4XtaV5He9P18+FLEOKM074pFtmHkFtAMEVKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8S2GCIBmDhpsr9ffz2NPr17A6UX3yXgBFRtRmtKvOXk=;
        b=nxevdW5vuqb9dhQffzLhi3SqaCZhVX3Z5e6uauF4N02SFbHUe8QGICIZYuNOlZ/0eF
         Cw/QSQNgXV+y7v92XasKySZhimnyc5wm9ikasciqmTNi+7BCOUGWSsAzxTTLVKqoe5Vx
         wCUIEpzpZz0KcWJOLwRRFs+sw6DAmaiPUMyB2mB43BtANDvuquk4PCVHXUEoY5ONc2d2
         d2SBKkXvCB5xxCtqsVQkxPJSqR+vAPIhX+/x4bibet6t3x7Fq1VE8oj3X3yXPzL4QWOh
         jU1SqNI16cutT5KyyypoVIvxOzPlcgxHmJU8zkq0LLnlGk1aCdPjdUL8jl4BQpfTLC7x
         qGdw==
X-Gm-Message-State: AA+aEWb4Cup2InGzD0VhwaSOCXVPMU2qTHYlH7TaHhAQxU6OKqgEQ6hq
        pqZeC3Ghq3B/7DdL6tveKHil+A==
X-Google-Smtp-Source: AFSGD/WKMVZMl8p2stz6rPXAyRupvk4CRUdiRupW5C6jKSwVFrTdwHk4qFbHX6nVcwqm1zlbuc5Rhg==
X-Received: by 2002:aed:3027:: with SMTP id 36mr15949423qte.252.1543861493699;
        Mon, 03 Dec 2018 10:24:53 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id v2sm6540675qte.75.2018.12.03.10.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:24:52 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: v4.14 fix for Hikey 960 unbalanced IRQ enablement
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
 <20181203141442.GA19335@kroah.com>
 <dc468512-7a73-3d69-fe9e-d660db85ee5b@linaro.org>
 <20181203151946.GG235790@sasha-vm> <20181203180521.GA15996@kroah.com>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <e0eb7f46-e619-7198-eb78-2b55246b1159@linaro.org>
Date:   Mon, 3 Dec 2018 16:24:48 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181203180521.GA15996@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Greg,
>>
>> Patch 5 in this series seems to explain the best what is happening here:
>>
>>> With the following changes, we fix all in one:
>>>
>>> - Do the setup, one time, at probe time
>>>
>>> - Add the IRQF_ONESHOT, ack the interrupt in the threaded handler
>>>
>>> - Remove the interrupt handler
>>>
>>> - Set the correct value for the LAG register
>>>
>>> - Remove all the irq_enabled stuff in the code as the interruption
>>>   handling is fixed
>>>
>>> - Remove the 3ms delay
>>>
>>> - Reorder the initialization routine to be in the right order
>>
>> We can't revert anything because the breakage was there since the driver
>> was introduced.
> 
> So the driver was broken in 4.14, why not just use 4.19 instead?  This
> isn't a 4.14 regression, it's something that obviously no one has
> noticed for a year now, so why backport these big patches to 4.14 now?
> 
> thanks,
> 
> greg k-h
> 

This was caught during our functional tests. No direct complains, but,
since it included a trace, and there was a fix for it, I thought it
could be accepted for upstream v4.14 (it is included in other v4.14
kernels, like Android's).

thanks!
-- 
Rafael D. Tinoco
Linaro - Kernel Validation
