Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B62ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93A9208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1MC33We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93A9208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbeIYBAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:00:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36026 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbeIYBAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:00:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id p89-v6so3105963ljb.3;
        Mon, 24 Sep 2018 11:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0avHkINkq96G2zoDTZhrD+TPLODKfH52jQoiT+v1OVE=;
        b=s1MC33WeuxFkOdeT5Sep5Vts7/6Ftx76oeIS/rQNTuq2chmi4YjBpu92xcwE82jx4F
         Om7CpCIrE+K6ltF4qoB+uC5hzFGopWDS6tvQs0MfATCunSJUJJSYNOqKjWhYNhqh2B4R
         BiRXjwPw0sDCK+CVtzRvgBmY5nQpangMTsUTUzQSRmrY5yZqO4BqE05Np56EVoAaHfSc
         QJsyjkXrZceEyNYKvqN6pe2C06Opc5kW5TsFnl5/lB5NOZCg9wYbt77jTLYwKuu7P2MP
         /vpqEoR6sRNRgd19sgeMZEMiLNkMY4Q4ip+HfrVKxck+P+r6JA8vlgMLj0TfbLRdtwzp
         SXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0avHkINkq96G2zoDTZhrD+TPLODKfH52jQoiT+v1OVE=;
        b=i1gSibsyKGWVPkANClv+/iXcDTWkm/qlSAC2kpg16oVQjNTJ5WLR6Aut7CVqaXFJnw
         0UgzoEb0x/CckuGkZEl4aN1HE5MrpcCW7KsTvnhW3bqD26vDfsPxKO3fWKUAm1MwBURN
         AbzJ/DLyNQRU/ZRmrUqnr9somC9Zdj+dFfSeC8xONHT6Z1Pys4jZ6WcYb+FnUGOoz9zz
         3eNpFUu4x7irqTIGSfV7yAeegzn7yGpccwyozoDQkuxltL+Bd93XcXxwyGZGxM38msUc
         7UY/ImGbH+d5Osv3b7uXKfoKMUvXDgPCdKIe3lcJdzyR/EWU/ItBABkGICQl//9azDUf
         VODQ==
X-Gm-Message-State: ABuFfohauUcFhf+/jvHVAXY5Rf7+eODn8CgNoM0i4r42blzqb4HOgEdm
        2i3A+zODZNKT2FGeZI7qD9DZSd+a
X-Google-Smtp-Source: ACcGV61lRsZHWP9ZjsJRJ1qVt3HUqyuwwoNu1uv1a79MqZfCTg0XYDRndjq9jdAlfxlNMhkFooMRGw==
X-Received: by 2002:a2e:2d2:: with SMTP id y79-v6mr122055lje.100.1537815431803;
        Mon, 24 Sep 2018 11:57:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id f9-v6sm16584ljf.9.2018.09.24.11.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 11:57:11 -0700 (PDT)
Subject: Re: [PATCH v4 16/20] iommu/tegra: gart: Don't use managed resources
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-17-digetx@gmail.com> <20180924105246.GM21032@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a9e2943b-1139-8838-5440-bd6cf55e9a55@gmail.com>
Date:   Mon, 24 Sep 2018 21:57:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180924105246.GM21032@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 1:52 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:49AM +0300, Dmitry Osipenko wrote:
>> GART is a part of the Memory Controller driver that is always built-in,
>> hence there is no benefit from the use of managed resources.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-gart.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> One benefit would be cleanup on probe error. Also, we may eventually
> want to make even the memory controller driver buildable as a module.

Please, let's keep that patch as is and re-introduce devm once it will
become really relevant.
