Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC1FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D21E24708
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D21E24708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeGDHv7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:51:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17947 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbeGDHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:51:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3c7c9c0006>; Wed, 04 Jul 2018 00:51:56 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Jul 2018 00:51:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Jul 2018 00:51:56 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 4 Jul
 2018 07:51:54 +0000
Date:   Wed, 4 Jul 2018 10:51:48 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Peter Geis <pgwipeout@gmail.com>
CC:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/3] clk: tegra: refactor 7.1 div calculation
Message-ID: <20180704105148.1e32d307@dhcp-10-21-25-168>
In-Reply-To: <46bc7178-f8a4-cc4e-ebe3-507671ffb735@gmail.com>
References: <1530617721-5767-1-git-send-email-avienamo@nvidia.com>
        <46bc7178-f8a4-cc4e-ebe3-507671ffb735@gmail.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 11:10:21 -0400
Peter Geis <pgwipeout@gmail.com> wrote:

> Good Morning,
> 
> Just a heads up.
> During compilation with your patches, I get the following warning:
> 
> In file included from ./arch/arm/include/asm/div64.h:127:0,
>                   from ./include/linux/kernel.h:174,
>                   from drivers/clk/tegra/div71.c:17:
> drivers/clk/tegra/div71.c: In function ‘div71_get’:
> ./include/asm-generic/div64.h:222:28: warning: comparison of distinct 
> pointer types lacks a cast
>    (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                              ^
> drivers/clk/tegra/div71.c:40:2: note: in expansion of macro ‘do_div’
>    do_div(divider_ux1, rate);
>    ^~~~~~
> 
> Very Respectfully,
> Peter Geis
> 
 
That's indeed true. Looks like this warning is produced only on 32-bit
arm as it uses a different variant of the do_div macro than arm64.

Thanks,
 -Aapo
