Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24179C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D514208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbeLNVg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:36:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34376 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeLNVg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:36:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BFB2714DF1CB4;
        Fri, 14 Dec 2018 13:36:57 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:36:57 -0800 (PST)
Message-Id: <20181214.133657.253891930157421703.davem@davemloft.net>
To:     wen.yang99@zte.com.cn
Cc:     tlfalcon@linux.ibm.com, jallen@linux.ibm.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, cheng.shengyu@zte.com.cn
Subject: Re: [PATCH] net/ibmvnic: Remove tests of member address
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181211042046.64810-1-wen.yang99@zte.com.cn>
References: <20181211042046.64810-1-wen.yang99@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 13:36:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>
Date: Tue, 11 Dec 2018 12:20:46 +0800

> The driver was checking for non-NULL address.
> - adapter->napi[i]
> 
> This is pointless as these will be always non-NULL, since the
> 'dapter->napi' is allocated in init_napi().
> It is safe to get rid of useless checks for addresses to fix the
> coccinelle warning:
>>>drivers/net/ethernet/ibm/ibmvnic.c: test of a variable/field address
> Since such statements always return true, they are redundant.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>

Applied.
