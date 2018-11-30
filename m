Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0723FC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B893720863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1B8hVed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B893720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeLAJjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:39:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41336 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeLAJjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:39:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so3451633plm.8;
        Fri, 30 Nov 2018 14:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KS7egSOHc+WwjRuWwPN6ftnxe+hqgOOVuppLKKWvtnI=;
        b=r1B8hVedx4XIUrqe3fq0y+5hKTM0M0lp0Nzb3qWbkJb0tSKE1TnTvr9FicoG3X315e
         IMlTpnIviW9+HXMnM0YjDpPbYgJW7h9cpMbEAv85M8uxhGtq9vEcxrqo123hW+u+kHTx
         zXExSRDxddN32+vJ2EMqOXerNTbw+KS6IDHxuNcZk9JdFQVI2ZPClOf7IyyA/J0i4niT
         VY5jEROJGD81tBAteYGwV9CItNJO2zoeLeocKWRR1oGbFAVkHn8bKoFxxbUANMYrUQcs
         3Cez2Fj1egE+Rs44MfvIuUMzfFzI+fDxTNWgV5yzCpk+XD3oj5WbRQmN1PNDa9s/UV37
         eHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KS7egSOHc+WwjRuWwPN6ftnxe+hqgOOVuppLKKWvtnI=;
        b=rVLp7K5uxo2hDGbDTTHQCNRhT3Q9CN9F+fMTabDtbpwB1fZ6cStDn6z9lQAZ4xj2Zh
         uc7DMaWqFyZBem7mnZ2hv7TGLfPX2az2vrxvDLLeM1q635UGtDhOdHGLfdRx5J2awlpb
         +zONL9E+/7rae+WO14ElPSDIU6/xBwWzeM6Alq3bweeYJD1t2SeD/4UTpr5aW8sq+qc9
         tyDzV/TCKscMKOtxyVHCtyPN2C7BP/PqR9vBos1CQ+ROn367inEdOvTWTXsCXfaQX4vl
         qkwf0Kl1OUtvlJTDduWcT5l1Yoyjajagt5k5aPfqo5EL1+hZ+gAPNaedUKdVzQdN9swG
         8+Eg==
X-Gm-Message-State: AA+aEWYh6rXq/hQpczDtLBK2ns05rb+nwlPIrN0p5g5dUb4tDgLca4JM
        sJ9rKJ19+BmrcDGeHmI12xk=
X-Google-Smtp-Source: AFSGD/X5vArnKb43vDn6WwMwurlojwZZ9n+dHrW0jh0bLVzw6HiQ/+v8YelvC85m4f/ltGRuQ3j/MA==
X-Received: by 2002:a17:902:5a0b:: with SMTP id q11mr7453853pli.186.1543616936501;
        Fri, 30 Nov 2018 14:28:56 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c23sm9117931pfi.83.2018.11.30.14.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 14:28:55 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:28:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/100] 4.14.85-stable review
Message-ID: <20181130222854.GD13361@roeck-us.net>
References: <20181129140058.768942700@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:11:30PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.85 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  1 14:00:29 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.84-96-gce3bc714816f:

Build results:
	total: 175 pass: 175 fail: 0
Qemu test results:
	total: 322 pass: 322 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
