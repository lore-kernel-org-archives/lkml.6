Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8DAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A1E2190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfBLSiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:38:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56136 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfBLSiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:38:22 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9EBCC14C59DA3;
        Tue, 12 Feb 2019 10:38:21 -0800 (PST)
Date:   Tue, 12 Feb 2019 10:38:21 -0800 (PST)
Message-Id: <20190212.103821.1113180544052186059.davem@davemloft.net>
To:     kal.conley@dectris.com
Cc:     willemb@google.com, edumazet@google.com,
        alexander.h.duyck@intel.com, jeffrey.t.kirsher@intel.com,
        ktkhai@virtuozzo.com, vincent.whitchurch@axis.com,
        lirongqing@baidu.com, magnus.karlsson@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/packet: fix 4gb buffer limit due to overflow
 check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190210085712.31622-1-kal.conley@dectris.com>
References: <20190209.190114.542890373094719579.davem@davemloft.net>
        <20190210085712.31622-1-kal.conley@dectris.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Feb 2019 10:38:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kal Conley <kal.conley@dectris.com>
Date: Sun, 10 Feb 2019 09:57:11 +0100

> When calculating rb->frames_per_block * req->tp_block_nr the result
> can overflow. Check it for overflow without limiting the total buffer
> size to UINT_MAX.
> 
> This change fixes support for packet ring buffers >= UINT_MAX.
> 
> Fixes: 8f8d28e4d6d8 ("net/packet: fix overflow in check for tp_frame_nr")
> Signed-off-by: Kal Conley <kal.conley@dectris.com>
> ---
> Changes in v2:
> - Add Signed-off-by and Fixes tag

Applied and queued up for -stable, thanks.
