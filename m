Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B9EC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D412133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfAEWfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:35:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33836 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfAEWfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 17:35:33 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 98AE5145E5995;
        Sat,  5 Jan 2019 14:10:22 -0800 (PST)
Date:   Sat, 05 Jan 2019 14:10:21 -0800 (PST)
Message-Id: <20190105.141021.1299321405902891635.davem@davemloft.net>
To:     ap420073@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@iogearbox.net, ast@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH net 1/4] umh: add exit routine for UMH process
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181230163143.21030-1-ap420073@gmail.com>
References: <20181230163143.21030-1-ap420073@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 05 Jan 2019 14:10:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 31 Dec 2018 01:31:43 +0900

> +void exit_umh(struct task_struct *tsk)
> +{
> +	struct umh_info *info;
> +	pid_t pid = tsk->pid;
> +
> +	mutex_lock(&umh_list_lock);
> +	list_for_each_entry(info, &umh_list, list) {

So this is probably too expensive of a cost for every process exit.
The problem is that the cost will be taken even if the process is
not a UMH.

I've taken my time to respond in hopes that I could come up with a
good alternative to suggest, but so far I don't have any better ideas.

I'll keep thinking about this some more, please let me know if you
have any ideas.
