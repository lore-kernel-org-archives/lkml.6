Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47798C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E179B214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWDm5ELd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E179B214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeIZCut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:50:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35110 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIZCus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:50:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so12030387pfh.2;
        Tue, 25 Sep 2018 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fncyDXiQmjyiPKXAO+RqRMGX0NZLLHQ/oYskS1Zm0UU=;
        b=VWDm5ELdRQJoiyEcBHL3y23j9+1oC4O4OCIrFP6jzMLWAtAguSLp21XGXA9e6mGXV4
         8frxL21/9k0BJyud9wLzuO8WRzmLBOs7BLNP//gGjMg8DI/VyUW/tlbeOkKrBb8eLbgo
         XbWqrhl7xlEx4m4FUA1VFWt0YoKoJXp35PZKKK2f/wurDcXRtHFIUgGKMx0FWDHuZHPX
         sRwek0YdGb0AYn8Cmh3SPu0kAwO2oCnw1GI1YPlY/YY6BENWX/NkKPkXEXZuf8uJ9iS5
         cBPXqVvyO7A5dm9khiEc8G78KleNB9hWRCZhoZtC9QuMNofOx4iC7HBSRozhK3OKZ7GB
         gM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fncyDXiQmjyiPKXAO+RqRMGX0NZLLHQ/oYskS1Zm0UU=;
        b=sTPiUhDIWeH55ssCum5bVZDBmo+qKjHmIAhH9FietwJLv01QvBMJXwM6EBUW64AUlK
         FjFYd+Jp/eBH5s48ckpdiJI/Fh1PynbNpCB42IFp7J9w2SIQL82XU6NMXE18ToGbb7A8
         791lfkap/BdFu88YynRKKrVdTZ/F++tMx9mr6TTKUA5PZZqx7X+AZTo/Am5hUSL4Mq33
         y1QXGxmO3bbT98MoZuHAH7A+diwDFoCbL+PunZC7STZo+mWaNvBecb0nnwJWqYppvXSR
         BcvsvFNLs/0ZIc3WwrmaXnySigQkJcz91EBuObHF8ok6AjGvuuzBzq4d9kc1uad72dMd
         F3NQ==
X-Gm-Message-State: ABuFfojV/LjXgtdYV9++NYzpuo7aRk5k2jKnhFEMyKKxpbTZohz7cNql
        wFatwt6Q4+pbb9/9pUDy648=
X-Google-Smtp-Source: ACcGV63C+nJH5MpB4pj9h+Z/+vAIBci3hAx5H5Djii2fWBd282rntBebpkF3LHmQwf0Qs7zWH5Rytw==
X-Received: by 2002:a63:1752:: with SMTP id 18-v6mr2582534pgx.131.1537908087431;
        Tue, 25 Sep 2018 13:41:27 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i123-v6sm4800649pgd.91.2018.09.25.13.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:41:26 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:41:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/70] 4.4.158-stable review
Message-ID: <20180925204126.GA13170@roeck-us.net>
References: <20180924113058.420454070@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:51:59PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.158 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 26 11:30:25 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 285 pass: 284 fail: 1
Failed tests: 
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs

The failed test is the result of a crash in devicetree unittest code.
It affects all branches. Nothing to worry about; fix is being worked on.

Details are available at https://kerneltests.org/builders/.

Guenter
