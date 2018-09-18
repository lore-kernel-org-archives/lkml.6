Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B385ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DBD2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyjAbxjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DBD2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeIRMJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:09:47 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:53162 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeIRMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:09:47 -0400
Received: by mail-wm1-f47.google.com with SMTP id y139-v6so1093836wmc.2;
        Mon, 17 Sep 2018 23:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AnljPYMHxT5UmbwaUjgsD3wP4F5nvqVkUzZa08aUWFo=;
        b=OyjAbxjc1Oz6xH3si+7/oYRgMkTaqEV7FI1vyaah6jrF3DWh2PjyXac4a99qEAFmk9
         A2oYRq4ogDYpFRt5PebtJi+A4Jbp8SP9AT0PdLa25U8d8QiGyZdm2MJK895BmXGd9i3/
         uH2GSU/CHQuQFMlha9f+dRwxfz45zTV9+Rhi2+hk/WsoradgN5wTFv5gK+BmU++VvHIV
         Ii3qquoYqki6daIN45S9Jch8xjuvY06feOmFvgQj2YF31BKoXbBw5sOKpHrHdT/1BLKM
         w6gW5tssEYiyiSiSgQWQMszUnzfAcVPQ72/pkV5FMtdU7fgjgWBSsy3TIcdXY3PLquhk
         Sxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AnljPYMHxT5UmbwaUjgsD3wP4F5nvqVkUzZa08aUWFo=;
        b=SZCW3dv05m+bf03bxIdB/tVOKwzeASwEgDzC/fi4MY4qsqV/N6cqsJl6F4b6JWFsGU
         jH/yHcvg+KZ1kl92gcDG+j5kyO4cWV/yG0jieR3d8Ctxe0qVf+MpNS/0Q8jefEovM8Xu
         1umblhIryKGMgXySKSf/xPewsEA7LKdQzrKasJD9O8F+PkBJKCSDjMq0oFNncZzByk80
         Hfmh1tG1GjvQXZVQ7wmoKJ4dVKTxri4nHmcjS+E79yYGTR9CkTz3UrK5a8d0BwkdVgbc
         SoRh9/eaiszfs/uDdJoIibqQ7aRpaTAqGTxhfbrr93+NHs320hgX2VuWSpLNRyA+FLlJ
         hIzQ==
X-Gm-Message-State: APzg51CKtUNOjXrBZKOvVXq1PKFO1DmA5HGVBCCq9EEMCAuBUdgGHm2C
        TjmD0Pvk5jjZ/lmrhcFOBO0=
X-Google-Smtp-Source: ANB0VdbaqbKFbw7Nns66xplNr6vS619FjuRSEjTcSyosoDrLeFJjeOJ0wZDjIoEP6E7/II3UUQm3Rg==
X-Received: by 2002:a1c:8291:: with SMTP id e139-v6mr13367791wmd.39.1537252717964;
        Mon, 17 Sep 2018 23:38:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x204-v6sm956245wmg.27.2018.09.17.23.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 23:38:37 -0700 (PDT)
Date:   Tue, 18 Sep 2018 08:38:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org, douly.fnst@cn.fujitsu.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [tip:sched/core] sched/fair: Remove #ifdefs from
 scale_rt_capacity()
Message-ID: <20180918063834.GA72834@gmail.com>
References: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
 <tip-2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a@git.kernel.org>
 <20180915114657.GA63704@gmail.com>
 <CAKfTPtD-vAw9=aDS83eEB56JOPV74R-oG1LAKKPXkDfxPDt1vw@mail.gmail.com>
 <20180915122956.GA12378@gmail.com>
 <CAKfTPtCSJLRjmLDHAOTBjOPg8HQyGhmwsk71bNSnz0tOqbwkyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCSJLRjmLDHAOTBjOPg8HQyGhmwsk71bNSnz0tOqbwkyw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> > I.e. this needs to be sorted out and done properly, the concerns you voice are simply a side
> > effect of this having been done badly.
> 
> Ok. I'm going to prepare a patchset to fix all these points.

Thanks!

	Ingo
