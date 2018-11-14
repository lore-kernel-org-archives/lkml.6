Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB71C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FE922360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FE922360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbeKOCnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:43:05 -0500
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:36691 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728686AbeKOCnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:43:05 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0C3F91822494B;
        Wed, 14 Nov 2018 16:39:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stick31_4f87e6e76d624
X-Filterd-Recvd-Size: 2322
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Nov 2018 16:39:06 +0000 (UTC)
Message-ID: <89e6bbe46d4fe804f884d7cf37303d43f577ad33.camel@perches.com>
Subject: Re: [PATCH 4/5] scsi: libsas: Drop SAS_DPRINTK() and revise logs
 levels
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     hare@suse.com, yanaijie@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Date:   Wed, 14 Nov 2018 08:39:04 -0800
In-Reply-To: <6c453baa-71bb-5fe0-28a1-5af097f2e9ae@huawei.com>
References: <1542203269-174932-1-git-send-email-john.garry@huawei.com>
         <1542203269-174932-5-git-send-email-john.garry@huawei.com>
         <132ba0c903b36d85db30cfebf58fe1f4c3a7c05b.camel@perches.com>
         <6c453baa-71bb-5fe0-28a1-5af097f2e9ae@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 15:12 +0000, John Garry wrote:
> On 14/11/2018 14:53, Joe Perches wrote:
> > On Wed, 2018-11-14 at 21:47 +0800, John Garry wrote:
> > > Like sas_printk() did previously, SAS_DPRINTK() offers little value now
> > > that libsas logs already have the "sas" prefix through pr_fmt(fmt). So it
> > > can be dropped.
> > > 
> > > However, after reviewing some logs in libsas, it is noticed that debug
> > > level is too low in many instances.
> > > 
> > > So this change drops SAS_DPRINTK() and revises some logs to a more
> > > appropriate level. However many stay at debug level, although some
> > > are significantly promoted.
> > []
> > > All the pre-existing checkpatch errors for spanning messages across
> > > multiple lines are untouched.
> > 
> > I think coalescing would be useful.
> 
> Sorry, I missed that. Do you mean that we stop spanning strings over 
> multiple lines?

Yes.

> If yes, I tend to agree. It means we can grep for full strings vs just a 
> different checkpatch issue (>80 lines or spanning multiple lines)

checkpatch does not emit a warning when a string is the
last element of a line that is > 80 chars when the
string stats before position 79.


