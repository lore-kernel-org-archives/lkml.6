Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337CDC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C608A20857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+Oo9sGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C608A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIIXWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:22:47 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53767 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeIIXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:22:47 -0400
Received: by mail-it0-f65.google.com with SMTP id p79-v6so26798907itp.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yqq5h6PEbHBqcX3OMbxyqNyRECeqrPDt9D9M8MhzC/Q=;
        b=S+Oo9sGXBFFhVUn/oVl+Ve8VZZnKdq3XYkz8WhmGA8Vz852ODlyVA6PDTfMkXBM4fN
         dOZzyCSPmmZBxCkDYo4e5tBsbQArmfLU9CrEIyCojbN3IWbyWs+swRkn+765EoJ4PZZq
         cdg+8ttVXXcUD7xodDRYRksdgzLqD+PusYLlnCIRmXI+3w1ov8lBzGJZwbVD854N53Al
         o8fLr6Fb0tDTqlMRIuycz9SsovTD9cJhKWJRDPi+vAtODIqHWrsCIKKpSLgWE2w6Mr7v
         fN82V1Wuepbk9TiUorhhNYyju3YOoMZB28ZyR4dHOoOps7utOCNU1xZqrjWm6GcmAq7Z
         YXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yqq5h6PEbHBqcX3OMbxyqNyRECeqrPDt9D9M8MhzC/Q=;
        b=IFTIbbzSCvUyTGtx3SJQ1T1V3257G5Y5gfL9R8u4HMIFFu7bYmkJS4Z6fMmC6/QGeV
         pKdGUKGUFCG5GZa7TUqcDQmo4TYaMF3TRSRdYb3p1Y/OYpUD7LR1eSHZYwsuLbjDgCLy
         IxYudrjoGXPPEa+THbG5FrSnOf1OO789LsX0B4bUwdljR1YwpxSd0Xq/97A3a8CZNSQp
         jr2+p5ZlR3Im9xoEapWKC3cOnIllEa2Vt4IlvuHuyZdpXQaLnNgslZn6X951MvGXrkXD
         EEVlqr4inkRdmCsmHWdCho6BtYAAyNJOROZxvhB+yGLQNPBr1Mcw2PaZ9Z/I8qkNDpEn
         nQQQ==
X-Gm-Message-State: APzg51DGFTpFnKgoC37bsAv+bPRF86adnn6+d8C0ocjzU1lwRD1Y84Tk
        g+KSDwlMcukgIVcSftlCCdDNGt6sjW2QJkMQ/yJN/w==
X-Google-Smtp-Source: ANB0VdaL/ioksFYT2HzJUGgp9YSca9CQfgMuzE6/nnazwBG+VU4YK62GV1jD9B2KzNH4NbLHDnZYZSZMBpr5tJEnz2Y=
X-Received: by 2002:a24:7f87:: with SMTP id r129-v6mr15007531itc.107.1536517935781;
 Sun, 09 Sep 2018 11:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <1536462862-11767-1-git-send-email-laoar.shao@gmail.com> <1536462862-11767-2-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1536462862-11767-2-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 9 Sep 2018 11:32:04 -0700
Message-ID: <CANn89iLN9H8tUhjMh1o0N7Ng8fPuXqQdpgkpBANpLwywaS3kNA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] tcp: fix the error count of tcpInSegs
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 8:14 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> In RFC1213, the tcpInSegs is the total number of segments received.
> While currently it is the total number of SKBs received.
> The number of SKBs may be not equal with the numer of segments because of
> GRO.
> So fix this error count.
>

We have discussed this in the past and the consensus was it was too
late to change this.

IP counters have the same issue, so after your patch, we would have
quite a difference between transport and network layers.

Adding all these max_t(u16, 1, skb_shinfo(skb)->gso_segs)) everywhere add a cost
