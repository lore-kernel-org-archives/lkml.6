Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CB5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575292084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544861190;
	bh=IezwQns4DLblWpky35pKtTr2icgfbaT1ZaBdtU0m3pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CRWSPrMfsWImMN7cEqznanhy+ghkYWSLd2gKL1kXsmNMcdzfLRz5AoC2s8Hkx4P2B
	 tFH7ba8yS7fQTdeBnpRNjYJ3FjZaWsIVPPosrG1QiY1lMjMQ72EwW6bFbBguoGNkdi
	 FjY9NjF2V5UV4fWituM5N2Bh3dlqVJPAFFn/6izQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeLOIG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbeLOIG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:06:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B1012080F;
        Sat, 15 Dec 2018 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544861187;
        bh=IezwQns4DLblWpky35pKtTr2icgfbaT1ZaBdtU0m3pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBY+QxBmxcUvu5Z0JcQvIVVrEeoe9I4ud6uJ95LtPKdj91rh2GOjRXFw65FuzznYA
         jLNMYkWK8/PUk0yeSwPkj/S6WP9xvSSAP/NAwdvlFdmvGYTWKaPp8lpk49a77FeB/7
         8vu9++lGVGhBkV4MqVOWtyOQC6+G7+lVeQ/WB1MM=
Date:   Sat, 15 Dec 2018 09:06:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
Message-ID: <20181215080625.GE10074@kroah.com>
References: <20181214115747.053633987@linuxfoundation.org>
 <61cb35c5-d260-6bcc-2f00-99a4ff4e57b9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61cb35c5-d260-6bcc-2f00-99a4ff4e57b9@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 01:11:32PM -0700, shuah wrote:
> On 12/14/18 4:58 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.10 release.
> > There are 142 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Dec 16 11:57:12 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.10-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
