Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D7F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D7F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeIRSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:41:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRSlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:41:46 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D4A01C7F;
        Tue, 18 Sep 2018 13:09:13 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:09:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 0/8] staging: erofs: error handing and more tracepoints
Message-ID: <20180918130911.GA16187@kroah.com>
References: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
 <20180918111953.GA3585@kroah.com>
 <aab26d0e-f8dc-cc83-46eb-7a93a833eaae@huawei.com>
 <20180918121413.GA499@kroah.com>
 <e940cdaf-faeb-7f60-b5ca-5f4d6af450be@huawei.com>
 <20180918130337.jtq6ziqp6efr3fq4@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918130337.jtq6ziqp6efr3fq4@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 04:03:37PM +0300, Dan Carpenter wrote:
> On Tue, Sep 18, 2018 at 08:31:22PM +0800, Gao Xiang wrote:
> > (I have no clang environment to build kernel yet... :( I will try later, but I have no idea why it happens,
> > and it seems a false warning).
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > Or is gcc just being "dumb" here?  What about clang, have you tried
> > > building it with that compiler as well?
> 
> Yeah.  Gcc is wrong.  Gcc used to be extra conservative and missed a
> bunch of bugs, but I guess now they're going in to opposite direction?
> 
> Smatch gets this correct, but you have to rebuild the cross function DB
> twice to make the warning go away.  It could be because it starts out
> with the old vle_get_logical_extent_head() information so it thinks it
> knows how that function works.

Ok, thanks for checking (both of you).  Just initialize the variable to
keep gcc from printing foolish warnings.

thanks,

greg k-h
