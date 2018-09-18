Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44C0ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928DD21473
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928DD21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeIRILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:11:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54474 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:11:18 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C12B91462E2D6;
        Mon, 17 Sep 2018 19:40:59 -0700 (PDT)
Date:   Mon, 17 Sep 2018 19:40:59 -0700 (PDT)
Message-Id: <20180917.194059.1970452340378032090.davem@davemloft.net>
To:     asmadeus@codewreck.org
Cc:     doronrk@fb.com, tom@quantonium.net, davejwatson@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180918015723.GA26300@nautica>
References: <20180912053642.GA2912@nautica>
        <20180917.184502.447385458615284933.davem@davemloft.net>
        <20180918015723.GA26300@nautica>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 19:41:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <asmadeus@codewreck.org>
Date: Tue, 18 Sep 2018 03:57:23 +0200

> Given you did reply now I'll try to spend some time to figure that out
> in the next couple of weeks but it might not make it for this cycle
> depending on the number of rc we'll get and time you want this to soak
> it -next.

Great.

Remind me, is there actually any way for the bpf programs run in this
situation to even _see_ strp_msg(skb)->offset at all?

There isn't right?  And the alternate proposal was to add such a
facility, right?

Just trying to remember all of the context, maybe it's good
information to add to the commit message?
