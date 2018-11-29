Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B3DC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8544B205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8544B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeK2TXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:23:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:33082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726780AbeK2TXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:23:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 024BFAEA3;
        Thu, 29 Nov 2018 08:18:40 +0000 (UTC)
Date:   Thu, 29 Nov 2018 09:18:39 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jessica Yu <jeyu@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: make it clearer when we're handling kallsyms
 symbols vs exported symbols
In-Reply-To: <20181123164104.6054-1-jeyu@kernel.org>
Message-ID: <alpine.LSU.2.21.1811290917310.21084@pobox.suse.cz>
References: <20181123164104.6054-1-jeyu@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018, Jessica Yu wrote:

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

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
