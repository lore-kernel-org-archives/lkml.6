Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECE0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5046621748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5046621748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeI1LIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:08:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeI1LIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:08:11 -0400
Received: from localhost (unknown [89.248.140.14])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 39086B78;
        Fri, 28 Sep 2018 04:46:21 +0000 (UTC)
Date:   Fri, 28 Sep 2018 06:46:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, Stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/64] 4.14.73-stable review
Message-ID: <20180928044617.GC20540@kroah.com>
References: <20180927090249.801943776@linuxfoundation.org>
 <CADVatmNwDEvdtpzvwo2ppCaLXgiyweLJStRBu_+ieyCz91eR1Q@mail.gmail.com>
 <CADVatmNrfhM6RdokTGtD1jn6ABxXDxTzy7qUwjLpp8doLECo7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmNrfhM6RdokTGtD1jn6ABxXDxTzy7qUwjLpp8doLECo7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:45:30PM +0100, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Thu, Sep 27, 2018 at 9:56 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > Hi Greg,
> >
> > On Thu, Sep 27, 2018 at 10:03 AM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> This is the start of the stable review cycle for the 4.14.73 release.
> >> There are 64 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Sat Sep 29 09:02:21 UTC 2018.
> >> Anything received after that time might be too late.
> >
> > My kvm guest had this:
> >
> 
> <snip>
> 
> > [    8.585076] RIP: drm_debugfs_init+0x183/0x370 [drm] RSP: ffff88002b1bf5e8
> > [    8.585404] ---[ end trace 62728db3ac408aba ]---
> >
> > And I had to revert 7e58fe2a97bc ("drm/atomic: Use
> > drm_drv_uses_atomic_modeset() for debugfs creation") to make it work.
> > I am looking more into why it failed.
> 
> update:
> 
> Backporting 57078338b2e4 ("drm: fix drm_drv_uses_atomic_modeset on non
> modesetting drivers.") fixed the issue. But 7e58fe2a97bc ("drm/atomic:
> Use drm_drv_uses_atomic_modeset() for debugfs creation") changed the
> functionality of the check. If this has to be applied, it will also
> need an additional patch to keep the check same as linus tree.
> 
> But looking at the other mails now, and you have already dropped the patch.

Yes, already dropped :)
