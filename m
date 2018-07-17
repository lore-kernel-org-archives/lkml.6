Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0267AECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A712075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AnCI41xU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A712075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbeGQW4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:56:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQW4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JiiGbcorn1nr8ixuuHQ0suH4e4B94m1ukUuorer1+QA=; b=AnCI41xUhgANtdZSeeyjvY2xN
        HC7qOyD//XQJ45iuWjHvUMbxReRCuCiqjeNFUMxkYOnWq3P56s9z22pT2nF97g/cNrgEqwh2lnaIq
        zpf4Y6N/YHsVl60sHh1JaEpxB8vNTRLOLl+aB8p/1UMwuqIH9+j8h7Y+mPZI+Hq+0f0qwAF3CRiAq
        /JyGkPjfT+YWwdjviD/J5BXPzilU9ChSpMZsAMoASKZgARv5tkDYqQHuONOm1dhu9xJS3LCt9eCHX
        TnIWhLKuN9lG28fvc4YRD8OfFRLfuh2TsxAwo3Mu036RJRSP1AYss6dpzs6GmTTAfPhRNHujzbP8c
        UELnq6/bQ==;
Received: from [121.135.244.1] (helo=vela.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffYLO-0000jA-0P; Tue, 17 Jul 2018 22:21:18 +0000
Date:   Wed, 18 Jul 2018 07:21:07 +0900
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     hannah@marvell.com, Jonathan Corbet <corbet@lwn.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josef Griebichler <griebichler.josef@gmx.at>,
        Hannes Frederic Sowa <hannes@redhat.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Ingo Molnar <mingo@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        dma <dmaengine@vger.kernel.org>, vkoul@kernel.org,
        Dan Williams <dan.j.williams@intel.com>, nadavh@marvell.com,
        thomas.petazzoni@bootlin.com, omrii@marvell.com
Subject: Re: dvb usb issues since kernel 4.9
Message-ID: <20180718072107.0bfdece8@vela.lan>
In-Reply-To: <CA+55aFwb5hPtPFbB02SSn+wTkqTDSgHGFkiw7LB57mj42VzyZQ@mail.gmail.com>
References: <CA+55aFwuAojr7vAfiRO-2je-wDs7pu+avQZNhX_k9NN=D7_zVQ@mail.gmail.com>
        <1d3d0fe3-bc02-7720-15ac-6bc06e00067c@marvell.com>
        <CA+55aFwb5hPtPFbB02SSn+wTkqTDSgHGFkiw7LB57mj42VzyZQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Em Tue, 17 Jul 2018 10:09:28 -0700
Linus Torvalds <torvalds@linux-foundation.org> escreveu:

> On Tue, Jul 17, 2018 at 4:58 AM Hanna Hawa <hannah@marvell.com> wrote:
> >
> > After some debug/bisect/diff, found that patch "softirq: Let ksoftirqd
> > do its job" is problematic patch.  
> 
> Ok, this thread died down without any resolution.
> 
> >- Using v4.14.0 (including softirq patch) and the additional fix
> > proposed by Linus - no timeout issue.  
> 
> Are you talking about the patch that made HI_SOFTIRQ and
> TASKLET_SOFTIRQ special, and had this:
> 
>   #define SOFTIRQ_NOW_MASK ((1 << HI_SOFTIRQ) | (1 << TASKLET_SOFTIRQ))
> 
> in it?
> 
> I think I'll just commit the damn thing. It's hacky, but it's simple,
> and it never got applied because we had smarter suggestions. But the
> smarter suggestions never ended up being applied either, so..

Yeah, IMHO the best would be to apply your patch[1], c/c stable up to
4.9. Nothing prevents applying a better/smarter solution once we
have it. From my side, I can keep testing whatever smart suggestions
people propose. Yet, better to have one fix on our hand than two
fixes flying around.

[1] e. g. 
	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=v4.15%2bmedia%2bdwc2&id=ccf833fd4a5b99c3d3cf2c09c065670f74a230a7

Regards,
Mauro
