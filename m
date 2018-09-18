Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76EAECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4553D214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4553D214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeIRH1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:27:49 -0400
Received: from nautica.notk.org ([91.121.71.147]:53241 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbeIRH1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:27:47 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 63194C009; Tue, 18 Sep 2018 03:57:38 +0200 (CEST)
Date:   Tue, 18 Sep 2018 03:57:23 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Miller <davem@davemloft.net>
Cc:     doronrk@fb.com, tom@quantonium.net, davejwatson@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20180918015723.GA26300@nautica>
References: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
 <20180912053642.GA2912@nautica>
 <20180917.184502.447385458615284933.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180917.184502.447385458615284933.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote on Mon, Sep 17, 2018:
> From: Dominique Martinet <asmadeus@codewreck.org>
> Date: Wed, 12 Sep 2018 07:36:42 +0200
> 
> > Dominique Martinet wrote on Tue, Sep 11, 2018:
> >> Hmm, while trying to benchmark this, I sometimes got hangs in
> >> kcm_wait_data() for the last packet somehow?
> >> The sender program was done (exited (zombie) so I assumed the sender
> >> socket flushed), but the receiver was in kcm_wait_data in kcm_recvmsg
> >> indicating it parsed a header but there was no skb to peek at?
> >> But the sock is locked so this shouldn't be racy...
> >> 
> >> I can get it fairly often with this patch and small messages with an
> >> offset, but I think it's just because the pull changes some timing - I
> >> can't hit it with just the clone, and I can hit it with a pull without
> >> clone as well.... And I don't see how pulling a cloned skb can impact
> >> the original socket, but I'm a bit fuzzy on this.
> > 
> > This is weird, I cannot reproduce at all without that pull, even if I
> > add another delay there instead of the pull, so it's not just timing...
> 
> I really can't apply this patch until you resolve this.
> 
> It is weird, given your description, though...

Thanks for the reminder! I totally agree with you here and did not
expect this to be merged as it is (in retrospect, I probably should have
written something to that extent in the subject, "RFC"?)

I really don't have much time to give to that right now as I'm doing
this on my freetime, and the lack of reply has been rather demotivating
so it got pushed back a few times...
Given you did reply now I'll try to spend some time to figure that out
in the next couple of weeks but it might not make it for this cycle
depending on the number of rc we'll get and time you want this to soak
it -next.


(I can start by putting the pull back in netparser and try to reproduce,
it's really weird that I never got it to happen at the time...)

-- 
Dominique
