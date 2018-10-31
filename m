Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E91C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76C620838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76C620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJaRTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:19:41 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:47189 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeJaRTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:19:41 -0400
X-IronPort-AV: E=Sophos;i="5.54,447,1534809600"; 
   d="scan'208";a="81195081"
Date:   Wed, 31 Oct 2018 09:22:25 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Manjunath Patil <manjunath.b.patil@oracle.com>
CC:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <konrad.wilk@oracle.com>, <axboe@kernel.dk>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] xen-blkfront: fix kernel panic with negotiate_mq
 error path
Message-ID: <20181031082225.zp2cnrfuinpbilv5@mac.citrite.net>
References: <1540918161-31283-1-git-send-email-manjunath.b.patil@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540918161-31283-1-git-send-email-manjunath.b.patil@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 09:49:21AM -0700, Manjunath Patil wrote:
> info->nr_rings isn't adjusted in case of ENOMEM error from
> negotiate_mq(). This leads to kernel panic in error path.
> 
> Typical call stack involving panic -
>  #8 page_fault at ffffffff8175936f
>     [exception RIP: blkif_free_ring+33]
>     RIP: ffffffffa0149491  RSP: ffff8804f7673c08  RFLAGS: 00010292
>  ...
>  #9 blkif_free at ffffffffa0149aaa [xen_blkfront]
>  #10 talk_to_blkback at ffffffffa014c8cd [xen_blkfront]
>  #11 blkback_changed at ffffffffa014ea8b [xen_blkfront]
>  #12 xenbus_otherend_changed at ffffffff81424670
>  #13 backend_changed at ffffffff81426dc3
>  #14 xenwatch_thread at ffffffff81422f29
>  #15 kthread at ffffffff810abe6a
>  #16 ret_from_fork at ffffffff81754078
> 
> Cc: stable@vger.kernel.org
> Fixes: 7ed8ce1c5fc7 ("xen-blkfront: move negotiate_mq to cover all cases of new VBDs")
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
