Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39F9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC3A2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfACPGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:06:44 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50618 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726259AbfACPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:06:44 -0500
Received: (qmail 1632 invoked by uid 2102); 3 Jan 2019 10:06:43 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Jan 2019 10:06:43 -0500
Date:   Thu, 3 Jan 2019 10:06:43 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Icenowy Zheng <icenowy@aosc.io>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] USB Storage quirk for SMI SM3350
In-Reply-To: <20190103032618.9237-1-icenowy@aosc.io>
Message-ID: <Pine.LNX.4.44L0.1901031006220.1460-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019, Icenowy Zheng wrote:

> SMI SM3350 UFS-USB bridge controller cannot handle REQUEST SENSE command
> with long sense (96-bytes) well, and will even trap the controller into
> a state that refuses to do read/write command.
> 
> Currently Linux uncondintionally set US_FL_SANE_SENSE for devices
> claiming SPC3+, which makes simply add US_FL_BAD_SENSE for SM3350 fail
> (as it claims SPC4).
> 
> Fix this conflicting quirk issue, and add the quirk for SM3350.
> 
> Icenowy Zheng (2):
>   USB: storage: don't insert sane sense for SPC3+ when bad sense
>     specified
>   USB: storage: add quirk for SMI SM3350
> 
>  drivers/usb/storage/scsiglue.c     |  8 ++++++--
>  drivers/usb/storage/unusual_devs.h | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)

For both patches:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

