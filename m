Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeBHR1m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:27:42 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44797 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbeBHR1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:27:40 -0500
X-Google-Smtp-Source: AH8x226EeYa71KPJLqfqlRPMe2U/dL2iGAbK10BMVOEozLGHgs3n5nU2TNrZ7TCd7ehixuMg65Hadw==
Date: Thu, 08 Feb 2018 09:27:38 -0800 (PST)
X-Google-Original-Date: Thu, 08 Feb 2018 09:27:30 PST (-0800)
Subject: Re: [PATCH v2 1/2] Add notrace to lib/ucmpdi2.c
In-Reply-To: <20180130224202.7682-2-antonynpavlov@gmail.com>
CC: linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, matt.redfearn@mips.com
From: Palmer Dabbelt <palmer@sifive.com>
To: antonynpavlov@gmail.com
Message-ID: <mhng-58c9bb50-e7d0-4b58-81ed-bf77161f9ec3@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018 14:42:01 PST (-0800), antonynpavlov@gmail.com wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
>
> As part of the MIPS conversion to use the generic GCC library routines,
> Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
> patch rectifies the problem.
>
> CC: Matt Redfearn <matt.redfearn@mips.com>
> CC: Antony Pavlov <antonynpavlov@gmail.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  lib/ucmpdi2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
> index 25ca2d4c1e19..597998169a96 100644
> --- a/lib/ucmpdi2.c
> +++ b/lib/ucmpdi2.c
> @@ -17,7 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/libgcc.h>
>
> -word_type __ucmpdi2(unsigned long long a, unsigned long long b)
> +word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
>  {
>  	const DWunion au = {.ll = a};
>  	const DWunion bu = {.ll = b};

Thanks for submitting this, I've gotten quite a bit behind due to FOSDEM.
