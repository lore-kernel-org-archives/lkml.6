Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4BAC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ECB21759
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ECB21759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbeHFW5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:57:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57964 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733134AbeHFW5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:57:08 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D2AC513534D16;
        Mon,  6 Aug 2018 13:46:20 -0700 (PDT)
Date:   Mon, 06 Aug 2018 13:46:20 -0700 (PDT)
Message-Id: <20180806.134620.124956510948789350.davem@davemloft.net>
To:     poros@redhat.com
Cc:     netdev@vger.kernel.org, ivecera@redhat.com,
        sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use Kconfig flag to remove support of deprecated
 BE2/BE3 adapters
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180806121230.23690-1-poros@redhat.com>
References: <20180806121230.23690-1-poros@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Aug 2018 13:46:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Oros <poros@redhat.com>
Date: Mon,  6 Aug 2018 14:12:28 +0200

>   Add flags to remove support of deprecated BE2/BE3 adapters.
>   BE2 disable will reduce .ko size by 2kb and BE3 by 3kb.
>   Disable both will reduce .ko size by 9kb.
> 
>   With dissabled support is also removed coresponding PCI IDs
>   and codepath with [BE2|BE3|BEx]_chip checks.
> 
>   New help style in Kconfig
> 
> Signed-off-by: Petr Oros <poros@redhat.com>

Sorry, I'm not too hot about this.

Imagine being one of the people who has one of these cards.

Pulling out detection and working'ness of devices from a driver
is a big step backwards, and I'm sorry I will don't want to be
part of something that facilitates this.

The S390 folks tried something similar in the past and I reject
those changes too.

Thanks.
