Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96E5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6844721714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcJjtaiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6844721714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeI1ERQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:17:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34823 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1ERP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:17:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so2912436pgb.2;
        Thu, 27 Sep 2018 14:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SC9XmRvz1gs5uu4Fj/8MbcDH0TUhivcGWK0ha4fCtb4=;
        b=bcJjtaiXLjEKv5p9kwuZzlGuBSzaY3XVvqcahrleSHSB33xtE1FaNiaBDytbytLbMA
         mSNULL+Oi+eF65+PmcYeq4mVWdKodJ5DsmlXD71TSP/1ppjxMX/cxuGLU4Hi4tjgXdQZ
         XfWdY44qKKEHXu1Iynq0Rut/qeKzMo9c9TGrZ/I9MAxfR4Jzdq0ZQGRcNKMXb4YNahYM
         zTiHR+8DKUNEKsI+/RIV01JBroOACyGnApMxAmxmcKCgpR94cxRvQjunLLY6WJlM7hvH
         61f3fOjj1uxDeeY2UnprMeo2/n1EUen66E5ywOyiO3nJF87RE6LNO9QtK6eTe5Lxi0pC
         LetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SC9XmRvz1gs5uu4Fj/8MbcDH0TUhivcGWK0ha4fCtb4=;
        b=c9WF7uJylKLiVJueHdV8GOeCpBYx25v8KcvMb/9KmG6Bt4lmhu2KV1OdSRvrVHOvio
         f5ik+azhaycx+oDdys26GQAoTCgx/9aT7/nB65uTqV8TL5kWvlfIcA1RyYetvEwFITHR
         Ce0Qacg7YKGekKRcYmDJBspyvR4CttjZiog9poZYU/lm2qYPxCX7G7er2X6WamcBnsnk
         sN7O9r35SRUb/VRZwhgdQ01Efo0nfl9/i5v4QbW5HomYR+IbZ+m9XqRFqm20j43Yc/G3
         2cfGlCHGqMm5ivRfYmek9cboDFCmXQoHdEnPhmyMKWN6t1I87HxEfAkYWyY/BrPNMBWX
         1O9w==
X-Gm-Message-State: ABuFfogFxz4fNGK1nIZg/rQ5xcN/uG2fJz8xNfdiCd5LKtpokO1UlT9I
        FvUyr6S6ggFBuKG00IGoUOw=
X-Google-Smtp-Source: ACcGV62tR4kjz9OvlG3PUq0u88AK/+ArhqZsPnj+GN4PLue+kWq1prD2u/1DnXoyL7N91ExGlqVkcg==
X-Received: by 2002:a63:982:: with SMTP id 124-v6mr12158181pgj.80.1538085412140;
        Thu, 27 Sep 2018 14:56:52 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r25-v6sm3881237pgm.59.2018.09.27.14.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:56:51 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:56:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/64] 4.14.73-stable review
Message-ID: <20180927215650.GB9198@roeck-us.net>
References: <20180927090249.801943776@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:03:17AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.73 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:02:21 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 318 pass: 314 fail: 4
Failed tests: 
	arm:sabrelite:imx_v6_v7_defconfig:imx6dl-sabrelite 
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs 
	x86_64:q35:Broadwell-noTSX:defconfig:smp:mem256:ata:rootfs 
	x86_64:pc:Opteron_G2:defconfig:smp:efi32:mem2G:scsi[virtio-pci]:rootfs

arm_sabrelite crashes in drm code as already reported.

powerpc:g3beige is the known problem. Patch should be available upstream
in the near future.

The x86_64 failures are spurious. I'll change the scripts to no longer
report those until I figure out what is going on.

Details are available at https://kerneltests.org/builders/.

Guenter
