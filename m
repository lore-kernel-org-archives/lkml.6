Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D317C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F352145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbeLQLjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:39:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbeLQLjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:39:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95A5681DE9;
        Mon, 17 Dec 2018 11:39:17 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-36.brq.redhat.com [10.40.200.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B73DA60BF1;
        Mon, 17 Dec 2018 11:39:14 +0000 (UTC)
Date:   Mon, 17 Dec 2018 12:39:49 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
Message-ID: <20181217113944.GG24150@asgard.redhat.com>
References: <cdbbf807-4df6-58c9-7d9c-2aeb1727c157@kernel.dk>
 <cover.1540843065.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540843065.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 17 Dec 2018 11:39:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 09:00:45PM +0100, Eugene Syromiatnikov wrote:
> This is a small fix of a typo (or, more specifically, some remnant of
> the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
> which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
> with "H" is used in man page and everywhere else, it's probably worth
> to make the name used in the fcntl.h UAPI header in line with it.
> Second follow-up patch updates (the sole) usage site of this constant
> in kernel to use the new spelling.
> 
> The old name is retained as it is part of UAPI now.

Hello.

Are there any issues with this version of the series?

> Changes since v1:
>  * Changed format of the commit ID in the commit message of the first patch.
>  * Removed bogus Signed-off-by that snuck into the resend of the series.
> 
> Eugene Syromiatnikov (2):
>   fcntl: fix typo in RWH_WRITE_LIFE_NOT_SET r/w hint
>   drivers/md/raid5.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET
> 
>  drivers/md/raid5.c               | 4 ++--
>  fs/fcntl.c                       | 2 +-
>  include/uapi/linux/fcntl.h       | 9 ++++++++-
>  tools/include/uapi/linux/fcntl.h | 9 ++++++++-
>  4 files changed, 19 insertions(+), 5 deletions(-)
> 
> -- 
> 2.1.4
> 
