Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC45CC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B50521A8F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B50521A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeHKXx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 19:53:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46460 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeHKXx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 19:53:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1foZYS-0001JQ-EN; Sat, 11 Aug 2018 19:28:04 +0000
Date:   Sat, 11 Aug 2018 20:28:04 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-alpha@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
Subject: Re: [PATCH 1/6] alpha: Move __IGNORE* entries to non uapi header
Message-ID: <20180811192804.GI6515@ZenIV.linux.org.uk>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-2-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531736638-15294-2-git-send-email-firoz.khan@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 03:53:53PM +0530, Firoz Khan wrote:
> It is correct to keep __IGNORE* entry in non uapi header
> asm/unistd.h while uapi/asm/unistd.h must hold information
> only useful for user space applications.

> diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
> index e153ca6..3bb6ac1 100644
> --- a/arch/alpha/include/uapi/asm/unistd.h
> +++ b/arch/alpha/include/uapi/asm/unistd.h
> @@ -481,9 +481,4 @@
>  #define __NR_pwritev2			521
>  #define __NR_statx			522
>  
> -/* Alpha doesn't have protection keys. */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
> -
>  #endif /* _UAPI_ALPHA_UNISTD_H */

Hmm...  There's also

#define __IGNORE_alarm
#define __IGNORE_creat
#define __IGNORE_getegid
#define __IGNORE_geteuid
#define __IGNORE_getgid
#define __IGNORE_getpid
#define __IGNORE_getppid
#define __IGNORE_getuid
#define __IGNORE_pause
#define __IGNORE_time
#define __IGNORE_utime
#define __IGNORE_umount2

in there...
