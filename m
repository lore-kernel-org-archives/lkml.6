Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CA2C282C7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 00:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256BD20C01
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 00:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfA0Abk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 19:31:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfA0Abk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 19:31:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2345FC0467DF;
        Sun, 27 Jan 2019 00:31:40 +0000 (UTC)
Received: from redhat.com (ovpn-120-59.rdu2.redhat.com [10.10.120.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 339F9101E5A5;
        Sun, 27 Jan 2019 00:31:39 +0000 (UTC)
Date:   Sat, 26 Jan 2019 19:31:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH net-next V4 0/5] vhost: accelerate metadata access
 through vmap()
Message-ID: <20190126193126-mutt-send-email-mst@kernel.org>
References: <20190123095557.30168-1-jasowang@redhat.com>
 <20190126.143708.1203048880266877709.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126.143708.1203048880266877709.davem@davemloft.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 27 Jan 2019 00:31:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 02:37:08PM -0800, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Wed, 23 Jan 2019 17:55:52 +0800
> 
> > This series tries to access virtqueue metadata through kernel virtual
> > address instead of copy_user() friends since they had too much
> > overheads like checks, spec barriers or even hardware feature
> > toggling.
> > 
> > Test shows about 24% improvement on TX PPS. It should benefit other
> > cases as well.
> 
> I've read over the discussion of patch #5 a few times.
> 
> And it seems to me that, at a minimum, a few things still need to
> be resolved:
> 
> 1) More perf data added to commit message.
> 
> 2) Whether invalidate_range_start() and invalidate_range_end() must
>    be paired.


Add dirty tracking.

> Etc.  So I am marking this series "Changes Requested".
