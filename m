Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B068C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFC72064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrzrxf30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFC72064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeJVTrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:47:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42373 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeJVTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:47:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id y71-v6so36601860lje.9;
        Mon, 22 Oct 2018 04:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5fm/Gw9h4+Wf//cPeYHo5uYvtTRh3Q+Whf94eNVqMGk=;
        b=Yrzrxf30j3CPbGFn3I6Yy+K5Cfb9VwV9oxA23JWAyrz1eD4BG/EDn069kIGFYgQZHy
         L071zRajD11XqChdE+LSneVBH+gTHZM9r6szcHFRyP6lxwnVSDBSeF/JOXKF2N2k4Qsu
         BoeJHi44FVHj4ifRo4BTWStbhmFc+hvHBnq6aYMIqrKYC37IrkiWOgHBwLltL02K4fg0
         cat/GTIGvhuE67ijKbyZ/jN9YHt8/0FC88zBKi8O52tpJTp2+TJyjLA7JAv546+38QBC
         wVRdjFGw9Kt9ChDun8qWZnriDQUoKE3pUpqZzKe9pbcR8vlnDLeerPMgdM36A6lsuuJd
         N1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5fm/Gw9h4+Wf//cPeYHo5uYvtTRh3Q+Whf94eNVqMGk=;
        b=H07qYDQ2s2qu28LYYpOFRDga28o2SsWrUoxdhXBABBfbM44dohbGUpG9jrk6uPzW0R
         v6TCmasgxUJVaWyw9eSs/Y/Wddlhyo3iNnRuPrO00nLvoVUNrJ/BAp0cnHPCz0gtLsv/
         nIiyNDgP2Yw4NQfpV5v45XjOR0mNZJDWdLQegFgJ/XAsn/2yxJ8Tx9/TcPk40tP3o9i1
         jtUJBXoDrsIpghRUTJq3mjSb97kQpcDqdZPVUDRxhYoA1UB5AIYmetEXiJay0tOxOWL1
         AnEj96hvay2x2vspeJgTi8Grlp/WIKHUJetB/l1x8EemdDsYNlgrJPXRXRuR21s4wK5J
         5uGw==
X-Gm-Message-State: ABuFfoibgdLo5iFWoOSoQw3VQk76FQgj+ym8vrfRtNbkoGEA5s+1zQRq
        qeYyGkcpPSzeUhgEWWw6/Oo0NKaF
X-Google-Smtp-Source: ACcGV62fulvcZNF4VS1iZCsG3PwyxLpZKWPWnyUmgiQ5gsb+pmE0lNQ0c95zqnOIaYTmoLInDWwQNw==
X-Received: by 2002:a2e:908:: with SMTP id 8-v6mr28348854ljj.1.1540207758576;
        Mon, 22 Oct 2018 04:29:18 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id f197-v6sm6140438lfe.49.2018.10.22.04.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 04:29:17 -0700 (PDT)
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
 <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
Date:   Mon, 22 Oct 2018 14:29:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 8:36 AM, Viresh Kumar wrote:
> On 21-10-18, 23:54, Dmitry Osipenko wrote:
>> Voltage regulators may be not available on some variations of HW, allow to
>> request stub voltage regulators by OPP core in a such case to reduce code
>> churning within drivers.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/cpufreq/cpufreq-dt.c | 2 +-
>>  drivers/cpufreq/ti-cpufreq.c | 3 ++-
>>  drivers/opp/core.c           | 9 +++++++--
>>  include/linux/pm_opp.h       | 4 ++--
>>  4 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>> index e58bfcb1169e..6ebca472ec76 100644
>> --- a/drivers/cpufreq/cpufreq-dt.c
>> +++ b/drivers/cpufreq/cpufreq-dt.c
>> @@ -196,7 +196,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>>  	 */
>>  	name = find_supply_name(cpu_dev);
>>  	if (name) {
>> -		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
>> +		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1, false);
>>  		if (IS_ERR(opp_table)) {
>>  			ret = PTR_ERR(opp_table);
>>  			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
> 
> Have you actually tested this stuff ? The cpufreq-dt driver will
> probably fail to probe if the CPU node has a "-supply" property, but
> no regulator matching that.
> 

Please notice that this patch doesn't change the original behaviour and I suppose that failing in a case of missing regulator is the expected behaviour for cpufreq-dt. Hence can't see any problem here.
