Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12261C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEBD20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEBD20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeICMUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:20:16 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15513 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeICMUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:20:15 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b8cea450000>; Mon, 03 Sep 2018 01:01:09 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Sep 2018 01:01:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 03 Sep 2018 01:01:16 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Sep
 2018 08:01:16 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id 73103F8086D; Mon,  3 Sep 2018 11:01:11 +0300 (EEST)
Date:   Mon, 3 Sep 2018 11:01:11 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] clk: tegra20: Enable lock-status polling for PLLs
Message-ID: <20180903080111.GR1636@tbergstrom-lnx.Nvidia.com>
References: <20180830184210.5369-1-digetx@gmail.com>
 <20180830184210.5369-2-digetx@gmail.com>
 <20180831092948.GP1636@tbergstrom-lnx.Nvidia.com>
 <909e2a52-4116-9ee7-db23-8ea1dfffade0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <909e2a52-4116-9ee7-db23-8ea1dfffade0@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:45:17PM +0300, Dmitry Osipenko wrote:
> On 8/31/18 12:29 PM, Peter De Schrijver wrote:
> > On Thu, Aug 30, 2018 at 09:42:10PM +0300, Dmitry Osipenko wrote:
> >> Currently all PLL's on Tegra20 use a hardcoded delay despite of having
> >> a lock-status bit. The lock-status polling was disabled ~7 years ago
> >> because PLLE was failing to lock and was a suspicion that other PLLs
> >> might be faulty too. Other PLLs are okay, hence enable the lock-status
> >> polling for them. This reduces delay of any operation that require PLL
> >> to lock.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>
> >> Changelog:
> >>
> >> v2:	Don't enable polling for PLLE as it known to not being able to lock.
> >>
> > 
> > This isn't correct. The lock bit of PLLE can declare lock too early, but the
> > PLL itself does lock.
> 
> Indeed, it locks but can't be polled for the lock-status as it doesn't have the
> lock-status bit.
> 
> Do you want me to adjust the commit description or it is fine as is?
> 

I think it's better to adjust it.

> It is also a bit odd that PLLE has "lock_delay = 0", is it correct?

That seems odd yes..

Peter.
