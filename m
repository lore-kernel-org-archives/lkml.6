Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66477C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2800D2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2800D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbeJ3Eo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:44:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeJ3Eo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 940F530832E9;
        Mon, 29 Oct 2018 19:54:48 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-27.brq.redhat.com [10.40.200.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF81251C68;
        Mon, 29 Oct 2018 19:54:45 +0000 (UTC)
Date:   Mon, 29 Oct 2018 20:55:13 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] fcntl: fix typo in RWH_WRITE_LIFE_NOT_SET r/w
 hint
Message-ID: <20181029195509.GL1535@asgard.redhat.com>
References: <8acaf8d7-17c9-e8ec-c60a-18a011b4c34f@kernel.dk>
 <cover.1540504380.git.evgsyr@gmail.com>
 <d3f2c6b14ebf020a07dff5e79410ac1c1fef6023.1540504380.git.evgsyr@gmail.com>
 <cdbbf807-4df6-58c9-7d9c-2aeb1727c157@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdbbf807-4df6-58c9-7d9c-2aeb1727c157@kernel.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Oct 2018 19:54:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 08:44:35AM -0600, Jens Axboe wrote:
> On 10/25/18 3:54 PM, Eugene Syromiatnikov wrote:
> > According to commit message in the original commit v4.13-rc1~212^2~51,
> > as well as userspace library[1] and man page update[2], R/W hint constants
> > are intended to have RWH_* prefix. However, RWF_WRITE_LIFE_NOT_SET retained
> > "RWF_*" prefix used in earlyy versions of the proposed patch set[3].
> > Rename it and provide the old name as a synonym for the new one
> > for backward compatibility.
> > 
> > [1] https://github.com/axboe/fio/commit/bd553af6c849
> > [2] https://github.com/mkerrisk/man-pages/commit/580082a186fd
> > [3] https://www.mail-archive.com/linux-block@vger.kernel.org/msg09638.html
> 
> Looks good, thanks for catching this. One note:
> 
> > Fixes: c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")
> > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > Signed-off-by: Eugene Syromyatnikov <evgsyr@gmail.com>
> 
> Why do you have two separate sign-offs?

Uh, sorry, I've messed up format-patch flags again.

> -- 
> Jens Axboe
> 
