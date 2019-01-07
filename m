Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3568DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D86921738
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfAGD27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:28:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfAGD26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:28:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7081887628;
        Mon,  7 Jan 2019 03:28:58 +0000 (UTC)
Received: from redhat.com (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 738321057049;
        Mon,  7 Jan 2019 03:28:57 +0000 (UTC)
Date:   Sun, 6 Jan 2019 22:28:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [RFC PATCH V3 0/5] Hi:
Message-ID: <20190106221832-mutt-send-email-mst@kernel.org>
References: <20181229124656.3900-1-jasowang@redhat.com>
 <20190102154038-mutt-send-email-mst@kernel.org>
 <0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 07 Jan 2019 03:28:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:19:03AM +0800, Jason Wang wrote:
> 
> On 2019/1/3 上午4:47, Michael S. Tsirkin wrote:
> > On Sat, Dec 29, 2018 at 08:46:51PM +0800, Jason Wang wrote:
> > > This series tries to access virtqueue metadata through kernel virtual
> > > address instead of copy_user() friends since they had too much
> > > overheads like checks, spec barriers or even hardware feature
> > > toggling.
> > Will review, thanks!
> > One questions that comes to mind is whether it's all about bypassing
> > stac/clac.  Could you please include a performance comparison with
> > nosmap?
> > 
> 
> On machine without SMAP (Sandy Bridge):
> 
> Before: 4.8Mpps
> 
> After: 5.2Mpps

OK so would you say it's really unsafe versus safe accesses?
Or would you say it's just a better written code?

> On machine with SMAP (Broadwell):
> 
> Before: 5.0Mpps
> 
> After: 6.1Mpps
> 
> No smap: 7.5Mpps
> 
> 
> Thanks


no smap being before or after?

-- 
MST
