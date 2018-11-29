Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415E7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0552920863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKqWmyAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0552920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeK2VcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbeK2VcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:32:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32852081C;
        Thu, 29 Nov 2018 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543487241;
        bh=Shw8B6QO0lnkCPgOCjUL4eF/xUeJlX2l1kI3zvEMJhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FKqWmyARYnxAafO9vOzx+R9C4A1RvMWoEphFTQvRXH1dS2hZCuXfbf3Z27AcSWthd
         W0ijez4fI9y9V4Izu++xKFp7g2I1JhTaLsMWtHA8utcKd5ssajERfIsReZqfq3yfkH
         cn8UmvTQ5RtmDcfOi9aKXGFNspyDEnsFIq6mvpCc=
Date:   Thu, 29 Nov 2018 11:27:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 4.14] kbuild: allow to use GCC toolchain not in Clang
 search path
Message-ID: <20181129102719.GC20297@kroah.com>
References: <20181129053511.8016-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129053511.8016-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:35:12PM -0700, Nathan Chancellor wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> commit ef8c4ed9db80261f397f0c0bf723684601ae3b52 upstream.
> 
> When using a GCC cross toolchain which is not in a compiled in
> Clang search path, Clang reverts to the system assembler and
> linker. This leads to assembler or linker errors, depending on
> which tool is first used for a given architecture.
> 
> It seems that Clang is not searching $PATH for a matching
> assembler or linker.
> 
> Make sure that Clang picks up the correct assembler or linker by
> passing the cross compilers bin directory as search path.
> 
> This allows to use Clang provided by distributions with GCC
> toolchains not in /usr/bin.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/78
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-and-tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> [nc: Adjust context]
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  Makefile | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

We also need this for 4.9, right?

thanks,

greg k-h
