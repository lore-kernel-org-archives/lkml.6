Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A4C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92BD213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYElCg0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92BD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeJLVJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbeJLVJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:09:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B647520835;
        Fri, 12 Oct 2018 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539351427;
        bh=TVPLra2qPIKCHppqYxYtRgTJQHsUGi600fKc+ee8M+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYElCg0sYMYut72Ius7S9sPYb0WGXCTPEOgTWenyHUkUtCzM6b7mMJRlXIG8Aj1th
         hkbPVvusfNYBHPcqLZ6rzHN+LJ25NviucdyR4m2TS6QpnDGpOFYPff++vpEHqO/bnD
         bWnYTp5cneGo0/2jdEjR7qByWrp7kb+rZs6xi/Ho=
Date:   Fri, 12 Oct 2018 15:37:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/120] 3.18.124-stable review
Message-ID: <20181012133704.GB3706@kroah.com>
References: <20181011152549.500488630@linuxfoundation.org>
 <9b2c52e4-56ce-37a3-b515-a6ff831fe17e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b2c52e4-56ce-37a3-b515-a6ff831fe17e@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 05:19:16AM -0700, Guenter Roeck wrote:
> On 10/11/2018 08:33 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.124 release.
> > There are 120 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Oct 13 15:25:29 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> [preliminary]
> 
> arm:allmodconfig:
> 
> drivers/mtd/spi-nor/fsl-quadspi.c: In function 'fsl_qspi_init_lut':
> drivers/mtd/spi-nor/fsl-quadspi.c:170:5: error: 'LUT_0' undeclared

That is really odd in that there are no patches that touch this file,
and I do not even see "LUT_0" anywhere in the 3.18.y tree.

strange,

greg k-h
