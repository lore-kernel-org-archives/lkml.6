Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C902BC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5B92080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5B92080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeLLXbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:31:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41142 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeLLXbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:31:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8B377149B2E7C;
        Wed, 12 Dec 2018 15:31:35 -0800 (PST)
Date:   Wed, 12 Dec 2018 15:31:34 -0800 (PST)
Message-Id: <20181212.153134.1249380470735153418.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net V2 0/4] Fix various issue of vhost
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181212100819.21295-1-jasowang@redhat.com>
References: <20181212100819.21295-1-jasowang@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Dec 2018 15:31:35 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Dec 2018 18:08:15 +0800

> This series tries to fix various issues of vhost:
> 
> - Patch 1 adds a missing write barrier between used idx updating and
>   logging.
> - Patch 2-3 brings back the protection of device IOTLB through vq
>   mutex, this fixes possible use after free in device IOTLB entries.
> - Patch 4-7 fixes the diry page logging when device IOTLB is
>   enabled. We should done through GPA instead of GIOVA, this was done
>   through intorudce HVA->GPA reverse mapping and convert HVA to GPA
>   during logging dirty pages.
> 
> Please consider them for -stable.
> 
> Thanks
> 
> Changes from V1:
> - silent compiler warning for 32bit.
> - use mutex_trylock() on slowpath instead of mutex_lock() even on fast
>   path.

Hello Jason.

Look like Michael wants you to split out patch #4 and target
net-next with it.

So please do that and respin the first 3 patches here with Michael's
ACKs.

Thanks.
