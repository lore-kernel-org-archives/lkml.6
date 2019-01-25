Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB56C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD0B218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfAYCZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:25:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36822 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfAYCZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:25:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 87407108AE0B9;
        Thu, 24 Jan 2019 18:25:22 -0800 (PST)
Date:   Thu, 24 Jan 2019 18:25:22 -0800 (PST)
Message-Id: <20190124.182522.1259000615710256514.davem@davemloft.net>
To:     lucien.xin@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        nhorman@tuxdriver.com
Subject: Re: [PATCH net] sctp: improve the events for sctp stream adding
From:   David Miller <davem@davemloft.net>
In-Reply-To: <a4261c440ed5821ddd5943ec7ed163004953d8b8.1548096012.git.lucien.xin@gmail.com>
References: <a4261c440ed5821ddd5943ec7ed163004953d8b8.1548096012.git.lucien.xin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 24 Jan 2019 18:25:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Jan 2019 02:40:12 +0800

> This patch is to improve sctp stream adding events in 2 places:
> 
>   1. In sctp_process_strreset_addstrm_out(), move up SCTP_MAX_STREAM
>      and in stream allocation failure checks, as the adding has to
>      succeed after reconf_timer stops for the in stream adding
>      request retransmission.
> 
>   3. In sctp_process_strreset_addstrm_in(), no event should be sent,
>      as no in or out stream is added here.
> 
> Fixes: 50a41591f110 ("sctp: implement receiver-side procedures for the Add Outgoing Streams Request Parameter")
> Fixes: c5c4ebb3ab87 ("sctp: implement receiver-side procedures for the Add Incoming Streams Request Parameter")
> Reported-by: Ying Xu <yinxu@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Applied and queued up for -stable.
