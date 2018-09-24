Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CEEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9530206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmnpDLIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9530206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbeIYA0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:26:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44038 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbeIYA0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:26:30 -0400
Received: by mail-lf1-f66.google.com with SMTP id g24-v6so17562679lfb.11;
        Mon, 24 Sep 2018 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KD8DooARnojKOLhBAkc50A3LWgt00nlc2+VZuH3Z1oQ=;
        b=OmnpDLIiz+fMi7eIPCGmV5rlCQ2argWqj9++6jzPESvvD1NBUzaZ6cAQDvs6YoYx5W
         laf5TMFG61DMQRBUQVQhT5iSfLOiSI0ZemPejMg+4tasyZGkszvMF/xAiQsHA5s0Cn24
         4Kt5w249s3eEd6FS73xIL+qteasW15P2SX2fcFtVt2ln5WH4q/O7BnZPlDWMF/Ln6qsc
         m85cqZX7b/ALQP05/5tUWL7z6tbP1eapqVFYu9whN9tIwejsnYLMEV5SAMPbtJjmpP9M
         fsE56aeLdz6+SjRB2EfmnaKl8czzVXa8PYYIN20PiOVF0o/kkRxr3TY4WrWlfSfEL0/R
         mVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KD8DooARnojKOLhBAkc50A3LWgt00nlc2+VZuH3Z1oQ=;
        b=PX6QR8iBn9AFzWhvfy58EcqqUrbCLjXe7Ly74/AEUHX16LwqsvQZPDToZrZO5KiHTk
         P+5asl7obDZ9AHBamicYsU6LMHC4YhJ2y7RIJ3NMULsmVuQpGljh76/tmzBU6v8c7Tub
         WswtmwrXLbO+W+0iC5KPkRXGfHjdz65Yl2LrKR0UDRdpvOd9cq4AI6SSMyMmcpp3mMkN
         +5bouK3UVTshPnZHGWhZcT0AFMv38xDQgPAAKpxeg1kjjfrOx3a4iqLY1SAk3kDHdBw5
         eIPqn9zVuCf5v7xgFMYy3gNShb2JMPD8z5AFY8S3RoFVKTVbp82+389O+VFvNHW+sI8a
         CWsQ==
X-Gm-Message-State: ABuFfogfJOmeSWDKPRn864AJGYxXqtW7H7kRl0aQz207JfuKWQvtBYoM
        tRriYaKRT6kB2GUR7FVlc8qeZexP
X-Google-Smtp-Source: ACcGV638YmW0noQs9ycvNKS9LEm7PPCSPpa2UeKANJaVGtGLo4u8Sf+Q/COc3iMCizDPzXUQyOZQgg==
X-Received: by 2002:a19:f50e:: with SMTP id j14-v6mr38356lfb.13.1537813380675;
        Mon, 24 Sep 2018 11:23:00 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id v85-v6sm5901lfa.18.2018.09.24.11.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 11:22:59 -0700 (PDT)
Subject: Re: [PATCH v4 12/20] iommu/tegra: gart: Integrate with Memory
 Controller driver
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-13-digetx@gmail.com> <20180924102322.GI21032@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b2d283fc-ff52-3166-cd70-42f9cba93948@gmail.com>
Date:   Mon, 24 Sep 2018 21:22:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180924102322.GI21032@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 1:23 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:45AM +0300, Dmitry Osipenko wrote:
>> The device-tree binding has been changed. There is no separate GART device
>> anymore, it is squashed into the Memory Controller. Integrate GART module
>> with the MC in a way it is done for the SMMU of Tegra30+.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/Kconfig      |  1 +
>>  drivers/iommu/tegra-gart.c | 98 ++++++++++----------------------------
>>  drivers/memory/tegra/mc.c  | 41 ++++++++++++++++
>>  include/soc/tegra/mc.h     | 27 +++++++++++
>>  4 files changed, 93 insertions(+), 74 deletions(-)
> 
> I think this could technically have been two patches, but since they'd
> have a compile-time dependency either way they need to be applied in the
> correct order, so some coordination between IOMMU and Tegra trees is
> going to have to happen anyway and might as well just stick this into a
> single patch.

I assume that Joerg will take the whole series once it's ready (no?),
hence your ACK will be needed here and in other patches.
