Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89EAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F9216FA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8F9216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeHHKbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:31:31 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:43493 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726939AbeHHKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:31:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0EAC718034F63;
        Wed,  8 Aug 2018 08:12:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chess47_8df9607785229
X-Filterd-Recvd-Size: 1670
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Aug 2018 08:12:55 +0000 (UTC)
Message-ID: <f06112b569731e2c5de3958d1b9de5a039b7ed0d.camel@perches.com>
Subject: Re: [PATCH 04/17] staging:rtl8192u: Rename eqMacAddr macro - Style
From:   Joe Perches <joe@perches.com>
To:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Date:   Wed, 08 Aug 2018 01:12:53 -0700
In-Reply-To: <20180807211255.29343-5-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
         <20180807211255.29343-5-johnfwhitmore@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-07 at 22:12 +0100, John Whitmore wrote:
> The eqMacAddr(a, b) macro causes a checkpatch issue, due to CamelCase
> naming, so has been renamed to eq_mac_addr(a, b).
> 
> This is a coding style change which should not impact on runtime code
> execution.
[]
> diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
[]
> @@ -30,7 +30,7 @@ struct rt_dot11d_info {
>  	enum dot11d_state state;
>  };
>  
> -#define eqMacAddr(a, b)		(((a)[0] == (b)[0] &&		    \
> +#define eq_mac_addr(a, b)		(((a)[0] == (b)[0] &&		    \
>  	(a)[1] == (b)[1] && (a)[2] == (b)[2] && (a)[3] == (b)[3] && \
>  	(a)[4] == (b)[4] && (a)[5] == (b)[5]) ? 1 : 0)

I'd check to see if the etherdevice.h ether_addr_equal
would be used instead of this macro.

