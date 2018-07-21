Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9348ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8106320871
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/rt3lUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8106320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeGUOe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:34:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33397 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeGUOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:34:58 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so6368733plb.0;
        Sat, 21 Jul 2018 06:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JD2X9ZL4OOMvUpO7NW8VEOHJRGdLWJuVWgckYIZCk1c=;
        b=B/rt3lUrVqsX8UWp0Bnvq2U3Y26U2S3TNA7S3RbFjjoXYQWeFsOTovl3EnIYBJK/UO
         lybGp+UHftsApUjhyl6Soyh9H2OFBOij1ac50BFQlUYkifqooTPqtbl0pv/04jB6kP14
         imq2XvsSXXRkbqTGEZDF6m8J+yAHYY3qS9r0Cr8WdfhHvsLfmZ6zgfDfV/IHGNeAa2QU
         Rc3PtvVlUmFSQp4fOfh+lkwCDb6NTPnCyfnhUhWygl4+rXWzZ2KkRTk/nY8lYh00p4kI
         7ZzPmh1+DfSUnLT94EDS7ZIc/8+0Ssg+2dd0dFA1TaSp9XKZUl5wHw+oc0nUktv/GX9Y
         heeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JD2X9ZL4OOMvUpO7NW8VEOHJRGdLWJuVWgckYIZCk1c=;
        b=MxHHareVJgIENytlRaDQz6ZgCeOwtK3BIo8bThLvmSVCGztm8ZFYWp7L9vXVI1tNTp
         hgp0lDMIOt2+rNXbpd39eKR8fQBs13Le9dEMfo8wzz3bkC6Kw9+YLOgDMbs+13y9QVmS
         +m3D9/L1pj6G9DitWu2GPevx0UdY+rA2jfJNkWEa7UI3D1Ad7a+ig8c9+Z/VnaTeVsb3
         dsh3JLM6pQjBCRKeHcv1TyD7jNj3YMlRy72Ss+4RHWZpYZdnLe6FOYEMrnA9KRSwzvTH
         /YXwWls+kE9ZWO9KFi3Nsw18rVOM84kpRH+eKG5wfz89LJUw0ZGf/zmWw7k5H/CpLMoK
         APXQ==
X-Gm-Message-State: AOUpUlFP8Yr5cCON43dsbGZ9s0b90BusHq4ImHXKsY5y9jMkrQu7xzVb
        pP2OswKfvHNfiiD0sxSa2/nM4GOS
X-Google-Smtp-Source: AAOMgpewwP8MdGiLJhksePrTOQuqs20DcBRZZikhEXqoQHPWHoXPbvGMhJlFDL+FnaFv9mOdklvZow==
X-Received: by 2002:a17:902:7b87:: with SMTP id w7-v6mr5974746pll.142.1532180528377;
        Sat, 21 Jul 2018 06:42:08 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z10-v6sm6564121pgc.9.2018.07.21.06.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:42:07 -0700 (PDT)
Subject: Re: [PATCH 4.17 000/101] 4.17.9-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180720121422.837870592@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ece8c09c-ac27-4c40-c9dc-ce6e8d675a83@roeck-us.net>
Date:   Sat, 21 Jul 2018 06:42:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 05:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.9 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 22 12:13:52 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 172 pass: 172 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
