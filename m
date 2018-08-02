Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F333C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582B3214AB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582B3214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbeHBPLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:11:02 -0400
Received: from fieldses.org ([173.255.197.46]:35896 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732349AbeHBPLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:11:02 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E3E322019; Thu,  2 Aug 2018 09:19:51 -0400 (EDT)
Date:   Thu, 2 Aug 2018 09:19:51 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Nixiaoming <nixiaoming@huawei.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "andros@netapp.com" <andros@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
Message-ID: <20180802131951.GA30706@fieldses.org>
References: <20180723015711.27961-1-nixiaoming@huawei.com>
 <20180801151820.GA18338@fieldses.org>
 <E490CD805F7529488761C40FD9D26EF12A730A64@dggemm507-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12A730A64@dggemm507-mbx.china.huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 01:00:26PM +0000, Nixiaoming wrote:
> On Wednesday, August 01, 2018 11:18 PM ,  J. Bruce Fields  wrote: 
> >On Mon, Jul 23, 2018 at 09:57:11AM +0800, nixiaoming wrote:
> >> READ_BUF(8);
> >> dummy = be32_to_cpup(p++);
> >> dummy = be32_to_cpup(p++);
> >> ...
> >> READ_BUF(4);
> >> dummy = be32_to_cpup(p++);
> >> 
> >> Assigning value to "dummy" here, but that stored value
> >> is overwritten before it can be used.
> >> At the same time READ_BUF() will re-update the pointer p.
> >> 
> >> delete invalid assignment statements
> >
> >Thanks, applying with a minor comment tweak to clarify that we're
> >intentionally not reading these:
> >
> >-		/* ssp_window and ssp_num_gss_handles */
> >+		/* ignore ssp_window and ssp_num_gss_handles: */
> > 		READ_BUF(8);
> > 		break;
> >
> >--b.
> >
> 
> Thanks for your advice
> I will update the patch as soon as possible according to your advice.

I've taken care of it, no need to update.

--b.
