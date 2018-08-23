Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FB2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E0C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uft2JiKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E0C20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeHWXmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:42:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43256 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeHWXmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:42:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6-v6so72469plv.10;
        Thu, 23 Aug 2018 13:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KgzVz9EJ9EpmY0Fj3hdfCCiA5HadOX0Yzb64Ev6lZO8=;
        b=Uft2JiKgFnmUKBhGm9H5UvaKqbZX50rX1BpSswg2eSZq3fOqWmVhZG3aI6XA11c+9d
         /WQE5oexY1/EsjqfCPTFn5Zh9EFmXCM/1LGluXQnchxTB4cOIL3OnRM6wBhgYxKrtwWx
         hBg6frsAxuGTiqJmIIpcOjfNsUjQ3OS/BhyK3R7qaIT4eLzD9VbGzb0fHK/eBAeQDFPN
         hftgSgEkZ1Cd0KsFTv+OQoDk4CqvmxSbycdHPXspQJBjpHLEC75IX80dMfJsP7w4vxj0
         pa3MRN05Khet8rsIariaAn/tk7g5W+qDqyBbH6MCDPIbm4Ci2IWwIcbSiFPVf7/nJdaV
         Tl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KgzVz9EJ9EpmY0Fj3hdfCCiA5HadOX0Yzb64Ev6lZO8=;
        b=GF08V5Z6YUUtqEQn1ppDgj06sln49OgPHOAU/VgdB+fXRbTf+4q3Gg+7Qb/lIbsdVF
         pqE6JqxmbBA5vqSNwSTVUa5Hi2OkIJvj2P9ve8tc4uVWYHqGm1oGkzBvBa/BQMqVdaNf
         Mb5Nof9f8PMRfq9Cg0lRC7j3FDLXpeu1gaRMmp2TnkWEzaJUlfdqBo4pXT2gqtIbXuS/
         CIEnfaUuqqAZm1ryy3yQI/LHOdf+9pNjmwWs46a4bmjckP66db9oO3FbnhaKHCDpE1eM
         WDBvxvXgVXglHdw1i+05G1xtIhX0bPUmdqW5+3xBptNAHIf6LlPvCQt/3d9lSorTglRb
         6EQg==
X-Gm-Message-State: AOUpUlGxfUs25z2QLlUevHC4JdwPVAn+vfX1E3yUR0YNoCpAzrZBSACE
        /vmS695QMyLiPZgx4vBGXjHin6a2
X-Google-Smtp-Source: AA+uWPy7gM39Q3EQMZYc6d7B8Bc4FtaUj+ikegxTMwqzos6xYmsdntdCvVwMrz3biZjVYR3bJ0Zqlw==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3-v6mr59935475plb.80.1535055068062;
        Thu, 23 Aug 2018 13:11:08 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r12-v6sm6780007pfh.79.2018.08.23.13.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:11:07 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:11:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/130] 4.9.124-stable review
Message-ID: <20180823201106.GC9368@roeck-us.net>
References: <20180823074927.161454870@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 09:51:56AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.124 release.
> There are 130 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 25 07:48:45 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 289 pass: 289 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
