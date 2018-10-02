Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4738C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7626820684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7626820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJBM5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:57:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38116 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeJBM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:57:11 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 792281414D36D;
        Mon,  1 Oct 2018 23:15:38 -0700 (PDT)
Date:   Mon, 01 Oct 2018 23:15:37 -0700 (PDT)
Message-Id: <20181001.231537.589368056102755607.davem@davemloft.net>
To:     haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Cc:     netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hv_netvsc: Fix rndis_per_packet_info internal
 field initialization
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180928144123.11926-1-haiyangz@linuxonhyperv.com>
References: <20180928144123.11926-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Oct 2018 23:15:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Fri, 28 Sep 2018 14:41:23 +0000

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> The RSC feature -- a bit field "internal" was added here with total
> size unchanged:
> struct rndis_per_packet_info {
> 	u32 size;
> 	u32 type:31;
> 	u32 internal:1;
> 	u32 ppi_offset;
> };
> 
> On TX path, we put rndis msg into skb head room, which is not zeroed
> before passing to us. We do not use the "internal" field in TX path,
> but it may impact older hosts which use the entire 32 bits as "type".
> 
> To fix the bug, this patch sets the field "internal" to zero.
> 
> Fixes: c8e4eff4675f ("hv_netvsc: Add support for LRO/RSC in the vSwitch")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied.
