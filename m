Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97557C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69696218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfAYGdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:33:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38316 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfAYGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:33:41 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B25781449B3B6;
        Thu, 24 Jan 2019 22:33:40 -0800 (PST)
Date:   Thu, 24 Jan 2019 22:33:40 -0800 (PST)
Message-Id: <20190124.223340.1801961504003089813.davem@davemloft.net>
To:     zhang.run@zte.com.cn
Cc:     marcel.ziswiler@toradex.com, lynxis@fe80.eu,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn
Subject: Re: [PATCH] net: usb: asix: ax88772_bind return error when
 hw_reset fail
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1548308929-7727-1-git-send-email-zhang.run@zte.com.cn>
References: <1548308929-7727-1-git-send-email-zhang.run@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 24 Jan 2019 22:33:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Run <zhang.run@zte.com.cn>
Date: Thu, 24 Jan 2019 13:48:49 +0800

> The ax88772_bind() should return error code immediately when the PHY
> was not reset properly through ax88772a_hw_reset().
> Otherwise, The asix_get_phyid() will block when get the PHY 
> Identifier from the PHYSID1 MII registers through asix_mdio_read() 
> due to the PHY isn't ready. Furthermore, it will produce a lot of 
> error message cause system crash.As follows:
> asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
>  reg index 0x0000: -71
> asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to send
>  software reset: ffffffb9
> asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
>  reg index 0x0000: -71
> asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to enable
>  software MII access
> asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to read
>  reg index 0x0000: -71
> asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
>  reg index 0x0000: -71
> asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to enable
>  software MII access
> asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to read
>  reg index 0x0000: -71
> ... 
> 
> Signed-off-by: Zhang Run <zhang.run@zte.com.cn>
> Reviewed-by: Yang Wei <yang.wei9@zte.com.cn>

Applied.
