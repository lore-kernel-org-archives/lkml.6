Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB24C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96DB20868
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+pGrMQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96DB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeKLXCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:02:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35030 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbeKLXCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:02:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15-v6so8111602wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=34SrX1T4S6Dxdn92/8v2JAUhCO12CJETVYDgPlQvHx8=;
        b=a+pGrMQYgFaGNpEmDkJ+Wwl0O4Hyoriz+Jm3njd4dxdMgYQTtBIm869/Kgs50Ox1ob
         AGAeBTDrBxzepEQMyd3+nTiR5sq2aws57gHoOj6qxgmYZyp3njci5kxqzc2l32MzB3OT
         bzaM4zKVGkWrH5jgGVfvvjDWzB8IP4nyeYyZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34SrX1T4S6Dxdn92/8v2JAUhCO12CJETVYDgPlQvHx8=;
        b=QKJCDnwfZ3YSRH0YnRl9KCm8f/UkhxlR9OXBudq4vWBsloyDzcd/J6lBk6z5tcrDHX
         Ok3JVw6m12pCY01KwVtMJ0S+QDSOsKjbJ89lI9TV/VDZozblMHHcR+1Iwz/QU1ChwZ3N
         AAlBes4zOHK8CGtNYlUA4Z4/NhdRucEkD8TmyqEuCWadIVv26lSmMILM+N9eiMaO66eq
         VJFTsba3APTX4hkY7llwBFLeY6p97fOuY0cOPSeBkhZCBdeq5JqezNn7NajfjMwgzIX+
         /dWLzUMmDBKF2Zw5tQdqm6AwF8twk9/+BmvRwNKfREamWa2Z5P0XQngHcuKaIDILdXo8
         MY6Q==
X-Gm-Message-State: AGRZ1gL41jpwaLgloCsACaQf5Q3sFT1iAWAympsXBV4fSEx296XE8fyn
        HV2RBGwVp80WL4FKEZstrhKAYO44tbA=
X-Google-Smtp-Source: AJdET5eZu3NkhmQN/7Qlnq15J5ozyMJS1DZMk7OKsISD9HBiEwon6wWC4eBf4tLJmYN3PJxYPuyz6A==
X-Received: by 2002:a1c:58c5:: with SMTP id m188-v6mr7224046wmb.85.1542028130976;
        Mon, 12 Nov 2018 05:08:50 -0800 (PST)
Received: from [192.168.0.12] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id x2-v6sm10351572wrw.42.2018.11.12.05.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:08:50 -0800 (PST)
Subject: Re: [PATCH 0/4] nvmem: meson: efuse updates
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181030102231.4851-1-jbrunet@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <fe93e6da-e55f-f127-32c2-5f0e46421b7b@linaro.org>
Date:   Mon, 12 Nov 2018 13:08:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181030102231.4851-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/18 10:22, Jerome Brunet wrote:
> The first change of this patchset just adds add error message in case
> of failure. If there is problem with the secure monitor, the
> SM_EFUSE_USER_MAX call will be first one to fail so it is better if it
> give us a clue to help debugging, instead af silently failing.
> 
> Next this series adds the peripheral clock missing in this driver.
> Like many other device in amlogic's SoC, the efuse requires a
> peripheral clock to operate. ATM, the clock controller has
> CLK_IGNORE_UNUSED on this clock and we have been lucky enough that the
> bootloader left the clock enabled
> 
> At some point, we would like to remove those CLK_IGNORE_UNUSED, so if a
> driver needs a clock, it needs to properly claim it.
> 
> Srinivas, Kevin,
> The dts change needs to land before the actual driver change, to avoid
> breaking the efuse on our users. If there an agreement on this series,
> Kevin could you provide a tag to Srinivas ?

These are not fixes to any bugs/regressions, so its new material which 
can only go in next dev cycle!

I guess that should also address the patch sequencing issue!

Also I need ack from dt-maintaners on clk bindings to pick patch 2 and 4.

thanks,
srini

> 
> Cheers
> Jerome
