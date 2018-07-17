Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A871ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C314D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C314D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeGQPhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:37:14 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55678 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731793AbeGQPhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:37:13 -0400
Received: (qmail 3019 invoked by uid 2102); 17 Jul 2018 11:04:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jul 2018 11:04:09 -0400
Date:   Tue, 17 Jul 2018 11:04:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Martijn Coenen <maco@android.com>
cc:     Kernel development list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH 6/6] RFC: USB: storage: move symbols into USB_STORAGE
 namespace.
In-Reply-To: <20180716122125.175792-7-maco@android.com>
Message-ID: <Pine.LNX.4.44L0.1807171100190.1689-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018, Martijn Coenen wrote:

> Modules using these symbols must now import this namesapce explicitly.

Spelling error ("namesapce").

> 
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>  drivers/usb/storage/alauda.c        |  1 +
>  drivers/usb/storage/cypress_atacb.c |  1 +
>  drivers/usb/storage/datafab.c       |  1 +
>  drivers/usb/storage/ene_ub6250.c    |  1 +
>  drivers/usb/storage/freecom.c       |  1 +
>  drivers/usb/storage/isd200.c        |  1 +
>  drivers/usb/storage/jumpshot.c      |  1 +
>  drivers/usb/storage/karma.c         |  1 +
>  drivers/usb/storage/onetouch.c      |  1 +
>  drivers/usb/storage/realtek_cr.c    |  1 +
>  drivers/usb/storage/sddr09.c        |  1 +
>  drivers/usb/storage/sddr55.c        |  1 +
>  drivers/usb/storage/shuttle_usbat.c |  1 +
>  drivers/usb/storage/uas.c           |  1 +
>  drivers/usb/storage/usb.c           | 20 ++++++++++----------
>  15 files changed, 24 insertions(+), 10 deletions(-)

This patch misses the various EXPORT_SYMBOL_GPL lines in debug.c,
protocol.c, scsiglue.c, and transport.c.  They should also be
considered part of the USB_STORAGE namespace.

Alan Stern

