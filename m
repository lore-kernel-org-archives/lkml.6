Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3B9C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F6C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfBFRwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:52:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbfBFRwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:52:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D6C1C01DE1B;
        Wed,  6 Feb 2019 17:52:03 +0000 (UTC)
Received: from redhat.com (ovpn-122-237.rdu2.redhat.com [10.10.122.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id A4D0D1048128;
        Wed,  6 Feb 2019 17:52:00 +0000 (UTC)
Date:   Wed, 6 Feb 2019 12:52:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Julien Freche <jfreche@vmware.com>,
        Jason Wang <jasowang@redhat.com>, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/6] vmw_balloon: 64-bit limit support, compaction,
 shrinker
Message-ID: <20190206124926-mutt-send-email-mst@kernel.org>
References: <20190206051336.2425-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206051336.2425-1-namit@vmware.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 06 Feb 2019 17:52:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 09:13:30PM -0800, Nadav Amit wrote:
> Various enhancements for VMware balloon, some of which are remainder
> from a previous patch-set.
> 
> Patch 1: Aumps the version number, following recent changes
> Patch 2: Adds support for 64-bit memory limit
> Patches 3-4: Support for compaction
> Patch 5: Support for memory shrinker - disabled by default
> Patch 6: Split refused pages to improve performance
> 
> Since the 3rd patch requires Michael Tsirkin ack, which has not arrived
> in the last couple of times the patch was sent, please consider applying
> patches 1-2 for 5.1.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: virtualization@lists.linux-foundation.org


I don't seem to have got anything except patch 0 either directly
or through virtualization@lists.linux-foundation.org
Could you bounce the relevant patches there?

Thanks!

> Nadav Amit (5):
>   vmw_balloon: bump version number
>   mm/balloon_compaction: list interfaces
>   vmw_balloon: compaction support
>   vmw_balloon: add memory shrinker
>   vmw_balloon: split refused pages
> 
> Xavier Deguillard (1):
>   vmw_balloon: support 64-bit memory limit
> 
>  drivers/misc/Kconfig               |   1 +
>  drivers/misc/vmw_balloon.c         | 511 ++++++++++++++++++++++++++---
>  include/linux/balloon_compaction.h |   4 +
>  mm/balloon_compaction.c            | 139 +++++---
>  4 files changed, 566 insertions(+), 89 deletions(-)
> 
> -- 
> 2.17.1
