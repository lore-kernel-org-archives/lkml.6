Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B234EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A8E20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRods/9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A8E20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeK0F66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:58:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38531 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0F66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:58:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so7042916pfi.5;
        Mon, 26 Nov 2018 11:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EYAIrBmeDQk+0FJ9kXgqkc/Wn4Oa1EeCXW/7W+HrX5I=;
        b=aRods/9Q+nyD1XhWnpxWQZ/Wja20AAu7k029kTMtOOOdcDOI5uCzivK5WdIuOHmIY6
         avSM02iZgjncDmJbzGs7NdJlQN8JG21yvV/QjElYTYum6f+4Dk4us71qguIMunx9xgDU
         MniFS/mi69idlh/v/7FDXbMFn7dPQhev4fscwn+253jK1YL8X4CPo/8k1+SSG0PhQCMH
         r3BqjaL7T6NyMJvqofyGi+Ftmcv+SWJXnrriLlYqIwkE4ACVChMRSjaNHmyuR2rK9IBj
         iROkmNBMi9Nq8bs6oCCdqcDijEYyegaf/DsKybYUbavYnRBhGwCUOniESmOr0Bg7/7js
         X6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EYAIrBmeDQk+0FJ9kXgqkc/Wn4Oa1EeCXW/7W+HrX5I=;
        b=dsqdyr0e3yUYrQnFZSjdThZQrAE5LITqVYfC0MkoVRIykLOKZfZcQlFb8gkCPWRqRb
         faE92UYJ+Wuc4ZexAHOz3X0CF3oh6KTLhpasaQRQWNeL6GTFhLOyfQoEwK9dDWs1Z0wR
         p++kpCUiJ14cDHs/x/G5RdLsTxkYUdHW7VgyFu1+5W/4FAZ0jL8bNowwlXBiIHBtuqS7
         XxaNt7EBNkPzofE5T2u6ojMbfAhDbA3ajVUDbZn7IFv3Ji0JqekcIlt0bKwS2frtophY
         THjjZJidRZMBlfY8QN/vBQ9EhA08C5aJquZCWXGYazf03Rs9zpBGkMfSRfK3t+gVvgE2
         Htig==
X-Gm-Message-State: AA+aEWboEjLj1AQ94fNM/+0+hxGuQ6CryWEx5ceUpFxnQHgUMAG6g7CQ
        8DKRcAWwtbWCpTjpZ2jLJx4=
X-Google-Smtp-Source: AFSGD/VGZUvKLOS9+LG3VoN5V8BdVushlYLyEgbTjha8jshPFOJ2uWooDRB6da+WfU3SBQ5ng3N8Rg==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr25285889pgv.407.1543259035730;
        Mon, 26 Nov 2018 11:03:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z191sm1275530pgd.74.2018.11.26.11.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:03:54 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:03:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/24] 3.18.127-stable review
Message-ID: <20181126190353.GA14137@roeck-us.net>
References: <20181126105029.790599475@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:50:54AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.127 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 28 10:50:13 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 138 pass: 138 fail: 0
Qemu test results:
	total: 223 pass: 223 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
