Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871B2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3972081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2oHwCZpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3972081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeK2XSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:18:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbeK2XSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:18:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C434206B6;
        Thu, 29 Nov 2018 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543493592;
        bh=RtKnbO7RK0QYezqdykxZgmhI+qNzqPBll/IYGbQQ3qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2oHwCZpE0A/L21MNuJ4Qh/cK6KYxdGUuTGKDqKGM+6B2jmZZ0ScP51Vf8SckGfNxA
         pC8hC6g4vEmDEWQsRmqqG3IaeAETgjm6Y7hPrchwwjUFsDNNsWGMTAWYHltxpRWgl5
         PaXogG7aMkggQ3bmMIgZ60UHRNl7DD1G59EzFRN0=
Date:   Thu, 29 Nov 2018 13:13:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: libsas: Add missing license and update to SPDX
 license identifier
Message-ID: <20181129121310.GB25319@kroah.com>
References: <1543328132-243266-1-git-send-email-john.garry@huawei.com>
 <20181127144333.GA11004@kroah.com>
 <8ae3a984-b4d4-f2eb-4aaa-b460441fa403@huawei.com>
 <07b65f80-9b73-472f-1fb8-7c0133f1d1ab@huawei.com>
 <20181129121110.GA25319@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129121110.GA25319@kroah.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 01:11:10PM +0100, Greg KH wrote:
> On Thu, Nov 29, 2018 at 11:52:39AM +0000, John Garry wrote:
> > On 27/11/2018 15:23, John Garry wrote:
> > > On 27/11/2018 14:43, Greg KH wrote:
> > > 
> > > Hi Greg,
> > > 
> > > > On Tue, Nov 27, 2018 at 10:15:32PM +0800, John Garry wrote:
> > > > > Currently sas_task.c has no license specifier, so add SPDX license
> > > > > identifier for GPL-2.0+.
> > > > > 
> > > > > As mentioned in commit b24413180f56 ("License cleanup: add SPDX GPL-2.0
> > > > > license identifier to files with no license"), files with no license in
> > > > > the kernel are under default kernel license.
> > > > 
> > > > The default is GPLv2, not v2+.
> > > 
> > > So sas_task.c should be v2.
> > 
> > Hi Greg,
> > 
> > I also note that currently we have an inconsistency in license of
> > sas_init.c:
> > 
> > /*
> >  * Serial Attached SCSI (SAS) Transport Layer initialization
> >  *
> >  * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
> >  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
> >  *
> >  * This file is licensed under GPLv2.
> >  *
> >  * This program is free software; you can redistribute it and/or
> >  * modify it under the terms of the GNU General Public License as
> >  * published by the Free Software Foundation; either version 2 of the
> >  * License, or (at your option) any later version.
> >  *
> >  * This program is distributed in the hope that it will be useful, but
> >  * WITHOUT ANY WARRANTY; without even the implied warranty of
> >  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >  * General Public License for more details.
> >  *
> >  * You should have received a copy of the GNU General Public License
> >  * along with this program; if not, write to the Free Software
> >  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
> >  * USA
> >  *
> >  */
> > 
> > ...
> > 
> > MODULE_AUTHOR("Luben Tuikov <luben_tuikov@adaptec.com>");
> > MODULE_DESCRIPTION("SAS Transport Layer");
> > MODULE_LICENSE("GPL v2");
> > 
> > So the license specifies v2+ but module license states v2.
> > 
> > I could not find a docment for guidance on this. I also note that making
> > sas_task.c v2 would mean mixing v2 and v2+ into the module.
> 
> This is not the only file in the kernel with this problem.
> 
> For now, we have been trusting the "written text" lines over the
> MODULE_LICENSE() lines, as that seems to be the proper way forward.
> 
> > I did find an example of someone changing the license:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/i2c/busses/i2c-designware-slave.c?h=v4.20-rc4&id=15c566fcff9cc7b8fd64461d6ee6fd1bc665b444
> > 
> 
> Yup, not good, that should be fixed.

I take it back, the changelog for the patch explains what is happening
here, the people involved were paying attention.

greg k-h
