Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EB6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B1C20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545037573;
	bh=ccHGDsuWxJ8N2+N7rvaKpsceYe0SbR6+eiKuJYOa2cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EnrbAJkEFCUjoSOTvVO6ZNdmmg4bnQOq1TLWRKFLawSqDLwjgE/g5YLtJBwv7fWWR
	 LZF4euQqUPcFtWBsiJTSTpIiASmVlbEZyfsAEeVnorJBhsmfIobrGCFSlBSteUc0zZ
	 Em6JAar3pH4hyH06jOLZRGtccymQTRqRd6m5yXPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbeLQJGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLQJGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:06:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265D520672;
        Mon, 17 Dec 2018 09:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545037571;
        bh=ccHGDsuWxJ8N2+N7rvaKpsceYe0SbR6+eiKuJYOa2cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sN00L9jlWT0XRSdU/QSdmm+Pjk7Oh40Qsep0O9M2W9UVdQgIzhfaDc5LlVqB5dvtH
         dgmw7sF+fQt0gp74KxcZhMjIOeiyk8rERCakJvVBl/WIMgoTz5GQgf0Vn9FkobnYzU
         djOaQjYLuKEGT/CiutK+recumhOIGA+ZTiS9nlMU=
Date:   Mon, 17 Dec 2018 10:06:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
Message-ID: <20181217090609.GB12938@kroah.com>
References: <20181214115702.151309521@linuxfoundation.org>
 <FF529C4A-07F3-4B96-8935-D0EB26638094@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF529C4A-07F3-4B96-8935-D0EB26638094@prjkt.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 04:45:33PM +0530, Harsh Shandilya wrote:
> On 14 December 2018 5:29:34 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.4.168 release.
> >There are 88 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.168-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.4.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> Built and booted on the Pixel 2, no dmesg regressions. Rather clean merge, only required adjustments in two places in Qualcomm drivers for the get_user_pages API change.

Thanks for the merge warning, it's appreciated :)

And for testing.

greg k-h
