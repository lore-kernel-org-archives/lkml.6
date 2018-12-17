Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B7A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AITLjvR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeLQMXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:23:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45816 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeLQMXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:23:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so10757722ljd.12;
        Mon, 17 Dec 2018 04:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fUrlHTpxadkpXLYTNzNbqxKrXN87fDDdi8vBAnzV0Uk=;
        b=AITLjvR4FGxNy6+fviwKkGMZ6IhrD/XTuogyRzd3Jl1jCCmbg5LT8ZQRiPjeOHr3xh
         xYUMMpEValCw+H3o9hFHSalu2J273ObSb1eAMqjvOG58W1BlsJXlgsmQQ/c+ePNknup+
         6U7+IYGe79znggLD9NEc+CrZSONikvo+2L+g0BhgOOK7w8LVOkAA71Ue+i2r1vN4Ppw5
         VAwZcRvD62PGPy+I0t7RGyNL0Ib3OWs+BK9XwEEljHah3pDFl2gITmjTtUsx1091hOiZ
         Kg6RB0Ed0/B17UAjf+DwKTFL2siXkGKDVn0HrZNRPXdA0cKa+HBAW9rvQg6IKMtrGham
         q61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fUrlHTpxadkpXLYTNzNbqxKrXN87fDDdi8vBAnzV0Uk=;
        b=bx/h8IHSlFxamXyEollJKmqF7gxCEWIcf8qUAUAOU3AscAQx/mj8XarIWIk4TXevat
         CKg+xup9Q/cqnNUgOfAT/DT/O0J8KOGNi4tIDJ8kz/Tysw0GI9Fi0Th3jfvWouDVoBEm
         wGlKojgXgHNc829n0C67CrxNzQKOT9R4fgdWCHYFh2gWlHBn+mhtEoTwSgF4hyQK+4rS
         AnR6jWXqV4j0gv1CVyAyzFRSpKu9yPlsl3DrqTVTOJ0mRDkXLd0HcgK7GxwlS1UtHxwq
         V3n218rCrZh4RfyQ7QXdPmbKuaHhLx/zxueEQG1XFLFj8Zpu5XXYUhbBYG2c5FmFXjKp
         vctA==
X-Gm-Message-State: AA+aEWZxvEt/M7CFTPYC3dOgYiDbfrW+2jnu+M1LNYO+4Ct1CFvQ4yoP
        g7pmuAhEBIeMPJkjuMA9WEF6zHXp
X-Google-Smtp-Source: AFSGD/WS4qetUdKH37uo763VZ36cQrc56QbrlenZwEGeP8cmCTfh/7WrBsGLANLea56piJVTGXAeLQ==
X-Received: by 2002:a2e:3218:: with SMTP id y24-v6mr8093826ljy.157.1545049377309;
        Mon, 17 Dec 2018 04:22:57 -0800 (PST)
Received: from [192.168.2.145] ([94.29.36.169])
        by smtp.googlemail.com with ESMTPSA id y9sm2618145lfe.75.2018.12.17.04.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 04:22:56 -0800 (PST)
Subject: Re: [PATCH v7 00/24] Tegra GART driver clean up and optimization
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181212203907.23461-1-digetx@gmail.com>
 <20181217091455.kkxpyojp4r4fyhrw@8bytes.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <75ffa70b-b0f3-0feb-c1ea-94a805a7bd0c@gmail.com>
Date:   Mon, 17 Dec 2018 15:22:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181217091455.kkxpyojp4r4fyhrw@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.2018 12:14, Joerg Roedel wrote:
> On Wed, Dec 12, 2018 at 11:38:43PM +0300, Dmitry Osipenko wrote:
>> Dmitry Osipenko (24):
>>   iommu/tegra: gart: Remove pr_fmt and clean up includes
>>   iommu/tegra: gart: Clean up driver probe errors handling
>>   iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
>>   iommu: Introduce iotlb_sync_map callback
>>   iommu/tegra: gart: Optimize mapping / unmapping performance
>>   dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
>>   ARM: dts: tegra20: Update Memory Controller node to the new binding
>>   memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
>>     Tegra20
>>   memory: tegra: Adapt to Tegra20 device-tree binding changes
>>   memory: tegra: Read client ID on GART page fault
>>   memory: tegra: Use of_device_get_match_data()
>>   memory: tegra: Use relaxed versions of readl/writel
>>   iommu/tegra: gart: Integrate with Memory Controller driver
>>   memory: tegra: Do not try to probe SMMU on Tegra20
>>   memory: tegra: Do not ask for IRQ sharing
>>   memory: tegra: Clean up error messages
>>   iommu/tegra: gart: Fix spinlock recursion
>>   iommu/tegra: gart: Fix NULL pointer dereference
>>   iommu/tegra: gart: Allow only one active domain at a time
>>   iommu/tegra: gart: Don't use managed resources
>>   iommu/tegra: gart: Prepend error/debug messages with "gart:"
>>   iommu/tegra: gart: Don't detach devices from inactive domains
>>   iommu/tegra: gart: Simplify clients-tracking code
>>   iommu/tegra: gart: Perform code refactoring
> 
> Applied, thanks.
> 

Awesome, thanks!
