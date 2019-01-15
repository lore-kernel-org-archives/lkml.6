Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1815C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AEC205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547516722;
	bh=KZIylzJc+1m4ZiO8Qkt+e86Nmc9v9twr7M1XCPhzs4o=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Hd9yLvXkVp1SbJiwv9BXlj46y7yOE6g/AHpvNhvDAE6HWPCNnuKNYl9MPemYtrbmp
	 NY8FyzG+We++hApqXzHc4EwnUsa3l7vZb2Am7E0uUii2eJfLKyAJPPjAMzyK41zr8H
	 oMuh4hwaoGA0/m0XfyZwyzzu4tJ65bOEl2eACMFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfAOBpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfAOBpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:45:20 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE9F205C9;
        Tue, 15 Jan 2019 01:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547516720;
        bh=KZIylzJc+1m4ZiO8Qkt+e86Nmc9v9twr7M1XCPhzs4o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=xXcpRO6LEH5kyD1m5+sO7cy41gS5yg7eUT0VWinyaWJKcaEk6wDvNuSQ/Dr3qcQRQ
         1tpsRr2joVH/0SwMU7TxOl2vYbITIzcY2KpYfoJiS/h3utdD7AbrAutt8TrUd7SScZ
         vtyfSoUkYjGfly6yD5SfkqK63sRRbMEeNeDkpoAA=
Subject: Re: [PATCH] tools/testing/selftests/x86/unwind_vdso.c: Remove
 duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     jrdr.linux@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com,
        shuah <shuah@kernel.org>
References: <5c3c7dfe.1c69fb81.7c853.0be7@mx.google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <3242d93b-bd3d-bce3-b912-bd28144a2e9d@kernel.org>
Date:   Mon, 14 Jan 2019 18:45:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5c3c7dfe.1c69fb81.7c853.0be7@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 5:18 AM, Sabyasachi Gupta wrote:
> Remove sys/ucontext.h which is included more than once.
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>   tools/testing/selftests/x86/unwind_vdso.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
> index 00a26a8..9731133 100644
> --- a/tools/testing/selftests/x86/unwind_vdso.c
> +++ b/tools/testing/selftests/x86/unwind_vdso.c
> @@ -44,7 +44,6 @@ int main()
>   #include <stdbool.h>
>   #include <sys/ptrace.h>
>   #include <sys/user.h>
> -#include <sys/ucontext.h>
>   #include <link.h>
>   #include <sys/auxv.h>
>   #include <dlfcn.h>
> 

Thanks for the patch. I will pull this in for 5.1-rc1

thanks,
-- Shuah
