Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA94ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4AD205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4AD205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeGRGq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:46:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58202 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeGRGqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:46:25 -0400
Received: from localhost (unknown [172.58.43.84])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ECA1F13FEA155;
        Tue, 17 Jul 2018 23:10:13 -0700 (PDT)
Date:   Wed, 18 Jul 2018 15:10:12 +0900 (KST)
Message-Id: <20180718.151012.1893863248575736713.davem@davemloft.net>
To:     david@lechnology.com
Cc:     petkan@nucleusys.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: rtl8150: demote allmulti message to dev_dbg()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180716225810.30741-1-david@lechnology.com>
References: <20180716225810.30741-1-david@lechnology.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Jul 2018 23:10:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>
Date: Mon, 16 Jul 2018 17:58:10 -0500

> This driver can spam the kernel log with multiple messages of:
> 
>     net eth0: eth0: allmulti set
> 
> Usually 4 or 8 at a time (probably because of using ConnMan).
> 
> This message doesn't seem useful, so let's demote it from dev_info()
> to dev_dbg().
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied, thanks David.
