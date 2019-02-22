Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC9220818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hseY7vwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfBVFyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:54:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36507 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfBVFyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 00:54:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so610616pgr.3;
        Thu, 21 Feb 2019 21:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+tYk4Wz0vuibFWVKvACfrQWYEAR99bXceQ+q8AjO0kI=;
        b=hseY7vwK907nTb28cNOi/GvP6OXu6uliVlRI7hfeYZvrUpDYwDyC44Om47i1sPIpSN
         yHcegB7QalCt3xTq8bh1EFaduPgy4G46hS4xNvIm0UfhuF266uZdffj4bAEs+3JKY4Ll
         6bjJ7C5kgtcN8oN1een8RXrwusrrNerrWDGqJQ2O9Cf5MxELxASZMfbGe+vX7OR8tVZ/
         60znf0rNgHVPlyXAA9QKBwd8JmBg2hUVbdiSpwIFC/2O5FrZj1oDG0YXaslJDByGj6G0
         5s43SxP4cZ7tcrUGih9ht2HQcWanzoMpJTe+vdGOh4a6j2qRU5xE6m+KZy/IoJFfmWwA
         u53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+tYk4Wz0vuibFWVKvACfrQWYEAR99bXceQ+q8AjO0kI=;
        b=jTsAF+GjW+cY3gKPCl46LC0S/3n9vxHnN5AiQKCMzh17oJeNENad58XAxXj2eLBtrw
         eX39/07qkaaBQ0WoqKy5k+aVh7kEPkJatjhPN3mCand/uDNZNAfqOPZVatn58UugBInb
         +BVYXWhicMp9Lq3i8DtPQi/M62AERAF3/t5823cgYMGJJdSZfigudPI6xJIZLyjAfVMk
         0DW6dOGBkYeRPLFAb5gzACXLH8FvVRLG0tqdOsBdh6ToAikouffrNdP85am4Dx0vX1/O
         Qgl9AEeB6gGyk1K0CGr3Gy9fPHCosRBLam1blRRKuQ3yJ6uR0HYWZ30Qow+DWXaJ8v6w
         h/ug==
X-Gm-Message-State: AHQUAua6VoDAGpIGHDbZB1YCYYVPJH/TIH+Te2tQ+fKtw0WF8INhadnb
        YaC8KG4wx3QE0mLA33Cuc48=
X-Google-Smtp-Source: AHgI3Iaci7LR9P78eHtdZMi0XsHq0YtH0/DigKlzcjPvsYyMCRq9Fn7YoYrehKfV+EXRplYUQ4WwqQ==
X-Received: by 2002:a63:515d:: with SMTP id r29mr2308229pgl.350.1550814856942;
        Thu, 21 Feb 2019 21:54:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e19sm732358pfn.145.2019.02.21.21.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 21:54:15 -0800 (PST)
Subject: Re: [PATCH] bpfilter: re-add header search paths to tools include to
 fix build error
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <1550805799-24572-1-git-send-email-yamada.masahiro@socionext.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <80b08bfa-8052-aebb-db43-c7cbf3f5dd9d@roeck-us.net>
Date:   Thu, 21 Feb 2019 21:54:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550805799-24572-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 7:23 PM, Masahiro Yamada wrote:
> I thought header search paths to tools/include(/uapi) were unneeded,
> but it looks like a build error occurs depending on the compiler.
> 
> Commit 303a339f30a9 ("bpfilter: remove extra header search paths for
> bpfilter_umh") reintroduced the build error fixed by commit ae40832e53c3
> ("bpfilter: fix a build err").
> 
> Apology for the breakage, and thanks to Guenter for reporting this.
> 
> Fixes: 303a339f30a9 ("bpfilter: remove extra header search paths for bpfilter_umh")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Guenter,
> 
> Sorry for bothering you, but
> could you please test this with your compiler?
> 
> I am also using GCC 7.3, but my compiler cannot
> reproduce the build error.
> 
> 
>   net/bpfilter/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> index 5d6c776..854395f 100644
> --- a/net/bpfilter/Makefile
> +++ b/net/bpfilter/Makefile
> @@ -5,6 +5,7 @@
>   
>   hostprogs-y := bpfilter_umh
>   bpfilter_umh-objs := main.o
> +KBUILD_HOSTCFLAGS += -Itools/include/ -Itools/include/uapi
>   HOSTCC := $(CC)
>   
>   ifeq ($(CONFIG_BPFILTER_UMH), y)
> 

