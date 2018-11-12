Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0517FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACA020815
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACA020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeKMB0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:26:49 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33771 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726385AbeKMB0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:26:49 -0500
Received: (qmail 8135 invoked by uid 500); 12 Nov 2018 10:33:04 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Nov 2018 10:33:04 -0500
Date:   Mon, 12 Nov 2018 10:33:04 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
cc:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: RE: scsi_set_medium_removal timeout issue 
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED1F1B7CD4@dggemm526-mbx.china.huawei.com>
Message-ID: <Pine.LNX.4.44L0.1811121031180.7773-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, Zengtao (B) wrote:

> >> >Something is wrong here.  Before sending PREVENT-ALLOW MEDIUM
> >> >REMOVAL, the host should issue SYNCHRONIZE CACHE.  This will force
> >> >fsg_lun_fsync_sub to run, and the host should allow a long timeout
> >> >for this command.  Then when PREVENT-ALLOW MEDIUM REMOVAL
> >is sent,
> >> >nothing will need to be flushed.
> >> >
> >>
> >> Definitely, I haven't seen the SYNCHRONIZE CACHE from the host, it
> >> directly issued the PREVENT-ALLOW MEDIUM REMOVAL, so maybe
> >something
> >> wrong with the scsi layer or something wrong with the mass storage
> >class driver?
> >
> >Or it could be something else.  Can you please post the dmesg log from
> >the host, showing what happens when the device is first plugged in?
> >
> 
> I have enabled the SCSI log for the host, please refer to the attachment.

The log you attached was incomplete -- it was missing some commands 
from the beginning.  In any case, it wasn't what I wanted.  I asked
you to post the dmesg log, not the SCSI log.

Alan Stern

