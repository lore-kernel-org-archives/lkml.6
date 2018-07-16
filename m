Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B01ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F449208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRPOpXGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F449208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeGPMGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:06:19 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36872 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbeGPMGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:06:19 -0400
Received: by mail-wm0-f44.google.com with SMTP id n17-v6so15555092wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0KmJ5Zu/ERbKEGlrwpSB+5zOzCJEYPpU0w+rC6L0R3w=;
        b=nRPOpXGx+mEu6FQUTmLa1HpIILHdBjgQQ6+fItM9h2QKQz/1O8WheX7KcdVcObyXDH
         yEb1EIh6K1JdrnsZGR00+Au4co8tVMg8HZ8daK8C3gEqcToCE116FTUUJoOOfajgYTQb
         nzjvNEkMvL/4iidMXnPZddYfy9YnLRSxdFrwBt1Z4LtROOATWj7m9irDRIF/RcHNXAQU
         HnyJlSKyp1aFjNx/J9VzBvNB0WHsXtI9EXqfqAd778T/9F7mVrUc0/uyubRVJdVk6V9i
         Wv4GDeaUiqmXgByphRnhBnk+liLsxHXVHUZRYV04KoO5QiGar9nuP/0IW+UnpQgNJ2en
         hIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0KmJ5Zu/ERbKEGlrwpSB+5zOzCJEYPpU0w+rC6L0R3w=;
        b=St6VtJ7HtyXsxR5ErwY3hFJepFRGTmoyzSGBsB3NTfeJ5JqJp+18p7kYpmnC4ootVd
         hPLyIGddQAPAESIZaOoRj9bjx1gZbvUNo+aUlNOqQGZHTloNxTSMBofM06HIVmPJpiah
         Pv1zPUktoaWsEhqPbXw9SG+pddS+UKlOjhjIj/duwKcFsOGjlPD4w/Z1oHQZSFnAl9WZ
         7Z6/5dICnFDIadGc86G6b5N00IA0c7gM2dt9jHzqPcGWodVRRK9Jwtr2mf0dY9Xw9T4l
         Kxvl6+9XIsSAuzI3wROEUga4G5U+Db0b/7u0ZigKHJBBH2Qbiqs8rYm6Ye9KPGdAg1aU
         q2lg==
X-Gm-Message-State: AOUpUlGdIXar8IvTvtvg68+lYNYJ+iuGXOvUT+s4ZcIbjuQ9lRG4F9t1
        phpp1AF2/XfuDieTGjJPA3g=
X-Google-Smtp-Source: AAOMgpfJsAIL/sDyYEP01NNYM59O8Rq+LqOg5G763afI+VtxWT4MV/uY34naqmZKehllAbN3f3cQew==
X-Received: by 2002:a1c:6585:: with SMTP id z127-v6mr8902580wmb.5.1531741156049;
        Mon, 16 Jul 2018 04:39:16 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g125-v6sm11715328wmf.16.2018.07.16.04.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:39:15 -0700 (PDT)
Date:   Mon, 16 Jul 2018 13:39:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 09/11] sched: use pelt for scale_rt_capacity()
Message-ID: <20180716113913.GA7053@gmail.com>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-10-git-send-email-vincent.guittot@linaro.org>
 <20180715221538.GA23280@gmail.com>
 <CAKfTPtCNtsu3v95+2vtVAn_mxAO_gQgb0X1L2G97T2dwdvee1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCNtsu3v95+2vtVAn_mxAO_gQgb0X1L2G97T2dwdvee1g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> > If the compiler refuses to optimize this away (due to the zero and overflow
> > cases), try to find something more clever?
> 
> Thanks for the fix.
> I'm off for now and will look at your proposal above once back

Sounds good, there's no rush, we've still got time until ~rc7.

Thanks,

	Ingo
