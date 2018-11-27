Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC7DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CC0208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlK1HXX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CC0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbeK0W5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:57:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbeK0W5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:57:46 -0500
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428052082F;
        Tue, 27 Nov 2018 12:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543320006;
        bh=kQmoouvl14YlG9VLJA4nVKVE81WjAE5O/WCIhK/ze+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlK1HXX4UFwh6Q0d19Opyp6z4VAyN5j7wt02Hx8n9Dya+TLOWqMII2hbY5XhtUjZc
         N7yueX388p+Q/8lCO/xFX53r60K14Hvva1G/IAnTUa7wUxOLc3VjoQzVWcOEb9kjpv
         F2Z3vhnLcHEtF531FzBUalVaPiXaBF8XLwYQ9SDE=
Date:   Tue, 27 Nov 2018 13:00:02 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: remove some duplicated includes
Message-ID: <20181127120002.GA17708@linux-8ccs>
References: <20181126142116.31090-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181126142116.31090-1-tiny.windzz@gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Yangtao Li [26/11/18 09:21 -0500]:
>We include elf.h twice in module.c. It's unnecessary.
>hence just remove them.
>
>Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>---
> kernel/module.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 49a405891587..438641fc4096 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -28,7 +28,6 @@
> #include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/vmalloc.h>
>-#include <linux/elf.h>
> #include <linux/proc_fs.h>
> #include <linux/security.h>
> #include <linux/seq_file.h>

elf.h is not _directly_ included twice in module.c, although it is
included by other header files that module.c pulls in. I'd rather keep
things as-is, since we shouldn't depend on other header files to pull
in the headers we want. I think it's better to keep the explicit
dependence/inclusion of elf.h in module.c.

Thanks,

Jessica
