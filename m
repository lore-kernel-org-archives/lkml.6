Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A257CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A1A214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A1A214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeIZLlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 07:41:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIZLll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 07:41:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D64CAE8A;
        Wed, 26 Sep 2018 05:30:31 +0000 (UTC)
Date:   Wed, 26 Sep 2018 07:30:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rafael Tinoco <rafael.tinoco@linaro.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 4.14 000/173] 4.14.72-stable review
Message-ID: <20180926053029.GA3800@kroah.com>
References: <20180924113114.334025954@linuxfoundation.org>
 <20180925090733.GB21224@kroah.com>
 <20180926002857.ajqqxi2qcfcwsg7g@xps.therub.org>
 <CADtBP2Do8u9Em2kUeb9nuux+kD=sjUpQ2XLetYO3vrdPxiYNKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADtBP2Do8u9Em2kUeb9nuux+kD=sjUpQ2XLetYO3vrdPxiYNKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:01:53AM -0300, Rafael Tinoco wrote:
> Greg,
> 
> > > > This is the start of the stable review cycle for the 4.14.72 release.
> > > > There are 173 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Wed Sep 26 11:30:10 UTC 2018.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >     https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.72-rc1.gz
> > > > or in the git tree and branch at:
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > > > and the diffstat can be found below.
> > >
> > > -rc2 is out to resolve some reported problems:
> > >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.72-rc2.gz
> >
> > -rc2 looks good. There is a problem on dragonboard during boot that was
> > introduced in v4.14.71 that I didn't notice last week. We'll bisect it
> > and report back later this week. dragonboard on the other branches (4.9,
> > 4.18, mainline) looks fine.
> 
> As Dan pointed out, during validation, we have bisected this issue on
> a dragonboard 410c (can't find root device) to the following commit
> for v4.14:
> 
> [1ed3a9307230] rpmsg: core: add support to power domains for devices
> 
> There is an on-going discussion on "[PATCH] rpmsg: core: add support
> to power domains for devices" about this patch having other
> dependencies and breaking something else on v4.14 as well.
> 
> Do you think we could drop this patch, for now, in a possible -rc3 for
> v4.14.72 ? Dragonboards aren't being tested, because of this, since
> v4.14.70. Hopefully it isn't too late for this release =).

I can't "drop" it as it is already in a released kernel, 4.14.71 and
4.18.9.  I can revert it though, and will do so for the next round of
releases after this one.

thanks for the report.

greg k-h
