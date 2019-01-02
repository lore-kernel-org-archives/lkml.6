Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08237C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6D7218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546460982;
	bh=Tlz+WDxhUktEFkRDtRxm+YNNoizm9JPaxd57VxJfvEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U2pGnV9Vr0iX13lm1Wj9QcUSF2cg4DcL4oHls6iVdLIy8dflVWbWkp7+/im/1BpbB
	 X76VqqbOigwyeyM6Mxxjg9qm7THof2POZAyYTrJUq2bKa79Tuuh79Q7T89hymWbFCb
	 slRvjIn32svWolMsSg4pUTva9SjbRkQeL7NUWkZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfABU3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:29:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfABU3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:29:41 -0500
Received: from linux-8ccs (unknown [47.156.141.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2CF21019;
        Wed,  2 Jan 2019 20:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546460981;
        bh=Tlz+WDxhUktEFkRDtRxm+YNNoizm9JPaxd57VxJfvEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXwcBt7fwCR5cnakizoh3wj+gkHqRtPK8T2nyx1M6cEzKyNhAdbBjb66et1/+a3md
         0Ngqkhz7oz/dBGe5qqjIlrl2lm02W5FQqYHEdYi4A0awJPo26xo80YcvF5nIywsB9c
         ZgjMok2k0UQs13V1bHCywUOBScdIVDAZCevH8V6c=
Date:   Wed, 2 Jan 2019 21:29:39 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Mathias Krause <minipli@googlemail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] vmlinux.lds.h: drop unused __vermagic
Message-ID: <20190102202938.GA26600@linux-8ccs>
References: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Mathias Krause [30/12/18 13:40 +0100]:
>The reference to '__vermagic' is a relict from v2.5 times. And even
>there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
>("Module Sanity Check") in the historic tree) to v2.5.69 (commit
>67ac5b866bda ("[PATCH] complete modinfo section")).
>
>Neither current kernels nor modules contain a '__vermagic' section any
>more, so get rid of it.
>
>Signed-off-by: Mathias Krause <minipli@googlemail.com>
>Cc: Rusty Russell <rusty@rustcorp.com.au>
>Cc: Jessica Yu <jeyu@kernel.org>

Thanks for the cleanup.

Reviewed-by: Jessica Yu <jeyu@kernel.org>

>---
> include/asm-generic/vmlinux.lds.h | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index 3d7a6a9c2370..530ce1e7a1ec 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -332,7 +332,6 @@
> 		__start_rodata = .;					\
> 		*(.rodata) *(.rodata.*)					\
> 		RO_AFTER_INIT_DATA	/* Read only after init */	\
>-		KEEP(*(__vermagic))	/* Kernel version magic */	\
> 		. = ALIGN(8);						\
> 		__start___tracepoints_ptrs = .;				\
> 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
>-- 
>2.19.2
>
