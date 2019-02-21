Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AA4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8382080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfBUVFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:05:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42990 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBUVF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:05:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 04F30145D4418;
        Thu, 21 Feb 2019 13:05:28 -0800 (PST)
Date:   Thu, 21 Feb 2019 13:05:28 -0800 (PST)
Message-Id: <20190221.130528.1962020421176856619.davem@davemloft.net>
To:     callum.sinclair@alliedtelesis.co.nz
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v6] ipmr: ip6mr: Create new sockopt to clear
 mfc cache or vifs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190217210752.20914-1-callum.sinclair@alliedtelesis.co.nz>
References: <20190217210752.20914-1-callum.sinclair@alliedtelesis.co.nz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Feb 2019 13:05:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Date: Mon, 18 Feb 2019 10:07:51 +1300

> Created a way to clear the multicast forwarding cache on a socket
> without having to either remove the entries manually using the delete
> entry socket option or destroy and recreate the multicast socket.
> 
> Calling the socket option MRT_FLUSH will allow any combination of the
> four flag options to be cleared.
> 
> MRT_FLUSH_MFC will clear all non static mfc entries and clear the unresolved cache
> MRT_FLUSH_MFC_STATIC will clear all static mfc entries
> MRT_FLUSH_VIFS will clear all non static interfaces
> MRT_FLUSH_VIFS_STATIC will clear all static interfaces.

Applied.
