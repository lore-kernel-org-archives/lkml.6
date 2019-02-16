Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35188C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB712222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEPlOZuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbfBPCSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 21:18:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34768 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbfBPCSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 21:18:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so5683284pgd.1;
        Fri, 15 Feb 2019 18:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zQJEssgRs5s6ldeOnVF5wzjL5/AyZ9wPQPD64Pxk0Rs=;
        b=CEPlOZuJsRPfUrUEtUbhOGoz0eEs2OP4ZzzTPXrSHTf9y9dTUiugrir69Ct4VD9vTO
         l65cRi9OiKa14yXDGdmXvM453JsVaRTMhIcpKThMkMLwMXoXZkBdWsxWdPmyjDYD+zNF
         gD18OpchDsvWE7V3CJc2zxOTNAkp0rS9LmsWf7FCwwCl9ASJiUwYym1rXIiYWiBW4Pkb
         miu2TPOVHDeSiVWgKsR2V/sPBwQgW9TBiOyfdW8IpQHGtuYycr5/W7AnrwDkA6tinKWC
         vOeOXzdarXCyMtmVhnJ8udEVcmS2kq8pWcE4Q8MeJA/McLhojY5qdAcAsB8WKDwQc6LG
         2nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQJEssgRs5s6ldeOnVF5wzjL5/AyZ9wPQPD64Pxk0Rs=;
        b=X33zkYK+0y3aSC9yLapNyGYUSNXiaY82a5WVhLrp9VDubnvZwZEIwWh9/2H3/PDCxb
         ooZ9OyW3kYquZYLGmQrg59p/AdYuyNR8C8FCKtlR/CYJtj7EdeREF0CD1NBkdZkO2bua
         cxf+AzTDZ4Q4D1u/FZJP0XleQDDiWcjIWpA9kQp1KwUJVyg7HsjDAWVd7CKB8m/MMiP8
         oDbbn/O99vfFdE+R5pGmqI/Hjb7IjpaRG4k6R6AIszB5wEt8CMnuLmKLru7UYcdBpEEW
         AiVttuZR0swlALUmjBF2dxxKnx6xWtPPgpqfnM0ONSxvEvpHG9d6DgWp4q2rx4qVWkfM
         lv9w==
X-Gm-Message-State: AHQUAua1WbduXwc9AmNh/5Kn/qXliobxvAQLbSwExDOraxO3SGGFm3lL
        WUw0cRzAKp7VogZklsS8JmI=
X-Google-Smtp-Source: AHgI3IYSTwRFu4dmbcl0i0UX7f1h/yKBf31djyJhyktfymMIwqEVhE+RkwfzdoKHhjda7vgmTl2cwg==
X-Received: by 2002:a63:3703:: with SMTP id e3mr8131914pga.348.1550283491931;
        Fri, 15 Feb 2019 18:18:11 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id o25sm8836450pfk.185.2019.02.15.18.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 18:18:11 -0800 (PST)
Subject: Re: [PATCH v2] of: unittest: unflatten device tree on UML when
 testing
To:     Brendan Higgins <brendanhiggins@google.com>, robh+dt@kernel.org,
        mcgrof@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190216004647.206431-1-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <eabdd156-62f4-fadb-bfa4-ecbb5ba65527@gmail.com>
Date:   Fri, 15 Feb 2019 18:18:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190216004647.206431-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 4:46 PM, Brendan Higgins wrote:
> UML supports enabling OF, and is useful for running the device tree
> tests, so add support for unflattening device tree blobs so we can
> actually use it.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/of/unittest.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 84427384654d5..6de34d5fa0e85 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -2527,6 +2527,9 @@ static int __init of_unittest(void)
>  	}
>  	of_node_put(np);
>  
> +	if (IS_ENABLED(CONFIG_UML))
> +		unittest_unflatten_overlay_base();
> +

This is still the wrong location.  It should be at the top of the function.

I'll try moving it to the top and see if it still works -- should only
take me a few minutes.

-Frank

>  	pr_info("start of unittest - you will see error messages\n");
>  	of_unittest_check_tree_linkage();
>  	of_unittest_check_phandles();
> 

