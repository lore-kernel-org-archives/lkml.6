Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804E1C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A30020836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cLnyjCrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A30020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933139AbeFTR0g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:26:36 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41021 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932383AbeFTR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:26:32 -0400
Received: by mail-qt0-f196.google.com with SMTP id y20-v6so317096qto.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kYfLnkCWneAK5Gsze6Sy8nWMdGaPX0qM1JSJpCgujWE=;
        b=cLnyjCrFulMdhPgCWF73fhhyGYu5Y/afcZYs1fCWKPO99w5LSUNS5FQSx3fxX/2ndv
         EI2DPrAW8tmPbc+b3CTLL7+UFpoYoojyM0/bLhiPQ41OHCL1b3GApg2RYcI5XOmCgHVq
         UpyTpdm7GYnCv77qxynAZQxuaD17Qf6r53hTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kYfLnkCWneAK5Gsze6Sy8nWMdGaPX0qM1JSJpCgujWE=;
        b=Pod57t8Bh0dx57EsMM3djFt/+8z+Zq4sHMpVi+c1qUWxJL3beff81oQu6ewClO7Ram
         dyo+trbpe6STOrzgYJy/ckJYB+/RU3WGxSvL3BeFvz+HlA25uObhn81Y9umdz35lx84Q
         Yf7cKQa7fbW1LRMOOuLVDvnDnIQRgCrAiVrcbGmAqbljkFsHwMUB/NlMjXMI6gTKLvEb
         DqGMdCLzuSy1do2cgrd820zd3MlyMQcrMyux10/Ar2Ej3VRPIj14rk453rVJkhEFhBX/
         0XgFbo11ckwnmHvVe8TcLrDhQX9acw04trA9xKazFvwnFzKjCQXbAcPdOAbpRA7ILKWO
         NdFA==
X-Gm-Message-State: APt69E2/JlD1i+Mlox/78IUhFlWeI3EQTkKFQ/4Pn74ccVcSPEg35u2M
        LhMKZRjXPkfF8WDNeeYiNXPrjg==
X-Google-Smtp-Source: ADUXVKJS1e6Hen4P594ZmDC029WZADDQg5QU3aWwTYmftlusnFvW0RToCjSEj3hVsl3PsnkAEVJPCQ==
X-Received: by 2002:ac8:5357:: with SMTP id d23-v6mr20163898qto.141.1529515592013;
        Wed, 20 Jun 2018 10:26:32 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j28-v6sm2291289qtk.56.2018.06.20.10.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:26:30 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Improve Broadcom PAXC support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <45945371-3cd7-102d-bb47-69a60435542b@broadcom.com>
Date:   Wed, 20 Jun 2018 10:26:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo/Bjorn,

Could you please help to review this patch series when you have time?

I believe I have addressed major comment in v1 from Bjorn and answered 
all questions from Lorenzo.

Thanks,

Ray

On 6/11/2018 5:21 PM, Ray Jui wrote:
> This patch series improves the Broadcom PAXC support by 1) adding more
> quirks for specific versions of PAXC controllers; 2) adding logic to
> reject internally unconfigured physical functions from the embedded
> network processor acting as endpoint; 3) reducing verbose print level
> in the outbound/inbound mapping code
> 
> This patch series is based off v4.17 and is available on GIHUB:
> repo: https://github.com/Broadcom/arm64-linux.git
> branch: sr-paxc-v2
> 
> Changes since v1:
>   - consolidate 2 PAXC related patch series into 1
>   - change the way how the capability list corruption is handled, per
> recommendation from Bjorn. Now handle and fix up the corruption at
> the config register read
>   - rebase to v4.17
> 
> Ray Jui (5):
>    PCI: iproc: Activate PAXC bridge quirk for more devices
>    PCI: iproc: Fix up corrupted PAXC root complex config registers
>    PCI: iproc: Disable MSI parsing in certain PAXC blocks
>    PCI: iproc: Reject unconfigured physical functions from PAXC
>    PCI: iproc: Reduce inbound/outbound mapping print level
> 
>   drivers/pci/host/pcie-iproc.c | 159 +++++++++++++++++++++++++++++++++++-------
>   drivers/pci/host/pcie-iproc.h |   8 +++
>   drivers/pci/quirks.c          |   3 +
>   3 files changed, 144 insertions(+), 26 deletions(-)
> 
