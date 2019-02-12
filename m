Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AE4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996AB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfBLIpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:45:13 -0500
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:42295 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728415AbfBLIpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:45:12 -0500
Received: from xps13 ([83.160.161.190])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id tTgggN8zOBDyItTgjgVGUS; Tue, 12 Feb 2019 09:45:10 +0100
Message-ID: <3dbf6ecb46ad65b3b4bddd4154e31fde2c79d13d.camel@tiscali.nl>
Subject: Re: [PATCH] ser_gigaset: mark expected switch fall-through
From:   Paul Bolle <pebolle@tiscali.nl>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     gigaset307x-common@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Karsten Keil <isdn@linux-pingi.de>
Date:   Tue, 12 Feb 2019 09:45:06 +0100
In-Reply-To: <20190211223444.GA29517@embeddedor>
References: <20190211223444.GA29517@embeddedor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLccxcAvVF3yquxzQAA5ITtPjwk4KLVItyi/LhkWdXVlXVOWlodmjAmdNv0QFQymp5ocvBjw/lj+SqgGmWKWytRsUedx+lFCLSDe8w7MskpK/GhKq4cC
 z3lHcFPdp+3IkTkVw4WLhv3/2D6sahlvgrNY/hNHgAtFllkJLeO3vwpF4dUY3dtLQGod2RO93KQrgj1CC+S+MzwkOs5wqWd/76k9r/kMjZGdY52jxWENusEu
 bKZzG2IP/FdV+OjkfwslyeCBzjqzlhO7JtJHvhdz1fMSU4aLqq7mMv5DSflVp1q2V4q7BTP0rFBBR9sC603x2FWQ3JdTvQmU6KwTptUQI8R2eJgx5fjkSWLm
 n+xLI20n
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo A. R. Silva schreef op ma 11-02-2019 om 16:34 [-0600]:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/isdn/gigaset/ser-gigaset.c: In function ‘gigaset_tty_ioctl’:
> drivers/isdn/gigaset/ser-gigaset.c:627:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    switch (arg) {
>    ^~~~~~
> drivers/isdn/gigaset/ser-gigaset.c:638:2: note: here
>   default:
>   ^~~~~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Paul Bolle <pebolle@tiscali.nl>

Thanks,


Paul Bolle

