Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C38C282C5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29B9218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfAYCZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:25:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36830 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbfAYCZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:25:33 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 75AE110888E80;
        Thu, 24 Jan 2019 18:25:32 -0800 (PST)
Date:   Thu, 24 Jan 2019 18:25:32 -0800 (PST)
Message-Id: <20190124.182532.1983690003554983866.davem@davemloft.net>
To:     lucien.xin@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        nhorman@tuxdriver.com
Subject: Re: [PATCH net] sctp: set chunk transport correctly when it's a
 new asoc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <d08f8708003363950333c0690960ce3d97897bd4.1548096129.git.lucien.xin@gmail.com>
References: <d08f8708003363950333c0690960ce3d97897bd4.1548096129.git.lucien.xin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 24 Jan 2019 18:25:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Jan 2019 02:42:09 +0800

> In the paths:
> 
>   sctp_sf_do_unexpected_init() ->
>     sctp_make_init_ack()
>   sctp_sf_do_dupcook_a/b()() ->
>     sctp_sf_do_5_1D_ce()
> 
> The new chunk 'retval' transport is set from the incoming chunk 'chunk'
> transport. However, 'retval' transport belong to the new asoc, which
> is a different one from 'chunk' transport's asoc.
> 
> It will cause that the 'retval' chunk gets set with a wrong transport.
> Later when sending it and because of Commit b9fd683982c9 ("sctp: add
> sctp_packet_singleton"), sctp_packet_singleton() will set some fields,
> like vtag to 'retval' chunk from that wrong transport's asoc.
> 
> This patch is to fix it by setting 'retval' transport correctly which
> belongs to the right asoc in sctp_make_init_ack() and
> sctp_sf_do_5_1D_ce().
> 
> Fixes: b9fd683982c9 ("sctp: add sctp_packet_singleton")
> Reported-by: Ying Xu <yinxu@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Applied and queued up for -stable.
