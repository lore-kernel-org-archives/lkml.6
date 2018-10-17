Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FE9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDD4214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uit1miuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDD4214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeJQKEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:04:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39595 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeJQKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:04:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so12379623pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 19:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zLTABFwy3vrrD2Njv1EGBGlAlc1lXEBaAna0RJh02S8=;
        b=Uit1miuJZ2X27QFdE2vdYIdZuThQV/GN5X+ju+cLCh8UY8gF7vJRkfg7q/Aj/X1l1e
         KGAubbR9VR3OuWIvF/mZ17JFbHLg8jZ7Ki720NPX4idSjZhNvWFG8AFlBlrt7Hv9+Cyi
         2Dd6W+93BET4y/prDiCO7hbrr7BTMBtw1EBqmoJBpibJl45NW2AAE/nkyQcGiNvE28IW
         gvHYE9hFkct69oP9rZ2miAIwvDIAYsferRQaQtWEhVozeo7pUa6o5lSt9eRGzNYJtcY5
         MxroqkSoUuPxwcSvLnh/oJjGFFLxfa4bB7AGMPGYRaHLAENi2ee+9aVisw/c0SKbpnDL
         H+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zLTABFwy3vrrD2Njv1EGBGlAlc1lXEBaAna0RJh02S8=;
        b=r6+O4XbJJetuOzh4nFn+aUnXF+2sXlVO18ztqfXTTNKIdvqTm68Thqu1pFWzn9T6qE
         Mr3wSC5xnYLWOG3M+06oIetJR2rjitrggSmjGHXM+oemMOMXSjWxqJc/uN/nbiEbHbAr
         lQG7arUhgHA/p4OaO2UB5eW7s2SnOhd5rNIzic8KwBYE6KX1q28fD5rTBCyin8ammlgE
         SyuaNwQt9IvOEM0h+c/leCpvMgIMTul2e1x8v+Omg2vERPL2VWHsTuLNVTDYYqRNi8y/
         LXjEznKGg8MGbTaIBqdStax7nhKE2fRa93yrU7lOqNECcn21IJxsg1KTycTmm7/zq98m
         3eiA==
X-Gm-Message-State: ABuFfoj6jQqWYIHQANEjT1uCAut6FjD02MlmjS43meQ6x1U54UXGPmGj
        7uOLvgk9RRl8jJAnGpYiwkGTOjmU
X-Google-Smtp-Source: ACcGV62+77yY6v0Nq2lgSGjBGDw12lencEshtiXhUi18y89WLlNJkZydVcugT5MSfa8Oepy8lQLXmg==
X-Received: by 2002:a63:4d5b:: with SMTP id n27-v6mr22646549pgl.270.1539742241035;
        Tue, 16 Oct 2018 19:10:41 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm27487612pfj.25.2018.10.16.19.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 19:10:40 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v3 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <1539701820.2805.6.camel@HansenPartnership.com>
 <1539701896.2805.7.camel@HansenPartnership.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e332116b-62e8-9930-c263-d022edb5828e@gmail.com>
Date:   Tue, 16 Oct 2018 19:10:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539701896.2805.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/18 07:58, James Bottomley wrote:
> The current code of conduct has an ambiguity in the it considers publishing
> private information such as email addresses unacceptable behaviour.  Since
> the Linux kernel collects and publishes email addresses as part of the patch
> process, add an exception clause for email addresses ordinarily collected by
> the project to correct this ambiguity.
> 
> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Shuah Khan <shuah@kernel.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Alan Cox <alan@llwyncelyn.cymru>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  Documentation/process/code-of-conduct.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> index ab7c24b5478c..aa40e34e7785 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants include:
>  * Trolling, insulting/derogatory comments, and personal or political attacks
>  * Public or private harassment
>  * Publishing others’ private information, such as a physical or electronic
> -  address, without explicit permission
> +  address not ordinarily collected by the project, without explicit permission
>  * Other conduct which could reasonably be considered inappropriate in a
>    professional setting
>  
> 

Repeating my comment on version 1:

My understanding of the concern behind this change is that we should be
able to use an email address for the current development practices, such
as Reported-by, Suggested-by, etc tags when the email address was
provided in what is a public space for the project.  The public space
is visible to anyone in the world who desires to access it.

I do not understand how "ordinarily collected by the project" is equivalent
to "an email address that was provided in a public space for the project".
Ordinarily collected could include activities that can be expected to be
private and not visible to any arbitrary person in the world.

My issue is with the word choice.  I agree with the underlying concept.

-Frank
