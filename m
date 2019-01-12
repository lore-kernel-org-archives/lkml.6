Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12884C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A752177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547280509;
	bh=Q5ouHoZfL3bx8f8tzhyUfdRQYsF0vB2+2NsGIiBPjn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NztABMJdyT1LgX33CDR0aIfM3Ic5ZfhzX4oTkm4WAmDfbEMD4L3Kz1Pb+wvKe7mN+
	 +1Tpbrnp+qdNZtU0olTzttbpYvb6wSPf7W2STycSLR1o/Hi6z6n9omHc+/HzivNlp3
	 1tZ++1EUuazoYCeX+wf9o//q7QO3lWCGCmsuUVAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfALII2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfALII2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:08:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C54B2133F;
        Sat, 12 Jan 2019 08:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547280508;
        bh=Q5ouHoZfL3bx8f8tzhyUfdRQYsF0vB2+2NsGIiBPjn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t81IuJD223IZ0Yw+M3ZhHAT+r1Xge88Tc0qszv39SpPIW4szMzkAZbqajWiTH2H6+
         lMVLGrGeE571IfO1FVvG1aeFgDqg1WHS9JQ5YDEbRaBCY0vgfpfvzBWzXiPBOm7EoT
         ew+TNOH171ZEwAngMbUzQimhfHaFYwTbDs8ghHOU=
Date:   Sat, 12 Jan 2019 09:08:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Dmitry Safonov <dima@arista.com>, Jiri Slaby <jslaby@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>, Dave Mielke <dave@mielke.cc>,
        linux-kernel@vger.kernel.org
Subject: Re: commit 83d817f410 broke my ability to use Linux with a braille
 display
Message-ID: <20190112080825.GA530@kroah.com>
References: <nycvar.YSQ.7.76.1901111239510.1512@knanqh.ubzr>
 <20190111193259.GA14966@kroah.com>
 <nycvar.YSQ.7.76.1901111503390.2566@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1901111503390.2566@knanqh.ubzr>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:10:04PM -0500, Nicolas Pitre wrote:
> On Fri, 11 Jan 2019, Greg Kroah-Hartman wrote:
> 
> > On Fri, Jan 11, 2019 at 01:33:09PM -0500, Nicolas Pitre wrote:
> > > I use Linux with the help of a braille display and the brltty daemon. It 
> > > turns out that the latest mainline kernel I can work with comes from 
> > > commit 231f8fd0cc. Anything past that and I lose the ability to read the 
> > > console barely a few seconds after the system has booted as brltty is 
> > > thrown a wrench and the braille display becomes completely inoperable.
> > 
> > Please try the patch below, it was just queued up to my tree and should
> > resolve the issue.  If not, please let us know.
> 
> Yes, it works. Thanks.
> 
> I also re-validated all the vt/vcs patches I sent you this week for 
> which I started entertaining some doubts about their stability. But they 
> all work fine again with the tty fix applied.

Great, thanks for testing, I will get this patch to Linus soon.

greg k-h
