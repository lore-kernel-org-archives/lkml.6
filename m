Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D1B214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjM2uvCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D1B214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJJNNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeJJNNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:13:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CF8221479;
        Wed, 10 Oct 2018 05:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539150751;
        bh=3HhPqwPFmc8zRvzwD9JQN66UmA+n5icywiBjfzdt7nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjM2uvCM8YXeTbU+8BXpBV/sVe6Ex3HJtgERq9GtJ0khkqws1hp8k3e+2fE1NWSEw
         mNfbTHjiTytuJiBDqBRZuqb6a3Ff+Z0a26QJ53CGEj8VA6OhpxrJe90atWbKU1f1lB
         cP+2CdjabTP/xzWbbyFDVtbwTX9Aw2ft42548DWY=
Date:   Wed, 10 Oct 2018 07:52:28 +0200
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
Subject: Re: [PATCH 4.18 000/168] 4.18.13-stable review
Message-ID: <20181010055228.GA7134@kroah.com>
References: <20181008175620.043587728@linuxfoundation.org>
 <20181009161445.GA7220@kroah.com>
 <CA+G9fYti8P46YP70wvfRbw2-+CY6+nTcE7yqZ5PjF-W=-NP1pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYti8P46YP70wvfRbw2-+CY6+nTcE7yqZ5PjF-W=-NP1pQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 09:42:46AM +0530, Naresh Kamboju wrote:
> On Tue, 9 Oct 2018 at 21:44, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Oct 08, 2018 at 08:29:40PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.18.13 release.
> > > There are 168 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed Oct 10 17:55:44 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.13-rc1.gz
> > > or in the git tree and branch at:
> > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
> >
> > -rc2 is out to resolve some reported issues:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.13-rc2.gz
> >
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> NOTE: Now the reports gets regressions and fixes.


Great, thanks for testing all of these and letting me know.

greg k-h
