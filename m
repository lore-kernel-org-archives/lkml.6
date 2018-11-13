Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23682C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD40E2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD40E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbeKNBZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:25:35 -0500
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:54437 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731840AbeKNBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:25:35 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F050D18227D95;
        Tue, 13 Nov 2018 15:26:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: honey20_76d71eee3a711
X-Filterd-Recvd-Size: 2529
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Nov 2018 15:26:56 +0000 (UTC)
Message-ID: <da1e7856fbb1c107edea42c03591161a5e808978.camel@perches.com>
Subject: Re: [PATCH] scsi: libsas: Remove pcidev reference
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Date:   Tue, 13 Nov 2018 07:26:55 -0800
In-Reply-To: <b63b6d3c-3b18-fcfa-1869-78b1f7637fd1@huawei.com>
References: <1542043689-214071-1-git-send-email-john.garry@huawei.com>
         <584e7b4fcd6f95fe0c581f6f9472852685c754d1.camel@perches.com>
         <310504a2-f33c-183b-d00a-fa067b273dfd@huawei.com>
         <3b62b0ad-53ba-37c2-817c-591d94eed838@huawei.com>
         <31d224e8c4b9bcebc3657c17fa50302f7da90e64.camel@perches.com>
         <dd39734e-4113-f9fd-6890-a83e80093c7e@huawei.com>
         <3470156e35390d1810a6a5e4a554a77493c0d44f.camel@perches.com>
         <39f56211-cf15-8ca5-a48f-3e4cc347cdb0@huawei.com>
         <dda6fafd2096845ef503921703652f511d4f0daa.camel@perches.com>
         <b63b6d3c-3b18-fcfa-1869-78b1f7637fd1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 13:38 +0000, John Garry wrote:
> On 12/11/2018 19:52, Joe Perches wrote:
> > On Mon, 2018-11-12 at 19:31 +0000, John Garry wrote:
> > > On 12/11/2018 18:58, Joe Perches wrote:
> > > > > > +#define pr_fmt(fmt) "sas: " fmt
[]
> > > > It also might useful to use the common debugging
> > > > mechanisms and convert SAS_DPRINTK to pr_debug
> > > > which would use the same #define pr_fmt.
{}
> We have almost 100 references to SAS_DPRINTK. So when we replace with 
> pr_debug, we will frequently have to realign the indentation. I'm 
> beginning to think it's not worth the churn to remove SAS_DPRINTK.

or just convert the #define

> However, with regards to using pr_debug(), there are loops to jump 
> through to ensure any output at all:
> - ensure DEBUG is defined or DYNAMIC DEBUG enabled

True

> - ensure current loglevel is high enough

That's already the case.

> Having said that, there are actually lots of logs in libsas where debug 
> level is too low (at pr_debug), and these could be upgraded.
> 
> So I think I will just go through the code and revise these levels.

Nice, thanks


