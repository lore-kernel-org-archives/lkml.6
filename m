Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC20C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E159206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcrt+9v4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeLOCKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 21:10:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46938 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbeLOCKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 21:10:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so3467707pgp.13;
        Fri, 14 Dec 2018 18:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u6sBasUQvTBWeZwe1xJdgWOcOcBv7g7IiwI/+cUhb/g=;
        b=hcrt+9v4dK8qyz5v+naUp2rxKSpGQhnuJitaANntlVTrpR9inylnc1EfqVPSYeGSLc
         03vfo2dENhI4wxHtCcqQMpAXqdHF5mdq56Elj8rMwheN594NCRc3jGqpdtAz1Nbqh84s
         2+3WpoZBIWJfnBNTixGjQpRFf0uInqSSeg3yMyjaURC9e2pLP9YmKU/+VGoKGt0jJef0
         AEhGo4H3PKAxZInH+9YDqlJ1i+AgvZduj2dAAI5WT14P+RC5ggwAJ12jktlYMeou88Td
         GM7iLrWe3JdgDQt3SanxEcvMDfLYSEcOcDAAc/xEG1UpVXv3nOWl/xkNDQM0WXrTqizJ
         tpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6sBasUQvTBWeZwe1xJdgWOcOcBv7g7IiwI/+cUhb/g=;
        b=mkqLkfu9qsLwaDM4jltbAKi/3aLGy+4L+dPCshugvre36/a7uiLpW4LFmmmoIQuC8U
         SEw71fC3MzZVcCHc86NkB1oLO7OV3JR5q0Z5g1bV406DRInbMum6jtmeO70uO+29JL7N
         JMj3IewIo9dkOqKkI8/pi2OqjXzdPxQqZrGf6WTZLB5n3cr2bsuXlaosH3taJL0GKJsg
         asmXmcG7rqyNlZwb4M417I2vt+NZ68unsn/rVTo2K4dR1q+EKTN1XxZUGtnZ0pNW0Ovt
         AAWTNv6e3LfiS9qteByp4qQ8Q/7aRBtd/+ctIcYT++Fzd5Ps/lrTzoFKKVwdpEqazKB5
         qFbg==
X-Gm-Message-State: AA+aEWYQbKW/eaK7FxEFAu9/ieLsqOroY2yhDXjF6pUhdEUTti15mUGf
        DCb2iItlrmqYinv8GwnvnzADi0ZV
X-Google-Smtp-Source: AFSGD/VbimR+WhrSg4zo23inLsfcIyCHNVfm7r4PCsE10hP1Xuvbj+yiPqtuZo3PMUDZbYdVAMWZ6g==
X-Received: by 2002:a65:4946:: with SMTP id q6mr4622491pgs.201.1544839830727;
        Fri, 14 Dec 2018 18:10:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 125sm7895027pfg.39.2018.12.14.18.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 18:10:30 -0800 (PST)
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181214115702.151309521@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <dfd49bfd-359a-7f5e-8332-5e6ad6da21cd@roeck-us.net>
Date:   Fri, 14 Dec 2018 18:10:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 3:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.168 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
> Anything received after that time might be too late.

Build results:
	total: 170 pass: 145 fail: 25
Failed builds:
	arm:allnoconfig
	arm:tinyconfig
	arm:efm32_defconfig
	blackfin:defconfig
	blackfin:BF561-EZKIT-SMP_defconfig
	c6x:dsk6455_defconfig
	c6x:evmc6457_defconfig
	c6x:evmc6678_defconfig
	h8300:allnoconfig
	h8300:tinyconfig
	h8300:edosk2674_defconfig
	h8300:h8300h-sim_defconfig
	h8300:h8s-sim_defconfig
	m68k:allnoconfig
	m68k:tinyconfig
	m68k:m5272c3_defconfig
	m68k:m5307c3_defconfig
	m68k:m5249evb_defconfig
	m68k:m5407c3_defconfig
	microblaze:nommu_defconfig
	microblaze:allnoconfig
	microblaze:tinyconfig
	sh:defconfig
	sh:allnoconfig
	sh:tinyconfig
Qemu test results:
	total: 288 pass: 288 fail: 0

mm/nommu.c: In function '__get_user_pages_unlocked':
mm/nommu.c:211:49: error: 'write' undeclared (first use in this function)
mm/nommu.c:211:56: error: 'force' undeclared (first use in this function)
mm/nommu.c:212:9: warning: passing argument 7 of 'get_user_pages' from incompatible pointer type [enabled by default]
mm/nommu.c:185:6: note: expected 'struct vm_area_struct **' but argument is of type 'struct page **'
mm/nommu.c:212:9: error: too many arguments to function 'get_user_pages'
mm/nommu.c:185:6: note: declared here

Details are available at https://kerneltests.org/builders/.

Guenter
