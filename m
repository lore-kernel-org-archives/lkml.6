Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F6BC65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2842087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIyHONw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2842087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeJHBBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 21:01:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42197 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeJHBBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 21:01:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so7134022pfn.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OikYU+xsBSIWH/iBAunyxk0DN8ye9H2FGU58wKCjm4g=;
        b=eIyHONw8cNnQakb3IsDnT/kQnmcxJJTSmqKiCpqEJVnnJhCUApMfnAol3W1Jr5qC6r
         yCqkcYY8xeH2a8KsSkux+zYfQP0FVsRIVmqowE7uf5/cPfn3fMHzhlIIvDGTKKpSVSOM
         BBJsr3gmlFEh34WXxNWecU2yR9fsPCIids2Tm44TOBQ/az2sap9HhVCKbrwH+HiDmn+I
         TuURZWUCUUoos1dbaaQ0YQ6r2b/VxOakgiSxkXE2CglVyAWGnsADiLnvA54NzyEMyCc2
         AIcHZ2YiL0/r2FhdCakgIenPVo2Ua3v2OD2cQxTAU0iOcw6ymPYMSJ8UMoqZPqcvwaLg
         NPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OikYU+xsBSIWH/iBAunyxk0DN8ye9H2FGU58wKCjm4g=;
        b=EMn79NAXwEhq4ClARBxwQJ21/hFlrtJp9nWNwgHHwlj/xSQ4zx3bdu0S5fEdUDd1Mp
         QFWIywmitdlAZbSFA5SAXVwlvKjksjGUtwpbL2k2wSxxO0TbnBr4a04ItsdY9T676kbJ
         N+CCa7fjmk7DGTu8P7Pbko0Lo1Cp8t/+uHLe5Dn+h5VOEjB1M0YEavnroL2pahGUDgi1
         KRFVdN2+lNVXqdsL5VAxrMo0rI+3e9MOng4ArPxcLpQWTOWnKGysTCWvLD7CavCKZq6I
         JQAMfgOWVECFK6OypWl3xExMjYsBVbcBuFkKXxuuEJxQMG0WOLEMtoF2VQCZzMpzy1Hu
         8Mgg==
X-Gm-Message-State: ABuFfogj8M0OtxN7OZmxqdfA0Xcs+I47tQ+d/zov9g3QaTYgZ5921rcD
        WDMl42ncZQKBG1vyKWOuQ/5VpVwu
X-Google-Smtp-Source: ACcGV635i+SjuulvMaQlEgTZV34L5dB/ydNQaQuuKaehaeW4VVHEIVutd+xgF96km2Mp4OfRQl/+YQ==
X-Received: by 2002:a62:c8c3:: with SMTP id i64-v6mr22088083pfk.183.1538934823465;
        Sun, 07 Oct 2018 10:53:43 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o24-v6sm22277703pfa.90.2018.10.07.10.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 10:53:42 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6f59a5cb-8a23-228c-34a1-5750b50c5c98@roeck-us.net>
Date:   Sun, 7 Oct 2018 10:53:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538861799.4088.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2018 02:36 PM, James Bottomley wrote:
>  From 4a614e9440148894207bef5bf69e74071baceb3b Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Sat, 6 Oct 2018 14:21:56 -0700
> Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting email
>   addresses
> 
> The current code of conduct has an ambiguity in the it considers publishing
> private information such as email addresses unacceptable behaviour.  Since
> the Linux kernel collects and publishes email addresses as part of the patch
> process, add an exception clause for email addresses ordinarily collected by
> the project to correct this ambiguity.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/process/code-of-conduct.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> index ab7c24b5478c..aa40e34e7785 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants include:
>   * Trolling, insulting/derogatory comments, and personal or political attacks
>   * Public or private harassment
>   * Publishing others’ private information, such as a physical or electronic
> -  address, without explicit permission
> +  address not ordinarily collected by the project, without explicit permission
>   * Other conduct which could reasonably be considered inappropriate in a
>     professional setting
>   
> 

