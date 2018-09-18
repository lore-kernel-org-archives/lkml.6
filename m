Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10AEECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816C520693
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816C520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeIRIQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:16:14 -0400
Received: from nautica.notk.org ([91.121.71.147]:37146 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbeIRIQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:16:14 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 437F5C009; Tue, 18 Sep 2018 04:45:51 +0200 (CEST)
Date:   Tue, 18 Sep 2018 04:45:36 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Miller <davem@davemloft.net>
Cc:     doronrk@fb.com, tom@quantonium.net, davejwatson@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20180918024536.GA2061@nautica>
References: <20180912053642.GA2912@nautica>
 <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica>
 <20180917.194059.1970452340378032090.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180917.194059.1970452340378032090.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote on Mon, Sep 17, 2018:
> Remind me, is there actually any way for the bpf programs run in this
> situation to even _see_ strp_msg(skb)->offset at all?

No, they can see it, so it's possible to make a KCM program that works
right now if you are careful (I'm not sure why the offset within bpf is
different from the offset in the kernel though, it looks like the bpf
program skips the qos part of the control buffer)

> There isn't right?  And the alternate proposal was to add such a
> facility, right?

The problem is that this isn't documented at all, and I could not find
any example doing that until Dave gave me one (I couldn't get it to work
because of the different offset).

The alternate proposal was to just document it, yes.

> Just trying to remember all of the context, maybe it's good
> information to add to the commit message?

Good idea, I'll add some more explanation there.

-- 
Dominique Martinet
