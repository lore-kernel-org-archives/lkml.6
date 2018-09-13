Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CF2C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E083220861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E083220861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeINFoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:44:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56350 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeINFoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:44:19 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 22370140C2BD4;
        Thu, 13 Sep 2018 17:32:28 -0700 (PDT)
Date:   Thu, 13 Sep 2018 16:53:39 -0700 (PDT)
Message-Id: <20180913.165339.1563703982938238294.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     netdev@vger.kernel.org, benh@kernel.crashing.org,
        chunkeey@gmail.com, ivan@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ibm/emac: Remove VLA usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180913212356.GA37936@beast>
References: <20180913212356.GA37936@beast>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 17:32:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Thu, 13 Sep 2018 14:23:56 -0700

> In the quest to remove all stack VLA usage from the kernel[1], this
> removes the VLA used for the emac xaht registers size. Since the size
> of registers can only ever be 4 or 8, as detected in emac_init_config(),
> the max can be hardcoded and a runtime test added for robustness.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Christian Lamparter <chunkeey@gmail.com>
> Cc: Ivan Mikhaylov <ivan@de.ibm.com>
> Cc: netdev@vger.kernel.org
> Co-developed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to net-next, thanks.
