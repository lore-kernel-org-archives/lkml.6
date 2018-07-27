Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30EAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E5720842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E5720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389828AbeG0Wgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:36:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39186 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389373AbeG0Wge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:36:34 -0400
Received: from localhost (unknown [172.56.44.110])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3FF16108A9043;
        Fri, 27 Jul 2018 14:12:52 -0700 (PDT)
Date:   Fri, 27 Jul 2018 14:12:49 -0700 (PDT)
Message-Id: <20180727.141249.2268355680445612136.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     petkan@nucleusys.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: pegasus: Replace mdelay() with msleep() in
 setup_pegasus_II()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180727083629.18663-1-baijiaju1990@gmail.com>
References: <20180727083629.18663-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 27 Jul 2018 14:12:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Fri, 27 Jul 2018 16:36:29 +0800

> setup_pegasus_II() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied.
