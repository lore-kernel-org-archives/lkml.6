Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA640C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C7A223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3bBa8af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C7A223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeKLX2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:28:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38404 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeKLX2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:28:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id f2-v6so8127967wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/wS3fuZmGEGEr8Ka/AfL0AaTLdFDC/w3BAgY50howE=;
        b=G3bBa8afume+a8FFYPDY5ljkUW+Mr+PGEbIXvBOt8eYOcCdWgCP4e9j8NBr3q73chx
         NCdh3ATjOZRQC78AY2wq3NjrGYf4KO3da5c7bpVvrnS02VXq2EsiTIIqXbLjPFmjXCCm
         bwADkCL79Q3QaGtbx67qDkhPWCFC2hNWKgsbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/wS3fuZmGEGEr8Ka/AfL0AaTLdFDC/w3BAgY50howE=;
        b=TbvZFTeTcll9yAD0djjaw9KUwxTLqELMis3QQvvBqPD0ZtWuTTWxkPFjju2K5Ju6Lw
         1292uODbvChEJ/A1ylCEUSQf+eYH6ym+utI9dUi0ZZ7DEFuXEIkxd1ee91ccjAHwQAi+
         lfNNgh2cDybiB8gEPFumC1keXjac6c+7mUtKvbA915ahKm1Zzc7+O/hIBs4MgGWv8GXF
         +p69RnuyU1QfJhF4jq6QccyJLfPr6yGuJ16zaKD1R9Owt/8iPywdyA1nHqR8IUzgNIw8
         /cF1cjuEA1uMKBSi+j6NDCUxIMX6H/yqkAxJ0DGTUZzI1UXsjQQbBvWF3BR0CzXSCtGT
         xbnw==
X-Gm-Message-State: AGRZ1gIbGQoIomlpAzmT925BzXxU/MG5PjIcQnniltZZ30D0oPcvJgWH
        +2KMNaAzgw+f66WlrtVbqGu5fjYV6JM=
X-Google-Smtp-Source: AJdET5ek4vIP9zBj7HWdZeoiOHB1Dx6qNeu1Wpru+G73/qSXW+qCxIwCpDx+VzOLyu+BOdlImR27sw==
X-Received: by 2002:a1c:8448:: with SMTP id g69-v6mr2096653wmd.63.1542029700595;
        Mon, 12 Nov 2018 05:35:00 -0800 (PST)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id m16-v6sm10230438wmd.35.2018.11.12.05.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:35:00 -0800 (PST)
Subject: Re: [PATCH 0/4] nvmem: meson: efuse updates
To:     jbrunet@baylibre.com, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181030102231.4851-1-jbrunet@baylibre.com>
 <fe93e6da-e55f-f127-32c2-5f0e46421b7b@linaro.org>
 <e2bda62e2d402d94762d47c6f775d06c3dfabfee.camel@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <00385654-f4cf-9881-e881-60a7a197ad85@linaro.org>
Date:   Mon, 12 Nov 2018 13:34:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <e2bda62e2d402d94762d47c6f775d06c3dfabfee.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/18 13:28, jbrunet@baylibre.com wrote:
>> Also I need ack from dt-maintaners on clk bindings to pick patch 2 and 4.
> I understand for patch 2, but don't really get it for patch 4 ?
Patch 2 is bindings which what I need ack from DT maintainers.
Patch 4 is driver changes related to patch 2, am okay with the changes!

So it makes sense for patch 2 & 4 to go together.
Once I get ack for 2, I can take 2 & 4 both.

thanks,
srini
> 
