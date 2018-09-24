Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B35ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0817B21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlJFxabq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0817B21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbeIYAKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:10:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51194 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbeIYAKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:10:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id s12-v6so10722342wmc.0;
        Mon, 24 Sep 2018 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5kF1/EeNMza8MYm1ckMLGpi0V87yMhELYqpVIbYj6pI=;
        b=hlJFxabqvCQ2oj4MA0uTwd9RG0Pri+968HeW4wCQyuO6ZZNatUDd8JsKqECTVhVMTm
         8MxAGYG3rf0MR8XXoIp7rKmgsL/buu57hoyXq7hGyC9eMur1WUwRBaIkHBX3PLN/MSEm
         541H+tkSa/60pSDWKaAItxAEPcScypLEbTEmCe56sOM/o69hxVcdyA+lJs1ahQqyCwSC
         v2hBoFWdIs5Qo1uDpOAma5kXuoPWSFDMzE2/ecwbAEFs43zbSvJB8WpTebkN0XOCVZdw
         74E+Rhs84d5alSGUlpJ/dAcS6dg6yQDUsVIPlOxfRgBOtIXiQ5Dsp9aceow/e6WSGudB
         PfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5kF1/EeNMza8MYm1ckMLGpi0V87yMhELYqpVIbYj6pI=;
        b=IH4v87Nwz3VDrXY5ImLPhSddD7FV45EXNdur31bNnW11UfqpdPtjPWJI3mI7lQAoNE
         xtXF72NYJla9un9sGjxboO0k703eNAolTZV/nijh900FnITXlrlm8sa4BV3WGm95RnCw
         eSXeeFE/8L8KfAgoPCngrjtmxyIlL2csDLKn+HFapfysVZJTnHuC7E7iUg7PWsYAEZUy
         rCdj+SBQFJcV4qB5g1EXJVCwq0j+1cqGTpJyML1VDKaK7A169huAqlN8C4+G9yoyonxP
         NHbQ29OssK9PWvoxDByGmF4VJDs6Vbbfvi0jW4xQqLVSpaSdz1Cy6UQoxGIqriFOSi+h
         8IIg==
X-Gm-Message-State: ABuFfoirnmYu8VvzlEEEYglhb5xDvmCnHKq1NEeRM8XMx0+CE2rjo3AT
        wVdG6TdbNkVcZ0g81c4Ys50=
X-Google-Smtp-Source: ACcGV62OO9Ab6ZDPGUKx3hy6g5aqWMKeqmQOk+RDkPdgmzZmtkdVYvKfrFu0M/f1XR0ThN0Yvn+MUw==
X-Received: by 2002:a1c:c1c8:: with SMTP id r191-v6mr8376246wmf.103.1537812406470;
        Mon, 24 Sep 2018 11:06:46 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k63-v6sm34792912wmd.46.2018.09.24.11.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 11:06:45 -0700 (PDT)
Date:   Mon, 24 Sep 2018 11:06:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/111] 4.9.129-stable review
Message-ID: <20180924180644.GB4232@flashbox>
References: <20180924113103.337261320@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:51:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.129 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 26 11:30:16 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.129-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
