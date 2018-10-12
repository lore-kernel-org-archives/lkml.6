Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE6C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D050213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/nVpHQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D050213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeJLWRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbeJLWRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:17:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CCAA2098A;
        Fri, 12 Oct 2018 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539355487;
        bh=gnGEc2YSlL3Ir2WPdGN7Zm6Nc5y2rMRfhLPpkjfgK6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/nVpHQRkuvuBQYx5fjDNpJwFJJDigGsdNuPgaRfhqFW/dl8is1AeX6udh3hoFPS2
         Ly1XN3Oj7hr3Xr7QS2Hzzd3kuO1WAmbzkU0Txl28G1u3yVl0EEc5YhLwUh+AnJpipr
         ShiWoBcWSqk2OsyNWt8/CZV3RM9+y4NXRdr7MQZ0=
Date:   Fri, 12 Oct 2018 16:44:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/35] 4.9.133-stable review
Message-ID: <20181012144445.GA15769@kroah.com>
References: <20181011152520.174949126@linuxfoundation.org>
 <df9b09c5-b231-5b8f-7b26-7efcac86ddcf@roeck-us.net>
 <20181012135243.GA5680@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012135243.GA5680@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 03:52:43PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 12, 2018 at 05:20:40AM -0700, Guenter Roeck wrote:
> > On 10/11/2018 08:35 AM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.9.133 release.
> > > There are 35 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat Oct 13 15:25:09 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > 
> > [preliminary]
> > 
> > powerpc:allmodconfig:
> > 
> > drivers/macintosh/rack-meter.c: In function 'get_cpu_idle_time':
> > drivers/macintosh/rack-meter.c:94:9: error: implicit declaration of function 'nsecs_to_cputime64'
> 
> Ugh, this one is messier, let me figure it out...

Ok, I've just dropped the offending patches now and pushed out a -rc2
with that all fixed up.  Hopefully that resolves this issue.

thanks,

greg k-h
