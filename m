Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90015C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695EF206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbeLQTPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:15:22 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42162 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732996AbeLQTPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:15:22 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 62A3910199D51;
        Mon, 17 Dec 2018 11:15:21 -0800 (PST)
Date:   Mon, 17 Dec 2018 11:15:20 -0800 (PST)
Message-Id: <20181217.111520.2080670078373730186.davem@davemloft.net>
To:     jhansen@vmware.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        gregkh@linuxfoundation.org, pv-drivers@vmware.com
Subject: Re: [PATCH] VSOCK: Send reset control packet when socket is
 partially bound
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1544607539-52634-1-git-send-email-jhansen@vmware.com>
References: <1544607539-52634-1-git-send-email-jhansen@vmware.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Dec 2018 11:15:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorgen Hansen <jhansen@vmware.com>
Date: Wed, 12 Dec 2018 01:38:59 -0800

>  static int vmci_transport_send_reset_bh(struct sockaddr_vm *dst,
> @@ -312,12 +328,29 @@ static int vmci_transport_send_reset_bh(struct sockaddr_vm *dst,
>  static int vmci_transport_send_reset(struct sock *sk,
>  				     struct vmci_transport_packet *pkt)
>  {
> +	struct sockaddr_vm dst;
> +	struct sockaddr_vm *dst_ptr;
> +	struct vsock_sock *vsk;
> +

Please order local variables from longest to shortest line.

Thank you.
