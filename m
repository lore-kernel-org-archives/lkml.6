Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9B2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65DE2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeLRBlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:41:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeLRBlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:41:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C701EC0AE06C;
        Tue, 18 Dec 2018 01:41:38 +0000 (UTC)
Received: from redhat.com (ovpn-120-67.rdu2.redhat.com [10.10.120.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C7236FF02;
        Tue, 18 Dec 2018 01:41:36 +0000 (UTC)
Date:   Mon, 17 Dec 2018 20:41:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     gchen chen <gchen.guomin@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jason Wang <jasowang@redhat.com>,
        gchen <guominchen@tencent.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] Export mm_update_next_owner function for vhost-net
Message-ID: <20181217204124-mutt-send-email-mst@kernel.org>
References: <1544676445-14897-1-git-send-email-gchen.guomin@gmail.com>
 <20181217113254.GA6971@infradead.org>
 <CAEEwsfQ9ARxJCZxy5bY70Aa0HYqwto-gROxT8fvrduNn0MVf=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEwsfQ9ARxJCZxy5bY70Aa0HYqwto-gROxT8fvrduNn0MVf=A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 18 Dec 2018 01:41:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:39:16AM +0800, gchen chen wrote:
> Yes, I think so. 
> and i think the point is that unuse_mm() can't directly set tsk->mm=NULL.

So why can't unuse_mm call mm_update_next_owner?

-- 
MST
