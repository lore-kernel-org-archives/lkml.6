Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C5C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4543E21855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhYg5ZKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfAYWJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:09:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40899 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfAYWJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:09:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so5155983plq.7;
        Fri, 25 Jan 2019 14:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yOK2pu+zjQkFNn+imQ1D4TTPfe1zrFINqOeFn96lPYs=;
        b=RhYg5ZKE+JsIoyxOWfstw6d4J0Z15RE5nl9zlvSBRPue9JtbSWzgY35OjuP4SSPuIc
         RHTQphFZV7nExm/VSclU1IKcPAm5ldXKq77nzdg0OPhCAdwkv6wJOR2Iw8YY9fAhPBZi
         lkHqwTXz13ORlrgIml0kSMaVp+jKXc0bepTCKoIWdUGO5/vH8i1HCbOmN+eraYCcnSrf
         f6gwiisSGP6j/rA3fzpTqjEkm7mcNb0SSQBJtu98F4rPUN5EBhcgqC2jrSEjDvTuIUIM
         uePyd32MWQkWaqMBaSXCny4bq7YtPqQpmluzDgIqkUeFn+UFAljLCQ/7yMO1ASOaV1Jd
         EOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yOK2pu+zjQkFNn+imQ1D4TTPfe1zrFINqOeFn96lPYs=;
        b=MSbk0GYWHpkqmoYm2iZBnAAyThOLLgECohmcp2TjQG72TrFp4+o5TJvNdQzHTH5fzR
         T75tWXoozyYeyBYBFSRaGe3EeT3u0/d/fHTRmlO+pnuOim4M6Gtv7t5kvm2wfSHbIBf4
         11ovDASZSs8/df7iz/ZTyDYqNyjkPWeV5Go1jzFZCutKLknxMpSlRycLqz4OI3z1YUTI
         VRJVCjxcvfiGH+1CLCv+zV+F96dYQrPo4q7aQxjZEDtzON3bNXmBfKNwKudCH03L3lnc
         fOjqhPE02z3JITTZPwq8YNCl8dT1kndcLzHhRIRKfBcVrHmFUml4v0JiamucJNjaYP5k
         zP6Q==
X-Gm-Message-State: AJcUukd/cwBLudnbMTRe3VKV8eO2ODALb32hX2SHBZCpk01LTONc8lpi
        /iogSgjd6nJkhpKqGLamun4lTcHG
X-Google-Smtp-Source: ALg8bN6l8HusjX6qpUJKde1EcT9svrVT/fQY1jm1u1qUr8GEOtzXH99qc7RXMsH3WCd/YDkA/ynKJA==
X-Received: by 2002:a17:902:b090:: with SMTP id p16mr12823454plr.190.1548454169164;
        Fri, 25 Jan 2019 14:09:29 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id l22sm45850608pfj.179.2019.01.25.14.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 14:09:28 -0800 (PST)
Subject: Re: [PATCH V2 3/4] i2c: tegra: Add DMA Support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-3-git-send-email-skomatineni@nvidia.com>
 <dcc1e094-638e-5b04-7a61-bdbc24ee068f@gmail.com>
 <BYAPR12MB339829FC6F2F95F833FE45A1C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <ad177c2e-3801-ddad-b359-ac83530ee1d6@gmail.com>
 <BYAPR12MB33982ED3A9EC34819D2490F8C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <782dcecf-2991-e886-af18-d355a3ea8325@gmail.com>
Message-ID: <42d20b67-95a7-c4c3-059e-0b990e6f684f@gmail.com>
Date:   Sat, 26 Jan 2019 01:09:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <782dcecf-2991-e886-af18-d355a3ea8325@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.01.2019 0:49, Dmitry Osipenko пишет:

> 3) After applying these patches I2C transfers are failing on Tegra20 with "tegra-i2c 7000c400.i2c: Failed to allocate the DMA buffer". 
> 

Actually scratch the above, turned out I haven't applied patches correctly. In fact patches are failing to apply with:

# git apply --verbose V2-3-4-i2c-tegra-Add-DMA-Support.patch
Checking patch drivers/i2c/busses/i2c-tegra.c...
Hunk #4 succeeded at 198 (offset 3 lines).
Hunk #5 succeeded at 212 (offset 3 lines).
Hunk #6 succeeded at 229 (offset 3 lines).
Hunk #7 succeeded at 243 (offset 3 lines).
Hunk #8 succeeded at 321 (offset 3 lines).
Hunk #9 succeeded at 636 (offset 3 lines).
Hunk #10 succeeded at 751 (offset 3 lines).
Hunk #11 succeeded at 798 (offset 3 lines).
Hunk #12 succeeded at 968 (offset 3 lines).
Hunk #13 succeeded at 996 (offset 3 lines).
Hunk #14 succeeded at 1050 (offset 3 lines).
Hunk #15 succeeded at 1075 (offset 3 lines).
Hunk #16 succeeded at 1125 (offset 3 lines).
Hunk #17 succeeded at 1180 (offset 3 lines).
Hunk #18 succeeded at 1304 (offset 13 lines).
error: while searching for:
                return -ENOMEM;

        i2c_dev->base = base;
        i2c_dev->div_clk = div_clk;
        i2c_dev->adapter.algo = &tegra_i2c_algo;
        i2c_dev->adapter.quirks = &tegra_i2c_quirks;
        i2c_dev->irq = irq;
        i2c_dev->cont_id = pdev->id;
        i2c_dev->dev = &pdev->dev;

        i2c_dev->rst = devm_reset_control_get_exclusive(&pdev->dev, "i2c");
        if (IS_ERR(i2c_dev->rst)) {

error: patch failed: drivers/i2c/busses/i2c-tegra.c:1000
error: drivers/i2c/busses/i2c-tegra.c: patch does not apply


Please use "git format-patch -4 xxxx" and do not edit patches manually.
