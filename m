Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF83ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8378821527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="odqd6crN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8378821527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJQPpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeJQPps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:45:48 -0400
Received: from localhost (unknown [188.88.119.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FAD21526;
        Wed, 17 Oct 2018 07:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539762682;
        bh=NL7rwTbyU6GxDOGvVbn3fOmZ6uuybHY/CODn19JQvcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odqd6crNicgoReGroeNsDioFGhj18ysWOWOG7Ty1diOxZnFw3ze5d5Bi4bmiNMMYB
         usMvIEUbydRWY6We4NYz/YS4hAy/ip7wNs8CmAKEqhVx+WQgoSn+1N2BbwcS9gcBzz
         m4xc/zyelg0CfmN4eAwAQORmheIu0mDJzDSsEI64=
Date:   Wed, 17 Oct 2018 09:51:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amit Pundir <amit.pundir@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.9 00/71] 4.9.134-stable review
Message-ID: <20181017075119.GH25537@kroah.com>
References: <20181016170539.315587743@linuxfoundation.org>
 <CAMi1Hd1SzkvCWsap+zYFrZ=mPtRN2V+NoaNFr89Z84+NqwTgvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd1SzkvCWsap+zYFrZ=mPtRN2V+NoaNFr89Z84+NqwTgvw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:50:42PM +0530, Amit Pundir wrote:
> Hi,
> 
> On Tue, 16 Oct 2018 at 22:52, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.9.134 release.
> > There are 71 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> <snip> ..
> 
> > Paul Burton <paul.burton@mips.com>
> >     MIPS: VDSO: Always map near top of user memory
> 
> This patch broke stable-rc/linux-4.9.y build on kernelci
> https://kernelci.org/build/stable-rc/branch/linux-4.9.y/kernel/v4.9.133-72-gda849e5647be/,
> mostly because of missing mips_gic_present() definition. It is added
> in 582e2b4aecda ("MIPS: GIC: Introduce asm/mips-gic.h with accessor
> functions"), which need to be backported too because it doesn't apply
> cleanly on linux-4.9.y.

Thanks for letting me know, I've now just dropped this patch from the
tree.

greg k-h
