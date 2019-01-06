Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DEBC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06ABD206B6
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfAFQzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 11:55:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43110 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAFQzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 11:55:44 -0500
Received: from localhost (unknown [198.134.98.50])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0EEBC14BF79E0;
        Sun,  6 Jan 2019 08:55:44 -0800 (PST)
Date:   Sun, 06 Jan 2019 08:55:35 -0800 (PST)
Message-Id: <20190106.085535.1209544587823450673.davem@davemloft.net>
To:     ap420073@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@iogearbox.net, ast@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH net 1/4] umh: add exit routine for UMH process
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAMArcTUGujArU1L8L=n32yKbT+MwuUEm6S8C=am_EGQ5GG3jQA@mail.gmail.com>
References: <20181230163143.21030-1-ap420073@gmail.com>
        <20190105.141021.1299321405902891635.davem@davemloft.net>
        <CAMArcTUGujArU1L8L=n32yKbT+MwuUEm6S8C=am_EGQ5GG3jQA@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 06 Jan 2019 08:55:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 6 Jan 2019 14:34:52 +0900

> How about adding a new PF_UMH flag for task_struct->flags to identify
> UMH process?
> By using this flag, the exit_umh() can avoid unnecessary lookups.

Yes, that might be more efficient and eliminate the high cost for
non-UMH tasks.
