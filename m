Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F712ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E182B2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E182B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeIRHPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:15:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53776 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeIRHPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:15:10 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6AC9C14621320;
        Mon, 17 Sep 2018 18:45:05 -0700 (PDT)
Date:   Mon, 17 Sep 2018 18:45:02 -0700 (PDT)
Message-Id: <20180917.184502.447385458615284933.davem@davemloft.net>
To:     asmadeus@codewreck.org
Cc:     doronrk@fb.com, tom@quantonium.net, davejwatson@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180912053642.GA2912@nautica>
References: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
        <20180912053642.GA2912@nautica>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 18:45:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <asmadeus@codewreck.org>
Date: Wed, 12 Sep 2018 07:36:42 +0200

> Dominique Martinet wrote on Tue, Sep 11, 2018:
>> Hmm, while trying to benchmark this, I sometimes got hangs in
>> kcm_wait_data() for the last packet somehow?
>> The sender program was done (exited (zombie) so I assumed the sender
>> socket flushed), but the receiver was in kcm_wait_data in kcm_recvmsg
>> indicating it parsed a header but there was no skb to peek at?
>> But the sock is locked so this shouldn't be racy...
>> 
>> I can get it fairly often with this patch and small messages with an
>> offset, but I think it's just because the pull changes some timing - I
>> can't hit it with just the clone, and I can hit it with a pull without
>> clone as well.... And I don't see how pulling a cloned skb can impact
>> the original socket, but I'm a bit fuzzy on this.
> 
> This is weird, I cannot reproduce at all without that pull, even if I
> add another delay there instead of the pull, so it's not just timing...

I really can't apply this patch until you resolve this.

It is weird, given your description, though...
