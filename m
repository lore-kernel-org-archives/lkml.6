Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D46C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A0D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jwC5i1k6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfA2RAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:00:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33892 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfA2RAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bbl0EZN5LTa5VH+fnQzizgDahgF6rPjBiHctuhxxhUk=; b=jwC5i1k6rLBrRFpGH7KQZHPcgQ
        dPhQlp524OrmZYuzkQTeKCAb3nQDS++dmKkVAQ2J8bNjQvwcU1DdC3/mhJwNXN5Dhro8epnieoHOu
        v2gHPwqdOXdYicDr5LnmUpLUb+jJWCDpuqJUL+/sUE7/wFzsSDskaw5hLUIG0wCu0FYuoZX9uxDlJ
        3s5mGeG5EoXVX8fJZtg1FFAfKTY2jSyJEfAmFfTGfN4Fo+LonLO5P/o/WGs4RJUb4ROVMlASZzPqd
        N4PAosxlU0creCj6DRGIQmlKXla0qNIHr4diHTvy/Cv05T/ZCJlFBz9ZcVXMh9eMutPNOBfO7Bd6e
        3dENxc3Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goWkK-0003vh-UT; Tue, 29 Jan 2019 17:00:28 +0000
Subject: Re: linux-next: Tree for Jan 29 (SLIMbus & SND_SOC_WCD9335)
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
References: <20190129171143.3945af24@canb.auug.org.au>
 <2eaba760-96d5-5e0b-c1e6-c45fb24d89f2@infradead.org>
 <a849e598-da5b-bfc2-cd41-dab94fa79c87@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7f4aa68d-d9ee-ec08-8593-a975a999e5e2@infradead.org>
Date:   Tue, 29 Jan 2019 09:00:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <a849e598-da5b-bfc2-cd41-dab94fa79c87@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 8:57 AM, Srinivas Kandagatla wrote:
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-5.1&id=a8233b6c1972e1959cf84a021aeb61ddcd23cc26
> 
> This should fix the issue! It should be in next today!

Looks good.  Thanks.

> Thanks,
> srini
> 
> 
> On 29/01/2019 16:50, Randy Dunlap wrote:
>> On 1/28/19 10:11 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20190125:
>>>
>>
>> on x86_64:
>>
>> CONFIG_SND_SOC_WCD9335=m
>> which selects REGMAP_SLIMBUS, but SLIMBUS is not set/enabled.
>>
>>
>> ERROR: "slim_driver_unregister" [sound/soc/codecs/snd-soc-wcd9335.ko] undefined!
>> ERROR: "__slim_driver_register" [sound/soc/codecs/snd-soc-wcd9335.ko] undefined!
>> ERROR: "slim_read" [drivers/base/regmap/regmap-slimbus.ko] undefined!
>> ERROR: "slim_write" [drivers/base/regmap/regmap-slimbus.ko] undefined!
>>
>>
>> Full randconfig file is attached.
>>


-- 
~Randy
