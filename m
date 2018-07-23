Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71ED20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a43yuFq6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ap4S/upU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71ED20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbeGWXxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:53:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeGWXxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:53:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 30A6F60B15; Mon, 23 Jul 2018 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532386228;
        bh=/Br1l6yKPHuuaxyYd5Mx2l52sdBHt6nau3QvIsxH1zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a43yuFq6bYwejMEOvwrqyPTQxSxOv+QU2j1p9d+YnlGbfCV2VU38rHgvKWluOE/K9
         +edK1mIDINug260n10SOPmzCk7f6GbVy5xHrkDls/cSiZeH585CuzE02/aFkjL46pH
         Mob60scjPngoaNyOB2JoVwkB8qXXNFqVxRdTHrVI=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A7786071B;
        Mon, 23 Jul 2018 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532386227;
        bh=/Br1l6yKPHuuaxyYd5Mx2l52sdBHt6nau3QvIsxH1zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ap4S/upUYPeqbFCLrnq8ls7yOips/pBnwel0s7Osq9/EYGXfijG+eR2kX7jgB77tj
         3eRt7Nxhz9PynKQyg/IFxOp8wnYwvTunR3t7WxMhVTdjCxZevdPCSrpeYeOeR1H0vv
         ySpF4Po7S5kzs7MiKxUvKRqKyhQyuM78JIlbkkyw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A7786071B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Mon, 23 Jul 2018 17:50:25 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] hexagon: modify ffs() and fls() to return int
Message-ID: <20180723225025.GC12771@codeaurora.org>
References: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 04:03:58PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
> printk format build warning.  This is due to hexagon's ffs() being
> coded as returning long instead of int.
> 
> Fix the printk format warning by changing all of hexagon's ffs() and
> fls() functions to return int instead of long.  The variables that
> they return are already int instead of long.  This return type
> matches the return type in <asm-generic/bitops/>.
> 
> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
> 
> There are no ffs() or fls() allmodconfig build errors after making this
> change.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
> add hexagon contacts, drop erroneous sh contacts; [thanks, Geert]
> only change return type for ffs() and fls() [thanks, Geert]
>   [drop the changes for ffz(), __ffs(), and __fls()]
> 
>  arch/hexagon/include/asm/bitops.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
