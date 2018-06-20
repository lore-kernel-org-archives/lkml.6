Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D711C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED01A20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1f0RKoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED01A20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbeFTNGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:06:34 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43232 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFTNGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:06:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so1580524pfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FzoI19nFiwY9NnsXAKsJxmG+GCMKkJ4j2eX8OxgTwBw=;
        b=c1f0RKoHHmVmQN1aekS1z1NeL2sPGiNwJXIGWfuOw/hin973PYeF9imfzidzg9qAZ9
         Ggh7ehGEBDrJSal2I9e08zdD81hkBqCiUmZqLuoN2Inr4fxMt4hKF1DkZr9lMXGVTgma
         EUaCtHsB4ScFkNZr/tYwE+8BlNmmbfzT47rX+M/srWi2AigDeSEzMYqO/B/JnN2jU2IM
         27L1AWdQibxmAfwDOdtRsJ6neJjh0lXBF8e1bELsHockyhb6RA4Wzw/4mV2tDwZVSVMq
         vE/eyAQNHtvF4yNU7SHMroimkVsRf8c2rITcmAkCFA4UphVeeB341QJ274qxxGs6KkJT
         7pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FzoI19nFiwY9NnsXAKsJxmG+GCMKkJ4j2eX8OxgTwBw=;
        b=SXnEm5VcwXzK6SOZ/S3inUQP/7P8E7Zc620EeFPUVqwWhg2piRNvp2dLe9zXLQVuch
         aYfOf6laCu0XJHtfB0UkKgoZ+P7FkeX7gBkAvkJ6+eV23ng+6I9xjdAbVljmMeFBEhIY
         VMcmHuld+1Xa9npCrbhqeGledR0nKhjQGJtoUAyJlB3ivn0zw9VSENpSz48p42etWRPD
         HQe2+7X9UbC8j989lKzOYcmK3lvv6kiLZz1DPtpqSIVBtlHFwkpkIihBtMj+yjuSNJMp
         k6bHzkjlMyuQyRWH4fczOUtZEbW/fLBcWOrfLT7usri9hBz9p32ivvIr7G6IDfOJNZwK
         5bxg==
X-Gm-Message-State: APt69E0lgk8zQoCl1jpAJBVFEMNq3dGtUSNum/jpFloNO5hkPrsZjLUL
        z4O40SyntS743r8MlAumAcA=
X-Google-Smtp-Source: ADUXVKLCcq4nMb7/GP6aLHhnQ5TxTnslGLcFw0leafen+CqDsS1hD50SYHozti0OGhan4WcSPjRQ7Q==
X-Received: by 2002:a65:5143:: with SMTP id g3-v6mr18595105pgq.190.1529499991880;
        Wed, 20 Jun 2018 06:06:31 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id 63-v6sm4994390pfo.1.2018.06.20.06.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 06:06:30 -0700 (PDT)
Date:   Wed, 20 Jun 2018 22:06:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180620130628.GA1000@tigerII.localdomain>
References: <20180524021451.GA23443@jagdpanzerIV>
 <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
 <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 13:32), Dmitry Vyukov wrote:
> > So, if we could get rid of pr_cont() from the most important parts
> > (instruction dumps, etc) then I would just vote to leave pr_cont()
> > alone and avoid any handling of it in printk context tracking. Simply
> > because we wouldn't care about pr_cont(). This also could simplify
> > Tetsuo's patch significantly.
> 
> Sounds good to me.

Awesome. If you and Fengguang can combine forces and lead the
whole thing towards "we couldn't care of pr_cont() less", it
would be really huuuuuge. Go for it!

	-ss
