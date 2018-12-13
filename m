Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6896C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9B720870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9B720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxdriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeLMPwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:52:36 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:49240 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeLMPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:52:36 -0500
Received: from cpe-2606-a000-111b-405a-a193-cb97-58ba-1c15.dyn6.twc.com ([2606:a000:111b:405a:a193:cb97:58ba:1c15] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1gXTHd-0001Pr-8u; Thu, 13 Dec 2018 10:52:28 -0500
Date:   Thu, 13 Dec 2018 10:51:49 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xin Long <lucien.xin@gmail.com>, kent.overstreet@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, dave.hansen@intel.com,
        davem <davem@davemloft.net>, Oleg Babin <obabin@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 6/6] Drop flex_arrays
Message-ID: <20181213155149.GA4127@hmswarspite.think-freely.org>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-7-kent.overstreet@gmail.com>
 <CADvbK_ccPYY5jGRV+cLNc5Nzcfv0mq0eNMeU-ALvepax0ZSizQ@mail.gmail.com>
 <20181213144111.GO6830@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213144111.GO6830@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 06:41:11AM -0800, Matthew Wilcox wrote:
> On Thu, Dec 13, 2018 at 09:30:47PM +0900, Xin Long wrote:
> > On Sat, Sep 8, 2018 at 1:57 AM Kent Overstreet
> > <kent.overstreet@gmail.com> wrote:
> > >
> > > All existing users have been converted to generic radix trees
> > NAK, SCTP is still using flex_arrays,
> > # grep flex_array net/sctp/*
> > 
> > This patch will break the build.
> 
> sctp added that user after this patch was sent.  Please stop adding
> flexarray users!
> 
> This particular user should probably have just used kvmalloc.
> 

No, I don't think thats right.

This appears to have been sent on September 7th.  Commit
0d493b4d0be352b5e361e4fa0bc3efe952d8b10e, which added the use of flex_arrays to
sctp, seems to have been merged on August 10th, a month prior.

regardless, however, sctp has a current in-tree use of flex_arrays, and merging
this patch will break the build without a respin.

Neil


