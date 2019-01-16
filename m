Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E654AC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E8120866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547621807;
	bh=zt7yWtTviNQ+ktqq5YRBy2Id5eGDN1UKGc+J4xXXF7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=utTH2LWPlpSkmuihpSgW5swP+WwrSUQk6An3NKAS7+9rkICygq3h5PQ2Qv/OG4+Hu
	 JxpbOJ5KZc8iofdHVQCh/Cpnjs6H+9cVhmAhO4rgUeGTokPjWgGGr0Rj8x3tiiq7+i
	 TwSLrpSUAN0K2tP5RVgDQrII16FoSrmHDZJBqOBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbfAPG4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731043AbfAPG4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:56:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 045E920859;
        Wed, 16 Jan 2019 06:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547621805;
        bh=zt7yWtTviNQ+ktqq5YRBy2Id5eGDN1UKGc+J4xXXF7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTv+DD2iO1ajcoyaqZqreVJts/emq6aoWuPKmGsv5Mv+OclxDTeYA4wY5Bxr3r5RJ
         haaB4mUWVHnLikUT1+L4gJwjA6LBN4y+FiVS2QuMPIYVouS314dVj1ZrDJGkdB1E9Q
         GSErflnwsuQew7O8ia8foAwFoE8289L9T2TdtN1A=
Date:   Wed, 16 Jan 2019 07:56:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/57] 4.20.3-stable review
Message-ID: <20190116065643.GD26290@kroah.com>
References: <20190115154910.734892368@linuxfoundation.org>
 <2fbb3469-5c12-cf32-9a71-08c7a4d8b0b0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fbb3469-5c12-cf32-9a71-08c7a4d8b0b0@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 07:00:59PM -0700, shuah wrote:
> On 1/15/19 9:35 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.3 release.
> > There are 57 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Jan 17 15:48:32 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.3-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
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
