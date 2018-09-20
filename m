Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BBC21524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BBC21524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbeITLxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:53:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35522 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbeITLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:53:42 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A39C31448D95D;
        Wed, 19 Sep 2018 23:11:57 -0700 (PDT)
Date:   Wed, 19 Sep 2018 23:11:57 -0700 (PDT)
Message-Id: <20180919.231157.1883415235792885935.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com
Subject: Re: [PATCH] isdn/hisax: Remove unnecessary parenthesis
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180920040523.21671-1-natechancellor@gmail.com>
References: <20180920040523.21671-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Sep 2018 23:11:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Wed, 19 Sep 2018 21:05:23 -0700

> Clang warns when more than one set of parentheses are used for single
> conditional statements:
> 
> drivers/isdn/hisax/w6692.c:627:30: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>                 if ((cs->dc.w6692.ph_state == W_L1IND_DRD)) {
>                      ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
> drivers/isdn/hisax/w6692.c:627:30: note: remove extraneous parentheses
> around the comparison to silence this warning
>                 if ((cs->dc.w6692.ph_state == W_L1IND_DRD)) {
>                     ~                      ^             ~
> drivers/isdn/hisax/w6692.c:627:30: note: use '=' to turn this equality
> comparison into an assignment
>                 if ((cs->dc.w6692.ph_state == W_L1IND_DRD)) {
>                                            ^~
>                                            =
> 1 warning generated.
> 
> Remove the parentheses to silence this warning.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
