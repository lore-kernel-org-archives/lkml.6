Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31A9C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D0F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXgx/cGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D0F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJOUTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:19:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42825 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbeJOUTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:19:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id s10-v6so13924682lfc.9;
        Mon, 15 Oct 2018 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cDokWh4eWbmscoIJMker+3lDr0M5JPw69rvKyE2pAe8=;
        b=rXgx/cGasReYZu6O7UJbhBfOF0ymyAq+sqcBTPpWEVHBdpE6ckBHFeVxFS9MS7Znf/
         jkfBGRxaV92l+gl04zMqEILBfhAwwi0kFb0ouYLwEyoWoQv3HTzGnRvIgfx4nc0wLFBV
         IiycHN5+7yb8kCLKQYorBOWWWD9vtB9pjPYppAPbY3aI39VvtScr4zPZJNitChMJ3wsH
         LUKoTsaSAT+D8742gi0BCA0WLrq1tVMGO30LyBnODujsuQFKkKNBekc+pyc6R4c9qgt7
         t3nZNNHINSPWhzdauqSVqmP5EB2i0uxx+aLyTOdZAg8eAkhdGG9dG39QjeGf0ufu+8Gr
         H8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cDokWh4eWbmscoIJMker+3lDr0M5JPw69rvKyE2pAe8=;
        b=dhleirVz5y+PKR8gk0A5AOyEQUhZiZlroFA2vv906mECHwoiohX5O71Zu6p4irICa8
         V3Q3mcOK0BTGZ/otWvaJhScxUkIWtN5yT76XcE+FIl1/arFEQFWRBP5H+kOj91nZXvty
         klnlFqCGHr+64KGI5aZAxYhBylGZRtPa7R/nJvI31XVa8nwj5HO8FlD+1xN+b3nqtiTG
         6TM8RC1ZXtBDjqzX+2rNSj5wGmWtcgs1UMTMkDXOriVEqYq+SkKgKhACHZ/JnOKBilJ3
         7OmlH3R/lALPpHNd2ratgV88QONJMQIs1bZymunU9ocSsL+6onMleyaRku1u+SJOHEBT
         LpIw==
X-Gm-Message-State: ABuFfoip8BDffcQSR4HYbBeXkBqKbLtSFfVSqkPibOgiGi50fn2S2wT7
        KSox+Dg2ko6TJllK/jE4BYgwuMn+
X-Google-Smtp-Source: ACcGV60zk42yrGvCIwNuoJhMBCB43g1TsuHpDwIbdjaIX+4DNWVETJNeadXEk9XatXd+/wGON9WCeQ==
X-Received: by 2002:a19:a90f:: with SMTP id s15-v6mr9521650lfe.154.1539606864067;
        Mon, 15 Oct 2018 05:34:24 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id s11-v6sm2395840ljj.93.2018.10.15.05.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 05:34:22 -0700 (PDT)
Subject: Re: [PATCH v1 0/4] EMC fixes for Tegra30+
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830185404.7224-1-digetx@gmail.com>
Message-ID: <ba166fc6-839e-017a-a7b9-057b5c4e1d3a@gmail.com>
Date:   Mon, 15 Oct 2018 15:34:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180830185404.7224-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 9:54 PM, Dmitry Osipenko wrote:
> Hello,
> 
> This patch series fixes couple bugs in the memory self-refresh code.
> The EMC / MC state is properly restored after patches being applied,
> please review.
> 
> Dmitry Osipenko (4):
>   ARM: tegra: Fix missed EMC registers latching on resume from LP1 on
>     Tegra30+
>   ARM: tegra: Fix DRAM refresh-interval clobbering on resume from LP1 on
>     Tegra30
>   ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+
>   ARM: tegra: Clear EMC interrupts on resume from LP1 on Tegra30+
> 
>  arch/arm/mach-tegra/iomap.h         |  9 ++++++++
>  arch/arm/mach-tegra/sleep-tegra30.S | 32 +++++++++++++++++++++++++++--
>  2 files changed, 39 insertions(+), 2 deletions(-)
> 

ping
