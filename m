Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C3C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CF4217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC1jLszs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CF4217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeHDNx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:53:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43208 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeHDNx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:53:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id r13-v6so6965750ljg.10;
        Sat, 04 Aug 2018 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RI3Tu2O+l8H/RLnhOlOKwo0o27c+tF591SEVuGVNbnU=;
        b=lC1jLszsVR/J1ImZTJjvfJN+wRjFSTHY1QfTCjqn7VvG5OSmJlr8lGZQh7KzooaKDT
         NsNpp9t8oDu6jHLYbd1s/hVnjq8Gz3o86HCLm0c/iVREi0Djlx+6d8W66O6M6XY+GtER
         NzGBxuAln06EIOxqAdkV/TTLKd8ztvSfEK0OpHPVeOuWTrNKZ8z+X0e31qVzR78lQPtc
         +AHwxMCl484Z3Y6TYF3DOBT4fak9t51LFOHBitWeEmbc8O92eGhs56iiF0YpWefHTxsH
         HxGWf5c4DvRumoccD4107zZ4saPp1VI+aKJyWLhZAlvReAb+w/k01AxyBuwPAMAiIWBp
         WJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RI3Tu2O+l8H/RLnhOlOKwo0o27c+tF591SEVuGVNbnU=;
        b=cVPBkezsCDUV+95M6TrSuwJqcTzTbAoZo2GmsN3XHFloF2DODaLC3umFE6SXYLVZQk
         IkNGGpZTMIQ9n9zGWk+S6RWRNcXJl5GRgNwmNDtA6r+YGw7nmoSCJJa0z/537f8ndPqh
         9XxchGkRR3nFXdNBeNS0hfmjjYrW1DHdDlY3Swtm/ExqCOYtbbVr2XYMuzw65SIUJqEf
         UEY6g0Hs/D/Vfis60nQD24PW2GAq6W9mADTCKDF7rV2012QY1sTkfmYVgk36Dg6rEMH0
         tcHMEMqnrDUmWBZZqkxq4incaCFMPBom92j2HBAJfYgonDvVAfoX1Xe/Gxa55I9uAMtq
         s30Q==
X-Gm-Message-State: AOUpUlE9suauwuO4DFNFRMNtbjn6jE+9Jpu6OX8xhFodX3sbBl3gRBMN
        JuVOzS+hh4W5f6Jv+HBy4DY=
X-Google-Smtp-Source: AAOMgpdULcBiinDD5uh+b8vAtM9uM3LIwuszBGrlNr1QQgJrkH+emlOMSyjFjh6Ni1vFtZHU5xKuCg==
X-Received: by 2002:a2e:5f5b:: with SMTP id t88-v6mr8318724ljb.140.1533383608047;
        Sat, 04 Aug 2018 04:53:28 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id h9-v6sm1150476lfc.47.2018.08.04.04.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 04:53:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] memory: tegra: Block DMA for clients HW on a faulty memory access
Date:   Sat, 04 Aug 2018 14:53:19 +0300
Message-ID: <2607799.I2xByD6lqT@dimapc>
In-Reply-To: <20180508165841.13758-1-digetx@gmail.com>
References: <20180508165841.13758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 8 May 2018 19:58:41 MSK Dmitry Osipenko wrote:
> Currently Memory Controller informs about erroneous memory accesses done
> by memory clients and that's it. Let's make it to block whole HW unit
> that corresponds to the misbehaving memory client in order to try to avoid
> memory corruptions and to stop deliberate attempts of manipulation by a
> misbehaving client.

Guys, any comments? That is a kinda useful feature, in worst case only some of 
memory could get corrupted instead of trashing the whole memory. In my 
experience with T20/30, the interrupt handling latency is low and blocking 
happens immediately after the first page fault.



