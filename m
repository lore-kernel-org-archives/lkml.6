Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEBBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB79E20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+N73N4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB79E20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbeG0Sv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:51:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38943 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388701AbeG0Sv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:51:58 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so10391478oib.6;
        Fri, 27 Jul 2018 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6USdOPw9Nq46kKunUc2QmjDQTEM9ougPq+qFGtYeb0=;
        b=p+N73N4pG6+lkOD1zZGqHKAgd6HOm3MfUPv2DUrv9z9q1KgjWRvibAJiw1g91QlgRU
         cnvT/GTnLVUhuLCBD6mBLx42bi441G3uPtXqq0cKtUTBGrRRGY+dFUJ8sNGdmT7nCpGm
         AzmWNRJD4EhI1D14WIw8sWX0Xp70c0Gv1BG18JFi3LqBcFiYLu7pqHvnD/T8ViCPeRcZ
         8lRYeQbdeSy975GGUYIfV2znTnoNSFF1tykHGFOp08vjZ9VPWNkZ2/vcA54mETl1UlmF
         cXZL1AyabmoPWLBCQuR0Eq6fuBD0Wat/Se23n5ZvNw2V8cNh3auCFrT6sEjWaqGKJSoJ
         KW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6USdOPw9Nq46kKunUc2QmjDQTEM9ougPq+qFGtYeb0=;
        b=miocAGNTmTUxbP7E56Bcd/kJicpe1JDqrbOE9w6aL25qhp31Us/NDomKrRJ5tsirQA
         7XsrPDiH8PDMQ7xuWIUcdiucFTcYMzKrYCSHbNzmgZ6QhDHsdt3SlyCjCa/0Dnx9iRBp
         KcF769WmsGRqb57gk6Bflh0TuWtV3NbYzAm9D2BBW9jO+qO5nSPAuKCccKT6iGSrVS3X
         N9aHRkIHn6yijZh0oZEV6PDotZpRaw3PPnhiWJzQ3qFH6QyCjeN3CFlITKPruLxb7ivc
         tX7qZ3FIHqIsrPgnNJqLbG0uDabI6qwDjQEajJWbIfR2xDYEd+0uqAE7PukIqlaCA82R
         5rFQ==
X-Gm-Message-State: AOUpUlGN+BzO9xo1WS34AU5h239KxrRykG2AZ4Njpi2mzuY5f40M3ZHm
        c7S9HY4ArwZ9YTA4dBOdlMZBSBlA
X-Google-Smtp-Source: AAOMgpdoaQFyiQLKCV4DVo3tQ+CBUejT4mtw4mLjHiied6sxfOKQPf++ocRPLe2yd+El4tlO50B5ZA==
X-Received: by 2002:aca:c7c2:: with SMTP id x185-v6mr7121994oif.43.1532712546141;
        Fri, 27 Jul 2018 10:29:06 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i204-v6sm9364653oia.41.2018.07.27.10.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:29:05 -0700 (PDT)
Date:   Fri, 27 Jul 2018 10:29:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/33] 4.9.116-stable review
Message-ID: <20180727172904.GC4564@roeck-us.net>
References: <20180727100827.665729981@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727100827.665729981@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:08:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.116 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 29 10:08:17 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 166 pass: 166 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
