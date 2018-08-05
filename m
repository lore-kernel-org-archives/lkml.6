Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1165C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AC0217C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHi3jhWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AC0217C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeHECkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:40:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38642 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeHECkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:40:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so7829875ljc.5;
        Sat, 04 Aug 2018 17:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c82ln70mP1NzdVbMkzTg4/+6iy9DXi/uAWsQ30Cg/WM=;
        b=sHi3jhWSOY92fu30VRk+bV6mHfonPYXSbQzTdTF6yxUjve9k2Crjki7xhOWHfyBi8+
         xmvZcWw6X1IkLsSQTdt42pn4ELumvUqLzMfAsKRSsm1xEVFMDWFHff6eijYGbVN9zAZi
         TPYS59dwvMp5OfTiDa4avgLS7E1+IqWMgTS+gtzWYW8swXZKLreSGnFurWkuv8ejwyMe
         pPz1keq5Tq6F5348Axsc0dOhGvsWIDq4arEiwKbQ0dGzA6Jd4F4QJKvDHY/R7ct1Cw1m
         lMf9rTO5ktaTaYDWS65JbKD3i9CDNtLNBkzz5y6BYeqkhCZL8nmcIiN9Un+pNE0MhQ5A
         N9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c82ln70mP1NzdVbMkzTg4/+6iy9DXi/uAWsQ30Cg/WM=;
        b=rKe7DqTvPVJxDx4bmwh6u3nmqr8dKjFXnTMf75uUAybx9TvVDFlv16PJtAjC/yYmI6
         9+Vj6Qy+jbu3YmOCrDe/2KoXyxPXKhATmnOUyE2dUtj+WvApeNXHzFNd+1/ps1dl07sl
         nKcfVgaTQNBw1yoonTbgSQIIptSk4jpEoXVi8P78n689af1/1ALLisbaaidGJ5KEa7u6
         +TN5B7ZPfDQYUCLmDI0dacGsSnoGEtUVu1QFBkc1xmohvhPF4q9YdILd8iL48WRtvHmn
         IScl3U8PzxnjjaC0e6YS1tZUf4hvHy1kOPZ8ON+VxanWWfztdx18Pw+v0mFzwBWa6xrN
         UNdw==
X-Gm-Message-State: AOUpUlGfMs59S272BQulJP51Lvszl4BVx3VrKZJHLX1w6QZwdSLn8J5B
        d6WgtZrgb3L6w1oGucZSpaw=
X-Google-Smtp-Source: AAOMgpfhk+6C8xrZAZuolAI8Blv73hxNgIDxel/Pw+hRa6UD1f4Lc9J3W8KdMKRaZnpnrwIFp1vmnA==
X-Received: by 2002:a2e:9e17:: with SMTP id e23-v6mr8629524ljk.14.1533429447938;
        Sat, 04 Aug 2018 17:37:27 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id k5-v6sm1531815ljk.69.2018.08.04.17.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 17:37:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] memory: tegra: Block DMA for clients HW on a faulty memory access
Date:   Sun, 05 Aug 2018 03:37:26 +0300
Message-ID: <1797693.ge5mZLuUEu@dimapc>
In-Reply-To: <89f0794e-affa-dba0-9684-582ce5570cad@kapsi.fi>
References: <20180508165841.13758-1-digetx@gmail.com> <2607799.I2xByD6lqT@dimapc> <89f0794e-affa-dba0-9684-582ce5570cad@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 5 August 2018 03:11:57 MSK Mikko Perttunen wrote:
> One potential issue is with host1x clients where userspace processes can
> submit jobs with invalid memory accesses (addresses not mapped to
> IOMMU). If when such a failure happens, we disable the DMA for the whole
> host1x client, unrelated userspace processes may see failures even
> though there is no problem with their jobs.

Good point, I'll take a look at partial resurrection of patch [0]. Anyway I 
think it's still better to fail even the unrelated jobs, rather than to have 
corrupted memory.

[0] https://github.com/grate-driver/linux/commit/
c0351a9d01491af2b2fefc162de1c2e4fcfaa94c#diff-20226be476307cb7ec9f60e26a9c30deR378


