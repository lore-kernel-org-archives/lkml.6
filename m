Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B90C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E3621564
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUzhvcjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E3621564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbeHBURg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:17:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44993 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeHBURg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:17:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so1771776pff.11;
        Thu, 02 Aug 2018 11:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lXk/BkwIVZIfA+Qxjlh2HBtk07O47Je0XVrYJbD31qA=;
        b=rUzhvcjbFxrrninis9TlVS61GmYO5qPxbJey6qDQNmVK5sqXz+PQF40+JxshBBuctP
         ee5uixRsl5Sql/0O6oWM8WHXVG1fgLWcqihse9PPhd6jPiq9e5wYkNXh8xUYpegCo7BF
         pwoxb2btP93Y0RK49t38uDrycIwVJGAsMe8tZUCi1IfMyob/ZG2TsQyxhooLokvBVcEJ
         nYaII9TOqS/nLp4SpAg2QZNPgLwSl2cMFYNA46fBZfCjOOWuREVpzMCYrktm28Hamhkj
         /2RorLeDFIAsgJh4UiWw9+0n5wEyWj0wnNMufbBAJe+Lvo9DuLzJG95Bg3/kU+VBQonK
         esIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lXk/BkwIVZIfA+Qxjlh2HBtk07O47Je0XVrYJbD31qA=;
        b=JYaIVXfp7y+XkyWrJniEpPg8ke4cooVafXaXJhke0LoJXabE0P9NdE9YDsH2N0z5Gj
         SRzmd57mafwGWrjKljR6vrtWwOn9h1lXRG6wfFMV7BypWFuZ1/vVBU0HHiUjqJLgVeQ4
         M0PgBDlB415k2Cbqc4Q27W+EQSZffLEti+lRdwnSqBq0AKbNn1RDcD3Mlufsd2qZEylH
         qJdUTO2Kd1GLshyj7BcC6d5Hj0NO18bYkj4h7KIlS1lp3PtpEiWdhztGIIBrrQCVbyae
         ZWR5If9uwJBkL9CcsXiXLMoAlzKeHOVQEqqcoa1FyJunOgnnIdd2bSkMwV5JiEowQ5Ak
         VCKQ==
X-Gm-Message-State: AOUpUlEPDUKZ1sxv1uPOu0ot6xI1tKHCvDwmvmVkCLONC76sBHLZfD0z
        L8x/1BIcv5QoEgo4NOjHvpP+M7py
X-Google-Smtp-Source: AAOMgpen9Q9hooUqIb05lxYUGunzYg9weJCLCC2xMIdjTP67aU3QWQCiGZ5vDUcxPHbZsZ0WTURzuA==
X-Received: by 2002:a63:5d58:: with SMTP id o24-v6mr525476pgm.349.1533234320094;
        Thu, 02 Aug 2018 11:25:20 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c1-v6sm7160682pfg.25.2018.08.02.11.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 11:25:18 -0700 (PDT)
Date:   Thu, 2 Aug 2018 11:25:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/246] 4.14.60-stable review
Message-ID: <20180802182517.GA24531@roeck-us.net>
References: <20180801165011.700991984@linuxfoundation.org>
 <20180802154325.GB5137@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802154325.GB5137@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 08:43:25AM -0700, Guenter Roeck wrote:
> On Wed, Aug 01, 2018 at 06:48:30PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.60 release.
> > There are 246 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Aug  3 16:49:18 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 148 pass: 148 fail: 0
> Qemu test results:
> 	total: 198 pass: 198 fail: 0
> 
> Details are available at http://kerneltests.org/builders/.
> 

I spoke too early. parisc images crash after adding some configuration
options. I don't see the crash with v4.14.59. I'll send another update
later after figuring out what is going on.

Guenter
