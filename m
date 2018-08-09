Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E583FC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 00:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EA221BC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 00:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EA221BC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbeHIDG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 23:06:59 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:46096 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeHIDG7 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 8 Aug 2018 23:06:59 -0400
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 09 Aug 2018 02:44:45 +0200
Date:   Thu, 9 Aug 2018 08:44:29 +0800
From:   joeyli <jlee@suse.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: acer-wmi: refactor function has_cap
Message-ID: <20180809004410.GF13767@linux-l9pv.suse>
References: <20180806203832.GA11751@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806203832.GA11751@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo, 

Sorry for my delay!

On Mon, Aug 06, 2018 at 03:38:32PM -0500, Gustavo A. R. Silva wrote:
> Refactor function has_cap in order to avoid returning integer
> values, when instead it should return booleans.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks for your patch and also thank Andy and Joe's help. 

Please feel free to add:

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com> 

Joey Lee

> ---
> Changes in v2:
> 	Remove parentheses and unnecessary code. Thank you all for
> 	the feedback!
> 
>  drivers/platform/x86/acer-wmi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 8952173..3294bb2 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -672,10 +672,7 @@ static void __init find_quirks(void)
>  
>  static bool has_cap(u32 cap)
>  {
> -	if ((interface->capability & cap) != 0)
> -		return 1;
> -
> -	return 0;
> +	return interface->capability & cap;
>  }
>  
>  /*
> -- 
> 2.7.4
> 
