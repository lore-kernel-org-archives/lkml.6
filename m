Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C152217C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvS6I1xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C152217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeHUSTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:19:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43899 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUSTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:19:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so8622938pfi.10;
        Tue, 21 Aug 2018 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EZNzC8GcS2VuQ6Y8/RmMGz/1HUJn0vN3Km59cEwImQU=;
        b=MvS6I1xrnY1sUC8WoTPR8ZU9k9J0/g5qvRWOGy5vpMN1MVfhtd7gaUzV/zJqP8sNlW
         6RiFJRfzl1mOileMgAON8ZXmIl/osAHekzmxK4mLUy7D5l2WFr7KEyfK3cMuR9B+0SFY
         rjtrGbTTCvGbQHRXiqKaYl2qou7zfyMSUlBqK1gwKA6Fh8eAtJrqX1pARW2sPePfgR4c
         7NrkdrTGmZhjvwiJT1HQeZ5KPwtQGAEcMU165OSAhb1gT2YMZkd3dv0LuJg+YN0RXldB
         YRfNxN6+XGxiKGXd9vHA1wQ1QHt+rLKnY5vMsJ27t8W2fBGVOWF9FsmIuskvSh5hI2D1
         4bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EZNzC8GcS2VuQ6Y8/RmMGz/1HUJn0vN3Km59cEwImQU=;
        b=tjPJhuq3FZI430aYFVqsWgFUKROJZFiSm0ixNzrr3x1hn5AE8POsp/TtqnbxqeGXIw
         4OD9o61NXz2pbgrN1fXPmBwWsYjKxRDU8ZTMqb/ax0M8O6L+0OcgLZJAz1KQ9vuOinWF
         gL0FxvA4GfEeB5D7ZP3Sq9w9ff9u8MsQVJCMJwcB1NOPd0IElFCiKZuaB/lOGE9t5nfG
         DrihIO7aqKXH2MXmWnZpubbkWG2GQ4TX0+L743uy0kqLctFAW33GA9spCL75g6kgJgRW
         SDs0UEucnZC9g86VwiIc7lTJBFJymWrsnCeHwy+MsGJe7UViRviiMv9atcsJsvIztfpl
         nvEQ==
X-Gm-Message-State: AOUpUlE/qLQcCCMT6JRkblL9B12soKWHOpmlqa34ZSVTdqTPD8+KAakZ
        te8+aIRlfRsX9RzUc3KsJjg=
X-Google-Smtp-Source: AA+uWPzISgAAvmSJ4Br78bBO+p5SVSVSdakGTXO0rR42ndNKxscGfl99Koycm8dntw6QsRZJVacacg==
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr53710433pfm.254.1534863517934;
        Tue, 21 Aug 2018 07:58:37 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f19-v6sm22217574pfd.147.2018.08.21.07.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:58:37 -0700 (PDT)
Date:   Tue, 21 Aug 2018 07:58:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/42] 4.17.18-stable review
Message-ID: <20180821145836.GD13639@roeck-us.net>
References: <20180821055017.596264829@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:20:32AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.18 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 23 05:50:04 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 302 pass: 302 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
