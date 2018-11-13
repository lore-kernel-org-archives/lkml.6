Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDFCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB5E224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4NDuOJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB5E224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbeKMKv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:51:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46099 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:51:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id s9-v6so5119188pfm.13;
        Mon, 12 Nov 2018 16:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vzc91Uf2avrPEQfccp6PPwm7fOifmGmlS/9jCS7bATo=;
        b=C4NDuOJjSAawkaB6UQFwXDYGobZKvRwliykjPN8+Fqs8Y7X2TLW36W5lXx7zzZ30jM
         k85oRNsNyomt+/6jxDZmaZmSfi9a96alceRsYBzKoz1bUUpPUGD1ZQT3mdcmBlhy5rsN
         KNSO6LQW7hwPOTaGna5pc1RNlY0gK5xgJmUgivNnjgrqC4eTkDqUroi+W4Qt2J2tSHuU
         zJioB6+18JinEYm0F49jEaMmxYZ0pMy+qCXO5yj3T/BJEv9K7u6LMTnVgwfB5qV5sTDP
         Gl791HVE+o5w7pYR3pNYzrKA9ULtQctoWJpTn3+ovjIZr87DGc+2/VoxddPczZ/LGg9k
         H0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vzc91Uf2avrPEQfccp6PPwm7fOifmGmlS/9jCS7bATo=;
        b=O8vBaYdpzE0NO//JWTw6uh/YGW4SL8vO1LqLUw+9ukTlGgTLIfGuWU8zcCG02fcMu3
         FPf4ReMPI3YhPsjnP2ybxOaFF2/wiRCnBPf+SP77GCX0V1seFNG6zVPQoVLR8r+KHh+q
         vU+pJHkxFrLXcKVWDWo70izJtaT0T+otT36SrDWjPRSoGA+wUZJPg07G0Cmil3IDVGnV
         6QeKgc+DpNG+lyn3ueQWMkj5KQzTge+yX/WWCyfnBeE7EoL2SX36qb+XItZGjouCBvNb
         e6yYPIjkF5SZOOch5UOUT7mbCce+dOu5A8LRVj99LVG/PTmpLgLpYMVlPOtPIHRZL8XP
         fwoA==
X-Gm-Message-State: AGRZ1gKnDDMrMcnXWhPhxBM/WnUYYTug+VFffXvXH+lT7MD3J3ydIaXN
        W9iVkeT0rYp5BGR9AkE3E0Es/bTh1o8=
X-Google-Smtp-Source: AJdET5dgnYYSqnq7Ped9UkmmLxPJMh60efGEdnoJpkAsvIvdTPihDQER5H7TjgmcafnP61rEYRXOyA==
X-Received: by 2002:aa7:858b:: with SMTP id w11-v6mr3119786pfn.77.1542070580856;
        Mon, 12 Nov 2018 16:56:20 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s86-v6sm37729647pfa.137.2018.11.12.16.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 16:56:20 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:56:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/222] 4.14.81-stable review
Message-ID: <20181113005619.GB2997@roeck-us.net>
References: <20181111221647.665769131@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 02:21:37PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.81 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Nov 13 22:15:32 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 293 pass: 293 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
