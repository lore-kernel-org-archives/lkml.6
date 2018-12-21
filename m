Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73440C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B0721906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545376263;
	bh=haJw1DYUfGLilURIaIgJsOVLY2v08+QN0YnAXVO9Qjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lDHNtIRzPNqsvPxubCYgTvYGEQq1kG2+kybxf6iGn1L8k8iaqXWX0DvhZ7jXTjHCi
	 XG8/dGif7prMCy5U0FT5ASPoVOdX1OtmMyZtRGt+uxa3LJ4BybXbjZ/gxqIKHL2Bgz
	 h50aVMJqe4O4XKfb41yeJBWxWeklr5zplRRbEkkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbeLUHLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:11:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbeLUHLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:11:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D16F218F0;
        Fri, 21 Dec 2018 07:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545376261;
        bh=haJw1DYUfGLilURIaIgJsOVLY2v08+QN0YnAXVO9Qjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHF8/GoRRrIi60P69/ecYgr4XI/YOkxR3yQHGVpv68W219v8LQ10cac5QFkAo1u04
         GoK2msICkQLvhO47IB+/Gjbjx1zyL9whgynnbjQDykkzFYRl/Z5lDujyVjeOp9TsGv
         ym9u1iOmKXmKyBxW0/tTvfW86mTJFgAXi289iXSQ=
Date:   Fri, 21 Dec 2018 08:10:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.19 00/67] 4.19.12-stable review
Message-ID: <20181221071058.GC19343@kroah.com>
References: <20181220085903.562090333@linuxfoundation.org>
 <CA+G9fYv0brPeSuyQC06DTe=P4pxKijiaG-EAnP_2aMbcj7tqaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYv0brPeSuyQC06DTe=P4pxKijiaG-EAnP_2aMbcj7tqaQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 08:33:23PM +0530, Naresh Kamboju wrote:
> On Thu, 20 Dec 2018 at 14:59, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.19.12 release.
> > There are 67 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Dec 22 08:58:49 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.12-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

That was fast, you all are getting quicker :)

Anyway, thanks for testing all of these kernels and letting me know.

greg k-h
