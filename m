Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3526720684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3526720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394159AbeKVU6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:58:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:51370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387447AbeKVU6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:58:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0EA5AD55;
        Thu, 22 Nov 2018 10:19:48 +0000 (UTC)
Date:   Thu, 22 Nov 2018 11:19:48 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jessica Yu <jeyu@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: make it clearer when we're handling kallsyms
 symbols vs exported symbols
In-Reply-To: <20181121175116.30025-1-jeyu@kernel.org>
Message-ID: <alpine.LSU.2.21.1811221109220.6711@pobox.suse.cz>
References: <20181121175116.30025-1-jeyu@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Jessica Yu wrote:

> The module loader internally works with both exported symbols
> represented as struct kernel_symbol, as well as Elf symbols from a
> module's symbol table. It's hard to distinguish sometimes which type of
> symbol we're handling given that some helper function names are not
> consistent or helpful. Take get_ksymbol() for instance - are we
> looking for an exported symbol or a kallsyms symbol here? Or symname()
> and kernel_symbol_name() - which function handles an exported symbol and
> which one an Elf symbol?
> 
> Clean up and unify the function naming scheme a bit to make it clear
> which kind of symbol we're handling. This change only affects static
> functions internal to the module loader.
> 
> Signed-off-by: Jessica Yu <jeyu@kernel.org>

Great. It should help a lot. Pity we cannot rename find_symbol() as well.

I have only a naming nit. I think it is nice to have 
<verb>_exported_<noun> convention. New kallsyms_ names don't hold it 
though. Wouldn't it be better to be consistent and have 
find_kallsyms_symbol() instead of kallsyms_find_symbol()? Or we could do 
the opposite and have a "namespace" prefix first. That is, 
exported_<verb>_<noun>. However, I don't like it that much. 

To be honest, your approach may be the best in the end.

What do you think?

Regards,
Miroslav
