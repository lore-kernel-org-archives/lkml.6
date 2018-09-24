Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D25C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19D821486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N72Ua5PA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19D821486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbeIXSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:41:46 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37770 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbeIXSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:41:45 -0400
Received: by mail-it1-f195.google.com with SMTP id h20-v6so10229590itf.2;
        Mon, 24 Sep 2018 05:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n0//hVXTNS1DGJH8wyRgkNyLszpkkaC60IjslwhoXow=;
        b=N72Ua5PARZtldHI2+Tzs/Xo974oQJMFin1JUubv8E5+iQ2D3TgxjqOOB9q0PsAaFBd
         9D8tZkJKnakq5KDpVRzp3Futy+x7ciMIax8sQiEU+rfTMXvu8f7OCV27e99iJn0vTKf3
         4evm3oTH6uFglxuGlmVYWHQp3LOOF851goq22R/MBwWS1Rq9PJiHxFRxft5EywN61iCO
         x6qqjeRGn12EYRkF2azKN3P357by2dyWorwGnFRn9DvHNmn2qK4DTp/OxqXOAV5yTzVw
         vnDKjRNhMG1JfM+9p4aafgLeYuncimUHP5TgJkY6B3pu8o+4llgCofgDlkuHFFCjy8i/
         t3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n0//hVXTNS1DGJH8wyRgkNyLszpkkaC60IjslwhoXow=;
        b=UqUk20wfLcpT30KGJ4FS++XXOzEvuvbffbnorNq1sx5uUa22c2uTpFHEHqzCN+RDeB
         tzFzkQjW7SPhyDzUq18CnLQfs9oawxhw+gJfBKpixKLtPAzUGPCmJTtkXaHBKp/2OHoI
         Uo40L27qjCqXU7//jAYnNM1Jd08/khkzy87dHQ2JFjncULm0cL/iO9D8zdt2aecHJm2H
         coRVUtgNFuUynBnTVUIl3F85ONMa5aUv3sehCAMdh/J7MGjyy1M7F4BnrlVFPFn/DES4
         XisUnEft1lOZPajzxqljID6kSW9QfSr8u2y0gdFYdWRpzDhrxtBMIxJxneSUrvd4ZSVz
         jVYA==
X-Gm-Message-State: APzg51DB1H6CMTVavW4f2zIg7lE434cC+srPLEfUEt8ErxE/LLF/Y7dQ
        1DQWr9YC/ml/DZwP2VtK41vRKRInDEvWPJGgV1c=
X-Google-Smtp-Source: ANB0VdbyHF9vrWHOBvKfmRaYkYCMJ09wPmFTHVlj9oLV7M+B7sv0Kd+/lUW2N6uVGpYZih2F7gUBbzX2tF++B7ysK6g=
X-Received: by 2002:a02:c881:: with SMTP id m1-v6mr5532551jao.43.1537792788386;
 Mon, 24 Sep 2018 05:39:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7315:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 05:39:08
 -0700 (PDT)
In-Reply-To: <375c389d-f391-5b72-bc52-9a82d61c6bd7@gmail.com>
References: <1537732141-22468-1-git-send-email-laoar.shao@gmail.com> <375c389d-f391-5b72-bc52-9a82d61c6bd7@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 24 Sep 2018 20:39:08 +0800
Message-ID: <CALOAHbD00L_dNTp=ETh26Wi+Mw-dKt3_PYq2Pc2oS0GiGxkOXA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: expose sk_state in tcp_retransmit_skb tracepoint
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 5:42 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 09/23/2018 12:49 PM, Yafang Shao wrote:
>> With sk_state, we can know whether this connection is in SYN_SENT state
>> or ESTBLISHED state.
>> The reason to distinguish between these two scenario is that the
>> retransmission in ESTABLISHED state always mean network congestion while
>> in SYN_SENT state it always mean server issue, i.e. the syn packet is
>> dropped due to syn backlog queue full.
>
> You mean, a packet drop on the remote peer ?
>

Yes, I mean drop on the remote peer.

> It could also be a packet drop in the network.
>

Yes of course.

> Your patch is good, but changelog is quite misleading.

Will modify the changelog.


Thanks
Yafang
