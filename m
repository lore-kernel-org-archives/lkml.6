Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFB4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42862214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfA2PVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:21:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfA2PVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:21:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F3948666F;
        Tue, 29 Jan 2019 15:21:10 +0000 (UTC)
Received: from localhost (unknown [10.40.205.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 887EE5D96F;
        Tue, 29 Jan 2019 15:21:07 +0000 (UTC)
Date:   Tue, 29 Jan 2019 16:21:06 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Brian Behlendorf <behlendorf1@llnl.gov>,
        Siarhei Volkau <lis8215@gmail.com>
Subject: Re: [PATCH] lib/div64: off by one in shift
Message-ID: <20190129152105.GA18383@redhat.com>
References: <1548686944-11891-1-git-send-email-sgruszka@redhat.com>
 <20190128094503.19e9f2ae0b286f7b1f743d70@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128094503.19e9f2ae0b286f7b1f743d70@linux-foundation.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 29 Jan 2019 15:21:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 09:45:03AM -0800, Andrew Morton wrote:
> On Mon, 28 Jan 2019 15:49:04 +0100 Stanislaw Gruszka <sgruszka@redhat.com> wrote:
> 
> > fls counts bits starting from 1 to 32 (returns 0 for zero argument).
> > If we add 1 we shift right one bit more and loose precision from
> > divisor, what cause function incorect results with some numbers.
> > 
> > Corrected code was tested in user-space, see bugzilla:
> > https://bugzilla.kernel.org/show_bug.cgi?id=202391
> 
> What are the usersoace-visible runtime effects of this change?

The bug is rather theoretical and for most cases divisor is within
32 bits, so problem is not visible. Moreover the bug is only for
32-bit systems and various users of it like btrfs are unlikely
to be run on such systems. So I do not consider this as very
important fix.

Thanks
Stanislaw
