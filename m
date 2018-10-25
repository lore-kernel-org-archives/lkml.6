Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D27D20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D27D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeJYXdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:33:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbeJYXdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:33:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BECF47E9C4;
        Thu, 25 Oct 2018 15:00:22 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-51.brq.redhat.com [10.40.200.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32D5160921;
        Thu, 25 Oct 2018 15:00:19 +0000 (UTC)
Date:   Thu, 25 Oct 2018 17:00:45 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
Message-ID: <20181025150045.GC1535@asgard.redhat.com>
References: <20181006175114.GA10435@asgard.redhat.com>
 <20181025141927.GB19512@asgard.redhat.com>
 <8acaf8d7-17c9-e8ec-c60a-18a011b4c34f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8acaf8d7-17c9-e8ec-c60a-18a011b4c34f@kernel.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 25 Oct 2018 15:00:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 08:25:44AM -0600, Jens Axboe wrote:
> On 10/25/18 8:19 AM, Eugene Syromiatnikov wrote:
> > On Sat, Oct 06, 2018 at 07:51:14PM +0200, Eugene Syromiatnikov wrote:
> >> Hello.
> >>
> >> This is a small fix of a typo (or, more specifically, some remnant of
> >> the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
> >> which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
> >> with "H" is used in man page and everywhere else, it's probably worth
> >> to make the name used in the fcntl.h UAPI header in line with it.
> >> Second follow-up patch updates (the sole) usage site of this constant
> >> in kernel to use the new spelling.
> >>
> >> The old name is retained as it is part of UAPI now.
> > 
> > Hello, are there issues with the patches?
> 
> I only got the 0/2 patch, none of the two others..

Uh, sorry, I see them on lkml[1][2], but likely have messed up git
format-patch options, as I usually do. Will resend shortly.

[1] https://lkml.org/lkml/2018/10/6/292
[2] https://lkml.org/lkml/2018/10/6/291

> -- 
> Jens Axboe
> 
