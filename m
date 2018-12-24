Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CB8C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FFF217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Zc7J0qkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLXIHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:07:07 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18103 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeLXIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:07:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c20939d0000>; Mon, 24 Dec 2018 00:06:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Dec 2018 00:07:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Dec 2018 00:07:06 -0800
Received: from [10.24.229.42] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 24 Dec
 2018 08:07:02 +0000
Subject: Re: [PATCH] scatterlist: Update size type to support greater then 4GB
 size.
To:     Christoph Hellwig <hch@infradead.org>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <axboe@kernel.dk>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <linux-crypto@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <vdumpa@nvidia.com>, <mmaddireddy@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <Snikam@nvidia.com>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
 <20181212080652.GA14877@infradead.org>
From:   Ashish Mhetre <amhetre@nvidia.com>
Message-ID: <c7dcdf51-3ade-90b5-aaf6-214e32aecd62@nvidia.com>
Date:   Mon, 24 Dec 2018 13:37:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212080652.GA14877@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545638813; bh=3pFyG3xe8DcvlXHjTZJeB9Jyl+ZtOZg6Daxpqoz1/O8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Zc7J0qkOzVbgCW9/Xd3ByQMWvKIIEDYXeIHwoKMZSSD1434Dzck+8821BexPhQ9HO
         JGrzTKG4+AtC9K/tZFwLtt/INUeELyX3JxMYgiPTdN80EQREDR0b7YSikOAMQdXl9k
         JUaR/WqgYNwfQK+KN5OmOtBgNDfYmOmNl44xbplDd+YCmZsiHQmmBjROoVCbFRVPwI
         ELtIcbSDcnAXP9eOj4sZB1/gNfDrY8bEEkSvxN5zBiHJXc8pnVTW7Vuyio/m9ceZuZ
         m8Bmo082r+31cMRr2R/FMQnBOBIDiLi+DjNehFO1UKRClCZWtihF/eFZOlmNvysJ8z
         dKYd8Gy2LditQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have a real use-case for this. Understanding the consequences, 
we are questioning the patch in downstream itself.
Please ignore this patch for now.

On 12/12/18 1:36 PM, Christoph Hellwig wrote:
> scatterlist elements longer than 4GB sound odd.  Please submit it
> in a series with your actual user so that we can help figuring out
> if it really makes sense or if there is a better way to solve your
> problem.
> 
> As is this patch will massively increase the memory usage for all users
> of struct scatterlist, so you better have a really good reason.
> 
