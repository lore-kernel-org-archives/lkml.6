Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CC0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DDD2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DDD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbeGRSYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:24:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbeGRSYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:24:32 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 759F6CFD;
        Wed, 18 Jul 2018 17:45:33 +0000 (UTC)
Date:   Wed, 18 Jul 2018 19:45:31 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
Message-ID: <20180718174531.GA2008@kroah.com>
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
 <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
 <CAE=gft5U1-Jo-GvTF7sNAV3Q565AmuUrHpmBdxUL+UwkKxesqA@mail.gmail.com>
 <0dce9e9c-4f93-9857-72ee-f65ff195c41a@codeaurora.org>
 <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
 <4cb931e199599314829f5ff750797c88fc123f1f.camel@wdc.com>
 <CAE=gft6zm2mw3rnNuktDe0NWs-NM1CFQw1BUeGhaBi3eoEDXBg@mail.gmail.com>
 <aa697186c00937c18519fe5eb1355d3fc458cfb6.camel@wdc.com>
 <20180718085651.GA23599@kroah.com>
 <16c8acaec092ef989ec20d0b006a434bc0de250c.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c8acaec092ef989ec20d0b006a434bc0de250c.camel@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 05:30:07PM +0000, Bart Van Assche wrote:
> On Wed, 2018-07-18 at 10:56 +0200, gregkh@linuxfoundation.org wrote:
> > On Tue, Jul 17, 2018 at 09:06:35PM +0000, Bart Van Assche wrote:
> > > On Tue, 2018-07-17 at 13:23 -0700, Evan Green wrote:
> > > > I'm not dead set on binary, since as above I could do it either way,
> > > > but it seemed worth at least talking through. Let me know what you
> > > > think.
> > > 
> > > The configfs documentation (Documentation/filesystems/configfs/configfs.txt)
> > > is clear about this: "Preferably only one value per file should be used." So
> > > I would like to hear the opinion of someone who has more authority than I
> > > with regard to configfs.
> > 
> > Don't we have "binary" files for configfs?  We have them for sysfs, they
> > are for files that are not touched by the kernel and just "pass-through"
> > to the hardware.  Would that work here as well?
> 
> If a new version of the UFS spec would be introduced and that new version of the
> spec introduces a new layout for the binary descriptor, will it be possible for
> user space software to figure out which version of the binary descriptor format
> that has to be used?

If a new UFS spec was crazy enough to keep the same field name but
change the layout of the field, well, the UFS spec authors deserve all
of the pain and suffering that would cause to be heaped on them.

Seriously, it's not hard to do this right, go fix the spec before they
do something stupid.

And you are reporting the version of the UFS spec that your device
supports to userspace, right?  So is this really a problem even if the
spec authors are that foolish?

thanks,

greg k-h
