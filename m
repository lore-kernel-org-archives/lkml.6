Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D47ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF6020837
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF6020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbeGPOGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:06:34 -0400
Received: from nautica.notk.org ([91.121.71.147]:57498 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbeGPOGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:06:34 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E8E6AC009; Mon, 16 Jul 2018 15:39:02 +0200 (CEST)
Date:   Mon, 16 Jul 2018 15:38:47 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     jiangyiwen <jiangyiwen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH] net/9p: Fix a deadlock case in the
 virtio transport
Message-ID: <20180716133847.GA9421@nautica>
References: <5B49B8CF.40709@huawei.com>
 <20180714090502.GA16186@nautica>
 <5B49DAA5.3020600@huawei.com>
 <20180714124715.GA16134@nautica>
 <5B4BFB29.3080507@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B4BFB29.3080507@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jiangyiwen wrote on Mon, Jul 16, 2018:
> You're right, this wake up operation should be put after the unlocking,
> I will resend it. In addition, whether I should resend this patch based
> on your 9p-next branch?

There is a trivial conflict with Thomas' validate PDU length patch,
but as it is trivial either work for me - pick whichever is easier to
work with for you.

The main reason I asked for a new version of the other patch is that the
IDR rework changed spin locks, so I'd rather it being clean.


Thanks,
-- 
Dominique
