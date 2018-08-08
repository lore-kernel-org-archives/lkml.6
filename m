Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C247C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E40C216FA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E40C216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeHHKcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:32:47 -0400
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:47849 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726979AbeHHKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:32:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 39C43100E86C3;
        Wed,  8 Aug 2018 08:14:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tent88_7a0b7b750b1f
X-Filterd-Recvd-Size: 1679
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Aug 2018 08:14:12 +0000 (UTC)
Message-ID: <5da4869d686787c55bb097305659693e471e86e8.camel@perches.com>
Subject: Re: [PATCH 05/17] staging:rtl8192u: Rename cpMacAddr Macro - Style
From:   Joe Perches <joe@perches.com>
To:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Date:   Wed, 08 Aug 2018 01:14:11 -0700
In-Reply-To: <20180807211255.29343-6-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
         <20180807211255.29343-6-johnfwhitmore@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-07 at 22:12 +0100, John Whitmore wrote:
> Rename the Macro cpMacAddr(des, src), as it causes a checkpatch issue
> due its use of CamelCase naming, to cp_mac_addr(des, src).
[]
> diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
[]
> @@ -33,7 +33,7 @@ struct rt_dot11d_info {
>  #define eq_mac_addr(a, b)		(((a)[0] == (b)[0] &&		    \
>  	(a)[1] == (b)[1] && (a)[2] == (b)[2] && (a)[3] == (b)[3] && \
>  	(a)[4] == (b)[4] && (a)[5] == (b)[5]) ? 1 : 0)
> -#define cpMacAddr(des, src)	      ((des)[0] = (src)[0], \
> +#define cp_mac_addr(des, src)	      ((des)[0] = (src)[0], \
>  	(des)[1] = (src)[1], (des)[2] = (src)[2], \
>  	(des)[3] = (src)[3], (des)[4] = (src)[4], \
>  	(des)[5] = (src)[5])

And this could be ether_addr_copy

