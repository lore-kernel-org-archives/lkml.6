Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBEBC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30D92082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iacFUCcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30D92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeLKNYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:24:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38040 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKNYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:24:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so12944687lja.5;
        Tue, 11 Dec 2018 05:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lu3D8Kt3wCaVZ6PwrC0Lj6Q5yOWn+ze8vYjEU/P/bec=;
        b=iacFUCcMlaW/sb/uhWG4Q+9hdF87CbytUNOzJRn0FbJMF5q9Rl3HiBygdD4g2ZtusQ
         aT3dAOfMNWie/87W5eDU36vJ+5YYb51OKqG1B68dT/BJcnU4HZEhxhBhBGprgtrN0Juq
         5xqYu4gh/Bmpzm3OTgNhPvcAYo9Ti75uCeyHPE6p8+dQbUQtXwowlGrfjASzfZpVdB3U
         twMIryuWdpulK5En09MUzvt10R3KyIVpqd/1fMMIut/Bib4LXP2N25hfVJj143nxsOAo
         gOtf1JMQ7B82XEzc8a/kePr79ub/uirYEb8hd54pW316rdvDqR0Sg8KAsTaFXLz4jkKu
         QQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lu3D8Kt3wCaVZ6PwrC0Lj6Q5yOWn+ze8vYjEU/P/bec=;
        b=gsw4kfh/LmGARb705uNTImp+K10s8LJdpH613jHqHrDwdsh8UTqcu1CNNcOBYamxwa
         wkvYw2S8wFjykvsXXU1/9Rxc4TM4BsdYv2Fv6JQW0pStTXb7rtW0WGOCHquDJN8u3x6z
         8/8tWL+swN0MyM/qfrDO7UwUGkP+98zWVu+HKTZWtQyk4sI48lSRxKVEPloLKrpeq6cx
         2vyRR49BeLRr9LdSNCav8PF8G7f2OzXqr1JKUUOrUEaJ/ak1TbjsIj8kxuQR1iyX6poe
         7dZBXqwkGcE98DyFtU7pJhhMysx6qFkTQuSKVgxXG6sPb0iC1Gs7+YWgCiewnl+sZczi
         6rBw==
X-Gm-Message-State: AA+aEWYqEkfofNvp4HztXX8o8d2oCxE7zXcOQfhWvsIPn1dyZXK72ift
        D/gSyyR8jK39zWZaDcsF8afysU+p
X-Google-Smtp-Source: AFSGD/WeL4I5xLRCJvuIOvm7W5OLbIlzCW88D+Ng0JNT1xIkks5b5PQ9T/HFhiqxX+fDOBCZ5JI6LQ==
X-Received: by 2002:a2e:9256:: with SMTP id v22-v6mr10881284ljg.178.1544534651676;
        Tue, 11 Dec 2018 05:24:11 -0800 (PST)
Received: from [192.168.2.145] ([94.29.36.169])
        by smtp.googlemail.com with ESMTPSA id o5-v6sm2685410ljh.75.2018.12.11.05.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 05:24:10 -0800 (PST)
Subject: Re: [PATCH v6 00/21] IOMMU: Tegra GART driver clean up and
 optimization
To:     Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181211095317.tv43aaefnsezmic7@8bytes.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0eb25577-cd64-11d5-1de6-8efa129b3b7b@gmail.com>
Date:   Tue, 11 Dec 2018 16:22:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181211095317.tv43aaefnsezmic7@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.2018 12:53, Joerg Roedel wrote:
> On Sun, Dec 09, 2018 at 11:29:29PM +0300, Dmitry Osipenko wrote:
>> Dmitry Osipenko (21):
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
>>   iommu/tegra: gart: Fix spinlock recursion
>>   iommu/tegra: gart: Fix NULL pointer dereference
>>   iommu/tegra: gart: Allow only one active domain at a time
>>   iommu/tegra: gart: Don't use managed resources
>>   iommu/tegra: gart: Prepend error/debug messages with "gart:"
>>   iommu/tegra: gart: Don't detach devices from inactive domains
>>   iommu/tegra: gart: Simplify clients-tracking code
>>   iommu/tegra: gart: Perform code refactoring
> 
> This is making progress, but some parts have no Ack or Review yet, I'll
> wait for Thierry before applying these patches into the iommu tree.

Okay, waiting.. zZZ :) Pretty much all of the patches are actually reviewed, those that are missing review/ack tags just have changes that were requested in a review comments to the previous version of the series. I hope it won't take much time to finalize the review of the patches.

Thierry, could you please acknowledge that you'll come back to these patches? More than two months passed since the last time you were replying regarding this series.
