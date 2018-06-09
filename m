Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kmN6BmYnHFskTQAAmS7hNA
	; Sat, 09 Jun 2018 19:15:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EEAEE602FC; Sat,  9 Jun 2018 19:15:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPNKfbdK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 59B9D608BF;
	Sat,  9 Jun 2018 19:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59B9D608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbeFITPq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 15:15:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38230 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbeFITPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 15:15:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id e18-v6so8192709wrs.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4dNHXqshqDRn84l4WhsZNgUxAFR0UQkQOi0SLoc8tsM=;
        b=HPNKfbdKiw2G9xtO2fAzMRWQRGCik/h0gDE+HrGUNC6nBE4aAPcpHr/cx6zbRCWgwy
         C/VJ5TC5CAQuL1C6H7t1CaA7/1TQcSrcjEE1aCajAWHt+Qg/rfUKw3VRLsWzNGIo3JR/
         PuRbjvb1wtKL8XyQBxAAjsqYkQNL2Ck/SeL6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4dNHXqshqDRn84l4WhsZNgUxAFR0UQkQOi0SLoc8tsM=;
        b=Iy0223kTYxl7FMcQfnw1UnU3Q6mTn1i4YP47XF2H75uTae0fC8ApjxauNochOyDZns
         3xSP5jTwjb/Kcy4yW0G2Ivnhc6B4FeIc6OZN86uuQxZJhp3fJMHLNaq+UHXVqqCRjjM1
         w739Qh07yeiKMcrKhY6st76r50trPBg5GVrOd2v2snY/Ia/GSR/MAAfzSvohQ2/pMckw
         X5P80G8e5y5gmmiBXUTAMJErhk5NzJD7W+VwOg7WqH/zgfQmEfRp25cvOI91UAYXcEwD
         +FxotBRr4E5r2z/C55gVWcZeHGbna5JABrb4BjGKiTUhBlYH3QXct5g0v5POAKeeL6G/
         f3xg==
X-Gm-Message-State: APt69E36Y/eeINonkC/B+grhdich6XmnRjGkF/UZCAE5V5yaRRKYxUHs
        96Yj2RrqvJ36zLTqYBF3xWmHsQ==
X-Google-Smtp-Source: ADUXVKL8G5MYVTQYaC3gVo+f1YUpqXYAxB+FL+wqgjc0MDRNP2KdCWwiHZ8HEWXk8IxobK5bDfNpVA==
X-Received: by 2002:a5d:4503:: with SMTP id s3-v6mr8603845wrq.191.1528571742582;
        Sat, 09 Jun 2018 12:15:42 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r3-v6sm38484583wrj.78.2018.06.09.12.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 12:15:41 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v4 1/7] interconnect: Add generic on-chip interconnect API
To: Alexandre Bailon <abailon@baylibre.com>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        skannan@codeaurora.org, seansw@qti.qualcomm.com,
        khilman@baylibre.com, mturquette@baylibre.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, davidai@quicinc.com,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-2-georgi.djakov@linaro.org>
 <ffd493a7-8c01-3f6b-074f-b4b67707dc83@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <625a529a-ae01-8615-e89b-409a20596806@linaro.org>
Date: Sat, 9 Jun 2018 22:15:41 +0300
MIME-Version: 1.0
In-Reply-To: <ffd493a7-8c01-3f6b-074f-b4b67707dc83@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 8.06.18 г. 18:57, Alexandre Bailon wrote:
> On 03/09/2018 10:09 PM, Georgi Djakov wrote:
>> This patch introduce a new API to get requirements and configure the
>> interconnect buses across the entire chipset to fit with the current
>> demand.
>>
>> The API is using a consumer/provider-based model, where the providers are
>> the interconnect buses and the consumers could be various drivers.
>> The consumers request interconnect resources (path) between endpoints and
>> set the desired constraints on this data flow path. The providers receive
>> requests from consumers and aggregate these requests for all master-slave
>> pairs on that path. Then the providers configure each participating in the
>> topology node according to the requested data flow path, physical links and
>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  Documentation/interconnect/interconnect.rst |  96 ++++++
>>  drivers/Kconfig                             |   2 +
>>  drivers/Makefile                            |   1 +
>>  drivers/interconnect/Kconfig                |  10 +
>>  drivers/interconnect/Makefile               |   1 +
>>  drivers/interconnect/core.c                 | 489 ++++++++++++++++++++++++++++
>>  include/linux/interconnect-provider.h       | 109 +++++++
>>  include/linux/interconnect.h                |  40 +++
>>  8 files changed, 748 insertions(+)
>>  create mode 100644 Documentation/interconnect/interconnect.rst
>>  create mode 100644 drivers/interconnect/Kconfig
>>  create mode 100644 drivers/interconnect/Makefile
>>  create mode 100644 drivers/interconnect/core.c
>>  create mode 100644 include/linux/interconnect-provider.h
>>  create mode 100644 include/linux/interconnect.h
>>

[..]

>> +
>> +/**
>> + * icc_link_create() - create a link between two nodes
>> + * @src_id: source node id
> I guess src_id has become node and is not an id anymore,
> so it should be updated.

Yes, absolutely!

>> + * @dst_id: destination node id
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_link_create(struct icc_node *node, const int dst_id)
>> +{

Thanks,
Georgi
