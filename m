Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9941EECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C62C208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C62C208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbeISIpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeISIpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:45:06 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBC0D8553D;
        Wed, 19 Sep 2018 03:09:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 296DD308BDA0;
        Wed, 19 Sep 2018 03:09:14 +0000 (UTC)
Date:   Wed, 19 Sep 2018 11:09:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] lib/percpu-refcount: introduce percpu_ref_resurge()
Message-ID: <20180919030909.GC20560@ming.t460p>
References: <20180918101946.13329-1-ming.lei@redhat.com>
 <20180918101946.13329-3-ming.lei@redhat.com>
 <20180918125021.GB902964@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918125021.GB902964@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Sep 2018 03:09:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 05:50:21AM -0700, Tejun Heo wrote:
> On Tue, Sep 18, 2018 at 06:19:44PM +0800, Ming Lei wrote:
> > Now percpu_ref_reinit() can only be done on one percpu refcounter when it
> > drops zero. And the limit shouldn't be so strict, and it is quite
> > straightforward that we can do it when the refcount doesn't drop zero
> > because it is at atomic mode.
> > 
> > This patch introduces percpu_ref_resurge() in which the above limit is
> > relaxed, so we may avoid extra change[1] for NVMe timeout's requirement.
> 
> For now,
> 
> Nacked-by: Tejun Heo <tj@kernel.org>
> 
> Please see the original discussion thread.

Your comment in that thread supposes that synchronize_rcu() is used for
avoiding race with .release().

But this patchset doesn't use that approach at all for avoiding this
race.

Thanks,
Ming
