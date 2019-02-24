Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EFDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCC320842
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+kxbHIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfBXPb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:31:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43184 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBXPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:31:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id j1so5011726lfb.10;
        Sun, 24 Feb 2019 07:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9DGra/qT9nwHaAta+jcIg0J8byqiadRpEruQD2xKnLE=;
        b=n+kxbHIjtSK1CTtxXyeB/wFygRjoQexO0VKXVIRCjfIoaOIOt1+Y2zOBcHe4iRvOIt
         JGJdPNt4NGMwW75NVfgRMTEnNgvxxMUmD+5ZQixoY86lv6PdFK5yu4cjYSEdH8XFlSwZ
         46E7YcDdB3x0zySRTOBXFDtoVNlbxIZkyM2GjCUDpKLQT/qDP8ZgVVAzRLmBLIcYJy1g
         V3uOhBrrlpY4BvHBxYwms22LoV7pktZEb5th3RK8eDs2KjjOFILWY6ibeJuEhPBpBoaB
         zCOAMQeaWt7oxHTklV7KjEe2VTAexy2oihlT2pTMwx5QPYCcHQD0+Muh8anKpTFpx7UE
         qxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9DGra/qT9nwHaAta+jcIg0J8byqiadRpEruQD2xKnLE=;
        b=CrzYoysgJUL40BqFRFc8ESBvua2cNIJvU5NvMmApd+LcDk4BU+HyKHujrZfT1mnsxS
         VHEujipI1mwzEf9JLXyupl1DEnhtfLweIpZi5zuUnl0UQu2hZPmcOzH9P5GcyZNJ3/q0
         3qUxIR/vb+pN24fPOKawgC4w40HirvMTS1Oyd59ddevHqZcub84lf8VJge9kHaizdCp9
         /Zma565Uc+LJwjRZCgH0GjfR2c8xVen4pCbazdQyUJY48ZETSWWIO+1tgPP4Soi5XabO
         Ayb/83srfVGPR9u/p9FcPn07H8IBMht2SvkVeLNs9sbsXuzvTZDfPsjC1z3y2/eYUDwL
         HSVw==
X-Gm-Message-State: AHQUAuaJKW2GHUr+haYS/PGyciWHR1W2isEWa+TKKzOJUS2YTb9DGU71
        ALOKFXZMaWYNqCpVHvnz7e6yuNDb
X-Google-Smtp-Source: AHgI3IYmIM+/nMEIZwZ27Kh9xkaMuHCc42VwHs/1MsO4ryZIu3/IDhnfcmgppJQgwnHdp9ILkrY9CQ==
X-Received: by 2002:ac2:43c3:: with SMTP id u3mr7906185lfl.114.1551022313108;
        Sun, 24 Feb 2019 07:31:53 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id o17sm2169057lfd.21.2019.02.24.07.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 07:31:52 -0800 (PST)
Subject: Re: [PATCH v1] ARM: tegra: cpuidle: Handle tick broadcasting within
 cpuidle core on Tegra20/30
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190224152740.7305-1-digetx@gmail.com>
Message-ID: <7b706843-a2e1-18bf-bad0-987016fc504e@gmail.com>
Date:   Sun, 24 Feb 2019 18:31:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190224152740.7305-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.02.2019 18:27, Dmitry Osipenko пишет:
> Tegra20/30 drivers do not handle the tick_broadcast_enter() error which
> potentially could happen when CPU timer isn't permitted to be stopped.
> Let's just move out the broadcasting to the CPUIDLE core by setting the
> respective flag in the Tegra20/30 drivers. This patch doesn't fix any
> problem because currently tick_broadcast_enter() could fail only on
> ARM64, so consider this change as a minor cleanup.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Woops, this is not a clk-related patch.. please ignore this email. Will fix it in a moment.
