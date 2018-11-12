Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A852C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0EC20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0EC20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbeKLLNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:13:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbeKLLNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:13:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F32F13DE05;
        Mon, 12 Nov 2018 01:22:26 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1810319745;
        Mon, 12 Nov 2018 01:22:18 +0000 (UTC)
Date:   Mon, 12 Nov 2018 09:22:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, snitzer@redhat.com,
        hch@lst.de, xni@redhat.com, mariusz.dabrowski@intel.com,
        axboe@kernel.dk
Subject: Re: Does the discard bug introduced in 4.19 by 744889b7cbb56a6 and
 fixed by 1adfc5e4136f5967 have potential for fstrim-caused corruption?
Message-ID: <20181112012213.GA21443@ming.t460p>
References: <20181110080635.wvlg6o34vtgndshw@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110080635.wvlg6o34vtgndshw@shells.gnugeneration.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 12 Nov 2018 01:22:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 12:06:35AM -0800, Vito Caputo wrote:
> I ask because I recently performed some fstrims on my 4.19-running
> laptop after a good house cleaning, and things started going rather
> haywire today at the filesystem level, on different filesystems of
> differing types (ext2 and ext4) but sharing the same underlying lvm
> pv+dmcrypt on an SSD.

Could you share us your test case? And what is the exact issue triggered
in your system?

> 
> At the time I needed to get work done and couldn't investigate.  So I
> crossed my fingers and rebooted back into 4.18, let some ugly fscks
> complete, and carried on like nothing happened.
> 
> This all seems to be a software bug, not a genuine SSD failure of any
> sort.
> 
> My filesystems are now all in a questionable state, though the machine
> seems usable enough for the moment while I prepare for rebuilding.
> 
> Should I assume this was all caused by the fstrims and 744889b7cbb56a6?

You may confirm that by revert 744889b7cbb56a6 and see if your issue is
gone.

However, 1adfc5e4136f5967d is supposed to fix 744889b7cbb56a6, so I
strongly suggest you to can verify 1adfc5e4136f5967d.

Thanks,
Ming
