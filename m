Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A877C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A464F2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkHX3Nyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A464F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeJSJob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:44:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53171 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSJob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:44:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so2057394wmw.2;
        Thu, 18 Oct 2018 18:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ypcxUpXxPLzJbx4Gz7UPMn4qNmV7shDLkexOHjGlI0Y=;
        b=mkHX3Nyg9Dt+/kysYRYPDrvFLAJ4IvXJoHv8nXm54nPoWemjtXc4UG+4wq8iKroCm8
         7EAYA6OCMrA/m7/reO4LQ70Fy5aptVSDBzw3dKYD0OSzih1bn5EvF53QrMRSOUVwudeZ
         2Cv5eem9OXg6kpZPDR7+0N6n5ruRzIVHKltIzqrm8adojqDJ+7ePzToEpj4oIOK8Opd1
         q4e1wCxXtDmwIUoME/3mrJ6P3f2AWx7qqaxMve0IcXM0EWJuObbSIoI+RshuNJXuHKhS
         99hUdDbZv5xN656lSHnxURtW3opHtyhhRR7bM7Z/z8a4TiYNsPhyL+ztCrkIX33xdL1a
         pNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypcxUpXxPLzJbx4Gz7UPMn4qNmV7shDLkexOHjGlI0Y=;
        b=PmzQ+nsuJ+m+c1zV5JSXcffnR+ua23IPfETF9NeX+Qxi9ERr8SsrPLYDJJTFVIap4T
         2ntFa1+9t5gIoizmPPKk0fznxDbYJuTFiputKGUCjk2nJi4tW31g1czk2kvsUuCYugTb
         4pVP5AVC+fLmLBcStKRrrCaabdXZgC3GZ8/9zB/10R2ECQ0WE8GF/J10CIb4j1lnfdVA
         7UAXQnLbS3/gVvDpLjUK89tp0Ya2OuMFvE01J2nr8XiH9CgSr1sgsApIjHUWagnYlAyT
         koKxQXotlzw3ABePamf/c1YclnUJ1Wr0XOw+CC9YeHNrPtn3kx9RAb0wYLEoJj9yIzPD
         QJNw==
X-Gm-Message-State: ABuFfoim/dh+GN4S4q/oAfwLBI8NHZEnWj/rBCHHGbFdpP9VqEphowZf
        +zxnMw8tHOsUyH9gNEA/j40=
X-Google-Smtp-Source: ACcGV626uPXCJwaM3kPLgysJO5e+0ULCGiDnHmGFyl0AMluBs+6mmugTc4VeTRVoL0g3IcgPJ29R7g==
X-Received: by 2002:a1c:ee8d:: with SMTP id j13-v6mr2607770wmi.125.1539913240437;
        Thu, 18 Oct 2018 18:40:40 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l67-v6sm4216753wma.20.2018.10.18.18.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 18:40:39 -0700 (PDT)
Date:   Thu, 18 Oct 2018 18:40:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/48] 4.4.162-stable review
Message-ID: <20181019014036.GA19093@flashbox>
References: <20181018175427.133690306@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:54:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.162 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 20 17:54:03 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.162-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
