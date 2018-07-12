Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EEAC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A0E208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A0E208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbeGLPmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:42:46 -0400
Received: from smtprelay0222.hostedemail.com ([216.40.44.222]:55107 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732384AbeGLPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:42:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E3A4D18224943;
        Thu, 12 Jul 2018 15:32:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: linen09_51748762bbe17
X-Filterd-Recvd-Size: 1996
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Jul 2018 15:32:39 +0000 (UTC)
Message-ID: <e03247c4ffeaf084621c0a19ed2635821939a0a5.camel@perches.com>
Subject: Re: [PATCH 02/12] blk: use for_each_if
From:   Joe Perches <joe@perches.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Jul 2018 08:32:38 -0700
In-Reply-To: <efb7a7fe-16ef-1928-9d95-50b1fb84f0c3@kernel.dk>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
         <20180709083650.23549-2-daniel.vetter@ffwll.ch>
         <20180711164058.GC72677@devbig577.frc2.facebook.com>
         <20180711164536.GD72677@devbig577.frc2.facebook.com>
         <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
         <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
         <2296606a890a1f3543c5db825ed172f7d295a504.camel@perches.com>
         <efb7a7fe-16ef-1928-9d95-50b1fb84f0c3@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-12 at 07:54 -0600, Jens Axboe wrote:
> 
> Thanks for your invaluable and useful feedback, sharing your vast
> experience in patchsets with dependencies.

I've probably more experience sending patchsets
with dependencies across subsystems than anyone.

There is no single style that works and I've
probably tried them all.

It's actually a somewhat significant issue within
this community that could use some arbitration.
