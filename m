Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE284C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1CF208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E0hRectx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1CF208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933679AbeGIR3q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:29:46 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36371 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbeGIR3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:29:44 -0400
Received: by mail-qk0-f196.google.com with SMTP id a132-v6so10103438qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=96PcFo3CnN6/IZAwpr5eOUjhetXFXkcAZvLs7FpLwkw=;
        b=E0hRectx8bdTV1i8+vPf7/KwiPxMX31Ysal4eQXap+596xodPh0qUixoeFh37on9Ef
         oByuYd7qqA7PMyS2dLEQwoSSQdQ2EmqWm6IjutHqcgfYN5I0FWUQBBQBUf3S12I5soJJ
         uRFaXsm+ifVqrVDOaxl0M78A2XneGJIXKqkUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=96PcFo3CnN6/IZAwpr5eOUjhetXFXkcAZvLs7FpLwkw=;
        b=B699CF0z0UEDIbiILudDC6dgNMAAxuHCo1ntLMPlE3oYVjgrHYZvzyUcqdOFvWbATM
         t2UnU7bdh7aNxrXr66rB68mSoE7k7lHVTfLHOys7LPrhHHVmTY0j4kMwJqKH60qcg/ej
         YYCExe9OD3QZe93s/0tlGSyChONaQF5a6a+C5jeP/f7Am3AJPRAUnhVu/3jlBQiJTK2e
         sWzra/36sCiB04ZGuBZ/8/YnYKLzyCLXIeSgnef0fUQUgeYyb2twjpM9aBofW++WDC8b
         t0qFKRxw83YyzAfgYucPwxBFKvd6DxEDLLoDhcG5H9mVptUEBgnFk5Fi4jreUfAFMjKK
         gE6w==
X-Gm-Message-State: APt69E2LqxlPHaTIXOiWtSsqsFRor1wIhQnEJBpCtup+wueGEABw3GsU
        1s8gvkesgOCYFjsu727G7erGYqj3NDg=
X-Google-Smtp-Source: AAOMgpcus/ZIMAVg1i309fhUwwgHlSgfelgu0OiPAQEq1bwIueYyjdOY1RUBo36pKdnEGIavPKO61A==
X-Received: by 2002:ae9:c00d:: with SMTP id u13-v6mr18235124qkk.290.1531157383403;
        Mon, 09 Jul 2018 10:29:43 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 4-v6sm11578226qtq.24.2018.07.09.10.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 10:29:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Improve Broadcom PAXC support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <20180709172251.GB16292@red-moon>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <740b4299-806d-8098-08f6-e467c7fae584@broadcom.com>
Date:   Mon, 9 Jul 2018 10:29:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709172251.GB16292@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On 7/9/2018 10:22 AM, Lorenzo Pieralisi wrote:
> On Mon, Jun 11, 2018 at 05:21:02PM -0700, Ray Jui wrote:
>> This patch series improves the Broadcom PAXC support by 1) adding more
>> quirks for specific versions of PAXC controllers; 2) adding logic to
>> reject internally unconfigured physical functions from the embedded
>> network processor acting as endpoint; 3) reducing verbose print level
>> in the outbound/inbound mapping code
>>
>> This patch series is based off v4.17 and is available on GIHUB:
>> repo: https://github.com/Broadcom/arm64-linux.git
>> branch: sr-paxc-v2
>>
>> Changes since v1:
>>   - consolidate 2 PAXC related patch series into 1
>>   - change the way how the capability list corruption is handled, per
>> recommendation from Bjorn. Now handle and fix up the corruption at
>> the config register read
>>   - rebase to v4.17
>>
>> Ray Jui (5):
>>    PCI: iproc: Activate PAXC bridge quirk for more devices
>>    PCI: iproc: Fix up corrupted PAXC root complex config registers
>>    PCI: iproc: Disable MSI parsing in certain PAXC blocks
>>    PCI: iproc: Reject unconfigured physical functions from PAXC
>>    PCI: iproc: Reduce inbound/outbound mapping print level
>>
>>   drivers/pci/host/pcie-iproc.c | 159 +++++++++++++++++++++++++++++++++++-------
>>   drivers/pci/host/pcie-iproc.h |   8 +++
>>   drivers/pci/quirks.c          |   3 +
>>   3 files changed, 144 insertions(+), 26 deletions(-)
> 
> Hi Ray,
> 
> apart from patch 1, that requires Bjorn's ACK, I would take the
> series (I will rewrite the logs), I would appreciate if the amount
> of HW quirks would decrease since it is becoming quite unwieldy to
> handle them, it is your code but please get the point across.
> 
> Lorenzo
> 

Okay, thanks Lorenzo. I will ping Bjorn for patch 1.

And yes, the amount of HW quirks is overwhelming. We do have a process 
internally to track each quirk and a plan to address them in the next 
revision of the silicon based on priority, but that's largely managed by 
our ASIC team. Bottom line is the next revision of the ASIC should 
require much less of these quirks though.

Thanks,

Ray
