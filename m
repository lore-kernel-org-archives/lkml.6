Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9733C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774212075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="i7FC+8If"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774212075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932960AbeFUOZH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:25:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39766 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932756AbeFUOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:25:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so6470198wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y5Q2SpwYf0b1hpBnuommI3B5HlCfoPuNNuzFSJNRlgE=;
        b=i7FC+8IfF1hLqCI9RVBo2mnqI/x+J4ASatAmimeOz9fFrxcwmKepwVzorsstpwF3yF
         WXT1xcQfVFjVJCJU/aa/rwFhlbMp4S+JIrSL5I6WDopUxX9jaQ2ot4ye7EWIbQljukW9
         jWqlR/maTqyQpfZXrN2NMuhA6S5Ht4lHGTUjlB6KP0Em+40kJlP3NOPd9goxrtzzJUO5
         Y+u9j3HmJIheVmUCvNeWMCW4ImksOX7Nm0vaU9rg1e0vqioNLYtWjh1FX5NsMzSrH4tT
         jJ5QAGGnB1inGJm01xfzTNeOwvrwDTFweQ4qBrLjxjKKvy++Lr2Vim1GYaIqED+ofB1X
         B0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5Q2SpwYf0b1hpBnuommI3B5HlCfoPuNNuzFSJNRlgE=;
        b=O4qIebz6NRDlf9b0JPyAV6infQvtl787u9YBwq+9AgmviHbs57JfAeVkJYvaRAvMAE
         0F8v99NYF3UKmGs44ueXuCYO7oAOwF/5q5eNEEs5jyCgY+MHvbN1qePiq/N/b/Dc9VwY
         Eex+tr9ei4Cgo5KRuHi9/ZHWVSVMZIEOs6HSHCMEDc/9+FvODIcJaPF5jNTTcP6X8bEX
         JN5+AecNfIDUn9ZGNnf0KY+DB7ghmBAugKcEmPKXo0a291e9NKiH7eMtggUEtnNOS9/x
         ATkGg+SXyU7/7A35pU700Uu21PkDu6JJTDyRDEXf/mpuOOb12HYd1OIaLs1l0n9B5KXL
         mS6w==
X-Gm-Message-State: APt69E0A/AbXSdd2SNkaQ5vg2kRa9I34wiFwR9ccVVoPvZGdmE17VQrl
        oV5SrVTzT/UXhEmluu4OaJumkQ==
X-Google-Smtp-Source: ADUXVKI0An6bdA+Bsks8KlNf1eAAyGHSmj6tm79KtOKAc/tLZVYvXB1Nu68/T0Kqbvqt0uXvqaLQmg==
X-Received: by 2002:a1c:e618:: with SMTP id d24-v6mr5051251wmh.154.1529591104110;
        Thu, 21 Jun 2018 07:25:04 -0700 (PDT)
Received: from [192.168.112.17] ([89.249.64.228])
        by smtp.gmail.com with ESMTPSA id q70-v6sm6356503wmd.45.2018.06.21.07.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 07:25:03 -0700 (PDT)
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <0f31d801-528e-54ee-f385-b7aa3eef414f@cogentembedded.com>
Message-ID: <26d9fd57-07bc-0bba-2f29-ca778bd85328@cogentembedded.com>
Date:   Thu, 21 Jun 2018 17:25:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0f31d801-528e-54ee-f385-b7aa3eef414f@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



21.06.2018 17:12, Nikita Yushchenko wrote:
>>>> This patches causes a regression on a imx51-babbage running 4.18-rc1:
>>>> I get a kernel hang.
>>>>
>>>> If I revert it on top of 4.18-rc1, then it boots fine and USB host is
>>>> functional.
>>>>
>>>> I understand this patch fixes a kernel hang for you, so which commit
>>>> is responsible for the hang you observe?
>>>>
>>
>> I never assumed it was a regression and that USB worked on RDU1 board
>> before, so I never tried to see if this was a regression. I can only
>> tell you that it hangs as soon as any PORTSC registers are accessed.
> 
> Hang at register access usually means that module that owns the register
> is not clocked.

On RDU1, call to usb_phy_init() actually calls usb_gen_phy_init() that
does regulator_enable() for &vusb_reg and clk_prepare_enable() for
&clk_26M_usb.  I thing some of these two is actually needed to avoid
hang on register access.
