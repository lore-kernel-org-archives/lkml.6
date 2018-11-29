Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8304C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D0D213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="McLgRLzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D0D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeK3FHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:07:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbeK3FHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:07:08 -0500
Received: from linux-8ccs (ip5f5ade7c.dynamic.kabel-deutschland.de [95.90.222.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7276213A2;
        Thu, 29 Nov 2018 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543514456;
        bh=7FLr58dheaSAWqR/sgmSjCSuAA5hPSAbTCV/eOeU7Vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McLgRLzjywtavr/NRxXvCWUAHLNHxg8AYIFdczwT4O9kb5Cx8189cLp14b8iCSbn/
         fp82Qf8uUBmUzYKte5C3hNNJKBhvuyYYMgKPIZjuDq13jZab81ijCThFVCdSlN/7tX
         YtbR/b20Cz/CHQar1gpJ0w6s7JLU215Ns1Eb9kcc=
Date:   Thu, 29 Nov 2018 19:00:52 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: make it clearer when we're handling kallsyms
 symbols vs exported symbols
Message-ID: <20181129180052.GA10810@linux-8ccs>
References: <20181123164104.6054-1-jeyu@kernel.org>
 <alpine.LSU.2.21.1811290917310.21084@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1811290917310.21084@pobox.suse.cz>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [29/11/18 09:18 +0100]:
>On Fri, 23 Nov 2018, Jessica Yu wrote:
>
>> The module loader internally works with both exported symbols
>> represented as struct kernel_symbol, as well as Elf symbols from a
>> module's symbol table. It's hard to distinguish sometimes which type of
>> symbol we're handling given that some helper function names are not
>> consistent or helpful. Take get_ksymbol() for instance - are we
>> looking for an exported symbol or a kallsyms symbol here? Or symname()
>> and kernel_symbol_name() - which function handles an exported symbol and
>> which one an Elf symbol?
>>
>> Clean up and unify the function naming scheme a bit to make it clear
>> which kind of symbol we're handling. This change only affects static
>> functions internal to the module loader.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>
>Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Applied, thanks!

Jessica

