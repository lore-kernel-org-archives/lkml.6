Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFD7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F772054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRn0XPuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F772054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJOUkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:40:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39890 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeJOUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:40:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so9641283pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/x9N+jHuRDPh9uNIhuTAZo2ZBNrX1Px7aajGfuqtLnw=;
        b=CRn0XPuqKVSOWeuVV/h1F46pS+jLj0/tNYzlS0gI08/kybMx4OBZL94XpoGF+L9fbG
         hqG2O9jhx2bmDqMLBr404JsgVzUEOhYIC29p537v8t40dr3Ap9k/tb3TegyXXueT7Pu5
         1Mo5zOi6/7jDbi+OxSrkSezFx9JcbNSE1tJc0TeZpApuql2m5Svbx6kJYax8jS5dJtgT
         AlXKAbQCzvBe7UhhW7RqDHaib2fWFsE3quolZs8+3waQVG8HL7ViKZ8ies15IeGK4dO6
         Vb+V/XiuVnRDl2BI8/2cx86C0QzA/uBsKk4AiHZMrg/+fR7Cpbfh3yOcxRA2aqHbuJrG
         oU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/x9N+jHuRDPh9uNIhuTAZo2ZBNrX1Px7aajGfuqtLnw=;
        b=mLXc+ueTLwV07AnFWEfXF2OMMQ5HHUT8zWibU6X9K6UWKPJ0vpPrymBYRq4ER4D+oh
         Iau3dA5lyh7jyXhSSvWsbs9lO7Jn5EKIT+eWHi8mhGgiBckRef2hZdylhhC8942nmHbV
         VOZTbg00LmDM2sB6WW9Farcv3ZkhOOessobIFlUY5lcborxGFxP0h2ECSnM2cRdPtm5j
         DRgE16YUCPyWEkQpn7Pj4kubD8a48nuzl9ZQ3jyrCFzEVm7PldzxE4mvNf8k9wYbeUps
         W2SD7dHSI2w+h7CFZrtQcgP6VyCm4qJeGDWlJIo6SNTYdyK/Zlhl7GOoAcM/M9UBwalv
         ocUQ==
X-Gm-Message-State: ABuFfojwsZfUGMFjZgTaTEr4iqQq1//0W0kpdVw2SbVDxRBSmIxDzw0f
        EHeQua8GfbNjm3FSy71azsKigJaG
X-Google-Smtp-Source: ACcGV62UkUs//LgIkagv8TQ5boUUlcZ37uQ44p5p9z3dizjUGEx2f7wtMQeIEoa/LR5LhWztFoz+WQ==
X-Received: by 2002:a63:4243:: with SMTP id p64-v6mr16232154pga.127.1539608123173;
        Mon, 15 Oct 2018 05:55:23 -0700 (PDT)
Received: from [192.168.0.123] ([49.207.50.246])
        by smtp.gmail.com with ESMTPSA id s13-v6sm23847975pgs.76.2018.10.15.05.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 05:55:22 -0700 (PDT)
From:   "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>
X-Google-Original-From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/book3s64: fix dump_linuxpagetables "present" flag
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <23d27ae15a7b0389fc26f2265f969c6c69f44009.1539433567.git.christophe.leroy@c-s.fr>
Message-ID: <1efceec5-7748-6aa8-66d4-a7dfcbc44649@linux.ibm.com>
Date:   Mon, 15 Oct 2018 18:25:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <23d27ae15a7b0389fc26f2265f969c6c69f44009.1539433567.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/18 12:07 PM, Christophe Leroy wrote:
> Since commit bd0dbb73e013 ("powerpc/mm/books3s: Add new pte bit to
> mark pte temporarily invalid."), _PAGE_PRESENT doesn't mean exactly
> that a page is present. A page is also considered preset when
> _PAGE_INVALID is set.
> 
> This patch changes the meaning of "present" and adds a status "valid"
> associated to the _PAGE_PRESENT flag.
> 

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Fixes: bd0dbb73e013 ("powerpc/mm/books3s: Add new pte bit to mark pte temporarily invalid.")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/mm/dump_linuxpagetables-book3s64.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c b/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
> index a637e612b205..ed6fcf78256e 100644
> --- a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
> +++ b/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
> @@ -38,8 +38,13 @@ static const struct flag_info flag_array[] = {
>   	}, {
>   		.mask	= _PAGE_PRESENT,
>   		.val	= _PAGE_PRESENT,
> -		.set	= "present",
> -		.clear	= "       ",
> +		.set	= "valid",
> +		.clear	= "     ",
> +	}, {
> +		.mask	= _PAGE_PRESENT | _PAGE_INVALID,
> +		.val	= 0,
> +		.set	= "       ",
> +		.clear	= "present",
>   	}, {
>   		.mask	= H_PAGE_HASHPTE,
>   		.val	= H_PAGE_HASHPTE,
> 

