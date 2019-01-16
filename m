Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DB6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FFA206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547675866;
	bh=i/FycA8xWOiPHYHlqzq4muWW9YdDs2Ca2zk5WlY9Nsg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=sT7bszcclotq2NiBoTyaZ8cbFm35k5AuKKuf6SqBl2FGjSL/hg7OeKyElzMYYgqMv
	 pDDbyARE8t+lp+6g9kz5RbRQtH5Wmr2e7xsbGdB23PY8AS5Kc2FtKtk6gopNHDk5OQ
	 vTH5n9OHjxcoXm84HrSYFT7Mf/+XG2NyBLMnRQtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfAPV5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731954AbfAPV4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:56:44 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE28220652;
        Wed, 16 Jan 2019 21:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547675804;
        bh=i/FycA8xWOiPHYHlqzq4muWW9YdDs2Ca2zk5WlY9Nsg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U6+Dy+2MVXa1RCepAFeAYYDMF5GgNnVDq2d71VKMkypas3DljJ8/D+WsTGuZ5T1sJ
         Sw6J9AIqsAzfqIHUVK0q0YNOfL39fcQOJV5thG7CgDLhZ1fHMuPNNfap6Ig8bYmlfc
         8RL8ZXvH+03JMqvLbWDg+EAufAGvoKsLTwGgNCi4=
Subject: Re: [PATCH 1/4] selftests: lib: allow to override CC in the top-level
 Makefile
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        Denys Dmytriyenko <denys@ti.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20190116174320.14938-1-daniel.diaz@linaro.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7d75f420-d624-d53d-4fa1-3827c90fa608@kernel.org>
Date:   Wed, 16 Jan 2019 14:56:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116174320.14938-1-daniel.diaz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 10:43 AM, Daniel Díaz wrote:
> From: Fathi Boudra <fathi.boudra@linaro.org>
> 
> Relax CC assignment to allow to override CC in the top-level Makefile.
> 
> Signed-off-by: Denys Dmytriyenko <denys@ti.com>
> ---
>   tools/testing/selftests/lib.mk | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 8b0f16409ed7..0f9c47eaaa6f 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -1,6 +1,6 @@
>   # This mimics the top-level Makefile. We do it explicitly here so that this
>   # Makefile can operate with or without the kbuild infrastructure.
> -CC := $(CROSS_COMPILE)gcc
> +CC ?= $(CROSS_COMPILE)gcc
>   
>   ifeq (0,$(MAKELEVEL))
>   OUTPUT := $(shell pwd)
> 

What problem does this fix?

thanks,
-- Shuah
