Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764A12083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ftk4huea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764A12083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIGXbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:31:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeIGXbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dFThqU3tIuS4vVcqI60vnNRJnvl9nZTUdiZ4/TwWp80=; b=ftk4huea3ELtTPjtMBApACYbz
        FFcqXewrlNp/gzXmKFK4rt9XgVRAZi64LKOYcafjkGo8rVzFPi74YMimditeAOHbZdBi5R/g2+FN0
        xqC9d/0PG3aiQlhhvzQR5JVrLj+NV4HXk5U8wLowDgC4KUNL0WcYc2rZ18lOrQrAkJkfbUGdEM10w
        2Cncp9KbyXSDvF8dwqds3pBIDh2GwHEUt1lDsMWoRV+2zFudrenz/1y4FbY0keC4mZLaqrRtqMrf+
        IEfbOq6Fdl6OkvcqCKxF9KEak4gPvdXWpv9swhiLWIHaqytQ6Alrd23tyb2BFPxqqAI1OpX09dUho
        N4ADqR8gg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyLol-0002M0-Lc; Fri, 07 Sep 2018 18:49:19 +0000
Subject: Re: [PATCH 6/6] Drop flex_arrays
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-7-kent.overstreet@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d9b1c3bc-5251-ca1f-835b-cd4f266c798b@infradead.org>
Date:   Fri, 7 Sep 2018 11:49:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907165635.8469-7-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 09:56 AM, Kent Overstreet wrote:
> All existing users have been converted to generic radix trees
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> ---
>  Documentation/core-api/flexible-arrays.rst | 130 -------
>  Documentation/flexible-arrays.txt          | 123 -------
>  include/linux/flex_array.h                 | 149 --------
>  include/linux/poison.h                     |   3 -
>  lib/Makefile                               |   2 +-
>  lib/flex_array.c                           | 398 ---------------------
>  tools/include/linux/poison.h               |   3 -
>  7 files changed, 1 insertion(+), 807 deletions(-)
>  delete mode 100644 Documentation/core-api/flexible-arrays.rst
>  delete mode 100644 Documentation/flexible-arrays.txt
>  delete mode 100644 include/linux/flex_array.h
>  delete mode 100644 lib/flex_array.c

Also drop one line from Documentation/core-api/index.rst:

    genericirq
-   flexible-arrays
    librs


thanks,
-- 
~Randy
