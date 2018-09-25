Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC20C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F9C20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY3ILFbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F9C20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeIZCtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:49:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32953 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIZCtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:49:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so9106902pge.0;
        Tue, 25 Sep 2018 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UwBT6Ua94F51ID+K3lylh+cP3AFbjq7QM3C/BSJSjj8=;
        b=CY3ILFbnYZu4LswVS0Tdz4O8jsqLu6PVrUtaw1AT1ZVRdS56bcER34FZfdE/hJE5pe
         CfpYh3LpO68qVeqTyHAHMRFnvSx1Gm3itMjSe8ZGNeLdSLfOW+gZMMsxGkFtyJDvbde2
         9gZ3LD5c0v4VjIvspJaY1soIYnel2B+GCVwDudyKXRKiDQAtJI7f77Zj6LwID1qpnyf/
         9Ift17P1qoRbFnqAP3FISQs0gy29Dt+0dv3rOFSrBXxQB0npuyf741xCweEQJDzbMP3N
         KNDpYWvbSf6B8OjVcLwyGSqmRYuGvkaQ6TU5THY0+1JhP9TSm+f5N4AIrYFVHWEPUgp4
         UVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UwBT6Ua94F51ID+K3lylh+cP3AFbjq7QM3C/BSJSjj8=;
        b=Zmn2A0ZMso13jWYM8JL0p3tP9LyiBvm3S14neLYpCxwYfyEWuAbJJL5tMBQnf+u6SP
         TCV9hb/rpjIkhNV7fCtcmwxR96FhplhHY9lHvfN7o/QsmFGSOhWXaL+BGSYP40HW5Rlr
         MXf8icfiRHaiFMAYuqbKZc6q3M9wqR781nSNz402TMWKaB12/X+ogNxdZO/3RvBxPE0Q
         FGt3lkGbrjfZHy+xCMrTBDzwulhjs8DILqCXVOLdHvcAII+NFCKOYJ88cOe/fSsTYIIL
         xNmFty+r6c1G5kKQQQVsWEemEVdwcLlZ11ksmttwvxzn09w/581xZysAF+J9MB9ZerVi
         yW8Q==
X-Gm-Message-State: ABuFfojfs7lH9l4choc89KZpPN3Oi+4w4v0GX1bdsqzQ5yUaMPzhT6Zu
        RyOf8jjG2rD5oxo3FahB/Tc=
X-Google-Smtp-Source: ACcGV61RMjx6gITARmerODzcN5VnGpzA+O9UzqKSSGEdT7yfNVKYkdt2lOd4ABc8oW/sqaEcOLYrXA==
X-Received: by 2002:a63:5e46:: with SMTP id s67-v6mr2534029pgb.373.1537908021299;
        Tue, 25 Sep 2018 13:40:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a19-v6sm4831598pfj.38.2018.09.25.13.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:40:20 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:40:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/105] 3.18.123-stable review
Message-ID: <20180925204019.GA13001@roeck-us.net>
References: <20180924113113.268650190@linuxfoundation.org>
 <20180925203843.GA12876@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925203843.GA12876@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 01:38:43PM -0700, Guenter Roeck wrote:
> On Mon, Sep 24, 2018 at 01:32:46PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.123 release.
> > There are 105 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Sep 26 11:30:30 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 151 pass: 151 fail: 0
> Qemu test results:
> 	total: 285 pass: 284 fail: 1
> Failed tests: 
> 	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
> 

Sigh. This was the result for 4.4. Here is the result for 3.18:
Sorry for the confusion.

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 221 pass: 221 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
