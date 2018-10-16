Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D674DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0A820869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0A820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeJPNrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:47:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44256 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeJPNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:47:23 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8D2B312106D9E;
        Mon, 15 Oct 2018 22:58:35 -0700 (PDT)
Date:   Mon, 15 Oct 2018 22:58:34 -0700 (PDT)
Message-Id: <20181015.225834.379019312137427646.davem@davemloft.net>
To:     haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Cc:     netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v3] hv_netvsc: fix vf serial matching with pci
 slot info
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181015190615.30628-1-haiyangz@linuxonhyperv.com>
References: <20181015190615.30628-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 22:58:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Mon, 15 Oct 2018 19:06:15 +0000

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> The VF device's serial number is saved as a string in PCI slot's
> kobj name, not the slot->number. This patch corrects the netvsc
> driver, so the VF device can be successfully paired with synthetic
> NIC.
> 
> Fixes: 00d7ddba1143 ("hv_netvsc: pair VF based on serial number")
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied.
