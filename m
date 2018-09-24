Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7C6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F3F214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7IU5OjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F3F214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbeIYANE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:13:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35734 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbeIYAND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:13:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so19146138ljg.2;
        Mon, 24 Sep 2018 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CXqqDtaDDY+Z+lOa5rtUPATO7mQEGuwGbwH/RuGTIrw=;
        b=d7IU5OjVWh0HuZAhfXwD7COkaNG4r79NuchJvNSo2iFuwEwN83+vRkE5WCDwjDbEVj
         1mk942ovegwFnDnyMFzgQsz4ANX+O9eXt5eCz02Jl9T1jFVr9CQ0bO1hoaxiGssEMJe6
         phPYXhnzitUSXwO3MOEdK6SgqFuJqB8zYNlB6wJ27rjflH2a42LvJgj+me1zOKJG4MEe
         YQWvsOBcjvRhm9YOhp81l1d4Sr0q8iqDurGBvK5f7XqFKRn/GNgAeZDN72FTJUsTf7y8
         c3S9mT+pPjE3I0XW/YeevWruCfEQ+7X7lNhWYRxXEMuxazu5K+gYTHhMDW+6TNh3LMsC
         Awog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CXqqDtaDDY+Z+lOa5rtUPATO7mQEGuwGbwH/RuGTIrw=;
        b=gjzhLc3IUO3oC6QS/Jih1KNytLMsq4Wy067olplwK3TbeL8XaLcgspU1WC9snLUnsN
         Sc9itwa5X1iioajXjIRkoRaPLUs68ITZf+eVBDkCVUwgQ5J1uavIWoB74CaMBti/tqkV
         i5Dlv+raWBYfP1u4jeGirwHn0oENHn07OVJJK3LpJdNzcS+MbhA5NrOjCXsYsSbu2APM
         K5jbkUUE+b7mWnl6M7HNKZ6uCFkK9OIcvZlvR2m6DQz/rU+J1bLQVV/3PL++IXQ9uT7z
         EKUIGH8WCYUsfI3cnpNqCV5ZgNeU+NfrChy/UmG1s3X7yCy9mkm01wJM1abixb/ETR14
         zcMQ==
X-Gm-Message-State: ABuFfog7DTothxj4ZzOz1aQfO2kElm1VDWMe+yNs8q+NYkwC8YBwt1Ks
        ji3OWH34PrV9XOVb3b9Hz+EOPlCs
X-Google-Smtp-Source: ACcGV63RjYsEkgTFNdN8zVyWhWa5uWd3UvgSBIoTke27qOCdop+7brMbaZeMFPs1Sb+epxVE9tlxhw==
X-Received: by 2002:a2e:4401:: with SMTP id r1-v6mr531lja.21.1537812578336;
        Mon, 24 Sep 2018 11:09:38 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id a15-v6sm6672463ljf.92.2018.09.24.11.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 11:09:37 -0700 (PDT)
Subject: Re: [PATCH v4 17/20] iommu/tegra: gart: Prepend error/debug messages
 with "GART:"
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-18-digetx@gmail.com> <20180924105714.GN21032@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <32307503-bbd5-6ccc-39bd-b956465a9977@gmail.com>
Date:   Mon, 24 Sep 2018 21:09:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180924105714.GN21032@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 1:57 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:50AM +0300, Dmitry Osipenko wrote:
>> GART became a part of Memory Controller, hence now the drivers device
>> is Memory Controller and not GART. As a result all printed messages are
>> prepended with the "tegra-mc 7000f000.memory-controller:", so let's
>> prepend GART's messages with "GART:" in order to differentiate them
>> from the MC.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-gart.c | 36 ++++++++++++++++++------------------
>>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> There's a macro called dev_fmt (similar to pr_fmt) to do this for dev_*
> printers. Also I think this would be more readable if the prefix was
> "gart: " rather than "GART: ". At least from my personal experience I
> get easily distracted by all-caps words in logs, because they usually
> indicate something that requires immediate attention. I think it's
> better to leave that up to higher level mechanisms, such as the color
> keying of messages based on level by tools like dmesg.

The dev_fmt is a new thing, thank you for pointing at it. I'll try to
switch to dev_fmt and lower the text case.
