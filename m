Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE58C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BABF2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BABF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbeKGLCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:02:44 -0500
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:44502 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727248AbeKGLCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:02:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 892891802959F;
        Wed,  7 Nov 2018 01:34:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: patch34_44d87b8aa7d57
X-Filterd-Recvd-Size: 2195
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed,  7 Nov 2018 01:34:32 +0000 (UTC)
Message-ID: <499e4358e72fca510fa6fcfb76ea3ac3792db08f.camel@perches.com>
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order
 of operations for deferred probe and remove
From:   Joe Perches <joe@perches.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Tue, 06 Nov 2018 17:34:31 -0800
In-Reply-To: <1541548114.196084.195.camel@acm.org>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
         <1541548114.196084.195.camel@acm.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 15:48 -0800, Bart Van Assche wrote:
> On Mon, 2018-11-05 at 13:12 -0800, Alexander Duyck wrote:
> > One change I made in addition is I replaced the use of "bool X:1" to define
> > the bitfield to a "u8 X:1" setup in order to resolve some checkpatch
> > warnings.
> 
> Please use "bool X:1" instead of "u8 X:1". I think it was a bad idea to make
> checkpatch complain about "bool X:1" since "bool X:1" should only be avoided
> in structures for which alignment must be architecture-independent. For struct
> device it is fine if member alignment differs per architecture. Additionally,
> changing "bool X:1" into "u8 X:1" will reduce performance on architectures that
> cannot do byte addressing.

I generally agree.  But the checkpatch warning _could_
be useful in those cases where alignment should be
architecture-independent.

Any suggestion on how to improve the message?
s

