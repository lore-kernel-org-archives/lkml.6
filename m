Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAAFC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBD920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBD920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeGYFQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:16:00 -0400
Received: from nautica.notk.org ([91.121.71.147]:35635 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbeGYFQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:16:00 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 0E032C009; Wed, 25 Jul 2018 06:06:15 +0200 (CEST)
Date:   Wed, 25 Jul 2018 06:06:00 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net, groug@kaod.org
Subject: Re: [PATCH] fs/9p/xattr.c: catch the error of p9_client_clunk when
 setting xattr failed
Message-ID: <20180725040600.GA11041@nautica>
References: <5B57EACC.2060900@huawei.com>
 <20180725033200.GA29865@nautica>
 <5B57F564.9070604@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B57F564.9070604@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Wed, Jul 25, 2018:
> On 2018/7/25 11:32, Dominique Martinet wrote:
> >>  		p9_client_write(fid, 0, &from, &retval);
> > 
> > I'm not sure what to do about this but it's also possible for
> > p9_client_write to not write the full length without setting and error.
> > 
> > We should probably compare the return value of p9_client_write and
> > value_len to detect short writes and return an error in this case.
> 
> It looks like we could identify short writes error from the *err. If no
> error case breaks the while loop, the total equal to the whole data len.

Ah, I looked too fast and missed the while loop in p9_client_write...
It's rather unusual for such a low level call to handle retries, but I
guess that's 9p.

Right, will take that patch as is then.

Thanks,
-- 
Dominique
