Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CD1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE1426980
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE1426980
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934052AbeFZK7H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:59:07 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37193 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932963AbeFZK7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:59:03 -0400
Received: by mail-wm0-f52.google.com with SMTP id n17-v6so800143wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YuXxeJxtpFY9n7Y7rXX/JHGiqjQyMFq+axpHJ8efnxU=;
        b=MiduU0vDrrZQdWB0yAbP7ygYrdS10eeEPi/VujmU386WQx6+ca8ftdc7ixG5i6IVEq
         /6d/Iv8uBX28Vj2cLbOhUGDPVw/8GMcNjQEEbf+YuBXrFYXFcI/sGYTFSEONcvdYh9q6
         W6VNjQEVYw2xIiVymyp51NK1fYUV/1Al8QeZ9kaxqYBqktq65AMwVZQsOWUBMiKpqLjf
         PY3uHStyZgeXeqsP/ulTa8BQexNWXHF9Xp5LCB4tXM+OwuqwLEZo1xQgSaxJrw/qM+DQ
         FedINEJNGgIDSVWjbv6Ygeh8mlH55BiAUsgW7P/PB07NvDcKOwdGMkrsNDPFsa56kYa2
         1S2w==
X-Gm-Message-State: APt69E2fIaZg/oBq///WXXUEU4d8mxx/UgUhWNcMk1kOVHMCJVTJWXLK
        9tYWerahGdsdlWfoF9LcE1w=
X-Google-Smtp-Source: AAOMgpfGwU+IBu8nSW8Wnk0jXlmGoNbwD+F53WH9tbVxin3MMwOqwWU4BNQfYOjkAvt1cJicoCTIUg==
X-Received: by 2002:a1c:3544:: with SMTP id c65-v6mr1166781wma.32.1530010742409;
        Tue, 26 Jun 2018 03:59:02 -0700 (PDT)
Received: from [192.168.64.169] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j10-v6sm1769927wrr.47.2018.06.26.03.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:59:01 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] nvme: trace: add disk name to tracepoints
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <20180611184630.3435-1-jthumshirn@suse.de>
 <c05ae7fd-3580-ffb5-8beb-6e28666687f4@grimberg.me>
 <20180625070850.jdl7mudz6o6diwsj@linux-x5ow.site>
 <d4786519-1695-25a0-dbf5-5d6cb9809539@grimberg.me>
 <20180625140300.rebclfa6pa6mtsat@linux-x5ow.site>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f09c1b97-ea12-20d6-ac8a-ee3f19b2879e@grimberg.me>
Date:   Tue, 26 Jun 2018 13:59:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625140300.rebclfa6pa6mtsat@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Looks good (both #1 if we want to use the two patch version or #2).
> 
> I have no idea what I did when I was trying to do when I tried it.

You want to submit or should I?
