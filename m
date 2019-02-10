Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F19C282C4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 03:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCFD21929
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 03:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBJDBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 22:01:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51242 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBJDBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 22:01:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CED4814B545F4;
        Sat,  9 Feb 2019 19:01:14 -0800 (PST)
Date:   Sat, 09 Feb 2019 19:01:14 -0800 (PST)
Message-Id: <20190209.190114.542890373094719579.davem@davemloft.net>
To:     kal.conley@dectris.com
Cc:     willemb@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, jeffrey.t.kirsher@intel.com,
        alexander.h.duyck@intel.com, ktkhai@virtuozzo.com,
        vincent.whitchurch@axis.com, lirongqing@baidu.com,
        magnus.karlsson@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/packet: fix 4gb buffer limit due to overflow check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190209203701.27252-1-kal.conley@dectris.com>
References: <20190209203701.27252-1-kal.conley@dectris.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 09 Feb 2019 19:01:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kal Conley <kal.conley@dectris.com>
Date: Sat,  9 Feb 2019 21:37:00 +0100

> When calculating rb->frames_per_block * req->tp_block_nr the result
> can overflow. Check it for overflow without limiting the total buffer
> size to UINT_MAX.
> 
> This change fixes support for packet ring buffers >= UINT_MAX.

Please resubmit with a proper signoff and also an appropriate Fixes:
tag.
