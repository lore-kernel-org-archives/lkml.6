Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95582C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5177F20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5177F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbeLMF5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:57:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47486 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLMF5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:57:18 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1E2DD14B3D338;
        Wed, 12 Dec 2018 21:57:18 -0800 (PST)
Date:   Wed, 12 Dec 2018 21:57:17 -0800 (PST)
Message-Id: <20181212.215717.702103892928039727.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net V3 0/3] Fix various issue of vhost
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181213025339.14023-1-jasowang@redhat.com>
References: <20181213025339.14023-1-jasowang@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Dec 2018 21:57:18 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Dec 2018 10:53:36 +0800

> This series tries to fix various issues of vhost:
> 
> - Patch 1 adds a missing write barrier between used idx updating and
>   logging.
> - Patch 2-3 brings back the protection of device IOTLB through vq
>   mutex, this fixes possible use after free in device IOTLB entries.
> 
> Please consider them for -stable.
> 
> Thanks
> 
> Changes from V2:
> - drop dirty page fix and make it for net-next
> Changes from V1:
> - silent compiler warning for 32bit.
> - use mutex_trylock() on slowpath instead of mutex_lock() even on fast
>   path.

Series applied and queued up for -stable, thanks Jason.
