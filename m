Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9139BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8A620644
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kSS+BK1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8A620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeJRDrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:47:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1352 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeJRDrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:47:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc7928d0000>; Wed, 17 Oct 2018 12:50:37 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 12:50:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Oct 2018 12:50:41 -0700
Received: from [10.26.11.110] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 19:50:37 +0000
Subject: Re: [PATCH v2 9/9] ASoC: tegra_sgtl5000: fix platform name vs.
 of_node assignement
To:     Mark Brown <broonie@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20181016104730.4598-1-marcel@ziswiler.com>
 <20181016104730.4598-10-marcel@ziswiler.com>
 <35848cb7-36ee-6698-ff17-7f0e73567914@nvidia.com>
 <1539786500.6233.58.camel@toradex.com> <20181017191633.GL24097@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ca23a9fd-2578-c4ae-7bc4-5e2d487fb1ca@nvidia.com>
Date:   Wed, 17 Oct 2018 20:50:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017191633.GL24097@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539805837; bh=OH3a9OxJJZVsr35thhiDco3Ue7K+gF1TNLdQOMKN65w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kSS+BK1VxPdulDkUqK8OL31xyyBDF/vutF4PKNAsR+WC4yiWSaNWbiAQRlk9dMUqT
         a+iVfmx1HZwH9B9ZlsNz/gFYncZ0bRqvWabkdwx0jofWQDel0cKZLqNbsDniEeSdj6
         KTAl/9PGxWATHNM6VTPF7upXj0kFEGULdlduPnqrS8jBtOgpvBz7wgdKFK49HOSKgh
         v3jXLeiXuPN6GP2u0EHLj8qIookmblaHMo1ekf2VcxHnbODKWyO97GK3N8ybzBSmVB
         T8cD4j6R/nman35r9dleku338NWh25oLF+0k0u0fLpXd3iE8Wc5jvNuvDdPKRdb07m
         I+pvQyvI6Gvqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/10/2018 20:16, Mark Brown wrote:
> On Wed, Oct 17, 2018 at 02:28:22PM +0000, Marcel Ziswiler wrote:
> 
>> Some questions:
> 
>> - How exactly are devm allocations supposed to work concerning probe
>> deferrals?
> 
> Probe deferrals are just normal probe errors, any devm_ allocated stuff
> gets unwound.
> 
>> - Does or should the platform get cleared during a probe deferral
>> cycle?
> 
>> - If so, why does that not work?
> 
> Is something writing to static data when it should be writing to
> dynamically allocated data?  That's what this sounds like, we shouldn't
> be modifying any static data and any data dynamically allocated during
> probe ought to be being discarded.

Marcel, it maybe worth looking at what happens in the 2nd call to
snd_soc_init_platform() following the probe deferral. Also pay attention
to the value of 'dai_link->platform_name' in snd_soc_init_platform() on
both 1st and 2nd call. Seems that on the 2nd time the function is called
the value is not NULL???

Cheers
Jon

-- 
nvpublic
