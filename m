Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71388C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4FD20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p0F1xsXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4FD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeHaAfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:35:34 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51894 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeHaAfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:35:34 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so4381661itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ujeAzmi8b6yJWRH3mqe9FCYgkKu9Tx0M59wdLcOlHnQ=;
        b=p0F1xsXq0Xxzbzh1uN+urS5S/OASMSJ02Is3L7TvK9RaSEu5H06HUgvbWwKjG74B3N
         kgfYxkC8d/TLebXh+aZF8A7F2PRLbyC1cgO7cytOBUKaCADYdHLgpFVAFII8qcSMr1c0
         oKc0d4geTGMo/hsQDnJasCXlkgcj6D6Er3NF/C7YMq/Tyn8CSXML47nZ2n7OjWfYl+Mp
         NHRkdVFGZJL02JnYpzxnzgQQddSWBklqGUJJ3NrWS+DYUaSwJf/nkMRWKLmdYQxYkVX7
         XsmAup/k6hGBiL0gE15tvDG/Kb/B4swesriqbXOti9sxKZmVikBZ+vvjHjZxmzp1mOGR
         XNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ujeAzmi8b6yJWRH3mqe9FCYgkKu9Tx0M59wdLcOlHnQ=;
        b=OIJDbk+8OjsLum3dTqBp8R/W0Kk0F6j0NsXYgIQfusgfbi2lv8hoaBknKLqsB4U6dc
         oaSq1MDTFeHCSve70bnpjJIPJrAAvUKxthpehpSt2xuwukzn2fIXkNk7+x/nGpnTUeBP
         Vi3EdPZTreeCJrBkyKHRrQ8lu76sdXSEJeiqfJZEP7Tx2grWgzc95UYVaH4qfDPkJX+o
         iM+dXyboPoPN2U6cWZJ1af/mfVXFurT7a8rLAgpe52wU4zfajhgDPxr8LiDAmkh1QEta
         7kVYfbPvVEVey9jHMHfDOkdEao+5jqyTfpmmT5VcrFJMrkWSolMBUF8KhpGTcsbjG1ww
         /Efg==
X-Gm-Message-State: APzg51D8qSD+/f/BKoXfZfyNbAKkPZRCSJlpebBtan8izMwUeifyRfB3
        bMmiqEsxmOJ5amXcHVWjfFHrrw==
X-Google-Smtp-Source: ANB0VdZDA4YPFBnIAs0b725TBAduzBEqzgjryufUu9DYkwwq3BzPIKxYY3tmw08rdxcgJpAK3Kzavw==
X-Received: by 2002:a02:3d8f:: with SMTP id n137-v6mr10263709jan.99.1535661097274;
        Thu, 30 Aug 2018 13:31:37 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t187-v6sm1334608ita.28.2018.08.30.13.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:31:36 -0700 (PDT)
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, hdegoede@redhat.com,
        kishon@ti.com, mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
Date:   Thu, 30 Aug 2018 14:31:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 1:01 PM, Corentin Labbe wrote:
> Hello
> 
> This patchset add support for allwinner R40 AHCI controller.
> 
> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> by this serie, so no regression should come with it.
> 
> The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
> but will be resent for inclustion when all patchs will have hit linus
> tree.

Applied 1-12 with Hans's blessing, thanks Corentin.

-- 
Jens Axboe

