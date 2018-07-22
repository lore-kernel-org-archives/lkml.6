Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB207C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632E320874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632E320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeGVRyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:54:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730042AbeGVRyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:54:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFC117A7E0;
        Sun, 22 Jul 2018 16:56:50 +0000 (UTC)
Received: from redhat.com (ovpn-120-237.rdu2.redhat.com [10.10.120.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 61C4679A9;
        Sun, 22 Jul 2018 16:56:44 +0000 (UTC)
Date:   Sun, 22 Jul 2018 19:56:43 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com,
        maxime.coquelin@redhat.com
Subject: Re: [PATCH net-next V2 0/8] Packed virtqueue support for vhost
Message-ID: <20180722194843-mutt-send-email-mst@kernel.org>
References: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
 <20180716113720-mutt-send-email-mst@kernel.org>
 <33f4643f-f226-0389-1f4f-607c289db94e@redhat.com>
 <20180716154102-mutt-send-email-mst@kernel.org>
 <5ba5c927-a0b4-f399-7a88-b90763765142@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba5c927-a0b4-f399-7a88-b90763765142@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sun, 22 Jul 2018 16:56:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sun, 22 Jul 2018 16:56:50 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 08:45:16AM +0800, Jason Wang wrote:
> > I'm not sure I understand this approach. Packed ring is just an optimization.
> > What value is there in merging it if it does not help speed?
> 
> If you want to support migration from dpdk or vDPA backend.

Migration from dpdk is a mess: if you add new features you
fix migration from new one but break migration from old one.
So I'm not too worried until dpdk guys implement one of
the migration versioning proposals that have been floating
around for years.

I think vDPAs are using split ring right now. They will likely
switch to packed ring in the future, but it will probably
take some time before they do.

> And we still
> have the chance to see the performance with virito-net pmd in the future. If
> this does not make sense for you, I will leave this series until we can get
> results from virtio-net pmd (or find a way that packed virtqueue
> outperform).

This makes sense to me. If there's a gain that is only
observed with the pmd driver, I think that's still fine,
but we do need to see it.

> And I will start to post other optimizations on vhost.
> 
> Thanks

Thanks a lot!

-- 
MST
