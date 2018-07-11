Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB59C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9128920BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9128920BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbeGKLVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:21:49 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16855 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbeGKLVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:21:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b45e7630000>; Wed, 11 Jul 2018 04:17:55 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 04:17:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 11 Jul 2018 04:17:54 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 11:17:57 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id 2D79BF8009D; Wed, 11 Jul 2018 14:17:54 +0300 (EEST)
Date:   Wed, 11 Jul 2018 14:17:54 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Jon Hunter <jonathanh@nvidia.com>
CC:     Aapo Vienamo <avienamo@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] clk: tegra: refactor 7.1 div calculation
Message-ID: <20180711111754.GC1636@tbergstrom-lnx.Nvidia.com>
References: <1531154338-3998-1-git-send-email-avienamo@nvidia.com>
 <1531154338-3998-3-git-send-email-avienamo@nvidia.com>
 <5805047f-4099-db34-0759-42e4a9e11629@nvidia.com>
 <20180711080022.GB1636@tbergstrom-lnx.Nvidia.com>
 <ef90eb24-e993-9cc1-ac09-5afedeceba75@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef90eb24-e993-9cc1-ac09-5afedeceba75@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:42:20AM +0100, Jon Hunter wrote:
> 
> On 11/07/18 09:00, Peter De Schrijver wrote:
> > On Tue, Jul 10, 2018 at 05:17:05PM +0100, Jon Hunter wrote:
> >>
> >> On 09/07/18 17:38, Aapo Vienamo wrote:
> >>> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> >>>
> >>> Move this to a separate file so it can be used to calculate the sdmmc
> >>> clock dividers.
> >>
> >> Sorry for not commenting sooner, but what is the motivation for moving
> >> this to its own file? I don't see why we need to do this in order to use
> >> elsewhere. Furthermore, the original file is quite aptly named 'clk-divider.c'
> >> and now we have a div71.c which seems quite specific.
> > 
> > How else would you do it?
> 
> Keep it in the same file?
> 

That seems odd. clk-divider.c is meant to implement a clock type, not
utility functions we happen to need in several types.

Peter.
