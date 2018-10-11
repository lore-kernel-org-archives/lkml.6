Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E798C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC6A20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC6A20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeJKNAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:00:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49004 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJKNAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:00:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7808212131DE4;
        Wed, 10 Oct 2018 22:34:59 -0700 (PDT)
Date:   Wed, 10 Oct 2018 22:34:58 -0700 (PDT)
Message-Id: <20181010.223458.915344551656019248.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        willemb@google.com
Subject: Re: [PATCH net-next V3] virtio_net: ethtool tx napi configuration
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181009020626.31723-1-jasowang@redhat.com>
References: <20181009020626.31723-1-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 10 Oct 2018 22:34:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue,  9 Oct 2018 10:06:26 +0800

> Implement ethtool .set_coalesce (-C) and .get_coalesce (-c) handlers.
> Interrupt moderation is currently not supported, so these accept and
> display the default settings of 0 usec and 1 frame.
> 
> Toggle tx napi through setting tx-frames. So as to not interfere
> with possible future interrupt moderation, value 1 means tx napi while
> value 0 means not.
> 
> Only allow the switching when device is down for simplicity.
> 
> Link: https://patchwork.ozlabs.org/patch/948149/
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V2:
> - only allow the switching when device is done
> - remove unnecessary global variable and initialization
> Changes from V1:
> - try to synchronize with datapath to allow changing mode when
>   interface is up.
> - use tx-frames 0 as to disable tx napi while tx-frames 1 to enable tx napi

Applied, with...

> +	bool running = netif_running(dev);

this unused variable removed.
