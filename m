Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FD7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A46217AC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A46217AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeHCVoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:44:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38844 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeHCVoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:44:15 -0400
Received: from localhost (unknown [209.201.65.154])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C9AF1400AC22;
        Fri,  3 Aug 2018 12:46:34 -0700 (PDT)
Date:   Fri, 03 Aug 2018 12:46:33 -0700 (PDT)
Message-Id: <20180803.124633.1750627389605139993.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Push iov_iter up from
 rxrpc_kernel_recv_data() to caller
From:   David Miller <davem@davemloft.net>
In-Reply-To: <153331241619.5289.329306820096612046.stgit@warthog.procyon.org.uk>
References: <153331241619.5289.329306820096612046.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 03 Aug 2018 12:46:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Fri, 03 Aug 2018 17:06:56 +0100

> Push iov_iter up from rxrpc_kernel_recv_data() to its caller to allow
> non-contiguous iovs to be passed down, thereby permitting file reading to
> be simplified in the AFS filesystem in a future patch.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied, thanks David.
