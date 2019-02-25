Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D81C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E0020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWvoI4cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfBYPNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:13:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38686 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBYPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:13:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id n125so4646418pfn.5;
        Mon, 25 Feb 2019 07:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mrfO67nbav+CIhQN9ZK3QikqwKUUWTdGL5TK8vZgYAU=;
        b=dWvoI4cxZtHhe50aEbO0BedwzVYX6gO3n1dyBbhdlWl6VOzK62LkaVj7tyyCIlaSW+
         J5JeJi7o5QRYcxzcWSQeQXE7wOrMG7OhRVAIN3GqITGYn526eHPTktlCJ/zD/sPmAvtL
         bkeL45M5iQEVuXI1ASPevhJDN5rmah+elb1v9fvOqH/FqItKB1XY6xNk3E2NkFWmBfpd
         0X8fryS2RflDyszJHGYH+J8Qcues03x+FFKv4g7Zdecdmk7fA5hWZSCZhBJjxo756fPZ
         ijXZ1jT3KBpJKlOm37oz36duCr/F4EUvSG3QlTJOTvO1BpWJKnKZF6u3LJ/CbSNsYJcs
         RaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mrfO67nbav+CIhQN9ZK3QikqwKUUWTdGL5TK8vZgYAU=;
        b=hXdsLHFgdwYCPDAs/47E7sVQFJUvE3RCdR/nAski1m1jHXuJTSFdvu4bp8vwZ57Wc6
         tHeonBBtlG6v3hubbbOmMijuvjCXlxDwoexCWkICbYOz7FbuLcB0UEzCZ6LcYjqTDgo5
         BB0G2J/8Il1yCVZr7ApPkihIcHLpt5MMNnHO9p1TLyoj9Z9nLELomxVd9O4aKYvRpCZa
         D+6m6d6GvOMbNovgwWN4EqeTU3bPc3b6Xay6cZLf28oFP/5gceGaAgq+xwjlKbjOjakP
         ZfxDlVKwZMdkXT+TOI8h2vKxMxpA9MA0YZ81wpReoYJucyIuLwVZyE+CnHGd7Gll/6av
         Ywdw==
X-Gm-Message-State: AHQUAuYkiCgUp9xKc1mqU5/fl70Ij9VHM454Vb1pgCarOQGOXm4UcFXz
        7z+nRZPXPwcajVS/75G0G+gciQYc
X-Google-Smtp-Source: AHgI3IZptuZzOsUP8/83IDgrSV6Xj0jd9wgQy6xyVSA/FuDTSvKi2nioUcqGTkGY/FOPya1i377lSg==
X-Received: by 2002:a63:8441:: with SMTP id k62mr18568698pgd.219.1551107612272;
        Mon, 25 Feb 2019 07:13:32 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id t23sm7349910pfa.111.2019.02.25.07.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 07:13:31 -0800 (PST)
Subject: Re: [PATCH] ARM: tegra: enforce PM requirement
To:     Sameer Pujar <spujar@nvidia.com>, linux@armlinux.org.uk,
        jhogan@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1549365418-26283-1-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ac4bd28e-6ba9-2da7-7bdf-8f11bee83bd2@gmail.com>
Date:   Mon, 25 Feb 2019 18:13:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1549365418-26283-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.02.2019 14:16, Sameer Pujar пишет:
> Drivers need to handle !PM case with work arounds for managing clocks
> and power explicitly, which is not really necessary when PM support on
> tegra is in good shape. In fact ARM 64-bit tegra platforms enforce PM

Tegra

> support and there is no reason why this cannot be done for 32-bit.
> 
> This patch selects PM unconditionally and drivers can rely on runtime
> PM framework for clock and power management.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
> ---

You probably should explain in the commit message what driver need this right now and why.
