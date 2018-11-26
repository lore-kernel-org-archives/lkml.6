Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DA2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF3A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF3A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeK0JxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:53:16 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.229]:11251 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbeK0JxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:53:16 -0500
X-Greylist: delayed 1255 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 04:53:16 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 0E7A0704E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:36:43 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RPUggiVYoSjJARPUhg6DJW; Mon, 26 Nov 2018 16:36:43 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=59722 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRPUg-002X2c-Cz; Mon, 26 Nov 2018 16:36:42 -0600
Subject: Re: linux-next: build warning after merge of the f2fs tree
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181126111933.1b0fb324@canb.auug.org.au>
 <20181126215924.GA55960@jaegeuk-macbookpro.roam.corp.google.com>
 <20181127091747.4830d123@canb.auug.org.au>
 <20181126222257.GB55960@jaegeuk-macbookpro.roam.corp.google.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <37611a15-da14-1796-5f4c-1278d46a4329@embeddedor.com>
Date:   Mon, 26 Nov 2018 16:36:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126222257.GB55960@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.127
X-Source-L: No
X-Exim-ID: 1gRPUg-002X2c-Cz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.78.127]:59722
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/18 4:22 PM, Jaegeuk Kim wrote:
> On 11/27, Stephen Rothwell wrote:
[..]
> 
> Oh, thanks~
> Is this okay?
> 

Yep. This fix the warning. :)

Thanks, Jaegeuk
--
Gustavo

>  From 79e24f1509e5b6a07069be9cc8163969da78c57a Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Mon, 26 Nov 2018 14:20:32 -0800
> Subject: [PATCH] f2fs: avoid build warn of fall_through
> 
> After merging the f2fs tree, today's linux-next build
>   (x86_64_allmodconfig) produced this warning:
> 
>   In file included from fs/f2fs/dir.c:11:
>   fs/f2fs/f2fs.h: In function '__mark_inode_dirty_flag':
>   fs/f2fs/f2fs.h:2388:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      if (set)
>         ^
>   fs/f2fs/f2fs.h:2390:2: note: here
>     case FI_DATA_EXIST:
>     ^~~~
> 
>   Exposed by my use of -Wimplicit-fallthrough
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/f2fs.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 26ad1de8641c..b3fe6803d4c6 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2387,6 +2387,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>   	case FI_NEW_INODE:
>   		if (set)
>   			return;
> +		/* fall through */
>   	case FI_DATA_EXIST:
>   	case FI_INLINE_DOTS:
>   	case FI_PIN_FILE:
> 
