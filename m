Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD4C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59272084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+YPJXlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59272084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeJHBEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 21:04:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35673 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeJHBEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 21:04:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so6820726pgb.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IxzGyc1JPT9oE9iHoUCT2NXlGRmv8pLGUxji2u6bi1s=;
        b=M+YPJXlxo5I6boCkz8FEFL+1ZFQPpPzhC4g4eJAk8c5b3db2cViQR+gTBbNeaV+rQQ
         hxCz9PKK/MHkuScLq2KnlEyd9Ms+FmjeSCQ0Ohg/L4m/76TviRC51D+gN5G1j/oSclQ0
         hMiPQzDSu7oaBlwrWtfWajFtoo0HLyU1+zCzuzyr00mrNNErAAtiUwxEoiRnh/lfoR34
         pT7TeuHlXv2SJ3OtGrUb8pLyiuwZ76Dv2rINywLmGi+Q/RUZipwHwQ9LbMA7arQ88hQl
         bVBfaMYYF8/16a0vNSRjeCYX5T+bvJGS2pnH/C3LYXZ+3FALEAU1gQSJU2oSMa3VO5Gc
         4ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IxzGyc1JPT9oE9iHoUCT2NXlGRmv8pLGUxji2u6bi1s=;
        b=SLb1F4uclnZXNIMlw1zEOIVzNtC03S76+za5godHylH2zlzTAHDZIZEk1CLR3xpiIb
         vD2i7dSvYS5CZiBsJ+mRgx6fRz2ZE+5CqPGBEYAHsUJFc+nWRunH+lFopRzYV2UGJxLX
         znEIlilluv5a8Xy8OXKkPsED82WPjfmlIalH/pO5/OYMtZSxABZUHsHWd4D6KSdtSRMG
         XvZHBb6D4zqi5M1T6G5l75glNp/fEC8EEAHiP3IbHvIuuay71wj8o1VUfqvdOx66Ar2Y
         yqPufsPx2iwnUz1yBa5YtQwt6voUESpym8D4TbxbwtsNpuzJVMcpzb8E/DfX6j9UTiB0
         8uRw==
X-Gm-Message-State: ABuFfohGxrfXlTapFejfvPQQCxj1V1z51TlYXmxL145ImIHdo/1pEAho
        aZ63mIDkZWvb8xOvWweHp+H0Vt44
X-Google-Smtp-Source: ACcGV62IRrgz51skPrshIm0bjR9ul0qACroX//hyMXsxcz+ePE00A1p8FEgo0pERhVL7r7exAyIZTQ==
X-Received: by 2002:a62:4c3:: with SMTP id 186-v6mr21395109pfe.156.1538935006640;
        Sun, 07 Oct 2018 10:56:46 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r1-v6sm28874312pgo.81.2018.10.07.10.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 10:56:46 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861851.4088.7.camel@HansenPartnership.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a564a1bd-6a11-a075-6d57-8d37bc5953aa@roeck-us.net>
Date:   Sun, 7 Oct 2018 10:56:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538861851.4088.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2018 02:37 PM, James Bottomley wrote:
> Significant concern has been expressed about the responsibilities outlined in
> the enforcement clause of the new code of conduct.  Since there is concern
> that this becomes binding on the release of the 4.19 kernel, strip the
> enforcement clauses to give the community time to consider and debate how this
> should be handled.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Reasoning:
- The TAB was not elected as enforcement agency.
- I, as a maintainer, was not consulted when it was decided that I shall be
   responsible for enforcing the Code of Conduct.

Guenter

> ---
>   Documentation/process/code-of-conduct.rst | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> index aa40e34e7785..4dd90987305b 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -59,21 +59,6 @@ address, posting via an official social media account, or acting as an appointed
>   representative at an online or offline event. Representation of a project may be
>   further defined and clarified by project maintainers.
>   
> -Enforcement
> -===========
> -
> -Instances of abusive, harassing, or otherwise unacceptable behavior may be
> -reported by contacting the Technical Advisory Board (TAB) at
> -<tab@lists.linux-foundation.org>. All complaints will be reviewed and
> -investigated and will result in a response that is deemed necessary and
> -appropriate to the circumstances. The TAB is obligated to maintain
> -confidentiality with regard to the reporter of an incident.  Further details of
> -specific enforcement policies may be posted separately.
> -
> -Maintainers who do not follow or enforce the Code of Conduct in good faith may
> -face temporary or permanent repercussions as determined by other members of the
> -project’s leadership.
> -
>   Attribution
>   ===========
>   
> 

