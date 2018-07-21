Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6757920849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMrLHFJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6757920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeGURLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 13:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727759AbeGURLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 13:11:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D4A206B7;
        Sat, 21 Jul 2018 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532189912;
        bh=hEoFSBDzzl5wz/4WozsumfhdqBLKGxEjdLZ9jOrw1Zk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QMrLHFJF44oqFCuaNTRza0bFI5lLKVl72RqDTqnrq6yZomkPgBOjuSE6Ue1+uxqJL
         5n9d2L4G76SaR0TuXtm4tLsQ6Pz3V7oJGKy3myZ54s/4TX9LjPkmQ8tgUzkA8oqC/g
         Y+6G+wCdG9J/OSD5OTVk3zE9RT8VckmCJv2QinXU=
Date:   Sat, 21 Jul 2018 17:18:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Manish Narani <manish.narani@xilinx.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anirudh@xilinx.com>,
        <sgoud@xilinx.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name
 to 'iio_xadc_channels'
Message-ID: <20180721171828.55395acc@archlinux>
In-Reply-To: <7c4ee0db-ac33-b093-4dbb-1742fb029012@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
        <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
        <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
        <7c4ee0db-ac33-b093-4dbb-1742fb029012@xilinx.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 10:22:07 +0200
Michal Simek <michal.simek@xilinx.com> wrote:

> On 18.7.2018 13:18, Lars-Peter Clausen wrote:
> > On 07/18/2018 01:12 PM, Manish Narani wrote:  
> >> This patch fix the following checkpatch warning in xadc driver.
> >> - Reusing the krealloc arg is almost always a bug.
> >>
> >> Renamed the 'channels' variable as 'iio_xadc_channels' to fix the above
> >> warning.
> >>  
> > 
> > This is a bug in checkpatch and should be fixed in checkpatch. The code is
> > not actually re-using the parameter. channels and xadc_channels are
> > independent variables, just checkpatch somehow does not realize this.  
> 
> I think it should be fine to have this patch in tree. Change in commit
> message to reflect this should be enough. But that's just view.

Let's wait and see if Joe has time to take a look at this.  Might be better
to fix checkpatch if it's not too hard!

Jonathan
> 
> Thanks,
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

