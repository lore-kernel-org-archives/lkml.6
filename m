Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E38C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CC420663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7Hbh02a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CC420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeJWHUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 03:20:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39987 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJWHUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 03:20:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so19742877plv.7;
        Mon, 22 Oct 2018 15:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xtk8aK9t64ZAizNN0rmyL8tThoipYFirypGHiQ5izPs=;
        b=C7Hbh02aE/kG4TbPwq+BZ+qy8aQCtTKGiLR4V4IHhBpM9HIV0+3ZU17F3Hep+74FyX
         NIWCA0c3wYMkKKrcx4ZA32X5XT+XctUUu5+W337Lf5w+KTMsxMfqv6gBFx1mOMZofg7m
         MWgF3/dMM9IOwiRZyOcGDUbYj8yqYvtLMlLzcM12LdLxjolGEU7oO5qZJMRK9vzpyytm
         kKffhpBksIn/7B0oCYGVhSG+Q7hbMbe3KEiD3rhdznfoucbd9jKqux5CE+NAcQnhdHzm
         pvs2KgTXRCdcLsAp5R3ntUn2NvAELAMIs2xDFyuZjtT59bOTcJEhocXtc3y5L5Qg6QXw
         eHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xtk8aK9t64ZAizNN0rmyL8tThoipYFirypGHiQ5izPs=;
        b=bSK/D3BY/lt+7kCZw9iF0NVEhFO/byrb1Vf+EmYpnnuYY9pbhqwTszUBBi2t5ufdVv
         lHpQJCQ7wYtXlNQr7PZvSVOlTtWXxvFb37RoEpLhSo3O4WIVxzKDqppn2YY6ODQKV42X
         XZlxj7Sj7pl0YGytuZZTgOnO9sP+Btbr39xApWe7tfpxNe/MHgBnhiqYoPYqo1RkpBUV
         1ux1DeiGhjUVYjoi/mb0c3xl08LxSHC7ZZ6kyy7nR1b8pAx0jsFAIzQrw85nmBqMJlMy
         A3EEt+SmaMON9/TiX8s7rguMtvsGpIZGc8ctvqRAQcxSZ/l2zRfBGOA7QHJGQf8ksYHv
         pOtw==
X-Gm-Message-State: ABuFfoh3NnOGDeoIgrJC3Z2HZsJo30AFDOXIq7XkhBYn0TzzsXyirTFp
        A46P9tvco68/8qx9Mwluno1rIUmZ
X-Google-Smtp-Source: ACcGV62fg9Qlw0VPBeevq04JIbJ01WSSjrVpxBtdOD0mRT6umsk2Q7SUsg/bMOulYcZ8WBBxsoowEw==
X-Received: by 2002:a17:902:4103:: with SMTP id e3-v6mr46028012pld.236.1540249183403;
        Mon, 22 Oct 2018 15:59:43 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm47967179pfj.72.2018.10.22.15.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:59:42 -0700 (PDT)
Subject: Re: [RFC PATCH v2 09/17] ARM: dts: tegra20: harmony: Setup voltage
 regulators for DVFS
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-10-digetx@gmail.com>
 <a1b4cd27-858c-de53-8ae2-b1aee689475f@wwwdotorg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5f3b5213-0901-be42-4f8d-2e68551f100c@gmail.com>
Date:   Tue, 23 Oct 2018 01:59:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a1b4cd27-858c-de53-8ae2-b1aee689475f@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 6:33 PM, Stephen Warren wrote:
> On 10/21/18 2:54 PM, Dmitry Osipenko wrote:
>> Set min/max regulators voltage and add CPU node that hooks up CPU with
>> voltage regulators.
> 
>> diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
> 
>> -                sm0 {
>> +                core_vdd_reg: sm0 {
>>                       regulator-name = "vdd_sm0,vdd_core";
>> -                    regulator-min-microvolt = <1200000>;
>> -                    regulator-max-microvolt = <1200000>;
>> +                    regulator-min-microvolt = <1000000>;
>> +                    regulator-max-microvolt = <1300000>;
>> +                    regulator-coupled-with = <&rtc_vdd_reg>;
>> +                    regulator-coupled-max-spread = <150000>;
>>                       regulator-always-on;
>>                   };
> 
> How do you know for sure that these increased ranges are safe (high end) and stable (low end) for this particular board? IIRC the safe/legal range depends on the chip SKU, and to be honest I have no idea which SKU is present on Harmony... For public boards like Colibri I imagine there's enough information out there to tell what will work, but maybe not our internal boards like Harmony, unless you checked our ancient downstream kernels?

Yes, the ranges could be inaccurate in these DT patches. But it shouldn't matter much because only OPP's that match actual HW SKU will be used for DVFS. Though certainly it will be nice if we could specify exactly correct ranges.

Looks like downstream doesn't specify safe ranges for any of the boards and it is relying on the SKU-VOLTAGE DVFS table values only. 

For now there are quite few obstacles that need to be resolved in order to get a properly working system-wide DVFS, but things are getting a bit closer. Thank you very much for your input!
