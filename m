Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9669C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4A6255C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4A6255C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965775AbeF0Vwi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:52:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751986AbeF0Vwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:52:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F137401DEC0;
        Wed, 27 Jun 2018 21:52:32 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FBF11C70A;
        Wed, 27 Jun 2018 21:52:27 +0000 (UTC)
Date:   Wed, 27 Jun 2018 17:52:27 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        Dan Williams <dan.j.williams@intel.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: dm: writecache: Use 2-factor allocator arguments
Message-ID: <20180627215227.GA13549@redhat.com>
References: <20180618175033.GA2627@beast>
 <CAGXu5j+Su3fObnuzntQ7Tp8W6jfMt1hc=h-3Xhidgx--Nau1Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+Su3fObnuzntQ7Tp8W6jfMt1hc=h-3Xhidgx--Nau1Ew@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 27 Jun 2018 21:52:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 27 Jun 2018 21:52:37 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27 2018 at  5:48pm -0400,
Kees Cook <keescook@chromium.org> wrote:

> On Mon, Jun 18, 2018 at 10:50 AM, Kees Cook <keescook@chromium.org> wrote:
> > This adjusts the allocator calls to use the 2-factor argument style, as
> > already done treewide for better defense against allocator overflows.
> > Additionally adjusts style nit to avoid assignments in test expressions.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Friendly ping -- I'd like to make sure this makes it into 4.18. All
> other 2-factor allocations have been fixed in the kernel.

Yeap, I'll be sending it to Linus this week.  Already staged and ready
to go, please see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.18&id=50a7d3ba7c9ac5e0b7e03fc7f420180989361dbf

Thanks,
Mike
