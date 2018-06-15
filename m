Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E6091C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A24C208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="cVY4L3cx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A24C208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965880AbeFOPTM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:19:12 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:45850 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965768AbeFOPTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WM5dmUv5gJhgscywHM4cRjh5ix4uF6Fdo/SFVaj2zFw=; b=cVY4L3cxE2ISMhwlSbKDG1xtwi
        2JztDIFOwOo/EmN13lLBBnn3wWF5AYWfSfGvFyzWIJv77p1iXEtuMzZLneubCHsG+1lIuhCK6tcn/
        tecTfPgTknL6GcToKbWNz7Ig6hP/ozKQ8y0xYrvOUmCQ7jwty61TaRALlhZ8DqD5pgLpeuJpKCAbk
        osXb+4fBSqo+XPtkUYS3XVql+H1EVPy8G8DoWrDs/JJwaXRA06oNQd8iq6qFrz3KVxYS6TIHz8nSK
        mOks4SXR8gWkuyjQJSjo24PD0xVcZnne6cIWALtEvwEoYa6ZbBEfiGyVSOA+Ruxo9FnUf5AU7UX61
        kK9ZmhKA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47912 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fTqVK-00054D-IK; Fri, 15 Jun 2018 15:19:11 +0000
Date:   Fri, 15 Jun 2018 08:19:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/36] 4.14.50-stable review
Message-ID: <20180615151909.GC28450@roeck-us.net>
References: <20180614132157.333004166@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614132157.333004166@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 04:04:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.50 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jun 16 13:21:44 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 153 pass: 153 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
