Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A4FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0ED205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfAQNe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:34:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfAQNe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:34:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFC7E9E62D;
        Thu, 17 Jan 2019 13:34:57 +0000 (UTC)
Received: from redhat.com (ovpn-122-124.rdu2.redhat.com [10.10.122.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 376D45DD7B;
        Thu, 17 Jan 2019 13:34:57 +0000 (UTC)
Date:   Thu, 17 Jan 2019 08:34:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: bulk free tx skbs
Message-ID: <20190117083429-mutt-send-email-mst@kernel.org>
References: <20190115012847.14730-1-mst@redhat.com>
 <20190116.153158.1210819126964530944.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190116.153158.1210819126964530944.davem@davemloft.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 17 Jan 2019 13:34:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:31:58PM -0800, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Mon, 14 Jan 2019 20:34:26 -0500
> 
> > Use napi_consume_skb() to get bulk free.  Note that napi_consume_skb is
> > safe to call in a non-napi context as long as the napi_budget flag is
> > correct.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > My perf testing setup is down but it works fine on my devel box and
> > should be fairly uncontroversial.
> 
> It would be uncontroversial if it compiled.
> 
> drivers/net/virtio_net.c: In function ‘free_old_xmit_skbs’:
> drivers/net/virtio_net.c:1346:25: error: ‘use_napi’ undeclared (first use in this function); did you mean ‘used_math’?
>    napi_consume_skb(skb, use_napi);
>                          ^~~~~~~~
>                          used_math
> drivers/net/virtio_net.c:1346:25: note: each undeclared identifier is reported only once for each function it appears in

Yes my bad it was on top of other patches.
I'm rebasing and will repost.

-- 
MST
