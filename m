Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139A5C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5D72176F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546086021;
	bh=Xfd9Ob1tXITsi2pFCbfJ3/cTb1OLtiEQF8dgXHLCqvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PhqnfBZ/70I8+4agP/dlHDaLaofZ0lWJbALpCOLbpF52zkfw5kU5MgzmwVLnHk9fW
	 qwGb/TQEb0u7Ht6RXNjp5+lNl4aNbMv6B2sxu6sOLjf0I6PgKKjfuH21gnhMVeHf+h
	 1CznMVm1XcE3JHMgPSbabxcL7XtM/8+CEM09leQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeL2MUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbeL2MUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 07:20:19 -0500
Received: from localhost (83-68-17-109.ip.xs4all.nl [83.68.17.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE932070D;
        Sat, 29 Dec 2018 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546086019;
        bh=Xfd9Ob1tXITsi2pFCbfJ3/cTb1OLtiEQF8dgXHLCqvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3U8xQqSgO2bSbp3TQ2bl25BDGHzbjQHEn2TxXtqR9MCGTo+yTgL9fAaXzLCBAboe
         /jkn7iG4PMnjCgwP4U+mrKMLaXFjt5KlfIWjmaIg6woCn5Ee+k7e0kdIU4gV4+QKMA
         okr0CrQ48jOWeqHGhzUOLUic8r9dUSpx1k6nPEyY=
Date:   Sat, 29 Dec 2018 13:20:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/46] 4.19.13-stable review
Message-ID: <20181229122015.GA24238@kroah.com>
References: <20181228113124.971620049@linuxfoundation.org>
 <F0DFEDEA-22A9-4767-AA10-3FFE2506CC79@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F0DFEDEA-22A9-4767-AA10-3FFE2506CC79@prjkt.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 02:31:33PM +0530, Harsh Shandilya wrote:
> On 28 December 2018 5:21:54 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.19.13 release.
> >There are 46 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Sun Dec 30 11:30:49 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.13-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.19.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> Built and booted on the Lenovo IdeaPad 330-15ARR, no dmesg regressions.

Great, thanks for testing and letting me know.

greg k-h
