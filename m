Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172D1ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D5A2151C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFySXys/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D5A2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeIRVyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:54:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33842 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbeIRVxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:53:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so1269669pfi.1;
        Tue, 18 Sep 2018 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NP0PBd54ktifO6nS318+b20V/99aJs9wINsORyWqplg=;
        b=LFySXys/XP7meiRakanUiZ4nfE1qTVkFa72t9QRmR6PPgyU2/n6KjbU8YSIFyX8n2q
         JWa9BhXmAMUtlo3pGDaRJEEdZ4zeArkKpEOOHeqtnz7Cu/XvMTbPf+71oXBwcZgvWBQD
         L2AtmCma1Mge3Zk6k6pBcH3nXa9j1tncpgaA5hBAyhqAlAebz8G/+yKcakO2nblQCb07
         qeSiyUSiEjnw1XwA+01AP7OIPcl/825GeRRBynUPlmSuevKI81ZZci9+T6x/Ai3xe7Ke
         dzcm4Wr9i3y3ltenImCX1TF2gX3eKZc9GX79tmDR4QWa0hUVm482yiJhJHfM7Nrw/Ewj
         iPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NP0PBd54ktifO6nS318+b20V/99aJs9wINsORyWqplg=;
        b=gLYJ9QZ5EGKTI4FAvzKHzAkHvyuRnnz87WgxSc8wG1Bu7XnWoUzrW3rR+MvT8kWGPq
         vk6c+TTPT96xPKSX4BAb2NRmhTmXOAfHVzSWTt26yGPX+XqZ2xO9qDk9DaF0aayxK28+
         h5nxFliyApwTgoeHrros6NQZz6RufTo4Ffe4cglLs/ZYDgLkYnit0MzSPvDbdKJhAhky
         p8rIIYQLXP2dJgDXyAtF/SMk+m8pfdnFhNnbFL1auDBvGm2cyWjykham4bzMeOgP8Ml2
         Dg1h01pCcLERlVCjbCnisrsyrDvzCotWtiTlGkLq8nt/95r3DcRqw4vXW0SLR8prnwwY
         t4eg==
X-Gm-Message-State: APzg51DqyCQLNrXgL5zehA1v9BIS+aH8WY/g5iJtnx+vRIaVQfOG4TsM
        corp6B+HP2kSZJo33KnB+8J0+NR0
X-Google-Smtp-Source: ANB0VdZc5gJplBJ8/9zqee2AbqE6yFY46hqbDBleT6eNQs3xj6bk9MofRcKExnMnlRWRbAmnvHC4iw==
X-Received: by 2002:a62:565c:: with SMTP id k89-v6mr31547897pfb.212.1537287622727;
        Tue, 18 Sep 2018 09:20:22 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x24-v6sm24231922pfh.67.2018.09.18.09.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:20:22 -0700 (PDT)
Date:   Tue, 18 Sep 2018 09:20:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/70] 4.9.128-stable review
Message-ID: <20180918162021.GB28152@roeck-us.net>
References: <20180917211649.099135838@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:41:33AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.128 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 19 21:16:09 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 305 pass: 305 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
