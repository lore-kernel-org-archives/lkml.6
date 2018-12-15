Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDBEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D902084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbeLOVPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 16:15:08 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55778 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeLOVPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 16:15:08 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7AC0014E8B9BD;
        Sat, 15 Dec 2018 13:15:07 -0800 (PST)
Date:   Sat, 15 Dec 2018 13:15:06 -0800 (PST)
Message-Id: <20181215.131506.1592727721701772545.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] vhost: access vq metadata through kernel
 virtual address
From:   David Miller <davem@davemloft.net>
In-Reply-To: <d70c5ac1-c805-cefd-ace1-643a2e271ba0@redhat.com>
References: <20181213101022.12475-4-jasowang@redhat.com>
        <20181213102713-mutt-send-email-mst@kernel.org>
        <d70c5ac1-c805-cefd-ace1-643a2e271ba0@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 13:15:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Dec 2018 11:57:35 +0800

> This is the price of all GUP users not only vhost itself. What's more
> important, the goal is not to be left too much behind for other
> backends like DPDK or AF_XDP (all of which are using GUP).

+1
