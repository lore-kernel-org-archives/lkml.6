Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71664C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41016213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41016213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJBHyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:54:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeJBHyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:54:05 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E20CD82;
        Tue,  2 Oct 2018 01:13:29 +0000 (UTC)
Date:   Mon, 1 Oct 2018 14:08:04 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     idryomov@gmail.com, sage@redhat.com, elder@kernel.org,
        jth@kernel.org, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] driver core: device: add BUS_ATTR_WO macro
Message-ID: <20181001210804.GA24332@kroah.com>
References: <1538407972-9340-1-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538407972-9340-1-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 06:32:52PM +0300, Ioana Ciornei wrote:
> Add BUS_ATTR_WO macro to make it easier to add attributes without
> auditing the mode settings. Also, use the newly added macro where
> appropriate.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  arch/powerpc/platforms/pseries/ibmebus.c | 12 ++++----
>  drivers/block/rbd.c                      | 48 ++++++++++++++++----------------
>  drivers/scsi/fcoe/fcoe_sysfs.c           |  4 +--
>  drivers/scsi/fcoe/fcoe_transport.c       | 10 +++----
>  include/linux/device.h                   |  2 ++
>  include/scsi/libfcoe.h                   |  8 +++---
>  6 files changed, 43 insertions(+), 41 deletions(-)

Nice!  This duplicates a lot of the work I did back in July but have not
pushed out very far due to the other things that ended up happening
around that time:
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/log/?h=bus_cleanup

As the patch series seen at that link shows, you can do this in more
places than just what you did here.

Either way, you should break this up into the individual patches, like I
did or you can take my patches if you want.  Getting the BUS_ATTR_WO()
macro added is good to do now, and then you can go and hit up all of the
different subsystems that should be converted over to it.

thanks,

greg k-h
