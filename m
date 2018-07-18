Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B7BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEA62075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEA62075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeGREpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:45:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56850 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeGREpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:45:44 -0400
Received: from localhost (unknown [172.58.43.84])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5A28F100851F1;
        Tue, 17 Jul 2018 21:09:53 -0700 (PDT)
Date:   Wed, 18 Jul 2018 13:09:52 +0900 (KST)
Message-Id: <20180718.130952.1583275621144007884.davem@davemloft.net>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com, tiwei.bie@intel.com,
        maxime.coquelin@redhat.com
Subject: Re: [PATCH net-next V2 0/8] Packed virtqueue support for vhost
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180716154102-mutt-send-email-mst@kernel.org>
References: <20180716113720-mutt-send-email-mst@kernel.org>
        <33f4643f-f226-0389-1f4f-607c289db94e@redhat.com>
        <20180716154102-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Jul 2018 21:09:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 16 Jul 2018 15:49:04 +0300

> I'm not sure I understand this approach. Packed ring is just an
> optimization.  What value is there in merging it if it does not help
> speed?

So it seems that both Tiwei's and Jason's packed patch sets are kind
of in limbo due to this discussion.

If I understand Jason correctly, he's trying to say that although this
work doesn't show improvements by itself, however it paves the way
such that optimizaations done in the future will be more visible.

I kind of can see Michael's viewpoint too, in that we should put this
stuff in later when it does actually show some difference.

Therefore, I'll mark both patch sets as "deferred" for now.

Let me know if I should do something else.

Thanks!
