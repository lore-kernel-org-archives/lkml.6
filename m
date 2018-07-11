Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27731C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2846213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2846213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389483AbeGKTmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:42:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbeGKTmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:42:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DCD940AC6DE;
        Wed, 11 Jul 2018 19:36:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-75.rdu2.redhat.com [10.10.112.75])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8FABA2026D6B;
        Wed, 11 Jul 2018 19:36:50 +0000 (UTC)
Date:   Wed, 11 Jul 2018 22:36:50 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Wang <wei.w.wang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Message-ID: <20180711223040-mutt-send-email-mst@kernel.org>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
 <5B455D50.90902@intel.com>
 <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
 <20180711092152.GE20050@dhcp22.suse.cz>
 <5B45E17D.2090205@intel.com>
 <20180711110949.GJ20050@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711110949.GJ20050@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 11 Jul 2018 19:36:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 11 Jul 2018 19:36:54 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 01:09:49PM +0200, Michal Hocko wrote:
> But let me note that I am not really convinced how this (or previous)
> approach will really work in most workloads. We tend to cache heavily so
> there is rarely any memory free.

It might be that it's worth flushing the cache when VM is
migrating. Or maybe we should implement virtio-tmem or add
transcendent memory support to the balloon.

-- 
MST
