Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A393C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B03420657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnhhOhhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbfAOQd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:33:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44821 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbfAOQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:33:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so2847775lji.11;
        Tue, 15 Jan 2019 08:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z6KiZ2EpfpnGBFM86KOJj/R+dT19TUJvuAqukHU3kJ4=;
        b=tnhhOhhwgTx06gQFqAro2Rvg57LeoUxqrPqVfwuxFSaABoaPZAdH5KvBzfVP/9/kyc
         TImpb9dveEdzAL06b6+bB3NH3psAzjEL3Gy1kkjogQw3srf6upURUAM9aPxNZCeWFVWi
         YIfoQp7F36DgaNnfycBc6M1fkN45TUam3hr9kjp7Lqt7oPj42bc0yH/DsicS+QTDFcxN
         CpH7a3WmwwOc51rq24l/OmuGLH1ERnofyvM2TnbJyGZz5/0IliMFDWLa85jNdQQrUSXu
         mCBkbVjilaAfjbIPAZ8+7IsC6n6FpeSP+ItjYbZPt7hb43NA3/DQHH2nr+MJ2dfjRN3Z
         WBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z6KiZ2EpfpnGBFM86KOJj/R+dT19TUJvuAqukHU3kJ4=;
        b=oi16qBTedn8+YI1AQ/+0rT5YARr/HoxDMoZ72C24kHuNb4ovF+0IYJD/VjJdwT/7hX
         L9bI0IMc3JZYOvj5Nh/MGfS+6IJLfKG3bIxCFNLjxfuXBesOmqZrStkJ2vhMjqFQKdss
         8+ljOk9kQQ0901U30aGMid1ysVPQ6VHsp+nYTfTImRLCXrXfurL+oLqCoW9Rc+aWZKsM
         Qx/Q8iBGLHflPVBT+ciKRtK2RPKVMBa4aUgHW9C9A4BEnDnP5docnlYJXPrj4dYnhIw9
         o7XgF/t84o05gxKkuuJTpsawUtLMUWVHI2gf/Nl3pknw8M0CVdkslD91q7ffDpcztzy3
         UkLQ==
X-Gm-Message-State: AJcUukfoDBEKQ+5AlGX+esK8UEAWdlYRXUi2Mj7yq7FFrpOzyt2xpzIi
        7ewp1Za0RKd0MsjFlo+HsXxwLPbs
X-Google-Smtp-Source: ALg8bN55UoE5XTiK/PF28ek0sxoA5iYaOHBSPtlaBSE3s+wD1BS2FTe0OW4KtkYmsZ/k/+2uhEbXyw==
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr3315558lji.145.1547570036177;
        Tue, 15 Jan 2019 08:33:56 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-58-198.pppoe.mtu-net.ru. [91.76.58.198])
        by smtp.googlemail.com with ESMTPSA id f8sm715018lfb.2.2019.01.15.08.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 08:33:55 -0800 (PST)
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
Message-ID: <bbefe330-d3e8-3eea-0f9e-a2b0b7915120@gmail.com>
Date:   Tue, 15 Jan 2019 19:33:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181217091455.kkxpyojp4r4fyhrw@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2018 12:14, Joerg Roedel пишет:
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

Hello Joerg,

Should I expect that the patches will appear in the IOMMU git and in -next consequently? Please let me know if there is any problem with the applying of the patches.
