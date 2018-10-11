Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B59C46462
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892012085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp60SFhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892012085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJKOCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:02:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36451 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeJKOCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:02:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id d4-v6so5803240lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PNBHulL0oFfjUGYh3RvkH2wZhiwmtpJy0O+sHUCUQEM=;
        b=hp60SFhrC/Jwv/NvikrDtrK8kD4THS9Ay72m6tQP7PQdXPmdEuPWuDgpqY9Kmc9TUR
         PYdz+Ek1BPAHEGWlC2NWAU444KDWVf8IvqdkB+nV0vs9cQiIqZfW8PFRADirr1mZy+tM
         di3HvJHIGzvu2Zxr95ZnfYbxsWO69aB/eHrdijSzASrTdMPbThxS3j+DSVV5C69poVEB
         0ZdIgjGGdIEIz9tNoPHsqYZRdQablH2C/4h450EmklEYdpYJgzOmiOf/nRx9Ss7CFNhs
         amhsbsL0wLn7725sEa3zV9vfbbjz1a+lNIeHSM/UmATw4uw2y3gfdR299BeHyhjNK0Zr
         ckKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PNBHulL0oFfjUGYh3RvkH2wZhiwmtpJy0O+sHUCUQEM=;
        b=jb70MisXMtemHMtnMe3MtU50c2M5Xni9yCeIAnsvS/I9aUrSOOOUw9QnFzzH5lzY5R
         T6d2AHPY+949MD+q9bm419DCP/vN/jwe/U/HnOAJnYbxxV8oFUSJlDCdA83t23eWg/Ba
         q8QWg7hd6de7XgIPTxxxvx63U0lw8ba2XuLZp6fi4Qy2zSDwATXCTaK1hOy9swDWy2El
         /FDZoqYeQy4i1eXmSl+g6+vOMSd6BOkf+iIyUdkhdWdAMr/LhFCnNyziwlJVHm8K5ORQ
         V2x2BzjCEYrmk8VdSsIXtQSyViAfjmyAZ9x2zK7OYHa3A/tU5FGXRPE8DdK1mJerSygS
         1SZw==
X-Gm-Message-State: ABuFfohvOmHeSQAsiWvmh8TRAUSISHHIX2NGG42mckKg+qsmd5RNSYsO
        LQ2Xs7+J1zoaydc2H8pwMHdvB8edCtk=
X-Google-Smtp-Source: ACcGV62XGrYpDCmq5+jOuSP0T6x6JViDrbEui5aQqwcKxGgp9FjyhBaYTUMYSH4q8ihRcx7CCpyy1g==
X-Received: by 2002:a19:9497:: with SMTP id o23-v6mr205517lfk.61.1539239770597;
        Wed, 10 Oct 2018 23:36:10 -0700 (PDT)
Received: from [192.168.1.111] (91-157-235-206.elisa-laajakaista.fi. [91.157.235.206])
        by smtp.googlemail.com with ESMTPSA id l100-v6sm5485597lfi.3.2018.10.10.23.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 23:36:08 -0700 (PDT)
Subject: Re: [PATCH] code-of-conduct: Remove explicit list of discrimination
 factors
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20181007085102.17795-1-geert@linux-m68k.org>
From:   Tomi Valkeinen <tomi.valkeinen@iki.fi>
Openpgp: preference=signencrypt
Autocrypt: addr=tomi.valkeinen@iki.fi; prefer-encrypt=mutual; keydata=
 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
 QChEB1am0BueV1JZaBboIL0AGlSJkm23kw==
Message-ID: <019bd8ac-8d2d-9682-4d7e-5932d22f8d1d@iki.fi>
Date:   Thu, 11 Oct 2018 09:36:07 +0300
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

On 07/10/18 11:51, Geert Uytterhoeven wrote:
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

Acked-by: Tomi Valkeinen <tomi.valkeinen@iki.fi>

 Tomi
