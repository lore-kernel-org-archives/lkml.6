Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FFDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6120A208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="crk/Z9t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6120A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408276AbeKWR5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:57:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387526AbeKWR5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:57:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB66E20820;
        Fri, 23 Nov 2018 07:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542957266;
        bh=o4BHNrGtjvnJ1jE0FC37OqL2oCmGU/CZIB0v23NIIm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crk/Z9t5FruUS4MmZh6Vfd1MhctZcopFledF9gch2ZpSiPVqzWlaxDKHknmt0NEHU
         YGdFkGyPb7VEPIC5exE7/Vn6Xtzbu5s8bdxa8bSt1vW7CEKrlwAXVLkq3j4c4tB1re
         tLIujFQ/37EdLweDxmmCOFIklcPDs/XZl+HN/Tc8=
Date:   Fri, 23 Nov 2018 08:14:24 +0100
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
Subject: Re: [PATCH 4.14 00/21] 4.14.83-stable review
Message-ID: <20181123071424.GA26178@kroah.com>
References: <20181121183422.103826775@linuxfoundation.org>
 <CA+G9fYsftAwyA9dsTJWDXtLJd9Zd4OkXYHw6MiJcPwUpXBYNPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsftAwyA9dsTJWDXtLJd9Zd4OkXYHw6MiJcPwUpXBYNPg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 09:52:07AM +0530, Naresh Kamboju wrote:
> On Thu, 22 Nov 2018 at 00:39, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.14.83 release.
> > There are 21 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri Nov 23 18:34:13 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.83-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing this and letting me know.

greg k-h
