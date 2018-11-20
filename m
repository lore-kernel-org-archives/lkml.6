Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B24EC46466
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE1220851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmfDGmuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE1220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeKUHKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:10:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36231 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUHKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:10:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id y6-v6so1999637plt.3;
        Tue, 20 Nov 2018 12:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ek/z1vJ6vYIkRM+eofS2rEgWo1aaVJT75yROmSLE/zw=;
        b=DmfDGmuzHy1uOey7VRuXmwzqyfJRXZLFmSY6/4XLug8KPLY8JNIO2mfrLYs7n9PkTC
         TAIL7T8ECwMi+bQIKJKi9nvBlRez72YPvT+RazbLTlvro7aQEs/FHimoxLAAQ8n+bxqW
         r9OMOZwyffVP/+2lH++18JLeKjIit//p5Wqr1KvZas4mUvmof+gfbg458Dkx84W2tycA
         avcZswI7/X2ki8n8GVmsDYwoFTSbPKwEhigGhOyOlq0bMZmFM6nGWJaxWNVz0EGTb8Gw
         Y0q4dvu9M5Yj29ZwOcy7vxp6qjWZtntmIemx1fQsDHvnpoVyQCzgiOMFwoUbFTS1L4j5
         ER6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ek/z1vJ6vYIkRM+eofS2rEgWo1aaVJT75yROmSLE/zw=;
        b=IaHwvJ51p1ZK/41SOhEfLa1ZS3AGTGDxVeOqzNAo2OZPiAVyNMi6mvwXA2amyMUpFQ
         UKJM4k1DGfgDq5LBNIPjV/gWck1CG1DylZjLdDnZivYlBQgXDBrBZohmvv1fOy92+arY
         Lyf3scaB4IMZRbDYtnQjCNaQDUrqLbdpfyOjPb4RQmbyjKBrcX3reCUyHNMM1ZHmfkRy
         tqFXB2lqI/GNSgveqpp9I11OSzHlxApADhu/Vn2nojuLRkBBnNZ4Uq6uJRBr6+ixcFiu
         2UIRZMeEmRRzplrMY5AqHZlH0byLeu7UTqu9KqnCMH8FwyL00M+9gu0f90twVrnliJGK
         m44g==
X-Gm-Message-State: AA+aEWZcHzfzex6i0pFMYK/YEOdIyK/PBgPuCkITLVkglzTTCwi+VxR2
        BSZGioM/tVK6NdLTdYS5n2s=
X-Google-Smtp-Source: AFSGD/Xmz9MCzebNsKQxgM+4DUxO1/UV64s6nokAJ0EU/VUr2RXEd8qHUkxPsSrMR97eIH5GUxFq0g==
X-Received: by 2002:a63:2643:: with SMTP id m64mr3226360pgm.35.1542746389001;
        Tue, 20 Nov 2018 12:39:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-v6sm62746014pfb.44.2018.11.20.12.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:39:48 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:39:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/124] 4.14.82-stable review
Message-ID: <20181120203947.GD19385@roeck-us.net>
References: <20181119162612.951907286@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:27:34PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.82 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 21 16:25:07 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 293 pass: 293 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
