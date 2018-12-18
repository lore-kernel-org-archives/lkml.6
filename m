Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8397DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8AA218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeLRTyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:54:35 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40020 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLRTye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:54:34 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 17A8D141A93FC;
        Tue, 18 Dec 2018 11:54:34 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:54:33 -0800 (PST)
Message-Id: <20181218.115433.2044623159542485583.davem@davemloft.net>
To:     jhansen@vmware.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        gregkh@linuxfoundation.org, pv-drivers@vmware.com
Subject: Re: [PATCH v2] VSOCK: Send reset control packet when socket is
 partially bound
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1545122046-43955-1-git-send-email-jhansen@vmware.com>
References: <1545122046-43955-1-git-send-email-jhansen@vmware.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 11:54:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorgen Hansen <jhansen@vmware.com>
Date: Tue, 18 Dec 2018 00:34:06 -0800

> If a server side socket is bound to an address, but not in the listening
> state yet, incoming connection requests should receive a reset control
> packet in response. However, the function used to send the reset
> silently drops the reset packet if the sending socket isn't bound
> to a remote address (as is the case for a bound socket not yet in
> the listening state). This change fixes this by using the src
> of the incoming packet as destination for the reset packet in
> this case.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reviewed-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>

Applied and queued up for -stable, thanks.
