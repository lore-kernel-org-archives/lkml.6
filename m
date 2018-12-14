Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA24C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EF1208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544821173;
	bh=QIyRYcDS8dvfL8d9WoHeQ5SoQird6ZVQTKa3VcZN68M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xMP1Rtyps7DzmGAl3r9gnNfs1cJ8W6HEX39Bt5ZvLMq5Jn4iuX+j0e7Wie2LdXCnE
	 tryaa0AB/CvHg3f+zFQdL2CXz1eB0K7SJC2wkK/ef1OQGhN2OBGUhmwHsuv2T3N4Es
	 d1uk+AEZzPCawIQVdGQaWQCMEFntoSJtnzaBDQjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeLNU7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:59:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbeLNU7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:59:30 -0500
Received: from linux-8ccs (ip5f5adea1.dynamic.kabel-deutschland.de [95.90.222.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0399B2086D;
        Fri, 14 Dec 2018 20:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544821170;
        bh=QIyRYcDS8dvfL8d9WoHeQ5SoQird6ZVQTKa3VcZN68M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8YEMqbYWYKeWuKqXyZQ8WixEa2VEPiQ4Z+TIj6eQRi13XxmpZEJKn9NpaYWgltNv
         3sqBnyhFDMNc6QRmAF0RmX7/t9byJgl1Z6aG7lRa7P9VQwYk4J8jXEVGJY2GzrkhrH
         rU+PLBE0xObwAKO6zoDrFGuIi9Te2vMbMgj6Qnvs=
Date:   Fri, 14 Dec 2018 21:59:25 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux@armlinux.org.uk, dave.martin@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v6 modules-next 1/2] module: Overwrite st_size instead of
 st_info
Message-ID: <20181214205925.GA9656@linux-8ccs>
References: <20181214160555.9980-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181214160555.9980-1-vincent.whitchurch@axis.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Vincent Whitchurch [14/12/18 17:05 +0100]:
>st_info is currently overwritten after relocation and used to store the
>elf_type().  However, we're going to need it fix kallsyms on ARM's
>Thumb-2 kernels, so preserve st_info and overwrite the st_size field
>instead.  st_size is neither used by the module core nor by any
>architecture.
>
>Reviewed-by: Miroslav Benes <mbenes@suse.cz>
>Reviewed-by: Dave Martin <Dave.Martin@arm.com>
>Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Applied both. (Thanks for rebasing!)

Thanks,

Jessica

>---
>v6: Add Miroslav Benes' Reviewed-by
>v5: Add Dave Martin's Reviewed-by
>v4: Split out to separate patch.  Use st_size instead of st_other.
>v1-v3: See PATCH 2/2
>
> kernel/module.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 1b5edf78694c..b36ff8a3d562 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2684,7 +2684,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>
> 	/* Set types up while we still have access to sections. */
> 	for (i = 0; i < mod->kallsyms->num_symtab; i++)
>-		mod->kallsyms->symtab[i].st_info
>+		mod->kallsyms->symtab[i].st_size
> 			= elf_type(&mod->kallsyms->symtab[i], info);
>
> 	/* Now populate the cut down core kallsyms for after init. */
>@@ -4070,7 +4070,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> 		kallsyms = rcu_dereference_sched(mod->kallsyms);
> 		if (symnum < kallsyms->num_symtab) {
> 			*value = kallsyms->symtab[symnum].st_value;
>-			*type = kallsyms->symtab[symnum].st_info;
>+			*type = kallsyms->symtab[symnum].st_size;
> 			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
> 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
> 			*exported = is_exported(name, *value, mod);
>-- 
>2.11.0
>
