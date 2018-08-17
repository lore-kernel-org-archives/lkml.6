Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2927BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5C621A2E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx+PH7jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5C621A2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeHQUU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:20:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46529 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:20:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so3768453pfn.13;
        Fri, 17 Aug 2018 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LY91YVzJoYaPVFuDgYZYWD3kjeYpl1AeWnm2w6GcylE=;
        b=dx+PH7jzkFoLsi6O3JzScGOSJmf6JzX9LQRm469Tf/x1yEa4e8FNWR1SpnSCq0HSTl
         d1eK6y2MA3AkRqqHHb14L4qGY76W/YYISmQJY3O5gTkGzhvk1Wrmwl7xaDQLt8y6ymww
         6GUXnTsw54QIvEPax7A8y8zZn6bl2J3YwEY6G21wWvZRrVrfl4EfrOYsmsXhiOGlwmfc
         oyvMbaP3pHp0JQg7pOeArUzE/dYS6y5/Nrj/3ns0DKNqBCA65b7Q7WCwr7jke1H/LAs/
         jNSo1dJQpRQaNBgC60/uRiTjIirT/IlrvlRt24XbV+0oMSBzbYfA+vULOLCnfNX7a2ee
         3NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LY91YVzJoYaPVFuDgYZYWD3kjeYpl1AeWnm2w6GcylE=;
        b=opemNBJKCeOPIDbM9DYBet2ZpoYMQthNR6/YtQwiOeWuZVLO0MBNHsmMOipHsAlsul
         SHXxDYXbXK+z+cHk1byZVYwEhoEbUy57rlMXTwP6Y+w8DpYMCZ3iiRdRe6GRsK6IgqJd
         zlQE44kEJ9AhTb8ncfPKXq3HZrXfS19LesjBxrAPUW22WkzgHfXRq4kxRjA3r96qDoy1
         fiyWdJ+SODB5xDGKcBFuaPRZrdzOS1lsjCfFUxsKrZNn8+jmUAg6z8OBxMPulb2Rf6y/
         ZdOfhB5r1CgkIQ1LshOUV2vdoSeVwztKZ+Sk1xUNR2fCwKg9CHtXca4F1YlYqjuDM0qH
         j34Q==
X-Gm-Message-State: AOUpUlEHIjTIIfc2qQ0dvp0nRtH0Li37NHCiDZmtPdRb0qq3y5cvKnUN
        BHdwNdqi0GhrkLIYTsLG3O4=
X-Google-Smtp-Source: AA+uWPx5uPfiTdByAUKqX2U7SHvyDRvi3CgwGvGBx4JQqwufapvZQtcTCDMK6fTBU/xiTwuHCRro0g==
X-Received: by 2002:a63:1c5f:: with SMTP id c31-v6mr34340809pgm.321.1534526208224;
        Fri, 17 Aug 2018 10:16:48 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k12-v6sm4480978pfj.30.2018.08.17.10.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 10:16:47 -0700 (PDT)
Date:   Fri, 17 Aug 2018 10:16:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/15] 3.18.119-stable review
Message-ID: <20180817171645.GA11442@roeck-us.net>
References: <20180816171633.546734046@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816171633.546734046@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:41:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.119 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:20 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 138 pass: 138 fail: 0
Qemu test results:
	total: 207 pass: 207 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
