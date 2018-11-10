Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13791C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAE720840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAE720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeKJRum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 12:50:42 -0500
Received: from shells.gnugeneration.com ([66.240.222.126]:54086 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbeKJRum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 12:50:42 -0500
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 186061A402A4; Sat, 10 Nov 2018 00:06:36 -0800 (PST)
Date:   Sat, 10 Nov 2018 00:06:35 -0800
From:   Vito Caputo <vcaputo@pengaru.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     ming.lei@redhat.com, snitzer@redhat.com, hch@lst.de,
        xni@redhat.com, mariusz.dabrowski@intel.com, axboe@kernel.dk
Subject: Does the discard bug introduced in 4.19 by 744889b7cbb56a6 and fixed
 by 1adfc5e4136f5967 have potential for fstrim-caused corruption?
Message-ID: <20181110080635.wvlg6o34vtgndshw@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ask because I recently performed some fstrims on my 4.19-running
laptop after a good house cleaning, and things started going rather
haywire today at the filesystem level, on different filesystems of
differing types (ext2 and ext4) but sharing the same underlying lvm
pv+dmcrypt on an SSD.

At the time I needed to get work done and couldn't investigate.  So I
crossed my fingers and rebooted back into 4.18, let some ugly fscks
complete, and carried on like nothing happened.

This all seems to be a software bug, not a genuine SSD failure of any
sort.

My filesystems are now all in a questionable state, though the machine
seems usable enough for the moment while I prepare for rebuilding.

Should I assume this was all caused by the fstrims and 744889b7cbb56a6?

Or does it not explain how this happened and we may have a different
problem on our hands?

I had been running 4.19-rc[178], but am uncertain if I performed fstrims
in any of those, I definitely did in 4.18 though and had no trouble.

744889b7cbb56a6 is especially suspect to me as it was in none of the
4.19 RCs but for some reason landed in 4.19 to fix a22c4d7e34402ccdf3,
even though a22c4d7e34402ccdf3 has been there since 4.3, that's left a
bad taste in my mouth but maybe I'm missing something.

Thanks,
Vito Caputo
