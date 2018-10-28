Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFF6C46475
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 01:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00D42086B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 01:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00D42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbeJ1JpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 05:45:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbeJ1JpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 05:45:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BB7E88305;
        Sun, 28 Oct 2018 01:02:08 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53975620AD;
        Sun, 28 Oct 2018 01:02:01 +0000 (UTC)
Date:   Sun, 28 Oct 2018 09:01:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: swap discard issue with zram caused by "block: don't deal
 with discard limit in blkdev_issue_discard()"
Message-ID: <20181028010156.GB26731@ming.t460p>
References: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
 <20181026062743.GA21483@ming.t460p>
 <CALjTZvaAc1HBXWHuhaCMsWwJLZEvPy_gvX2U2Lzcj6iVVktWNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALjTZvaAc1HBXWHuhaCMsWwJLZEvPy_gvX2U2Lzcj6iVVktWNQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 28 Oct 2018 01:02:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 08:50:20AM +0100, Rui Salvaterra wrote:
> On Fri, 26 Oct 2018 at 07:27, Ming Lei <ming.lei@redhat.com> wrote:
> >
> > The patch titled with 'block: make sure discard bio is aligned with logical block size'
> > in the list may fix this issue, please test and see if it works.
> >
> > Thanks,
> > Ming
> 
> Hi, Ming,
> 
> Thanks for the quick reply. Unfortunately, it doesn't seem to apply
> cleanly to 4.19. To which tree/tag/commit should I apply the series?

The whole patchset is against linus tree (44786880df196a4200).

I am sure that the 1st patch can be applied cleanly against v4.19, and
it is enough for fixing this issue, please double check.

[ming@ming linux]$ git log --oneline -1
84df9525b0c2 Linux 4.19
[ming@ming linux]$ git am ~/emails/blk/181026\ \[PATCH\ 1∕3\]\ block\:\ make\ sure\ discard\ bio\ is\ aligned\ with\ logical\ block\ size.eml
Applying: block: make sure discard bio is aligned with logical block size
[ming@ming linux]$ 


Thanks,
Ming
