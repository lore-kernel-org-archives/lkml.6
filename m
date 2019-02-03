Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A41C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC93217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfBCTGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 14:06:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42756 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfBCTGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 14:06:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 74C1114C0959F;
        Sun,  3 Feb 2019 11:06:44 -0800 (PST)
Date:   Sun, 03 Feb 2019 11:06:41 -0800 (PST)
Message-Id: <20190203.110641.1343135792694929353.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     stefanha@redhat.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] vsock/virtio: fix issues on device hot-unplug
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190201114207.97217-1-sgarzare@redhat.com>
References: <20190201114207.97217-1-sgarzare@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Feb 2019 11:06:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri,  1 Feb 2019 12:42:05 +0100

> These patches try to handle the hot-unplug of vsock virtio transport device in
> a proper way.
> 
> Maybe move the vsock_core_init()/vsock_core_exit() functions in the module_init
> and module_exit of vsock_virtio_transport module can't be the best way, but the
> architecture of vsock_core forces us to this approach for now.
> 
> The vsock_core proto_ops expect a valid pointer to the transport device, so we
> can't call vsock_core_exit() until there are open sockets.
> 
> v2 -> v3:
>  - Rebased on master
> 
> v1 -> v2:
>  - Fixed commit message of patch 1.
>  - Added Reviewed-by, Acked-by tags by Stefan

Series applied.
