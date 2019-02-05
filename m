Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93FAC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84692083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8rFXq1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfBEGFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:05:08 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52734 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfBEGFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:05:08 -0500
Received: by mail-it1-f196.google.com with SMTP id d11so5642717itf.2;
        Mon, 04 Feb 2019 22:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hjeUtTEn9UGT29eseEN2Cjm7ZUgHTxdZKKSZ6UwAIPc=;
        b=J8rFXq1U43OmoIQIq2l1MxwJTotzItZ8DjgW6LXoGKHVAt0ga0vhxHmVxGX/U1NogZ
         bz0eQoVYc5djY6mHRH3Rv/e0J267XId/sM8Wl86GVCl8Vsw126Mu7ldcop4wWfZTbu8y
         lQVrJwomDpOmlf4jsILxzrvmFCYesdp66KHXE6JEwuMsFtZ8Cktt+etsNCjcq7iwQzbH
         u8V1zk9Iw1MwMRgg/rD+D5a6/you90+leXmbX6EnRK3/Ex4jsEeyTFcRZMQLaituXwDt
         RL6xT+PXiw0xxaVboEXt2Clou2v0PJwTWDt3nrWSR5DuNdAvGbOHXphGgSXgXfpNefW/
         LCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hjeUtTEn9UGT29eseEN2Cjm7ZUgHTxdZKKSZ6UwAIPc=;
        b=mwFgxhadyVcIlZR9X6P+suJ72lD+h9YsWH9aI33zdW7hD3yCyImGQ4sP+Ltm1kpcYG
         H9YP6eiquXc8xEKR2aSfRoHRys/CV7AmPI2oF1VGAwM98VcWZq9X4Ws3Qc5HZEcO/qXX
         rhO+yGijUuDvjT3HfPF08CNpTrjA7D4dcGdUJASiJHKzjNdoEx36xz8j2hYLWp5+lkZL
         bVjm0oqxvY+QjCPwwRtw4JpFQLnbN8ySOJ4LAqHNbi91BUub1l9XSCkLIUoBokRH3RpG
         o4ooS1ayhtYpJ/JUqsFC/Zz6na4BiMkZNyz3xiRVJFNNPHpUybNiA2VFOsPy4u+DcqX2
         IMxw==
X-Gm-Message-State: AHQUAuYAveA4m+JNvloOslWRXkzIAz4Wd5GfQxYEi2MU2tU62kPRtnwl
        vGcjqsmI42pAeGomoM6DaRS5VNLG
X-Google-Smtp-Source: AHgI3IbH2hG7AoT/C08BEAecq4HWPnGtsqZxiT/5riOPw+LrdixQCw1s8RyusXPdTTU66FH4kGApew==
X-Received: by 2002:a05:660c:20c:: with SMTP id y12mr1380418itj.88.1549346707238;
        Mon, 04 Feb 2019 22:05:07 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id d11sm1062531ioq.31.2019.02.04.22.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:05:06 -0800 (PST)
Subject: Re: [PATCH V10 1/5] i2c: tegra: sort all the include headers
 alphabetically
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549330167-8690-1-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <42dcb7c4-eb5a-13a8-7977-1d0fae12be38@gmail.com>
Date:   Tue, 5 Feb 2019 09:04:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549330167-8690-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.02.2019 4:29, Sowjanya Komatineni пишет:
> This patch sorts all the include headers alphabetically for the
> I2C Tegra driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Yours "Signed-off-by" should be that the last line of the commit message. Same for the other patches. 

> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> ---
