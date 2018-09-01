Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B4C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD082083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDeScB9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD082083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeIAN3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 09:29:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46097 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 09:29:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so13214718wrc.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 02:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/jPN7w7lJWiNLZQYHn6myG46ZhnQZvdsh/TSY0wsTPQ=;
        b=cDeScB9tq+auktyw6Jr/usgzdWuczaXMWu//PCsDIZ59jyYorNQ1tEyD9tLLQjXSO/
         c68EnFnNjvcDVjISH7LCTydeHSbBtKyQ6KxKmhfFjluazwgg8cB11SafB9cJjX9bQDVL
         Ew/uQ7hsvsGcPdbPwE0wOpZOc6Sk/oQRz7pIGTHBTtl2WfrIs+OXLV++ICdtwAvJWcHT
         38epPHFGuofLjQv6kqO17CzzT4a8sfkjgXyaVAFuiFHl+MASxyRy16YvjBK8CLz6srP1
         2H642dyOyPqBUSvATSn1YLNW2jBt32v6/3LVapgV5dgl7I7/6YRSlrz4BZxLidLZaRTm
         qlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/jPN7w7lJWiNLZQYHn6myG46ZhnQZvdsh/TSY0wsTPQ=;
        b=nvlaV0Rvm0xbmXnzwm56m2VFilU+fji6mB8FR4eNJUdEiNY/fiQVfw/XseICPfnTOR
         QfXQohkL45CiLt7lYSmjiolygzuWiCWUfURsRY470YZrnc6Yr3DeXqYIhlyqN4Ap4Q2m
         7hbKvt0WtSrxCX2cXzma+/DBkO8ZQ3zOzVCio6Kb+pd0Xg0IUNHDz+UItAYggEyRz+AQ
         UiMiaIvlqOkTtLzk7nMzaXvcv5Jeo8HBKK75zNZrbV12t+eCoI0bukwlwu8RErdJN5AY
         t+qoYdNwXPXBpt0I6CuY5+Q6GYetJU1Y/f0ZsG7yheyA1TLuIb6KU0loH189SSizLsy1
         ijtA==
X-Gm-Message-State: APzg51DUil2W2RZoaQUE4/Ead4cKAsX3AUwgMWiHVanIfGSRxefUatZL
        Tgk0B6YMfTC8qbF28fyc7sE=
X-Google-Smtp-Source: ANB0VdZFmfHRaS8/y2wFPa339QhTCNsG86u0y8uDZxAnlXOmQHQ8FmEnhp1I+U7GQSFX6JtmAhQY1Q==
X-Received: by 2002:adf:8567:: with SMTP id 94-v6mr3346161wrh.223.1535793461808;
        Sat, 01 Sep 2018 02:17:41 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:8852:4a4c:95e8:7a2])
        by smtp.gmail.com with ESMTPSA id t9-v6sm4090558wmf.1.2018.09.01.02.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 02:17:41 -0700 (PDT)
Date:   Sat, 1 Sep 2018 11:17:40 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 4/7] Compiler Attributes: homogenize __must_be_array
Message-ID: <20180901091738.73dzegdenvla5crf@ltop.local>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-4-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831170514.24665-4-miguel.ojeda.sandonis@gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 07:05:11PM +0200, Miguel Ojeda wrote:
> Different definitions of __must_be_array:
> 
>   * gcc: disabled for __CHECKER__
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index e0e55eb3f242..e4a702f99e50 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -357,4 +357,11 @@ static inline void *offset_to_ptr(const int *off)
>  	compiletime_assert(__native_word(t),				\
>  		"Need native word sized stores/loads for atomicity.")
>  
> +#ifdef __CHECKER__
> +#define __must_be_array(a)	0
> +#else
> +/* &a[0] degrades to a pointer: a different type from an array */
> +#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
> +#endif
> +
>  #endif /* __LINUX_COMPILER_H */

You can also remove the #ifdef __CHECKER__ because:
1) even ancient version of sparse don't have a problem
2) BUILD_BUG_ON_ZERO() is currently disabled for __CHECKER__

-- Luc Van Oostenryck
