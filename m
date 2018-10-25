Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FC4C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A33720834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A33720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeJZG2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeJZG2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:28:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43E4330820C4;
        Thu, 25 Oct 2018 21:54:18 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-21.brq.redhat.com [10.40.200.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A623D5D6AA;
        Thu, 25 Oct 2018 21:54:14 +0000 (UTC)
Date:   Thu, 25 Oct 2018 23:54:39 +0200
From:   Eugene Syromyatnikov <evgsyr@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RESEND 0/2] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
Message-ID: <cover.1540504380.git.evgsyr@gmail.com>
References: <8acaf8d7-17c9-e8ec-c60a-18a011b4c34f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8acaf8d7-17c9-e8ec-c60a-18a011b4c34f@kernel.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 25 Oct 2018 21:54:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is a small fix of a typo (or, more specifically, some remnant of
the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
with "H" is used in man page and everywhere else, it's probably worth
to make the name used in the fcntl.h UAPI header in line with it.
Second follow-up patch updates (the sole) usage site of this constant
in kernel to use the new spelling.

The old name is retained as it is part of UAPI now.

Eugene Syromiatnikov (2):
  fcntl: fix typo in RWH_WRITE_LIFE_NOT_SET r/w hint
  drivers/md/raid5.c: use the new spelling of RWH_WRITE_LIFE_NOT_SET

 drivers/md/raid5.c               | 4 ++--
 fs/fcntl.c                       | 2 +-
 include/uapi/linux/fcntl.h       | 9 ++++++++-
 tools/include/uapi/linux/fcntl.h | 9 ++++++++-
 4 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.1.4

