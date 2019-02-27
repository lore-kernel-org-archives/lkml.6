Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03072084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551267214;
	bh=Urgmppu0gS+MX06eWHv9grHbWIxnqWyesc1P67n1eO0=;
	h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:
	 From;
	b=Dd/zQAv98DpRrPE9Op8Lr81qJY+JEgebm+UvqTz3d7R2k2dQR89RHumiWzqGuHBSM
	 c7qQ2vdRg/zHizgs96cTNdURwdpVNGSeiR1FV4kZOGKnR6/ArztxTgaC1j04ITWBsx
	 0blu8Dik6eLqcO+dnpfGik35QYEFIcbNiAQaWydM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfB0Ldc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfB0Ldc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:33:32 -0500
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E777C2084D;
        Wed, 27 Feb 2019 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551267211;
        bh=Urgmppu0gS+MX06eWHv9grHbWIxnqWyesc1P67n1eO0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O4rp3CQgUQ3dQPhMfzNqdDHSSG2719W8m3PmW7E+LIYiRIjGFTlYy/AwHeYDMMItC
         yy2gCvVtpMdAI1L8kfnZXv9p1GAiixJsBSQq6BqIFPM3UKKmrbp7IabjeJysP9Yqar
         6rQpkMlyVVHH1lWxjZfGCoMpAIiEiHBsyRp+njHM=
Reply-To: kbingham@kernel.org
Subject: Re: [PATCH 2/5] kbuild: remove unimportant comments from ./Kbuild
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org
References: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
 <1550568787-18710-2-git-send-email-yamada.masahiro@socionext.com>
From:   Kieran Bingham <kbingham@kernel.org>
Openpgp: preference=signencrypt
Message-ID: <dcc1ba3b-d544-b556-8aa5-69a4a1a88f75@kernel.org>
Date:   Wed, 27 Feb 2019 11:33:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550568787-18710-2-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On 19/02/2019 09:33, Masahiro Yamada wrote:
> Every time we add/remove a target, we need to touch the header part,
> including renumbering. This is not so important information.
> 
> Numbering targets is rather misleading because they are not necessarily
> generated in this order. For example, 1) and 2) can be executed
> simultaneously when the -j option is given.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Sounds reasonable to me.

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> ---
> 
>  Kbuild | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/Kbuild b/Kbuild
> index 4cebcc7..a07bbd6 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -1,14 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Kbuild for top-level directory of the kernel
> -# This file takes care of the following:
> -# 1) Generate bounds.h
> -# 2) Generate timeconst.h
> -# 3) Generate asm-offsets.h (may need bounds.h and timeconst.h)
> -# 4) Check for missing system calls
>  
>  #####
> -# 1) Generate bounds.h
> +# Generate bounds.h
>  
>  bounds-file := include/generated/bounds.h
>  
> @@ -19,7 +14,7 @@ $(bounds-file): kernel/bounds.s FORCE
>  	$(call filechk,offsets,__LINUX_BOUNDS_H__)
>  
>  #####
> -# 2) Generate timeconst.h
> +# Generate timeconst.h
>  
>  timeconst-file := include/generated/timeconst.h
>  
> @@ -31,8 +26,7 @@ $(timeconst-file): kernel/time/timeconst.bc FORCE
>  	$(call filechk,gentimeconst)
>  
>  #####
> -# 3) Generate asm-offsets.h
> -#
> +# Generate asm-offsets.h
>  
>  offsets-file := include/generated/asm-offsets.h
>  
> @@ -45,8 +39,7 @@ $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
>  	$(call filechk,offsets,__ASM_OFFSETS_H__)
>  
>  #####
> -# 4) Check for missing system calls
> -#
> +# Check for missing system calls
>  
>  always += missing-syscalls
>  targets += missing-syscalls
> 


-- 
--
Kieran
