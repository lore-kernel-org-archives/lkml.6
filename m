Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACFE21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfA3Bgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:36:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbfA3Bgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:36:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE7632D7F0;
        Wed, 30 Jan 2019 01:36:37 +0000 (UTC)
Received: from redhat.com (ovpn-123-79.rdu2.redhat.com [10.10.123.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id EA52A5C2E6;
        Wed, 30 Jan 2019 01:36:31 +0000 (UTC)
Date:   Tue, 29 Jan 2019 20:36:31 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     jasowang@redhat.com, stefanha@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: fix OOB in get_rx_bufs()
Message-ID: <20190129203157-mutt-send-email-mst@kernel.org>
References: <20190128.225444.1929870241029842289.davem@davemloft.net>
 <20190129175145-mutt-send-email-mst@kernel.org>
 <20190129.151026.358327408932275252.davem@davemloft.net>
 <20190129.153810.493942539151548676.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129.153810.493942539151548676.davem@davemloft.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 30 Jan 2019 01:36:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:38:10PM -0800, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 29 Jan 2019 15:10:26 -0800 (PST)
> 
> > Yeah the CVE pushed my hand a little bit, and I knew I was going to
> > send Linus a pull request today because David Watson needs some TLS
> > changes in net-next.
> 
> I also want to make a general comment.... for the record.
> 
> If I let patches slip consistently past 24 hours my backlog is
> unmanageable.  Even with aggressively applying things quickly I'm
> right now at 70-75.  If I do not do what I am doing, then it's in the
> 100-150 range.
> 
> So I am at the point where I often must move forward with patches that
> I think I personally can verify and vet on my own.

If it helps I can include most virtio stuff in my pull requests instead.
Or if that can't work since there's too often a dependency on net-next,
maybe Jason wants to create a tree and send pull requests to you.  Let
us know if that will help, and which of the options looks better from
your POV.

-- 
MST
