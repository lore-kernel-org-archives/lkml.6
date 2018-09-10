Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11896C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D6820866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D6820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeIJOFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:05:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeIJOFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:05:42 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B0EA0BC6;
        Mon, 10 Sep 2018 09:12:38 +0000 (UTC)
Date:   Mon, 10 Sep 2018 11:12:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/29] staging: bcm2835-audio: Cleanups and fixes
Message-ID: <20180910091236.GB21533@kroah.com>
References: <20180904155858.8001-1-tiwai@suse.de>
 <2050605805.39126.1536412690563@email.1und1.de>
 <s5hd0to5598.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hd0to5598.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 06:21:55PM +0200, Takashi Iwai wrote:
> On Sat, 08 Sep 2018 15:18:10 +0200,
> Stefan Wahren wrote:
> > 
> > Hi Takashi,
> > 
> > > Takashi Iwai <tiwai@suse.de> hat am 4. September 2018 um 17:58 geschrieben:
> > > 
> > > 
> > > Hi,
> > > 
> > > since I had an opportunity to play with RPi3B+ recently, I took a look
> > > at the existing bcm2835-audio driver code and was amused very much :)
> > > 
> > > So here is the result, a cleanup and fix patch series.
> > > 
> > > Most of the patches are trivial cleanups, just brushing up, removing
> > > many redundant and buggy codes, as well as code simplifications.
> > > 
> > > A big functional change is that now it uses non-atomic PCM ops, so
> > > that we can kill the ugly workqueue usages.  Also, the resource
> > > management was simplified.
> > 
> > first of all, thank you very much for this series.
> > 
> > Eric has no time as maintainer, so i will try to give you some feedback (beware of very little audio driver knowledge).
> > 
> > I functionally tested your patch series on a Raspberry Pi 1 B (bcm2835_defconfig), so this whole series is at least:
> > 
> > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> OK, thanks, I'll put to my series in case of resubmission.
> Meanwhile I'll keep the series in topic/vc04 branch of sound.git
> tree.

I'll just take this through my tree now, so there aren't merge issues if
there happens to be other cleanups to the driver that show up in the
near future.

thanks,

greg k-h
