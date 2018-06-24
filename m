Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9370BC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF942516E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF942516E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755087AbeFXP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:59:27 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:60894 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754881AbeFXP7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:59:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B436F181D341D;
        Sun, 24 Jun 2018 15:59:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ball06_8c383ae65800a
X-Filterd-Recvd-Size: 1939
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 Jun 2018 15:59:23 +0000 (UTC)
Message-ID: <ed1a3747023af619d547e1ef7d593fd25b3abcb7.camel@perches.com>
Subject: Re: [PATCH v3 7/8] staging: rtl8192u: Correct if statement - Coding
 Style
From:   Joe Perches <joe@perches.com>
To:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Date:   Sun, 24 Jun 2018 08:59:22 -0700
In-Reply-To: <20180624153454.27356-8-johnfwhitmore@gmail.com>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
         <20180624153454.27356-8-johnfwhitmore@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-24 at 16:34 +0100, John Whitmore wrote:
> Corrected the coding style of if statement.
[]
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
[]
> @@ -732,7 +732,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
>  	   section of code.
>  	if(IS_UNDER_11N_AES_MODE(Adapter))
>  	{
> -		posRT2RTAgg->Octet[5] |=RT_HT_CAP_USE_AMPDU;
> +		posRT2RTAgg->Octet[5] |= RT_HT_CAP_USE_AMPDU;
>  	}else
>  	{
>  		posRT2RTAgg->Octet[5] &= 0xfb;

Rather than doing individual patches for each line
with a whitespace issue, I think it'd be better to
do a single driver wide patch.

Perhaps use a tool like:

$ git ls-files drivers/staging/rtl8192u |
  xargs ./scripts/checkpatch.pl -f --fix-inplace --types=spacing

where:

$ git diff -w drivers/staging/rtl8192u/

should not show a single difference.

Then compile and commit that as a single patch with
something like "use a more typical spacing style"
as the commit message.

