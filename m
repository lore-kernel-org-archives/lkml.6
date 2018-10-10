Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827D5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9222086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stW6dKfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9222086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeJKETA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:19:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40525 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeJKETA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:19:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so3222769pfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JkMHV4tKcQujRR/xNu7qKvNHN4pNkRm9rGRkyjWQ5Sk=;
        b=stW6dKfIlmrz4Jb7i+QkpmxpErA633YqDPzw6cYMiTs5wdsEPRfdQrWSrkyRUBHZ5u
         UFhnAZpvK2nnslXvjKH5wpyuAPjA3P+vT6XoJQUJNkUz6Eo9JywQykJWU2I/67Qgd6au
         P/Av5eUqWzY1WCI3WX2pc8LOa0lK5MiBzPvMwoTHEJPi33koP5WdkisOucKHF/EWvTqE
         N1e0W7cgcq4FINZAAzPrnUNepVFim1ZpU5WgMq6PMnQO6deeSHh5Xn9f3VwsXH2TSDx+
         izFCT3ZTtOaD8/nRIOQTSmUGeOlDX1l90S4X+eGcIiKFIxCmUY6KLT2bNQRARpZ/hAQ0
         Iyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JkMHV4tKcQujRR/xNu7qKvNHN4pNkRm9rGRkyjWQ5Sk=;
        b=ZW7zWWlXUXbvT2FX8y7VWkVY7uVMjBy8oOZTn2dU4ymWbAsfjAjFhjyZiJY5hj4+dE
         w3R301oLmZVCnLRVIgFHDqGLmGG4i5naTLXbuQJnikTndJSDj/IKYIHd3vSoeB/HeSKN
         O+nVqR/6c8dqXugq+WoO7p74+B7XS4UE1gywGmp40Bh//elakYV/2OuM+3Xu1tZx1SUy
         JduVvYSdHKkOhP+ohCreehvEo3/0sJkzkW+LICb8UD68B3Ffy1iU6G5TJU32WyZIt+0S
         X9V10omNltID+GeEBkWCtNEfViq8vRk5uHpKMsARJDZUpMcWaqZYqHUsWcUx8MaZW3wP
         OE4g==
X-Gm-Message-State: ABuFfojwu4S7hog2wpNi7fegW66AEwPK7mD3GrMYuY0SOKgPFDR38Gwl
        tVjqrgnRJAN6pGTms2hzjrQ=
X-Google-Smtp-Source: ACcGV627RwMX/zbbKTJI29Ql1JdlwMe/cNclHU1fgR1SqxIhBn7tk1FKmSnP2m7+eq9auEcH0/VYJQ==
X-Received: by 2002:a62:2fc1:: with SMTP id v184-v6mr36385608pfv.115.1539204905925;
        Wed, 10 Oct 2018 13:55:05 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l89-v6sm7695486pfk.34.2018.10.10.13.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 13:55:05 -0700 (PDT)
Subject: Re: [PATCH] code-of-conduct: Remove explicit list of discrimination
 factors
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20181007085102.17795-1-geert@linux-m68k.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f4f7bf39-af34-4375-d6a2-b1f23cad519e@gmail.com>
Date:   Wed, 10 Oct 2018 13:55:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181007085102.17795-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/18 01:51, Geert Uytterhoeven wrote:
> Providing an explicit list of discrimination factors may give the false
> impression that discrimination based on other unlisted factors would be
> allowed.
> 
> Avoid any ambiguity by removing the list, to ensure "a harassment-free
> experience for everyone", period.
> 
> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> The use of "race" may also conflict with the United Nation's views on
> this matter, cfr. e.g. the UNESCO's "Four statements on the race
> question"[1][2] and "Declaration on Race and Racial Prejudice"[3].
> 
> [1] https://en.wikipedia.org/wiki/The_Race_Question
> [2] http://unesdoc.unesco.org/images/0012/001229/122962eo.pdf
> [3] http://portal.unesco.org/en/ev.php-URL_ID=13161&URL_DO=DO_TOPIC&URL_SECTION=201.html
> ---
>  Documentation/process/code-of-conduct.rst | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> index ab7c24b5478c6b30..e472c9f86ff00b34 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -6,10 +6,7 @@ Our Pledge
>  
>  In the interest of fostering an open and welcoming environment, we as
>  contributors and maintainers pledge to making participation in our project and
> -our community a harassment-free experience for everyone, regardless of age, body
> -size, disability, ethnicity, sex characteristics, gender identity and
> -expression, level of experience, education, socio-economic status, nationality,
> -personal appearance, race, religion, or sexual identity and orientation.
> +our community a harassment-free experience for everyone.
>  
>  Our Standards
>  =============
> 


The words removed by this patch are a political statement.  They do not belong
in the document.

Acked-by: Frank Rowand <frowand.list@gmail.com>
