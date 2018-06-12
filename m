Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42E3FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC0F2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC0F2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934944AbeFLWn0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:43:26 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:42960 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934418AbeFLWnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:43:25 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C61E100AB041;
        Tue, 12 Jun 2018 15:43:25 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:43:24 -0700 (PDT)
Message-Id: <20180612.154324.84720221873990983.davem@davemloft.net>
To:     jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        netdev@vger.kernel.org, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2] xen/netfront: raise max number of slots in
 xennet_get_responses()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180612065753.10569-1-jgross@suse.com>
References: <20180612065753.10569-1-jgross@suse.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Jun 2018 15:43:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>
Date: Tue, 12 Jun 2018 08:57:53 +0200

> The max number of slots used in xennet_get_responses() is set to
> MAX_SKB_FRAGS + (rx->status <= RX_COPY_THRESHOLD).
> 
> In old kernel-xen MAX_SKB_FRAGS was 18, while nowadays it is 17. This
> difference is resulting in frequent messages "too many slots" and a
> reduced network throughput for some workloads (factor 10 below that of
> a kernel-xen based guest).
> 
> Replacing MAX_SKB_FRAGS by XEN_NETIF_NR_SLOTS_MIN for calculation of
> the max number of slots to use solves that problem (tests showed no
> more messages "too many slots" and throughput was as high as with the
> kernel-xen based guest system).
> 
> Replace MAX_SKB_FRAGS-2 by XEN_NETIF_NR_SLOTS_MIN-1 in
> netfront_tx_slot_available() for making it clearer what is really being
> tested without actually modifying the tested value.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Applied, thanks.
