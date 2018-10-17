Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D57ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7302098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQOdX5MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7302098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeJRDSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:18:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38318 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbeJRDSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:18:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id q19-v6so10076525pll.5;
        Wed, 17 Oct 2018 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jTefwHuG+L5Kf3USFKuYW8f41noDExV21Vx8AhWFhyg=;
        b=pQOdX5MY7+HDEANyG6X1hHPSRTAy8hlD3j6Wom2Gd8wEJkHPu5+34q9P7R75JayLFD
         xaf+IRjLziRF3AuylkuD8BUQlTJb0D7shgLMZVbq86kK2xCF7B8yk/Z0as0Vw1xpe1+D
         mQ7htguWDNQuxtWX1msssCxehOJS9IyD2eKC4S1K4IVsqagrOb9XmFsKkq+JOOTTYq6b
         gLiy690r4y7BqEhIbGwRQ/idQwGKJjT3XAB9860ZRw4kI65U8JRMRCvZfDaxFz1nLzQi
         FGfzsrn6I9934Mk+oR5XnDATo7BqJ3keBRWLXcPS4BzeQ8fvzkbx1ng1THh6+K6DUwai
         YfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jTefwHuG+L5Kf3USFKuYW8f41noDExV21Vx8AhWFhyg=;
        b=sbM81/c3n0Zsgo8EicsgGml8P3JPw5gku2IV6nUJwX9xgJ3GSSK78A0Hj4niCGo3qX
         oq77erDyIXvzfG2Vg7UgNBUfff0ZDyF2s5Oal5VqGu1KowvMiTeWyRVngNT2VzgD1ZQE
         t6YsgseNUuSMW+zsS5dhWheP2ER6m2+ezU9r46l+tXJjGKIeXZY8IYTaluspFji1U05p
         2Zh3OYEbacPATNIWPUR07wLB8LjvuFJ/GVnY/HvxurReu4M0xYy999jAZ6MEL6hl61Th
         xzbzaDbfYK6A/Mn4iFtSe8y+kFwfx+qNUvtvwYV4USARjG+rjzt9Tlk4bPe47WV2PNlx
         zofw==
X-Gm-Message-State: ABuFfoizDpM7spZ+uvRJPwGaqMggwU/OE7k9wdA7MOM3zMATiYex9TQE
        Fyu6tmeCdE6CV5+PO3dQPyg=
X-Google-Smtp-Source: ACcGV63y+c82wI1HtsPAm6wevF8dvBxDDPIJ4sjqYGd1IlzJHL2LYBECpug+CKlialRRBaiDotdj3A==
X-Received: by 2002:a17:902:6848:: with SMTP id f8-v6mr27379476pln.27.1539804084147;
        Wed, 17 Oct 2018 12:21:24 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 68-v6sm24283685pfg.136.2018.10.17.12.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 12:21:23 -0700 (PDT)
Date:   Wed, 17 Oct 2018 12:21:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/135] 4.18.15-stable review
Message-ID: <20181017192122.GC1653@roeck-us.net>
References: <20181016170515.447235311@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 07:03:50PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.15 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct 18 17:04:43 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.18.14-136-g56f5edd347f5:

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 321 pass: 321 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
