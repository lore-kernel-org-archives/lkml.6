Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648D9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2219020870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WlfxnWQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2219020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeGPSR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:17:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55768 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q1lBPBB7FpyA/Hrdte9tsJEA2bf9IIT062lVVzikLAk=; b=WlfxnWQvDDXPKQXlZ+VZrY0GHB
        PIopnvHcvepF43+uwb+nQBKT4JL7dMcyGQrUKbaituC8hJGlRADILPxCVr/NLVf+wLqRo+CJH4k8y
        +k4s4Z25qqnck56dExqQTHVmXSK07aYInJ2npwPLeJkHA3Z23iw9JcqAo7Ce8dr6eXQ21JObJBlKk
        yZjBocuTKdOqi1Rr3MRXQHm829djgjpZbf/M5zR0pszFjzKZG8WgJQVyEiKPYemqxArWb65dPg2o2
        XT08swheZ1295q1DHRWlYpVFjQUDqqeh0pENExg/4n6LqwZGUHs1BfEqIJuZdIW1z/lJE8lfNxpjy
        nTgC3H3A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ff7c8-0003ie-7L; Mon, 16 Jul 2018 17:48:49 +0000
Subject: Re: [PATCH 1/4] lib/crc64: add crc64 option to lib/Kconfig
To:     Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20180716165507.23100-1-colyli@suse.de>
 <20180716165507.23100-2-colyli@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9a57ba5a-ec33-b275-43f8-1fa103966d1d@infradead.org>
Date:   Mon, 16 Jul 2018 10:48:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716165507.23100-2-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 09:55 AM, Coly Li wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This patch adds crc64 option entry in lib/Kconfig. This patch is part of
> a patch originally written by Andy Shevchenko, Coly Li cherry-picks it
> and compose the commit log for a re-written crc64 source code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> ---
>  lib/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 706836ec314d..4059df9ec4c7 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -170,6 +170,14 @@ config CRC32_BIT
>  
>  endchoice
>  
> +config CRC64
> +	tristate "CRC64 functions"
> +	help
> +	  This option is provided for the case where no in-kernel-tree
> +	  modules require CRC64 functions, but a module built outside
> +	  the kernel tree does. Such modules that use library CRC64
> +	  functions require M he

eh?  missing something here.

> +
>  config CRC4
>  	tristate "CRC4 functions"
>  	help
> 


-- 
~Randy
