Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4BFC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF5D2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvdR2squ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF5D2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeJVUac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:30:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35314 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeJVUac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:30:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so36750555ljj.2;
        Mon, 22 Oct 2018 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tWqSH/JLsi4Wzzp51efFVTIU8xkaytvDycXSRB9X1hY=;
        b=gvdR2squxeT8SgFSBjXKazXM5vspvnC9vV9tDxz2RlQrZIb3r6enD57A2DjFGZgT7c
         tej0+VuZDa26heJVwpPoSocrv3MZmX62aObhrF5HnyU4Odt4ZF4ZzB0AdjGHecK5OY6H
         mRJWHiNmdeBglcxySoqdtOTN/8TArh143Fan9rUlLJs7XIPEEzCKYRbpV/KxXKay2BT8
         1z+6PnNTkTT3mI+d278wO9EfIpRsDKi5XZPt443nzXkRCBirfGRUNzQ6BGiVAQCwVPEW
         ZYc+QcUzGM24N4c5TwQ1HNFBPu5Ld5il+TRv4gbC+JwWdXLeFsvB2JsPkN3KxEB7o0N0
         LTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tWqSH/JLsi4Wzzp51efFVTIU8xkaytvDycXSRB9X1hY=;
        b=W7IUlGKBrGTqYIGcmRNaZiTAGdnRAl3btid8kvpqcauaJD9MR6ODJzqnk3DPFKyR4/
         EZVapBhKyuJeDqxJ55O6AihbZpAo9vm3NONApgf7m+R1Q20QUYcHCSaQiLIoYR1Z0bvY
         iukJ/Gwondc1vZrTsyK4MusHAKpyq0SysPoX5AafmXC8G1uXTFtnGjwDr8iOfdybojjU
         R2WRp0jgrsQwRluatYDe71598CZxqgNdZTNa1ktJz44/XoUIBmQZ9AG8tU5OCwhKqyQd
         u2y/S1WmrF7/08uz/MMlHqwXpZ1sKzUO3Yk5wwnYmDaY1IORX4FkGUicfQchJAFyruRE
         i9Rw==
X-Gm-Message-State: AGRZ1gKXHHrxxE4on61pyfImr+21qkRyO3QmpQ9TEzKKcGhBPADaQXpF
        ofE8Ig0AUbtQT5TjE8jshOUEi3gt
X-Google-Smtp-Source: AJdET5dhYOM337hK9MsQjvywYHlzLjXq2Jb6NYxFUHznEiSgfH0pQ5fwXw6JSZasmfHmFqWw/ESDGw==
X-Received: by 2002:a2e:48d:: with SMTP id a13-v6mr10912641ljf.27.1540210330613;
        Mon, 22 Oct 2018 05:12:10 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id h25-v6sm1285045ljh.12.2018.10.22.05.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:12:10 -0700 (PDT)
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
 <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
 <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
Date:   Mon, 22 Oct 2018 15:12:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 2:32 PM, Viresh Kumar wrote:
> On 22-10-18, 14:29, Dmitry Osipenko wrote:
>> On 10/22/18 8:36 AM, Viresh Kumar wrote:
>>> On 21-10-18, 23:54, Dmitry Osipenko wrote:
>>>> Voltage regulators may be not available on some variations of HW, allow to
>>>> request stub voltage regulators by OPP core in a such case to reduce code
>>>> churning within drivers.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/cpufreq/cpufreq-dt.c | 2 +-
>>>>  drivers/cpufreq/ti-cpufreq.c | 3 ++-
>>>>  drivers/opp/core.c           | 9 +++++++--
>>>>  include/linux/pm_opp.h       | 4 ++--
>>>>  4 files changed, 12 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>>>> index e58bfcb1169e..6ebca472ec76 100644
>>>> --- a/drivers/cpufreq/cpufreq-dt.c
>>>> +++ b/drivers/cpufreq/cpufreq-dt.c
>>>> @@ -196,7 +196,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>>>>  	 */
>>>>  	name = find_supply_name(cpu_dev);
>>>>  	if (name) {
>>>> -		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
>>>> +		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1, false);
>>>>  		if (IS_ERR(opp_table)) {
>>>>  			ret = PTR_ERR(opp_table);
>>>>  			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
>>>
>>> Have you actually tested this stuff ? The cpufreq-dt driver will
>>> probably fail to probe if the CPU node has a "-supply" property, but
>>> no regulator matching that.
>>>
>>
>> Please notice that this patch doesn't change the original behaviour
>> and I suppose that failing in a case of missing regulator is the
>> expected behaviour for cpufreq-dt. Hence can't see any problem here.
> 
> So why have this patch then ?

Because there is one Tegra20 board (tegra20-trimslice) that doesn't declare necessary regulators, but we want to have CPU frequency scaling. I couldn't find board schematics and so don't know if CPU / CORE voltages are fixed on Trim-Slice or it is just preferable not to have DVFS for that board, it is an outlet-powered device [0]. Hence tegra20-cpufreq driver will request a dummy regulators when appropriate. 

[0] http://www.compulab.co.il/utilite-computer/web/trim-slice
