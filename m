Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52700C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB6820879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544711371;
	bh=ULClFrvyo6tBm01xsIGQTLi6JacG1D/MvFgQdVS3rO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ez2qwXLpTDFemosEWSewKYCBJrD0xhXoPXyQkYsuzPdy58ZLdDNpm/lMn1Dhh7Vev
	 c1OzTyRHKprB7n4UMbFBMMDnJTnnL3d4w4uAEBsWklS10WH4M8GIstO4GmuGs3KtWU
	 8ocTuAggPB6v/umnXmh79H+PrkzVocYNUyqnkBr4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB6820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeLMO3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:29:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbeLMO33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:29:29 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1467320870;
        Thu, 13 Dec 2018 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544711368;
        bh=ULClFrvyo6tBm01xsIGQTLi6JacG1D/MvFgQdVS3rO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FubIBwDFHU+vkaJpIw+yXWcU1YKtwrPeXSf/RM4Q3nUbsJz5+P2Qrn8vhZehvsl+S
         Im4qd7LAAZTR00VUpgCT01YmuE23p21C28uPkJdTbXPW0OtYn510E3+iQG0mLnhDKf
         h482z18Hd2puC57lv7IXZD/JlJcB6p5pS2mKOloo=
Date:   Thu, 13 Dec 2018 09:29:27 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Daniel Wang <wonderfly@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp,
        Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181213142927.GH2746@sasha-vm>
References: <20181212174333.GC2746@sasha-vm>
 <CAJmjG2_zey77QxMzq997ALkD56d0UtHmGjF4dhq=TbEc2gox5A@mail.gmail.com>
 <20181212214337.GD2746@sasha-vm>
 <CAJmjG2_C0YRtVmNh2sg4JqhJJ11LMmbRHqwADxyO9CGh9ixQbA@mail.gmail.com>
 <20181212215225.GE2746@sasha-vm>
 <CAJmjG28s9bz51k=5i8eoKH2crj8e7-qM_EYWMqtUKZ_nGREQOg@mail.gmail.com>
 <CAJmjG29PnAfkUsU4PuVaFvjW-okO=U-MbHZHg7Sj_bBJ6EO09w@mail.gmail.com>
 <20181213022703.GD4860@jagdpanzerIV>
 <CAJmjG2-eoKTHtChWK0fdWfy872h5N1c-NgxBKZra1+ujutF+Fw@mail.gmail.com>
 <20181213095931.24qovurhtpa3jxzl@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181213095931.24qovurhtpa3jxzl@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:59:31AM +0100, Petr Mladek wrote:
>On Wed 2018-12-12 18:39:42, Daniel Wang wrote:
>> > Additionally, for dbdda842fe96f to work as expected we really
>> need fd5f7cde1b85d4c. Otherwise printk() can schedule under
>> console_sem and console_owner, which will deactivate the "load
>> balance" logic.
>>
>> It looks like fd5f7cde1b85d4c got into 4.14.82 that was released last month.
>>
>> On Wed, Dec 12, 2018 at 6:27 PM Sergey Senozhatsky
>> <sergey.senozhatsky.work@gmail.com> wrote:
>> >
>> > On (12/12/18 16:40), Daniel Wang wrote:
>> > > In case this was buried in previous messages, the commit I'd like to
>> > > get backported to 4.14 is dbdda842fe96f: printk: Add console owner and
>> > > waiter logic to load balance console writes. But another followup
>> > > patch that fixes a bug in that patch is also required. That is
>> > > c14376de3a1b: printk: Wake klogd when passing console_lock owner.
>> >
>> > Additionally, for dbdda842fe96f to work as expected we really
>> > need fd5f7cde1b85d4c. Otherwise printk() can schedule under
>> > console_sem and console_owner, which will deactivate the "load
>> > balance" logic.
>
>To make it clear. Please, make sure that the following commits are
>backported together:
>
>+ dbdda842fe96f8932ba ("printk: Add console owner and waiter
>		logic to load balance console writes")
>+ c162d5b4338d72deed6 ("printk: Hide console waiter logic into
>		helpers")
>+ fd5f7cde1b85d4c8e09 ("printk: Never set console_may_schedule
>		in console_trylock()")
>+ c14376de3a1befa70d9 ("printk: Wake klogd when passing
>		console_lock owner")
>
>
>I generated this list from git log using "Fixes:" tag. It seems
>to mention all commits dicussed above.

All 4 queued for 4.14, thank you.

--
Thanks,
Sasha
