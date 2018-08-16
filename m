Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DAFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B3420659
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq0SZBjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B3420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391895AbeHPSRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:17:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37867 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeHPSRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:17:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so4505054wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xsmjUGLHv165IMxIahWHMVgHlqJ4ofwpO1ULhGDtAT0=;
        b=Pq0SZBjV7IYuEO+0nskI3F+4eRUaxT9FAYbdzDCcHyQKKOTiglm+WX2pxckatwlau7
         viB+bFyhopfKBKB7RwO2yW34aNnlhh0OzQB9oFUlkjWWVddmj0+YklWeayZiTnLufhth
         aQQvokwVRH1mrMHza8hC89cupz9oOgAEqSbNo2kv+S+f+OUSUY77wMpExvFmerqrzOtr
         yd2dEtBgHv54YK5AIk1a5r4YFMDuirVU6lUTFq0qfzyoS/rUuhwcQuy9g5Omci0wVfen
         veL2eKZ3tgzhUDKR6oMoXYHQwm2L/40JMe3EKCocBi0TVQD7AHwIOlpz0zDygCmT7mbW
         isFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xsmjUGLHv165IMxIahWHMVgHlqJ4ofwpO1ULhGDtAT0=;
        b=Rr3i8BkqKDi3MyW7gI7oDw4mkYKXpZm5giyv+S4yOd7EWw2HcGjm2aIQo6BP4dUwRf
         LYMmCXFaZim4cWEiyMVSxFUEdodk6x4LBDpst9sQJx7Iw0YKXlI0srbhzNnn6dxnbgZL
         rHWZCvKCWfw1cwCxU2Vjq/9XtdvIhKa40FKQ+F1PYrq4PUf0RwNdu2MwoH5X3TlSM7pD
         nzy6C5PbI5vJuBrr9hP0xP+qycGEx3yUXwIjEB9agFygZiN2/D6DeFZ3k4nTyuJL6zm0
         YmjZcyfSJzNUjiyoAi58+FUSA4V89NIFKeqguS1OOZe3ruq/NHH1ns/liuCI4afaF8/q
         JdPg==
X-Gm-Message-State: AOUpUlFIchEMN2sFHdUc+g+KKGd9wiKk8ARJMLmhLLMYwMI3ZIMmvgy6
        jFEvGkD9F0XinUUstfxyyqENtpuZ5ME=
X-Google-Smtp-Source: AA+uWPzoTx7RsB8byqz/0GGR06uEitah98IpCUYlxbnlo45Wy9JiL4Kadet584iysXETdf6Q2xo2Eg==
X-Received: by 2002:adf:a41c:: with SMTP id d28-v6mr681993wra.121.1534432717980;
        Thu, 16 Aug 2018 08:18:37 -0700 (PDT)
Received: from uranus.localdomain ([79.172.193.244])
        by smtp.gmail.com with ESMTPSA id b13-v6sm29148070wrn.17.2018.08.16.08.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 08:18:37 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 8C4EF460B3D; Thu, 16 Aug 2018 18:18:35 +0300 (MSK)
Date:   Thu, 16 Aug 2018 18:18:35 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrey Vagin <avagin@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next] Kernel panic while tetsing criu
Message-ID: <20180816151835.GW10406@uranus.lan>
References: <20180816092429.GV10406@uranus.lan>
 <87va8acqkn.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va8acqkn.fsf@xmission.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 09:51:36AM -0500, Eric W. Biederman wrote:
...
> 
> That patch is incorrect as it misses the rcu_read_unlock.
> >
> > p.s. Andrew noticed the problem and asked me to notify,
> > also he has been testing this oneliner patch. I'm out
> > of sources at the moment but I think Andrew will help
> > to test if needed.
> 
> I noticed a similar report from syzbot yesterday and I applied the patch
> below.  Can you verify it fixes your issue?

I'm quite sure it will help, since the patch is almost doing the same
as Andrew's fast fix, which checks for @p being nil. But to be sure
lets wait Andrew to verify.
