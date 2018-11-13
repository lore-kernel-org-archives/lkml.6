Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672D5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257ED22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYLvJLeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257ED22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeKNFKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:10:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeKNFKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:10:45 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C58B223DD;
        Tue, 13 Nov 2018 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542136277;
        bh=wjQUBrYb2TEviWezjBtQjElNhmLstCUceIOQtSARuO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYLvJLeBkXAiSwDI08acOCJeIgzx6TPLC4LE0pjX0jf3zj6ma2S20Z+PAm1pTXqsr
         78YV370KADHQM7gSDnLsOUVYSSceTKDrb6VBbP2ehf6MRYyH2z3uwmELF0elH07x7G
         Mp/9uYXnZIIOHEvr1ionGMOdzzgXL6MXQHZILBZE=
Date:   Tue, 13 Nov 2018 11:11:16 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Rafael Tinoco <rafael.tinoco@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, sashal@kernel.org
Subject: Re: [PATCH 4.9 000/141] 4.9.137-stable review
Message-ID: <20181113191116.GA27890@kroah.com>
References: <20181111221627.853046496@linuxfoundation.org>
 <18c91c75-18c8-21a1-3051-65007bd2f30f@linaro.org>
 <20181112133301.GB22022@kroah.com>
 <CA+G9fYuasGVXY__7xZ7NOwijMvvmapPBCbd8q2DjBgxR3UHV1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuasGVXY__7xZ7NOwijMvvmapPBCbd8q2DjBgxR3UHV1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 10:39:56AM +0530, Naresh Kamboju wrote:
> On Mon, 12 Nov 2018 at 19:03, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Nov 12, 2018 at 08:38:44AM -0200, Rafael David Tinoco wrote:
> > > On 11/11/18 8:24 PM, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.9.137 release.
> > > > There are 141 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Tue Nov 13 22:15:38 UTC 2018.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >     https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.137-rc1.gz
> > > > or in the git tree and branch at:
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > >
> > > > -------------
> > > > Pseudo-Shortlog of commits:
> > > >
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >      Linux 4.9.137-rc1
> > > >
> > > ...
> > > > Prarit Bhargava <prarit@redhat.com>
> > > >      cpupower: Fix coredump on VMWare
> > >
> > > Greg, maybe...
> > >
> > > commit ef8d3a128c1f1de7ffdedb2f14e846e10fd3fec3
> > > Author: Prarit Bhargava <prarit@redhat.com>
> > > Date:   Mon Oct 8 12:06:19 2018
> > >
> > >     cpupower: Fix coredump on VMWare
> > >
> > >     [ Upstream commit f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6 ]
> > >
> > > should be dropped from v4.9 (and v4.4) since it causes:
> > >
> > > $ make V=1 -C tools/power/cpupower all
> > >
> > > gcc -fPIC -DVERSION=\"4.9.136.142.g36c7703\" -DPACKAGE=\"cpupower\"
> > > -DPACKAGE_BUGREPORT=\"linux-pm@vger.kernel.org\" -D_GNU_SOURCE -pipe -DNLS
> > > -Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare -Wno-pointer-sign
> > > -Wdeclaration-after-statement -Wshadow -O1 -g -DDEBUG -I./lib -I ./utils -o
> > > utils/helpers/amd.o -c utils/helpers/amd.c
> > > utils/helpers/amd.c: In function ‘decode_pstates’:
> > > utils/helpers/amd.c:106:39: error: ‘union msr_pstate’ has no member named
> > > ‘fam17h_bits’
> > >    if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))
> > >
> > > Due to nonexistent CPU (flag) support.
> > >
> > > Replied to Sasha on specific commits for both, v4.4 and v4.9.
> >
> > Now dropped from both queues.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Great, thanks for letting me know.

greg k-h
