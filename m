Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E1021928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389958AbeLUTZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:25:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51634 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389907AbeLUTZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:25:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 667E514B666DD;
        Fri, 21 Dec 2018 11:25:22 -0800 (PST)
Date:   Fri, 21 Dec 2018 11:25:21 -0800 (PST)
Message-Id: <20181221.112521.1449281052807365475.davem@davemloft.net>
To:     tiny.windzz@gmail.com
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        sparclinux@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sunsu: fix refcount leak
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181212160145.23117-1-tiny.windzz@gmail.com>
References: <20181212160145.23117-1-tiny.windzz@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Dec 2018 11:25:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>
Date: Wed, 12 Dec 2018 11:01:45 -0500

> The function of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> 
> su_get_type() doesn't do that. The match node are used as an identifier
> to compare against the current node, so we can directly drop the refcount
> after getting the node from the path as it is not used as pointer.
> 
> Fix this by use a single variable and drop the refcount right after
> of_find_node_by_path().
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied.
