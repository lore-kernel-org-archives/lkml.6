Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57A3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE4020852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nuOOyoxw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h2wE1biV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE4020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbeGXAen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:34:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388130AbeGXAen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:34:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6321160B15; Mon, 23 Jul 2018 23:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532388669;
        bh=FvPmG4TIwWg8Cx5qQHofK9kEKxmFe6MT8oh2lOjySjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuOOyoxw5Vtaya76n1Pi77rvBxMMu1TrCpbLrw9DVQflGp5JERCiMfB7R38I2e5ty
         7km+CATuS1j9vsHdzF+BGvLDemsyfpMdhLu3/czN2hJ3QbmPmDIoPTUgydsk3AE8Rs
         FFN0PDQdu3Vc0f7PZkpVr90qcriT4r2K4D+IVVXk=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28E04602D7;
        Mon, 23 Jul 2018 23:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532388668;
        bh=FvPmG4TIwWg8Cx5qQHofK9kEKxmFe6MT8oh2lOjySjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2wE1biVItExXMh/NcagTtZgTwCzFQQXnjW7cpr3LUKyGGwHIO1RcPXhCowFYI13i
         znp4NvhMNUrhY3epPC/v60/rGkmHvVVKl89nWbc63FhG7/+Nsdoyw4Jh5nTlsV65zb
         f/m+KkFD1qmb4SHLWPCsebs/om8+Mq6yo2ClWMuI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28E04602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Mon, 23 Jul 2018 18:31:06 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] hexagon: modify ffs() and fls() to return int
Message-ID: <20180723233106.GD12771@codeaurora.org>
References: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
 <20180723225025.GC12771@codeaurora.org>
 <39ac5a3f-b5fa-a928-6caf-a7a01251f5ea@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ac5a3f-b5fa-a928-6caf-a7a01251f5ea@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:27:47PM -0700, Randy Dunlap wrote:
> On 07/23/2018 03:50 PM, Richard Kuo wrote:
> > On Sun, Jul 22, 2018 at 04:03:58PM -0700, Randy Dunlap wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
> >> printk format build warning.  This is due to hexagon's ffs() being
> >> coded as returning long instead of int.
> >>
> >> Fix the printk format warning by changing all of hexagon's ffs() and
> >> fls() functions to return int instead of long.  The variables that
> >> they return are already int instead of long.  This return type
> >> matches the return type in <asm-generic/bitops/>.
> >>
> >> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
> >> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
> >>
> >> There are no ffs() or fls() allmodconfig build errors after making this
> >> change.
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Richard Kuo <rkuo@codeaurora.org>
> >> Cc: linux-hexagon@vger.kernel.org
> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >> ---
> >> v2:
> >> add hexagon contacts, drop erroneous sh contacts; [thanks, Geert]
> >> only change return type for ffs() and fls() [thanks, Geert]
> >>   [drop the changes for ffz(), __ffs(), and __fls()]
> >>
> >>  arch/hexagon/include/asm/bitops.h |    4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> > 
> > 
> > Acked-by: Richard Kuo <rkuo@codeaurora.org>
> > 
> 
> Hi Richard,
> 
> You are listed as the arch/hexagon/ maintainer.  Can you please merge these
> patches?
> 
> thanks,
> -- 
> ~Randy

Yes, I can queue it up and take it through my tree.


Thanks,
Richard Kuo


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
