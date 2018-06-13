Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0C18FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7030208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="crmjuICV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7030208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935849AbeFMVBJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935524AbeFMVBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:01:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADA64208C4;
        Wed, 13 Jun 2018 21:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528923667;
        bh=UWa19/5Fxmee4wE3cdxvmYRuyLLju5pLPGGhd1mAwSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crmjuICVADSsB7toAesgAJ0wmpZHxm7QpMB5VefztI1+cWdo+GOWVjTiOaf+umWxE
         vhPZDzRDXBjQD/KmRk86P4IYN5AD62j0EvzQijQOyYSP5yz2BijvlliEjyOpbUrEdq
         zCJhEFd1Qhgi1/8DXuvvhVFRXS/DyaW3tq0Ptl/E=
Date:   Wed, 13 Jun 2018 23:00:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rafael Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.4 00/24] 4.4.137-stable review
Message-ID: <20180613210044.GA15146@kroah.com>
References: <20180612164816.587001852@linuxfoundation.org>
 <CADtBP2D4a2OdLsAgZ8sRFBhkh2jArviaYNzYrS7wqdmogyc=Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtBP2D4a2OdLsAgZ8sRFBhkh2jArviaYNzYrS7wqdmogyc=Mg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:47:49PM -0300, Rafael Tinoco wrote:
> Results from Linaro’s test farm.
> Regressions detected.
> 
> NOTE:
> 
> 1) LTP vma03 test (cve-2011-2496) broken on v4.4-137-rc1 because of:
> 
>      6ea1dc96a03a mmap: relax file size limit for regular files
>      bd2f9ce5bacb mmap: introduce sane default mmap limits
> 
>    discussion:
> 
>      https://github.com/linux-test-project/ltp/issues/341
> 
>    mainline commit (v4.13-rc7):
> 
>      0cc3b0ec23ce Clarify (and fix) MAX_LFS_FILESIZE macros
> 
>    should be backported to 4.4.138-rc2 and fixes the issue.

Really?  That commit says it fixes c2a9737f45e2 ("vfs,mm: fix a dead
loop in truncate_inode_pages_range()") which is not in 4.4.y at all.

Did you test this out?

thanks,

greg k-h
