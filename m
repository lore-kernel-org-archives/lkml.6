Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD801C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B86E206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z8YnJdVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbeLNQZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:25:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60704 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbeLNQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jfco13n+1H9tZN43pnQnP7RAD8tlWGPz72vq0fB1OPk=; b=z8YnJdViN30AsYbewzYWg87hWD
        /xJuwOxO9sZy0x/KPzNetbrlRBQjs9LGhLyuUYZjugYelZ5k7GiAyHvcCjwfBSMtwgXxe5xeeArv/
        PBV5EO2yPYykAEaWhGSvood64CRnztJUqACpf/LWbdYFh8TndMEAuLmhcmSqTlKzQdUpJDygBOd9m
        odczxhWq8lBDn1l7xo8O6DUC+TOX9RudxR6yRrHAv4328EuvERCAbDVfGz4WXSFJBPsIEsQLBehU3
        VV1/tDr2I2s8viGNJcnJGoArHJIZxHu+FMCnL61+f4C7i0U8mG2VkRaGZZUjVYtgYeUqwsbQlGRFH
        gxllb2lA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXqHR-0007tr-7h; Fri, 14 Dec 2018 16:25:37 +0000
Subject: Re: linux-next: Tree for Dec 14 (security/integrity/ima/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org
References: <20181214181826.5775b958@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8205aafb-bbc1-2196-17d9-e70e9ac56c2e@infradead.org>
Date:   Fri, 14 Dec 2018 08:25:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181214181826.5775b958@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/18 11:18 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181213:
> 

on i386:

  CC      security/integrity/ima/ima_main.o
../security/integrity/ima/ima_main.c: In function 'ima_load_data':
../security/integrity/ima/ima_main.c:535:3: error: implicit declaration of function 'is_module_sig_enforced' [-Werror=implicit-function-declaration]
   sig_enforce = is_module_sig_enforced();
   ^


Needs:

---
 security/integrity/ima/ima_main.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20181214.orig/security/integrity/ima/ima_main.c
+++ linux-next-20181214/security/integrity/ima/ima_main.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
+#include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/mman.h>
 #include <linux/slab.h>



-- 
~Randy
