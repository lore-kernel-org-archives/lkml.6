Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6196C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB1820989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB1820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeK0ROx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:14:53 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53484 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeK0ROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:14:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0180E14E0F702;
        Mon, 26 Nov 2018 22:18:04 -0800 (PST)
Date:   Mon, 26 Nov 2018 22:18:04 -0800 (PST)
Message-Id: <20181126.221804.911097813637187592.davem@davemloft.net>
To:     mst@redhat.com
Cc:     tiwei.bie@intel.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [PATCH net-next v3 00/13] virtio: support packed ring
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181127010157-mutt-send-email-mst@kernel.org>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
        <20181127010157-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 26 Nov 2018 22:18:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 27 Nov 2018 01:08:08 -0500

> On Wed, Nov 21, 2018 at 06:03:17PM +0800, Tiwei Bie wrote:
>> Hi,
>> 
>> This patch set implements packed ring support in virtio driver.
>> 
>> A performance test between pktgen (pktgen_sample03_burst_single_flow.sh)
>> and DPDK vhost (testpmd/rxonly/vhost-PMD) has been done, I saw
>> ~30% performance gain in packed ring in this case.
>> 
>> To make this patch set work with below patch set for vhost,
>> some hacks are needed to set the _F_NEXT flag in indirect
>> descriptors (this should be fixed in vhost):
>> 
>> https://lkml.org/lkml/2018/7/3/33
> 
> I went over it and I think it's correct spec-wise.
> 
> I have some ideas for enhancements but let's start
> with getting this stuff merged first.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Series applied.
