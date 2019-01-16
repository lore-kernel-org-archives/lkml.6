Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D974FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD00E20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfAPViv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:38:51 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45090 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbfAPViu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:38:50 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A6514126662E6;
        Wed, 16 Jan 2019 13:38:49 -0800 (PST)
Date:   Wed, 16 Jan 2019 13:38:49 -0800 (PST)
Message-Id: <20190116.133849.1334161442048173947.davem@davemloft.net>
To:     lucien.xin@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        nhorman@tuxdriver.com, glider@google.com
Subject: Re: [PATCH net] sctp: allocate sctp_sockaddr_entry with kzalloc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <b1033e296052216772051e87ba5aa61bfc222076.1547462042.git.lucien.xin@gmail.com>
References: <b1033e296052216772051e87ba5aa61bfc222076.1547462042.git.lucien.xin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 Jan 2019 13:38:50 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 14 Jan 2019 18:34:02 +0800

> The similar issue as fixed in Commit 4a2eb0c37b47 ("sctp: initialize
> sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event") also exists
> in sctp_inetaddr_event, as Alexander noticed.
> 
> To fix it, allocate sctp_sockaddr_entry with kzalloc for both sctp
> ipv4 and ipv6 addresses, as does in sctp_v4/6_copy_addrlist().
> 
> Reported-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Applied and queued up for -stable.
