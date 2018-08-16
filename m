Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D30C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7AF20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7AF20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeHPWYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:24:11 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44368 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeHPWYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:24:11 -0400
Received: by mail-qt0-f196.google.com with SMTP id b15-v6so6084528qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 12:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zLQvIDtjtGko1xB3gXADRmWviRjFlggMCqSQ1H9FKGU=;
        b=HvpnxM3VwvTw7ybRjqpJeLhBcmDywLpJ1J7MFJp/+qZT2K/LFyR3/DFBs0C/9IrtL5
         reYL5SMGDBTaOmi7JEWC2jyTwxhyv0AE67wkOsvLLahLDYxYo6oGMmxz5wX9b4SjTqsL
         6OlgdUsO+b1YOpG9Ek/TuBsuMtRkDK25jeKvc/n6JfQgklYDygaVbbvixuzovc06ABra
         O6HRuoRp7orakvgjib0LDSwn6kgQgEf95cqhFTbYuHHtDWCjGhd77CgJIoDLpKGpJxPA
         s808DOc6W9naqjRr7+kl3rL4u8I/i0OHkAPXUHBguSPN4l79JkCYtEibbQrhXKpMV81K
         6Gbw==
X-Gm-Message-State: AOUpUlH1qnjudKw+KOkvKNQKeH/ptNlLq6V2gjEid3qxPanEgY8U7yHl
        MN3ah38vhIYPcdRn4zaz4ALM9rmiNbw=
X-Google-Smtp-Source: ANB0VdYlRMHRw9vrOCHYzgsuyQDnFBMIMcuGm7OfW4Yf+SfAo1C2r+S78g0+vZAg1QO05Ai7DRkBRg==
X-Received: by 2002:ac8:364b:: with SMTP id n11-v6mr950594qtb.339.1534447432167;
        Thu, 16 Aug 2018 12:23:52 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::8a8f? ([2601:602:9802:a8dc::8a8f])
        by smtp.gmail.com with ESMTPSA id b40-v6sm84319qte.43.2018.08.16.12.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 12:23:51 -0700 (PDT)
Subject: Re: [PATCH] kbuild: Fix LOADLIBES rename in
 Documentation/kbuild/makefiles.txt
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180816170555.21623-1-msuchanek@suse.de>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <4f6673db-5b59-c3b1-042c-b36057c31c13@redhat.com>
Date:   Thu, 16 Aug 2018 12:23:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180816170555.21623-1-msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 10:05 AM, Michal Suchanek wrote:
> Fixes: 8377bd2b9ee1 ("kbuild: Rename HOST_LOADLIBES to
> 		KBUILD_HOSTLDLIBS")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Acked-by: Laura Abbott <labbott@redhat.com>

> ---
>   Documentation/kbuild/makefiles.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
> index 766355b1d221..7b6a2b2bdc98 100644
> --- a/Documentation/kbuild/makefiles.txt
> +++ b/Documentation/kbuild/makefiles.txt
> @@ -680,7 +680,7 @@ Both possibilities are described in the following.
>   
>   	Example:
>   		#scripts/kconfig/Makefile
> -		HOSTLOADLIBES_qconf := -L$(QTDIR)/lib
> +		HOSTLDLIBS_qconf := -L$(QTDIR)/lib
>   
>   	When linking qconf, it will be passed the extra option
>   	"-L$(QTDIR)/lib".
> 

