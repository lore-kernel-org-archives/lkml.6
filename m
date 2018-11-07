Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CB7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4379420882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4379420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeKHHqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:46:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeKHHqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:46:53 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 77AD9B37;
        Wed,  7 Nov 2018 22:14:29 +0000 (UTC)
Date:   Wed, 7 Nov 2018 14:14:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Skidanov <alexey.skidanov@intel.com>
Cc:     sbates@raithlin.com, logang@deltatee.com, danielmentz@google.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        labbott@redhat.com
Subject: Re: [PATCH] lib/genaloc: Fix allocation of aligned buffer from
 non-aligned chunk
Message-Id: <20181107141428.bd1f8b1a989449633394d8c1@linux-foundation.org>
In-Reply-To: <d76d64cf-70a9-9c1f-6f11-2d812aacaaef@intel.com>
References: <1541506853-10685-1-git-send-email-alexey.skidanov@intel.com>
        <20181106141131.76e94f6b1ff2859d96792aca@linux-foundation.org>
        <d76d64cf-70a9-9c1f-6f11-2d812aacaaef@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 08:21:07 +0200 Alexey Skidanov <alexey.skidanov@intel.com> wrote:

> > Why does this need "fixing"?  Are there current callers which can
> > misalign chunk_start_addr?  Or is there a requirement that future
> > callers can misalign chunk_start_addr?
> > 
> I work on adding aligned allocation support for ION heaps
> (https://www.spinics.net/lists/linux-driver-devel/msg118754.html). Two
> of these heaps use genpool internally.
> 
> If you want to have an ability to allocate buffers aligned on different
> boundaries (for example, 4K, 1MB, ...), this fix actually removes the
> requirement for chunk_start_addr to be aligned on the max possible
> alignment.

OK.  This sort of information should be in the changelog, please.  In
much detail.

