Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806D9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398FB20875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398FB20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966193AbeFSOJc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:09:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39450 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756803AbeFSOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:09:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so699331wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/eY7U5TEC0Ymmw5WXBmOOLV+sT3UquxTWhyrZwHRD1g=;
        b=EyRCtC3UKnJq8YkA0041iB57DbUOzKBm4SVdAp+d1SR778PdxRhSxJGDVra/ZSxehX
         uDvQiwQeWowlCCj6bGBIo4VtLUU0C2GHmq6OE/U3p6yTc02qk/M9YtVg4tf1VuTsQxJ6
         Zbc+9wb0nf0SO/zYySNxcRo0A2xUgZhQ/vkfiUrE7ki59INOipulTIpRz4Qj8DT9j9mW
         DsuOdi30SMisTkcc7AY1dM+BC2W8kJIb09otCq0pIF5Ksn8NbxBmsYI6gpTWCSQ4wTWP
         ppHC2b6jMMPTmvEfIDSZ6DvMpPP7kgKyKDzYVjLOj2OjPpF5zy2+kjQwFd4pOAXmVOd+
         uRgQ==
X-Gm-Message-State: APt69E2d3R0wXKmObP3PKQiB6E3DzD1hf9zj1s2PnUA+WuHovYh+NSuU
        oplqPEyDjbIAAS1521oPw9Q=
X-Google-Smtp-Source: ADUXVKJSDIRxuwolj8941ga2tjt8Q3Ch3CJFsVAiijtet4RV0QOVK5zybDcDfjgI2YNBjjAeQZ4GbQ==
X-Received: by 2002:a1c:5582:: with SMTP id j124-v6mr12496325wmb.153.1529417369715;
        Tue, 19 Jun 2018 07:09:29 -0700 (PDT)
Received: from [192.168.64.169] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v2-v6sm80959wmh.41.2018.06.19.07.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 07:09:28 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] nvme: trace: add disk name to tracepoints
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <20180611184630.3435-1-jthumshirn@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c05ae7fd-3580-ffb5-8beb-6e28666687f4@grimberg.me>
Date:   Tue, 19 Jun 2018 17:09:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611184630.3435-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2018 09:46 PM, Johannes Thumshirn wrote:
> Add disk name to tracepoints so we can better distinguish between
> individual disks in the trace output.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> ---
> 
> I'm not entirely sure if this adding the ctrl pointers to
> nvme_complete_rq() and nvme_setup_cmd() is a good idea, it's the
> fast-path after all.

We are going to need it for traffic based keep alive to update
that we saw a completion to extend the kato.

But I suggest you simply keep a ctrl reference in struct nvme_request
instead so you don't need to pass it to nvme_complete_req (that's what
I did for traffic based keep alive).
