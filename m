Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEDDC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4DF207E6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4DF207E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeJWK7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:59:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39916 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWK7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:59:02 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 54AC7146CB8F2;
        Mon, 22 Oct 2018 19:37:47 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:37:46 -0700 (PDT)
Message-Id: <20181022.193746.688608612910779105.davem@davemloft.net>
To:     jjk@jjacky.com
Cc:     netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] umh: Add command line to user mode helpers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181020173957.31239-2-jjk@jjacky.com>
References: <CAADnVQ+xFfwV67BRXD0epoTwKz54W3mcYHXVWBd1iWb94p+zpg@mail.gmail.com>
        <20181020173957.31239-1-jjk@jjacky.com>
        <20181020173957.31239-2-jjk@jjacky.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Oct 2018 19:37:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Brunel <jjk@jjacky.com>
Date: Sat, 20 Oct 2018 19:39:56 +0200

> User mode helpers were spawned without a command line, and because
> an empty command line is used by many tools to identify processes as
> kernel threads, this could cause some issues.
> 
> Notably during killing spree on shutdown, since such helper would then
> be skipped (i.e. not killed) which would result in the process remaining
> alive, and thus preventing unmouting of the rootfs (as experienced with
> the bpfilter umh).
> 
> Fixes: 449325b52b7a ("umh: introduce fork_usermode_blob() helper")
> Signed-off-by: Olivier Brunel <jjk@jjacky.com>

Applied.
