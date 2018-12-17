Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381DFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0603B2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545035041;
	bh=fFZqMlL0xlET21mN2UXXAUWoY2PLKtq5/g2X1729i3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VO89J6yQ/Ykwq55IZM2e3ZtpP4AvK0Z5P1RvAfjiiKGjoSFy1/8H3vOMzCMKu7VTp
	 r/C4hW2hjHCAaj5OQwRDfRlZCcMsXqU1R5c6ymr/CBDGEIuWH175PtVotdziMyN/7A
	 lugqWlQXKkGqhI7vqiE3VqphUrMq9R+lBZoYEGhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbeLQIYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:24:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbeLQIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:23:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61CAA20672;
        Mon, 17 Dec 2018 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545035038;
        bh=fFZqMlL0xlET21mN2UXXAUWoY2PLKtq5/g2X1729i3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H010TWDQlijj2JMnPp+2oix4j47JQSINY41CGRAbcbsLeToyg4/ODeNSk+XE/F54b
         TyldvnoWUbnr2oens9K2itrIThjmOyf6YHDx0JvAW05YRJltchpzAgqzEBFXjKp6IX
         TEc1KolYDKC09+++UvJ61wG87IuAlpBsExNluecc=
Date:   Mon, 17 Dec 2018 09:23:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
Message-ID: <20181217082355.GB16452@kroah.com>
References: <20181214115747.053633987@linuxfoundation.org>
 <2EC51071-B0CC-4779-BF21-7791733838F1@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2EC51071-B0CC-4779-BF21-7791733838F1@prjkt.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 04:46:52PM +0530, Harsh Shandilya wrote:
> On 14 December 2018 5:28:05 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.19.10 release.
> >There are 142 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Sun Dec 16 11:57:12 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.10-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.19.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> Built and booted on the Lenovo IdeaPad 330-15ARR, no dmesg regressions.

Thanks for testing and letting me know.

greg k-h
