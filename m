Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2227AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98CC20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98CC20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbeGQKM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:12:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeGQKMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:12:55 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C4AEA95;
        Tue, 17 Jul 2018 09:41:10 +0000 (UTC)
Date:   Tue, 17 Jul 2018 11:41:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dave Chinner <dchinner@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ltp@lists.linux.it, open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [LTP] [PATCH 4.17 00/67] 4.17.7-stable review
Message-ID: <20180717094107.GB25341@kroah.com>
References: <20180716073443.294323458@linuxfoundation.org>
 <CA+G9fYtVSorLiG5cZdqtipy4XO1zr1HUZ4gH7tf_07m-B4HS1w@mail.gmail.com>
 <2078122506.33400530.1531776704409.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2078122506.33400530.1531776704409.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 05:31:44PM -0400, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
> > On 16 July 2018 at 13:04, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > wrote:
> > > This is the start of the stable review cycle for the 4.17.7 release.
> > > There are 67 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed Jul 18 07:34:11 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.7-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > >         linux-4.17.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > 
> > Results from Linaro’s test farm.
> > Regressions detected.
> > 
> > LTP syscalls failed test cases on all devices arm64, arm32 and x86_64,
> >  - creat08
> >  - open10
> 
> This is consequence of:
>   0fa3ecd87848 ("Fix up non-directory creation in SGID directories")
> 
> So likely cause of action here will be modifying both tests to not
> expect S_ISGID in scenario described in commit above.

Yes, ltp should be fixed up here.

thanks,

greg k-h
