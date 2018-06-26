Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DA9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862B826A86
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862B826A86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934770AbeFZM3p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:29:45 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:41177 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933509AbeFZM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:29:44 -0400
Received: by mail-wr0-f176.google.com with SMTP id h10-v6so17054126wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ltWOwBNAIf002/bfBUo0NuouhSN7QvGQa3/OhRxb6VU=;
        b=Sa3oUYODxnIy1YvtrEAhB7J+vzL1CSnxDkhVxFvdBbc3eRwepu8vifCkkVpQBCkdWS
         7dVMwJ0Ms7aKA9ZpMozCwOrFdPAFC8yn8xTG3lpBcMO8qA0k5PtNS1WgrxelPIX1VSWr
         d2g8sKTMSyQvNkoJTQfpBqnJ19JsAvgIrVxANJUZwM2WlnLCUSZOyaF8X9ndpceZb92N
         nmGGaYQOnMpUp4M59bwszxNuG9Zm6PqgrJxLMdqhWdAKyuOwdBrvzDRLDo4zG2rULQd0
         ZCBXix4T27BIPgcsVGBQct27hn1nbTj9p/F0PrECSYnWscVR/RL3bgdpDCXOeWfAhpZB
         idqA==
X-Gm-Message-State: APt69E1dopjoGQggp7Nf5vcHCz2hWDSi9WGAhkBTQPXtk4DXwpFv0uuj
        qbUZOuQ6kmJPq6oTEXIp3zbwHwGc
X-Google-Smtp-Source: AAOMgpcCEyQS2slSPeWKca2BERrev9zvkj8ddHBj+f0W6F5cG9rW1wikPSQXei2ksfqNwb+cIOD29w==
X-Received: by 2002:adf:f246:: with SMTP id b6-v6mr1314931wrp.235.1530016183155;
        Tue, 26 Jun 2018 05:29:43 -0700 (PDT)
Received: from [192.168.0.105] ([46.120.250.42])
        by smtp.gmail.com with ESMTPSA id w12-v6sm1226897wrp.69.2018.06.26.05.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 05:29:42 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] nvme: trace: add disk name to tracepoints
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20180611184630.3435-1-jthumshirn@suse.de>
 <c05ae7fd-3580-ffb5-8beb-6e28666687f4@grimberg.me>
 <20180625070850.jdl7mudz6o6diwsj@linux-x5ow.site>
 <d4786519-1695-25a0-dbf5-5d6cb9809539@grimberg.me>
 <20180625140300.rebclfa6pa6mtsat@linux-x5ow.site>
 <f09c1b97-ea12-20d6-ac8a-ee3f19b2879e@grimberg.me>
 <20180626111342.4g7or4jzm5zw2ks4@linux-x5ow.site>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dd17ed26-1d1c-5611-63a8-b10c69b81134@grimberg.me>
Date:   Tue, 26 Jun 2018 15:29:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626111342.4g7or4jzm5zw2ks4@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> You want to submit or should I?
> 
> Whatever is easier for you

You're the owner, you should go ahead with it. Thanks!
