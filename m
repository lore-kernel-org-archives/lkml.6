Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D96C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD23821527
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J8+MOyZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD23821527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLFSvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:51:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37753 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFSvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:51:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so1366521lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtHJ3kp3x/vlLC5M0AAup4QJTGPpZ1IUQEvR5OziQYA=;
        b=J8+MOyZ7elAOpBFAXOm/DFldjf3bMIRGwHcE9Z2JExH1aRrMhhr7zDbfKJ/330KtDb
         pRXYgGym2+/eJK64Ck6id4J7l8akd2ew+OHirfnBah+Rjo/tZKxU7wrALb3zJ6o47QM3
         03a4JqC5usku3K+Unl40IWLtK/ZBb9YsorTD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtHJ3kp3x/vlLC5M0AAup4QJTGPpZ1IUQEvR5OziQYA=;
        b=B8S1NmQh1ROo/FY/q53kBjdQgSWf12cuzJZ3Q6s6HSkb/bNjncizjfbp19vMvKU2FV
         lzUvM6N4dXC7NvPEEjwgZw1ScuxPAh1Wr6+J3/LKbct06Sv7gNnRy44h6Yfbb0PTqclJ
         YcLMpX11Pq6ZYrJyH8joOOnsakJVSMrLNO1mZW1ZerwIdlQ4cH4hdAidPyQ+c6MlDE2X
         krurKTBe5kl8/vFT2yp28EQw6GWdE4P/qyt2g2we4QoHYDNDgmxtYXnA2pYs4qyFqsnm
         iVqYMDQRiso0R+Kd9GCL1vwffzX+W98EWav6klGLUEyVvqtOc7R/EAlJcWqBnLIkQT77
         Qyjw==
X-Gm-Message-State: AA+aEWbG43EtGmB/e6201hE879bqjsYLxZ8w/6M/NNw2kIJkhnDUJC0e
        wy5YJ1Qu7B5jAfosBNqf84uMQN+NU3s=
X-Google-Smtp-Source: AFSGD/Xxg8B9e1wJ7125gZFoJtHOZJ38JzNydQvfKdSdceTrZep0g+Q0wgiK6bcbwmmhSgnwcJm0Gw==
X-Received: by 2002:a2e:7d15:: with SMTP id y21-v6mr1377634ljc.77.1544122311227;
        Thu, 06 Dec 2018 10:51:51 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id x29-v6sm195853ljb.97.2018.12.06.10.51.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:51:50 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id k19-v6so1321593lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:51:50 -0800 (PST)
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr16949452ljj.120.1544122309785;
 Thu, 06 Dec 2018 10:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20181206153720.10702-1-hch@lst.de> <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
 <20181206184330.GB30039@lst.de>
In-Reply-To: <20181206184330.GB30039@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Dec 2018 10:51:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=aLuvLu++ZcehjDLgZfSqOVK+whecEq_-JP12VQ96sg@mail.gmail.com>
Message-ID: <CAHk-=wh=aLuvLu++ZcehjDLgZfSqOVK+whecEq_-JP12VQ96sg@mail.gmail.com>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, brouer@redhat.com,
        tariqt@mellanox.com, ilias.apalodimas@linaro.org, toke@toke.dk,
        robin.murphy@arm.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 10:43 AM Christoph Hellwig <hch@lst.de> wrote:
>
> >
> >  (a) the dma_is_direct() function/macro uses "likely()" for the test
>
> I'm a little worried about that.  Yes, for the common case it is
> likely.  But if you run a setup where you say always have an iommu
> it is not, in fact it is never called in that case, but we only know
> that at runtime.

Note that "likely()" doesn't have any really huge overhead - it just
makes the compiler move the unlikely case out-of-line.

Compared to the overhead of the indirect branch, it's simply not a
huge deal, it's more a mispredict and cache layout issue.

So marking something "likely()" when it isn't doesn't really penalize
things too much. It's not like an exception or anything like that,
it's really just a marker for better code layout.

                  Linus
