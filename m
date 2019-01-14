Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8743C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C222086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfANKJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:09:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:50168 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfANKJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:09:13 -0500
Received: from p5b1272c6.dip0.t-ipconnect.de ([91.18.114.198] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gizB4-0004xw-Hk; Mon, 14 Jan 2019 11:09:06 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Sandy Huang <hjc@rock-chips.com>,
        kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] drm/rockchip: add missing of_node_put
Date:   Mon, 14 Jan 2019 11:09:05 +0100
Message-ID: <10335721.Px6jQUZGiA@phil>
In-Reply-To: <20190114100556.GC10517@phenom.ffwll.local>
References: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr> <3397932.PmTvevuZIG@phil> <20190114100556.GC10517@phenom.ffwll.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 14. Januar 2019, 11:05:56 CET schrieb Daniel Vetter:
> On Sun, Jan 13, 2019 at 07:48:49PM +0100, Heiko Stuebner wrote:
> > Am Sonntag, 13. Januar 2019, 09:47:43 CET schrieb Julia Lawall:
> > > The device node iterators perform an of_node_get on each iteration, so a
> > > jump out of the loop requires an of_node_put.
> > > 
> > > The semantic patch that fixes this problem is as follows
> > > (http://coccinelle.lip6.fr):
> > > 
> > > // <smpl>
> > > @@
> > > expression root,e;
> > > local idexpression child;
> > > iterator name for_each_child_of_node;
> > > @@
> > > 
> > >  for_each_child_of_node(root, child) {
> > >    ... when != of_node_put(child)
> > >        when != e = child
> > > +  of_node_put(child);
> > > ?  break;
> > >    ...
> > > }
> > > ... when != child
> > > // </smpl>
> > > 
> > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > I've added a fixes+stable tag and applied it to drm-misc-fixes
> 
> All of them or just this one here? These cleanup patches have a high
> chance of falling through cracks, so taking them all usually works out
> better ...

That is the only one I got, so right now I only applied this one in my inbox.
Weekend and such resulted in me not going looking for other ones.

Heiko


