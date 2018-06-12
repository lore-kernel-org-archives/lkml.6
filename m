Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C4E4BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934F4208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934F4208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934007AbeFLKXl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:23:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:41085 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933950AbeFLKXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:23:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5CANH7Q027710;
        Tue, 12 Jun 2018 05:23:19 -0500
Message-ID: <b91d8e9b0df0600a5fd00ae0e00067d366bcc551.camel@kernel.crashing.org>
Subject: Re: [GIT PULL]  FSI updates
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org
Date:   Tue, 12 Jun 2018 20:23:17 +1000
In-Reply-To: <20180612062059.GA26240@kroah.com>
References: <7c268f5bb58cb45a2868020b3c5b8f48ac6844ea.camel@kernel.crashing.org>
         <20180612062059.GA26240@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 08:20 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 12, 2018 at 02:14:25PM +1000, Benjamin Herrenschmidt wrote:
> > Hi Greg !
> > 
> > There are a first round of updates of the FSI stack, aiming at reducing/removing
> > the gap with the OpenBMC tree and a first step in getting dependent drivers
> > upstream.
> > 
> > These changes significantly improve the FSI bitbanging driver performance
> > and reliability, and add the new "sbefifo" driver for communicating with
> > the POWER9 Self Boot Engine (which will be needed for some upcoming
> > additional drivers).
> > 
> > [ Apologies if I got part of the process wrong, I haven't
> >   sent a pull request in years ;-) ]
> 
> So, these are all for 4.19-rc1, right?  Not bugfixes for 4.18-final?

The earlier the better as it reduces the diff with openbmc kernel tree
(with the goal of going down to 0) and simplify merging further new
stuff that depends on this. We are the only users of drivers/fsi so the
risk is for now at least nul. That said if you prefer queuing that up
for 4.19, that's ok (the patches were posted a little while ago, this
is just putting them in a git repo, nothing new since).

> > The following changes since commit 8efcf34a263965e471e3999904f94d1f6799d42a:
> > 
> >   Merge tag 'armsoc-late' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-06-11 18:19:45 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git 
> 
> I need a signed tag to pull from, not just a git tree, otherwise I don't
> know that you really sent me what you think you sent me :)
> 
> Can you fix that up, and tell me where you want this to go and then I
> can take it after 4.18-rc1 is out.

Ah ok, I haven't done signed tags yet :-) Linus didn't require them
back in the day for kernel.org hosted trees. I'll look into it
tomorrow.

Cheers,
Ben.

> 
> thanks,
> 
> greg k-h
