Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77BEC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D15621A27
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnggAe5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D15621A27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeHHSHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:07:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36848 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeHHSHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:07:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so1213035plb.3;
        Wed, 08 Aug 2018 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r5a59EqO7x1cbkPAPQ+/Zk34ZKDBQK5F8AEA1UXlAlU=;
        b=LnggAe5xMbC4q7B1jyj/PMDwCGPNO0uX9LnUQh5dHvmBVOdZfvQUvkeiYtutCoO5pz
         p6CaLwedZzBxwUgUOQQvSVyWiBZvfHUoH3zcNeTA/5j9xftPY5Aveb52GE8t/eoHXyJ0
         Y38nb8/JejlxE9WAMOerp4fuI8lQ8EOr99IDCx/pRcaUBi11yqmHm8iWtOcOxJbZcEqj
         C2z9J6fMnuCsSf5Iy7Wy4gyB7kyddVjEcHZsiEBxLO4PoC2o6HaxOLMG1usMeYHoVymd
         W2Eg71addc2OyXl56+RqoePM8bJcGC/lNNE+j5V2iPNMVTdhQlp96FpySH7rI5X6SuIJ
         rnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r5a59EqO7x1cbkPAPQ+/Zk34ZKDBQK5F8AEA1UXlAlU=;
        b=AoxyTNhCanO20t+pzsO0VPULqt35fS+FwK7LmLBYf/jLQwKuLz1ODn6USOcioWzg1/
         rxNyTwGgSywOYPS9b0Zh1X60t16C8EoP7fS50jOd1rG7rT7lLRB3rKmWlgKONoEVTMci
         kXQiuXCJjIidxcnglXwxLK3DU2wq6iovMhFN0ddd3X18DOCwKQjLxeVcwk3eM/MIRekQ
         GGWodgi9kg5OGNkCjKvwacwY+Z2tdCesYkKjd7APn0kz1PaPxkIGp6FLhXohoKeAO9er
         Rrj+Jir0eSb5m827OdQiVZ0BmyNMPZSf4B/GDN0WfdFmnpmAdjQtJpiedwdZyPNSCOTt
         zX4g==
X-Gm-Message-State: AOUpUlEGYgrxHrfQfTh5ZSxqss0+VyhgcOHU1npGiAQpRPkViDQERgjX
        uagu689JrSVnJxTD04q5LSI=
X-Google-Smtp-Source: AA+uWPylMVNve6dRskh8bpMyGioZkBDpcIsAldG7EhBhPjR+qv2YlgGjGEcd91wRe8CqafLZBc+wjg==
X-Received: by 2002:a17:902:583:: with SMTP id f3-v6mr3078550plf.115.1533743258295;
        Wed, 08 Aug 2018 08:47:38 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h7-v6sm12662271pfd.155.2018.08.08.08.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:47:37 -0700 (PDT)
Date:   Wed, 8 Aug 2018 08:47:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/17] 4.9.119-stable review
Message-ID: <20180808154736.GB5368@roeck-us.net>
References: <20180807172342.071526922@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807172342.071526922@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:51:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.119 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug  9 17:23:30 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 277 pass: 277 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
