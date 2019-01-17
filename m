Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FAEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE5E20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KY8yntzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfAQKUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:20:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32859 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:20:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so676655wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G4MDW0RhZARgx5TiYSSJYdn+7lJiem1DGlMxsyBST44=;
        b=KY8yntzKs5LMdURpDgncQhl5t2V9jls9aME2503Wh4PGEGyQDnJr8OUDHhRviH9DLl
         bSJfGDmZJrjSQdvQY9Honu2u0vMcNuNrfLoUYejxg/Bb8nGBgqIzx8T9IFlOq1AEi+Um
         amXD/0p1snd/4F+KvWGGzLtTLSQzFOijKbRfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G4MDW0RhZARgx5TiYSSJYdn+7lJiem1DGlMxsyBST44=;
        b=pClYgSq+oMD5kjGY3tSTQ5enX7e9I1EvxJ1oHm7+p25hG8YqEZ8vPNRjh39gOjCxOc
         J47oIntYGOyJ5Y2rJXvA7uxtCZYXnajSqm7uQnXu14M9Q8EoVfYphgeiUItLQj9stV+w
         8e895oIKPcVFqpZ23UBtLR/a8Iaxza1t8Pb8nYClvDEoVgZ1YNojCqybzs8l9TtgRIGU
         8TAZnyAhSO9sLwvtj77r7NlYwo4RRvIrUyaRqtSf075CwgzXbBzGVuinG+p3GHXCO5qR
         KdSC400WmTg2+Vqw4hF55OU++ekDLreJgLG+oqEGknxEfcctubnKkYVTYIh4yKXsktVc
         HL1Q==
X-Gm-Message-State: AJcUukd4RrYXwOQDMLTU5oybol0qBQYeXjiEjl67NNws96mJsBv4jVJP
        3Y8xuhZ1mESV2/Lpn2cGhi3o/Yyjpfw=
X-Google-Smtp-Source: ALg8bN6qLqHD/1N6yoFk4zDMNaF65Vfagt/ukjK86VCEftVAnMJ3gMTy9z62+ERXmJGZeadNJgFpnw==
X-Received: by 2002:a1c:2b01:: with SMTP id r1mr10906918wmr.7.1547720414634;
        Thu, 17 Jan 2019 02:20:14 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y34sm225764748wrd.68.2019.01.17.02.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 02:20:13 -0800 (PST)
Subject: Re: [PATCH 3/8] nvmem: Add nvmem_cell_get_optional and
 devm_nvmem_cell_get_optional
To:     Alban <albeu@free.fr>
Cc:     linux-kernel@vger.kernel.org
References: <20190106192820.12558-1-albeu@free.fr>
 <20190106192820.12558-4-albeu@free.fr>
 <de4aa31e-2d9e-a7bd-270e-f00ac3e88988@linaro.org>
 <20190116192658.7df211e8@tack>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5ea0d73e-5a71-708e-4c45-bb8d27137e45@linaro.org>
Date:   Thu, 17 Jan 2019 10:20:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116192658.7df211e8@tack>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/01/2019 18:26, Alban wrote:
>> What is the real use-case here, it does not make sense to me to add this
>> additional call just to return NULL when cell is not found!
> It also return NULL when nvmem is not compiled in. I quiet like such
> convenience functions as they make the driver code much simpler and
> the intent explicit. It replace:
> 
> 	data->cell = devm_nvmem_cell_get(dev, "my-cell");
> 	if (IS_ERR(data->cell) {
> 		if (PTR_ERR(data->cell) == -ENOENT ||
> 		    PTR_ERR(data->cell) == -EOPNOTSUPP)
> 			data->cell = NULL;
> 		else
> 			return PTR_ERR(data->cell);
> 	}
> 
> with:
> 
> 	data->cell = dev_nvmem_cell_get_optional(dev, "my-cell");
> 	if (IS_ERR(cell))
> 		return PTR_ERR(data->cell);
> 
> It's your call if you find that useful or not.
I don't think this should belong to nvmem core in anyway! Its more of 
consumer specific logic!

I have already applied all of the patches in this series except this one!

thanks,
srini

