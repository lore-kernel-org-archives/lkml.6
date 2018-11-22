Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED2DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9C520864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej2i4XMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9C520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392334AbeKVRhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:37:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbeKVRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:37:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so1270166pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 22:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tXk/Ip4jQz/WKT17CfBtE3AcIWzJODmjTMo36/daKds=;
        b=ej2i4XMBRxZh3SDJnbjRLaLHwS3RbD/KneT4jGu47TABfZVLGlUVbHsNlrGQ4krv09
         YxDlJM8f2B9ketHgDRcbOBYeXY1wn4zYiC2Bz9Nya/QdHyiIq6jBjIIDxETLr5riUUde
         MnQurt4XN+i5Flc67nKq/U1nU7xoPZTqlS88/2H8XTQo6oxg/azqzMLoVPB8IS4ZTP/q
         UNITjItaBvc0A+q+uOwF6o4nXXaFSKelDEEdfRB/ydFRdIbqqQToWI0IW3nS4QbK5bfX
         uqKNw9uhcjyS71nqF96iOJfY1Mkwn65s5vfr9dmYPnKt5nmNSOkjDRY4jMXeRt+dWuwO
         /srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tXk/Ip4jQz/WKT17CfBtE3AcIWzJODmjTMo36/daKds=;
        b=KyrV7jU1evtnJfN1KWEK+km6lRhY0+Ptcaze57uJg0DHTDkCoGTIMg/Dr0rVLOdGuA
         xO2gi2JMrFce85AZvtDO4gFbQQ/vRcWwa96E4n1BL45cH03vMyK1cIzdId1+OjGMnz1v
         TPOuXbEMuftu9yOoqJOSxGt1ZIeMtuQ/6T3ODrni+Uuo78tpxBFq4dL1dXRL3q1hVRGo
         2iYlrgGX+yMfaBT0aNOOjtAsUofvKA1Dw+jkogbcjqxKCKAQ44FwtUerFsp8wjkn8vjE
         GylI4NI/s0TbQ6mX4Zym5AFWxg4uqssbPP+U+ssw/Y5Gr+VmMzcPpsuMN0Tj43pQBdgg
         BZZw==
X-Gm-Message-State: AA+aEWbXvI8D6bSM9/mm11/TRJ0/VezepHUxCquOBUM8Ah5Akr/7RLpY
        7v126jWHJN+T+uX8R+mPyBs=
X-Google-Smtp-Source: AFSGD/WvEo+YoAQCUaqltEcrTtjuv+7JSE6mSpx1gwezrb3G6uERlA/ySezIT+2areyPvLvTnRMw6A==
X-Received: by 2002:a63:507:: with SMTP id 7mr5802218pgf.411.1542869971344;
        Wed, 21 Nov 2018 22:59:31 -0800 (PST)
Received: from localhost ([175.223.27.1])
        by smtp.gmail.com with ESMTPSA id 5-v6sm57369963pfg.141.2018.11.21.22.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 22:59:30 -0800 (PST)
Date:   Thu, 22 Nov 2018 15:59:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] zram: support idle page writeback
Message-ID: <20181122065926.GG3441@jagdpanzerIV>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-5-minchan@kernel.org>
 <20181121045551.GC599@jagdpanzerIV>
 <20181121133408.GA103278@google.com>
 <20181122021442.GB3441@jagdpanzerIV>
 <20181122050437.GA182024@google.com>
 <20181122054040.GE3441@jagdpanzerIV>
 <20181122061542.GA211816@google.com>
 <20181122063103.GB211816@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122063103.GB211816@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/22/18 15:31), Minchan Kim wrote:
> > 
> > I got what you mean now. Let's call it as "incompressible page wrieback"
> > to prevent confusing.
> > 
> > "incompressible page writeback" would be orthgonal feature. The goal is
> > "let's save memory at the cost of *latency*". If the page is swapped-in
> > soon, it's unfortunate. However, the design expects once it's swapped out,
> > it means it's non-workingset so soonish swappined-in would be rather not
> > many, theoritically compared to other workingset.
> > If's it's too frequent, it means system were heavily overcommitted.
> 
> Havid said, I agree it's not a good idea to enable incompressible page
> writeback with idle page writeback. If you don't oppose, I want to add
> new knob to "enable incompressible page writeback" so by default,
> although we enable CONFIG_ZRAM_WRITEBACK, incompressible page writeback
> is off until we enable the knob.
> It would make some regressison if someone have used the feature but
> I guess we are not too late.
> 
> What do you think?

Yes, totally works for me!


"IDLE writeback" is superior to "incompressible writeback".

"incompressible writeback" is completely unpredictable and
uncontrollable; it depens on data patterns and compression algorithms.
While "IDLE writeback" is predictable.

I even suspect, that, *ideally*, we can remove "incompressible
writeback". "IDLE pages" is a super set which also includes
"incompressible" pages. So, technically, we still can do
"incompressible writeback" from "IDLE writeback" path; but a much
more reasonable one, based on a page idling period.

I understand that you want to keep "direct incompressible writeback"
around. ZRAM is especially popular on devices which do suffer from
flash wearout, so I can see "incompressible writeback" path becoming
a dead code, long term.

	-ss
