Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59FFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062A5206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db/dUt3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbeLOCIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 21:08:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37809 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbeLOCIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 21:08:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so1976254pgb.4;
        Fri, 14 Dec 2018 18:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CcIkbcKBlshPn9iJd/cPz+roCk64WIC1HqlRb7ewGRM=;
        b=db/dUt3XJpbVGQ/jxLksp5L6MYGKnNVWSfLysNKZdg7+j0pRMWfyE+NsGC6wkGC3sU
         yndd6GLIdjN2x49fd3RRaq2XWFyLgcC20BHZOVfbqz5vK8p3pkzyLCexhNAR9Yoq9NmE
         LqjxUBzlyJLIc77XjY5ozym3Dssq6safnbMQ7BrPTGPOmqYX7DHJDG71OlH5kWxBmljF
         T+XG+ojzkpt2KaN61jPaa8qk/XhEGSsnTxnLHdMlb6nlnAsPuycn4a7jQOjAEHOHh9nL
         2e7vcmmK6Q918X/E79hWlVGSSeKrKkWaHSXTLBg69715cuiUoynmY1yOeEGs3c+IK/6v
         92Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CcIkbcKBlshPn9iJd/cPz+roCk64WIC1HqlRb7ewGRM=;
        b=HccEGVpZt2ws45E2NrMOEaLha4OfnAIFDQzG+TkiDC6bY52hAGDVd2iThKnj1nOEAD
         BHrctmitasZF8ZZmCTtCHGD4WL0G+26h3aE+4OJr2MnOBGBO9GMjWhiRU4S3IcbyXteR
         BfC8A4L0rron4wznytr3MHnzR3/GPyGa4UdIIMrt/4HaAvBe3I1t/n0Z5i4RH2npAolN
         mgEvUfGsMbBccEiZ5wZMvMGZguKfTDEqSyg/3jQgomRWLUz+0y0DRATjDP743uKdmdz4
         x6Y3+vEGpX5wjgm0V0LIDq/Oqnnnkg9E8P3GaorsWBYzc/rZWIELOiP3fL6+O1DoPizd
         jxgw==
X-Gm-Message-State: AA+aEWYTtIBmJgtU5O6NbCrFyQ6CfI4bqnD6+SjkDI4MIBnaCrLc1qw5
        GpWBCLYRuv6hNKO2FbqM3nuZsy+N
X-Google-Smtp-Source: AFSGD/VFLDwQK5MNXgDHEwyL7+UejtIffaRUO60huxw+l7gzgMeuSSF1UiUEuXD9byMTEWqKcr9ZQw==
X-Received: by 2002:a63:a452:: with SMTP id c18mr4849898pgp.204.1544839680494;
        Fri, 14 Dec 2018 18:08:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b9sm7154359pfi.118.2018.12.14.18.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 18:08:00 -0800 (PST)
Subject: Re: [PATCH 4.9 00/51] 4.9.146-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181214115713.244259772@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <139ed5f9-378b-2941-caec-050ba43a0891@roeck-us.net>
Date:   Fri, 14 Dec 2018 18:07:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 4:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.146 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:56:52 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 311 pass: 311 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
