Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4386C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CE020849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqkFX09o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CE020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeLKP2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:28:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37555 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeLKP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:28:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so12868376edb.4;
        Tue, 11 Dec 2018 07:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7awNY4ymdO+RNLil9JDwL8hY7iyonw/4hjSQTrtkG0Y=;
        b=aqkFX09os53Wz8YPHEdNH1j5+XhWVQIwp4/1t7QqAnq09NQZ5e/Ky2kExZjNmuh902
         e34RcDqx9Bcd7WGqugCvaM19UgoHlvAJedvAcVHCklkbsS9E+sUh3dq/AaOeV/G7d4VJ
         NMMjLK4OB/FNgxLrxjz+gG1+6HQZH6YEkdoSOBQTYiLHbHcbQNJNAIikT8/hkI7TKUlo
         zmjpB1hxadWqk9OSQcbe50BYSJyS0J3m6h2ktvi6uQnTu5UpfYTd4ql3CyieH/c1fYtq
         4XdF4z3ZgPhQICWWhjDZd8OeRpD2npwa749bXI3aGBLAfC76dkIpAVbMI+JWgXRJ/Wk+
         cXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7awNY4ymdO+RNLil9JDwL8hY7iyonw/4hjSQTrtkG0Y=;
        b=Xk9QWV1FFW32z7tVgwsc4CjsPjWjXhWQftRIaUVVkJwMPvVJ6OC86j+PPtLAhNdK4E
         GIpVefACx4Mk0Pq+75bETqOxTHYpXdi9d7liXIhy/9LMUoCwFDsSBwANXRBfI7+xogY5
         sHo292LQdxlaFUjooNsqVh/PM8fpQRlQzd5xrFaDZqc216fIXlDj1YR/qXVwjv37hdnz
         VmUj0Gtl83gYtF9IxtHUweCIKpyuIo7Agu59MH/x3bt8+tDwv9aTTS6HApn6OSIHROJ6
         ou7sco6MS9fnG8BPONeTvhFTpTtsKAXnJrcnZUm5JeoA9PonCFkTn2s3Xx3Tjsa7vaO0
         j/QA==
X-Gm-Message-State: AA+aEWbezLHbyVJ2baTdosf4spsAe/ZgXH/vTofYXXXrP3w4n2lt5JZK
        tx3KN+h/H6m2QTPNJ9yrG08=
X-Google-Smtp-Source: AFSGD/UlCY20XFFFIWP/ONk+SiZ5SXRAj4sT17yb2VOnwB4TwhH8KbE0Q44Yz3HZvzUVGYBLANHO/w==
X-Received: by 2002:a50:a6cf:: with SMTP id f15mr15192704edc.97.1544542124463;
        Tue, 11 Dec 2018 07:28:44 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:450b:7efe:59a0:ccfd])
        by smtp.gmail.com with ESMTPSA id t11sm3981662eds.34.2018.12.11.07.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 07:28:43 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:28:41 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org, Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Subject: Re: [PATCH v13 05/25] kasan: add CONFIG_KASAN_GENERIC and
 CONFIG_KASAN_SW_TAGS
Message-ID: <20181211152840.ezjujzpyz5z6fd2d@ltop.local>
References: <cover.1544099024.git.andreyknvl@google.com>
 <b2550106eb8a68b10fefbabce820910b115aa853.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2550106eb8a68b10fefbabce820910b115aa853.1544099024.git.andreyknvl@google.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 01:24:23PM +0100, Andrey Konovalov wrote:
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 3e7dafb3ea80..39f668d5066b 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -16,9 +16,13 @@
>  /* all clang versions usable with the kernel support KASAN ABI version 5 */
>  #define KASAN_ABI_VERSION 5
>  
> +#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
>  /* emulate gcc's __SANITIZE_ADDRESS__ flag */
> -#if __has_feature(address_sanitizer)
>  #define __SANITIZE_ADDRESS__
> +#define __no_sanitize_address \
> +		__attribute__((no_sanitize("address", "hwaddress")))
> +#else
> +#define __no_sanitize_address
>  #endif
>  
>  /*
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 2010493e1040..5776da43da97 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -143,6 +143,12 @@
>  #define KASAN_ABI_VERSION 3
>  #endif
>  
> +#if __has_attribute(__no_sanitize_address__)
> +#define __no_sanitize_address __attribute__((no_sanitize_address))
> +#else
> +#define __no_sanitize_address
> +#endif

Not really important but it's the name with leading and trailing
underscores that is tested with __has_attribute() but then it's
the naked 'no_sanitize_address' that is used in the attribute.

-- Luc
