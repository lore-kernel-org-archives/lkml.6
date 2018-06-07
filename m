Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2OkpJSZ4GVt6LQAAmS7hNA
	; Thu, 07 Jun 2018 18:37:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 87FC8606FA; Thu,  7 Jun 2018 18:37:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E8167601C3;
	Thu,  7 Jun 2018 18:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8167601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbeFGShE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:37:04 -0400
Received: from smtprelay0181.hostedemail.com ([216.40.44.181]:43832 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753781AbeFGShD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:37:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D69A91907476C;
        Thu,  7 Jun 2018 18:37:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: linen31_5a5f40746d91d
X-Filterd-Recvd-Size: 1889
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Jun 2018 18:37:00 +0000 (UTC)
Message-ID: <1bcb1e168f863ed5946327b54ceb64f6694c6b86.camel@perches.com>
Subject: Re: [PATCH] Staging:rtl8192e Replace function names by using
 __func__
From: Joe Perches <joe@perches.com>
To: Janani Sankara Babu <jananis37@gmail.com>,
        gregkh@linuxfoundation.org
Cc: johannes.berg@intel.com, davem@davemloft.net,
        keescook@chromium.org, Rene.Hickersberger@gmx.at,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Thu, 07 Jun 2018 11:36:59 -0700
In-Reply-To: <1528428555-7884-1-git-send-email-jananis37@gmail.com>
References: <1528428555-7884-1-git-send-email-jananis37@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 23:29 -0400, Janani Sankara Babu wrote:
> This patch is created to solve the warning shown by checkpatch script
> Prefer using '"%s...", __func__' to using ', this function's name,
> in a string
[]
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
[]
> @@ -127,7 +127,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
>  	}
> 
>  #ifdef VERBOSE_DEBUG
> -	print_hex_dump_bytes("rtllib_ADDBA(): ", DUMP_PREFIX_NONE, skb->data,
> +	print_hex_dump_bytes("%s(): ", __func__, DUMP_PREFIX_NONE, skb->data,
>  			     skb->len);

You didn't compile this with VERBOSE_DEBUG enabled.

You are adding arguments to a function that takes
a fixed number of arguments.

checkpatch is mindless.

Please don't mindlessly do what it says, just try
to improve the code readability where it's unclear
and especially try to find and fix logic defects.
