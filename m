Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBCECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091A320840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLfMjTKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091A320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeKICaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:30:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35309 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeKICay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:30:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so18632145ljb.2;
        Thu, 08 Nov 2018 08:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U1mIQ0dunOnrqDDsmLDruczBjJ/DdXuddnoL7xJFOD4=;
        b=DLfMjTKjfl+0yj/oOcUt5Zh4XLgkWalwUvxFmdA5whFIz+ajKsOwTn8sUpf62eHg7q
         cOJYhjPsZg5OKJtIE3aJr9FDgg8tdwjB6huCQzo63I2hKIZHzugIGm+RDNthhoea7L8q
         Z0GvAr9phZaTV+hYaz7DbFfoBzoHVyq9pOzaUWw3U0JPPIixPB798F8W0g2FhsxH0JPv
         3t9bAxsIfRbaCHSuwmwk45xCFYwmCmwbtbDEY27McT+lr88mOdjwXAot6qCBLUzKQ2LE
         3Cy1+zhE5SQO0GAdHHLEGulKzxwd7U/GUKJplUxNcM8kw+TnIwA13zxzSGdJpsddsmUR
         QeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U1mIQ0dunOnrqDDsmLDruczBjJ/DdXuddnoL7xJFOD4=;
        b=g1bXTioFKSk+0Z7ONL+2Jr6fNTM18zYiAWYrSw6MhOyZ1QquppjXO6nu/1TXLMKBK/
         QBdQi1lkKImApCETs6i3T+kVoF1wfrgiX6F8WW83+8RN1TyRiYq340pgOzV7iIaSlabe
         itnRBmkKdiaSKwmjZ9ESRSgxg482WwB6jRo2MUIs1frpAh8iRAg/A9lcT4SmawW494pI
         Txo4eud9cENZBpXC9qxEC8BtOsxXlJqpPSphfKU/yRvqXW3l2sTnF+QXPfPNUtzNEJvM
         TSlPx0tDIvk0QXGmDbBQbS2BwBAkjCV5zXnk5jgr+LxMBCaKAk2nLGJ7ok3pvW1dJZDh
         6BlQ==
X-Gm-Message-State: AGRZ1gK5i5eBkgEgjMoUmAzX7AsCOsV2pX7S0vgT+cIc8lC9+5/pH7bA
        QZnrmMffeYFu7TapS9hlMyUHQKTC
X-Google-Smtp-Source: AJdET5cCKnQ5zOQ4WxxdrNwu35Ps/NMhVq0ehik/Q2MPd3XDsitV4PG7Stf9feBDyrYz5iUwHqDNbw==
X-Received: by 2002:a2e:9603:: with SMTP id v3-v6mr2912040ljh.15.1541696070433;
        Thu, 08 Nov 2018 08:54:30 -0800 (PST)
Received: from [192.168.2.145] (109-252-91-202.nat.spd-mgts.ru. [109.252.91.202])
        by smtp.googlemail.com with ESMTPSA id a2-v6sm787610lji.13.2018.11.08.08.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:54:29 -0800 (PST)
Subject: Re: [PATCH v1 10/11] regulator: core: Use ww_mutex for regulators
 locking
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-11-digetx@gmail.com>
 <20181108130714.GE6675@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <31841457-32c5-f28e-707e-a2eca012acc5@gmail.com>
Date:   Thu, 8 Nov 2018 19:53:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181108130714.GE6675@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.2018 16:07, Mark Brown wrote:
> On Fri, Oct 05, 2018 at 06:36:37PM +0300, Dmitry Osipenko wrote:
> 
>> Wait/wound mutex shall be used in order to avoid lockups on locking of
>> coupled regulators.
> 
> This breaks the build due to a few of the drivers (wm8350 and da9210 at
> least) taking rdev locks in their interrupt handlers.  I'd suggest
> adding a function for those drivers to use - exposing the ww context
> seems like the wrong thing to do there.

I totally missed those drivers, will fix them in v2.

> Otherwise the series looks good, I've applied everything up to here.
> Thanks for taking the time to pick this up, and especially for figuring
> out the ww_mutex conversion.
> 

Thank you.
