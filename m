Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C7DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3552151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MyIAhHJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3552151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJQQxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:53:51 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13718 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeJQQxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:53:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc6f9d80000>; Wed, 17 Oct 2018 01:59:04 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 01:59:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Oct 2018 01:59:08 -0700
Received: from [10.26.11.110] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 08:59:05 +0000
Subject: Re: [PATCH v1 2/3] clk: tegra: Add more rates to Tegra30 PLLX
 frequency table
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180830192045.11017-1-digetx@gmail.com>
 <20180830192045.11017-3-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1c4e20b2-9929-b163-b371-b32596b6189a@nvidia.com>
Date:   Wed, 17 Oct 2018 09:59:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180830192045.11017-3-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539766744; bh=i+y+Cs1Mev+vCXSIQGBrXfz1qAeqb/m/Ab6qu9W0fEI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MyIAhHJxYV55uEWhs+CRJiFrc9Yip4TVAuYUeZ1vrbaX28csms3vAEjha/ECZxc55
         wp2j9xAqgvXGutjGatCov8iG4Ek3wGqTH5tLLiD+OcRteTQdT+okjuoHWKdRagG48J
         kp2s3mx0ju4Yj2kCQ+9QSRBCa+H4Kx1OZdTxQDhbtfDtgA+oF7QtBBG1cDMAuExZk0
         vuNWom69rQKIEXs5R46Dxft7CGCf9OlII75luFKFMLPzhdoEfCSOuPeqGfQ2HA27kJ
         yfSFZNYm/CiA4/UvkrW7+UGWUYNLWvkGIRCMLKik3AVsb69kTmccelOD/sxh0SJPZu
         OXHxSfjzSEMZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/08/2018 20:20, Dmitry Osipenko wrote:
> Add more predefined rates to the PLLX table, allowing to lower the rate
> down to 312MHz. This gives more variations of frequency selection to the
> CPUFREQ driver.

If these tables are pulled from some other NVIDIA kernel or a particular
document, I always like to see a reference to where these came from so
we can always refer back to them.

Cheers
Jon

-- 
nvpublic
