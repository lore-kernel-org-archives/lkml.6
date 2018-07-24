Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4285EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E381020844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="UqbhDM5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E381020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbeGXEoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:44:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41872 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388130AbeGXEop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:44:45 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so2839116qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=DrbTyXy1O78Cpgpso8MkdBnIbR7lqRMcVlE+5Mfl7lw=;
        b=UqbhDM5Twc4PbzCYsNo70TghfE34QGkYDU6lFXspDkoullbKKEMC7/jsTCX++w4yD8
         aWlpWQ4z5k8yJhRLJpBHVcqguNcqO7rG7CawCqXNlWEZc6d4f224xE10uIjCca9/JODN
         OcCNHaAaXmVLOwSxhas6GC1A60CLWKhosp/DIxuskaQTODzFjuocdGnqhTsS4Pnm7e6O
         uQ1GdYJmdOS9C7qfgnIhAFEJhN8+nzqFUTV9usdyiLux/F8mZhAmzy6rMTdyJ+Vx0ia0
         Jw7+FqiJ38XLyHu1YMPr4n4LMr3HkzFzKDiRGT9CZ3uhNIxiTtnnq81PegEWOoIWTNYh
         YClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=DrbTyXy1O78Cpgpso8MkdBnIbR7lqRMcVlE+5Mfl7lw=;
        b=h1FC61fLawFF2TwzN3vDH5aQ7/ehaz2y7uUVyep7cpaHBidTZXi0d8Mu8Fw0ly3eq7
         aFKFoBUwShTK3xQZ7ITTVMxbu50HUe550TVQY23Enp7+rNmOos7posiACw2m4jHqIrcr
         ggKXuZFsSMiEAoVS4WvLDOQu4mnMf9eYvERwl9S65FRqeJsqK0vjCjq2cUpScWuYIC7J
         UDVHFJnPF9jH2GOIOMib0kpJ+NQxOOXlyiubko1zr4m3GNZjpJeqQ6qcc12nIyZ4cZec
         MeJ3REDoMmlYCPM2bC5YpN4GMMw8a007ty0TOu6if9p8cYo0fYp/8xtLQ1wy3/Qz+iDr
         YetA==
X-Gm-Message-State: AOUpUlEXzUE3nnd7IYTnKO8DAI7dgl6j28BKCcJ47qA3qceodntPR/To
        IXPuV6mstJmoUqA8SHtdJ9CxbQ==
X-Google-Smtp-Source: AAOMgpdtc23GpWQxoL1fDD5srnqfVN2poIzQ9yFx1oW/WlAP/V5dcaouCOJ2wj9IdZIUFflKRVeLmg==
X-Received: by 2002:aed:36a9:: with SMTP id f38-v6mr15252947qtb.64.1532403623702;
        Mon, 23 Jul 2018 20:40:23 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d12-v6sm6955085qtp.6.2018.07.23.20.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 20:40:23 -0700 (PDT)
Date:   Mon, 23 Jul 2018 20:40:19 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <quentin.monnet@netronome.com>, <bhole_prashant_q7@lab.ntt.co.jp>,
        <osk@fb.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <davem@davemloft.net>
Subject: Re: [PATCH bpf-next] bpf: btf: fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20180723204019.5cb5e753@cakuba.netronome.com>
In-Reply-To: <20180724025524.22012-1-yuehaibing@huawei.com>
References: <20180724025524.22012-1-yuehaibing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 10:55:24 +0800, YueHaibing wrote:
> Fix inconsistent IS_ERR and PTR_ERR in get_btf,
> the proper pointer to be passed as argument is '*btf'
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 2d3feca8c44f ("bpf: btf: print map dump and lookup with btf info")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

FWIW:

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
