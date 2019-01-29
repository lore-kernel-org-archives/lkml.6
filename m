Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8418C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4BE2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2lYVseO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfA2JGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:06:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38929 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2JGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:06:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so16775404wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dBHGbd4uyqxBuIpS6W/UvoUs6SB71cP+RGg2XCiky3o=;
        b=e2lYVseOdBzR4L/aHJo2sdqsqlUcjH2QLWY6GjxcGw3W/HexoONzwssfIsqmiVvBMG
         3hc15wjoV87obfBpmTXFlVdy2/vCSkiigtO+KB8NlZjXwYZYmCk/6yIp9FfT4EQtj0aa
         FTMeCeP6SvTWQIdaZMhC8crmsHvFt12JaYyo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dBHGbd4uyqxBuIpS6W/UvoUs6SB71cP+RGg2XCiky3o=;
        b=tvkjZZRqwYjSpdG4Vbh10tjOU0aB1XDWpLjFelfrp3gfEP04BNNuoVKnk9b4F5DCsS
         LxO1rWbsdmNFefcVCPlCCQvBXxnyJARofZoVBCEYU/X8c76hiBWVN52Ce9aG3BoFm++3
         4PQxD+a6WhvhteRSNGf+7ntCzqUJCpx75bOOigLRVhm31IWqznu+cL68O++DmPlfPk7L
         xN1hcccQmgi1vOh6s2joR/WvPd67KXoBE3yursWB38FQ9wAVvL2bJRDRUslGMANCL4cn
         RMapvKFYvpJsQUqpV6nmIauBImBybCyGNpuY92aSE9/c9CKqzjvtuL3LGgLFbIVcoK+n
         V50Q==
X-Gm-Message-State: AHQUAuYhxzK8LSmQGIxJ5G/R9GIr7AgPupnqZAivz1gOl7I1KvTXZMJ7
        zaz9mdK5kTay43UMzbryfhF2P8E0MJs=
X-Google-Smtp-Source: ALg8bN5z5hUoxGnrUFXAPf9lq3hyz/FeDdUxWWCM1rkXhmBdX3dpiQgDz7+X8EyAD0Dg5dX27sJ0YQ==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr9076371wmh.126.1548752809742;
        Tue, 29 Jan 2019 01:06:49 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a12sm133313639wro.18.2019.01.29.01.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 01:06:49 -0800 (PST)
Subject: Re: [PATCH 2/3] nvmem: allow to select i.MX nvmem driver for i.MX 7D
To:     Stefan Agner <stefan@agner.ch>
Cc:     peng.fan@nxp.com, linux-imx@nxp.com, fabio.estevam@nxp.com,
        kernel@pengutronix.de, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org
References: <20190128160722.23955-1-stefan@agner.ch>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3e305756-7929-b01b-3291-2d8380c3a7ed@linaro.org>
Date:   Tue, 29 Jan 2019 09:06:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128160722.23955-1-stefan@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2019 16:07, Stefan Agner wrote:
> The imx-ocotp nvmem driver supports the i.MX 7D SoC too. Allow to select
> the imx-ocotp driver even if only the i.MX 7D SoC has been selected.
> 
> Fixes: 711d45477931 ("nvmem: octop: Add i.MX7D support")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied thanks,


srini
