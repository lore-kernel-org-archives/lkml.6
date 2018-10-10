Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3D7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA4F20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5ZTOypQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA4F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbeJKEMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:12:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36643 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJKEMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:12:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so3071611pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8vkzTesM11m9QdFlTyCHJ5CCaQvwAQMQ/TFVtVTECNY=;
        b=j5ZTOypQWH8ViuBOLSJxKqUxBXS5wOd/UXanfAf6ZiaiGOmdaRGePVbXf+CcMSeckO
         +zwRh/a6OHzpDM9BzsbMTPBBSwhEDIrKampV8ueSuaPkqLHwGCM89Fsnb36lfDW+Ax6G
         x/2xfHi0pcs/Jk/w3HManjg466jagMHzmxIyXsHzCfp1jtmdcrX4yRigdzzCUY3WwSvm
         VONzvF2Kj2BcwB8icCoHU+/8APM5NNPwv4bjjmtJlGg9d3A8Kg5ggDSPYoB1cZX3CTE6
         6mwOgFFnE6yiAKDOZG6j+rHgV07/zg02IPQpajOoey8GlrkH3UcpnCEFFSgiIk5ntkBi
         GJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8vkzTesM11m9QdFlTyCHJ5CCaQvwAQMQ/TFVtVTECNY=;
        b=DTgX4wuZvNKf0Oh4IKJ9W3W4CdQIUJyClut5ndY/Kv9/LWxHZGPErD4gyHg7cqz1Ov
         VXAeWvFCTAZA0gwY/J60BsCxxFuZwSRPkoylO0PE8VJFHZSzqSm/KHjhpkYHFiBIsb5o
         lv1l/KMyjE2654tHuRt+dBxyvSY48XSZ4xjKCJnCkyyfFnPVXZ8y1ywZzRBH1Mt+Tc6Q
         StKS3d8C1N/TV8ijg9c0sIKXNpa6RDde9eLWSR62Edc4nAt+msf39qAYJ12/SPcaBoTG
         1sOOKm4dTPIP5NdT97h2Rxp9Zp9YSle+SBSkcrcMi/m5onR43eHG1nC+ijyuy7wHpR1u
         KIdQ==
X-Gm-Message-State: ABuFfogN8rJtDahKcVfMGqdCS9JDc4NbmEQmWJbIR6IPtot4Ww/ceuTO
        tmfZ9jfNkyrNwyFD/nLotsk=
X-Google-Smtp-Source: ACcGV603vfo+oqKEW0knjRrTgRkWvwYQrSH9lhcYuYfRMjvjd+uPTfakXgtRnfJL/6f60dUoduHmrA==
X-Received: by 2002:aa7:8252:: with SMTP id e18-v6mr31826985pfn.164.1539204525652;
        Wed, 10 Oct 2018 13:48:45 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id g3-v6sm28714778pgn.37.2018.10.10.13.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 13:48:45 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b1f8939a-220f-b99f-8def-cb2a6551dead@gmail.com>
Date:   Wed, 10 Oct 2018 13:48:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538861799.4088.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/18 14:36, James Bottomley wrote:
> From 4a614e9440148894207bef5bf69e74071baceb3b Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Sat, 6 Oct 2018 14:21:56 -0700
> Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting email
>  addresses
> 
> The current code of conduct has an ambiguity in the it considers publishing
> private information such as email addresses unacceptable behaviour.  Since
> the Linux kernel collects and publishes email addresses as part of the patch
> process, add an exception clause for email addresses ordinarily collected by
> the project to correct this ambiguity.
> 
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
