Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6234920862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6234920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeHAViC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:38:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbeHAViC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:38:02 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkx8h-0001GL-0b; Wed, 01 Aug 2018 21:50:31 +0200
Date:   Wed, 1 Aug 2018 21:50:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aashish Lakhwara <aashish.l@samsung.com>
cc:     linux-kernel@vger.kernel.org, himanshu.sh@samssung.com,
        a.sahrawat@samsung.com, pankaj.m@samsung.com,
        Himanshu Shukla <himanshu.sh@samsung.com>
Subject: Re: [PATCH] posix-timers: Remove the stack variable clockid_t
 introduced as part of Protect posix clock array access against speculation
In-Reply-To: <20180801055857epcas5p35ac85b8c9c9339eb3080e6d89b1a0ce6~GrS4x1NZj0970809708epcas5p3l@epcas5p3.samsung.com>
Message-ID: <alpine.DEB.2.21.1808012140160.1835@nanos.tec.linutronix.de>
References: <CGME20180801055857epcas5p35ac85b8c9c9339eb3080e6d89b1a0ce6@epcas5p3.samsung.com> <20180801055857epcas5p35ac85b8c9c9339eb3080e6d89b1a0ce6~GrS4x1NZj0970809708epcas5p3l@epcas5p3.samsung.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Aashish Lakhwara wrote:

> Subject: [PATCH] posix-timers: Remove the stack variable clockid_t introduced as part of
    Protect posix clock array access against speculation

Documentation/process/submitting-patches.rst:

  For these reasons, the ``summary`` must be no more than 70-75
  characters, and it must describe both what the patch changes, as well
  as why the patch might be necessary.  It is challenging to be both
  succinct and descriptive, but that is what a well-written summary
  should do.

The above $subject violates all of these rules.

> The "array_index_mask_nospec" code has been updated to allow index
> argument to have const-qualified type.

> Now the stack variable "idx" is no longer required and can be removed.
> We should directly pass the const variable "id" to array_index_mask_nospec

We should? Changelogs are about facts. So having:

  The "array_index_mask_nospec" code has been updated to allow index
  argument to have const-qualified type.

  So the stack variable "idx" which was introduced in commit 19b558db12f9
  ("posix-timers: Protect posix clock array access against speculation") to
  cast the const argument 'id' is not longer required.

is factual and precise. Hmm?

> Signed-off-by: Aashish Lakhwara <aashish.l@samsung.com>
> Signed-off-by: Himanshu Shukla <himanshu.sh@samsung.com>

This SOB chain is wrong. Please read and follow the Docuentation.

Thanks,

	tglx
