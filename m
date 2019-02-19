Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC998C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC322077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0EJVi0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfBSRjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:39:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36660 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfBSRjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:39:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id k2so1416601plt.3;
        Tue, 19 Feb 2019 09:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7rP07xv4OKRvqO65rpP4mqxTwBPtf2HLWODhcakSHp4=;
        b=e0EJVi0/jcnRR/HfC/kKmSPRmUaq2bFtu5FvT7piI2Vg+DWBfqQHrEw0BB/pR66fFQ
         iBR+ZsfND3UJFg47djR43QBJVAuXpM9Hf7D+xUpiO0qUs+fWHJnn01eTF+Rwq1AHcAco
         4HQy5+esG1I4Xq6E1baK6D1aNZ/3PkKwyhazVy+90vZXueO58cJ56hOwumHryHBDxdCw
         u/j3Y2r33DCIvpG7PDnVsBeYenyE06vZPxCJy1t5Fu+ncTaO4VJWjGLTEKe/AtSDg0LJ
         LLI6uoqYrKmNQ9F8ypEgnWxnvn5dgwwFGikDC2+v0QERk+Gjl1f2s+2yvTKMGEAvOgsQ
         dhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7rP07xv4OKRvqO65rpP4mqxTwBPtf2HLWODhcakSHp4=;
        b=R7G2VxOw4KRnCJ2taN7cThNFvekxMzCH2juIFYk+JppNULkDP/+7YbVr32nfB9lNqv
         hK4yhbD8KaC7UM4mbH9YitqqATlZLTeZtmUxWYkjWyTA5pSEXxCVH3CTpiMjYdZa7YB7
         IgxWbfH6nX+tR+w3b4/8allwF6y2dQqZkiTK4qNABqeEOPwHcyaVpMRANT192H3BTr3j
         Ztfqjtm1OCOA8IyEFOzSbooD1vjzyS6p9w+YZYw3/FkaojPUq3GHQ0Fj+uID9H7/Fjc/
         XOHs8wnNy8VI9U70pz9gaxDjQcuuK9cv7y6UuRSF/A8lJ5mETZBDjgcd55gf6lvJdup5
         VG2A==
X-Gm-Message-State: AHQUAuZ+jN2kIH9f9GO7JciMtZSs1iENEBnHVtRgJoJWbBbFxj9PxwUZ
        VMZ7SdtThrAIkGzDkZRB0dPKBv9N
X-Google-Smtp-Source: AHgI3IZxppuRUp4FFLWEk40NR41E16KpOAZIgomqV/Sl/rMjG6d/xQlznekbHuMD2Rgoe90q8NbDqQ==
X-Received: by 2002:a17:902:3381:: with SMTP id b1mr32445620plc.13.1550597954726;
        Tue, 19 Feb 2019 09:39:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z127sm28460385pfb.80.2019.02.19.09.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 09:39:13 -0800 (PST)
Subject: Re: [PATCH 4.20 00/92] 4.20.11-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190218133454.668268457@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1ed0095f-ae1a-f57d-8005-38603ab460b5@roeck-us.net>
Date:   Tue, 19 Feb 2019 09:39:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 5:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.11 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:25 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 156 fail: 3
Failed builds:
	csky:defconfig
	csky:allnoconfig
	csky:tinyconfig
Qemu test results:
	total: 343 pass: 343 fail: 0


Building csky:defconfig ... failed
--------------
Error log:
mm/memory.c: In function ‘__pte_alloc’:
mm/memory.c:406:18: error: too many arguments to function ‘pte_alloc_one’

Commit d6caf1d0d553 ("csky: fixup compile error with pte_alloc")
(upstream patch 2a60aa14a9a) needs to be removed; the offending patch
is not in v4.20.y.

The automatic scripts seem to be a bit too aggressive.

Guenter
