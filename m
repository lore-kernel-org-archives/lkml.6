Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005E0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDE222419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDE222419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbeKOBjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:39:12 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:47912 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2387520AbeKOBjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:39:12 -0500
Received: (qmail 2405 invoked by uid 2102); 14 Nov 2018 10:35:28 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Nov 2018 10:35:28 -0500
Date:   Wed, 14 Nov 2018 10:35:28 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Martin Petersen <martin.petersen@oracle.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
cc:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: RE: scsi_set_medium_removal timeout issue 
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED1F1BC495@dggemm526-mbx.china.huawei.com>
Message-ID: <Pine.LNX.4.44L0.1811141027420.1637-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Zengtao (B) wrote:

> I just enabled the scsi log in the middle of the umount operation, otherwise I can't
> reproduce the issue when the scsi log is enabled.
> 
> >from the beginning.  In any case, it wasn't what I wanted.  I asked you to
> >post the dmesg log, not the SCSI log.
> 
> Please refer to the new attachment for dmesg log.

Heh, yes, I see now.

Martin, shouldn't sd_release() call sd_sync_cache() in the same way
that sd_shutdown() does, before it calls scsi_set_medium_removal()?

Alan Stern

