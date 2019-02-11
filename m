Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBCEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDBC2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549870716;
	bh=jnk3CUlz+/fFGgtArd/8GipM1GopwLpbwZi21WsRc3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rHRvrJKx6csKqwmGorY3YwpdX45oV1oq8zXDcKBpFi+5KHwLBAg5i4ldA41iCHPdu
	 0/sTgXyiFjBvzMF3GDcXE78TGyjOoY95m3GL6B803FknYm87xheZ6iQMgitwUfS5t1
	 WE7ZJ1nuIRr9zYzlL6NFhEVMnMy0p9aJzzucfcdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBKHif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:38:35 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:51066 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:38:34 -0500
Received: by mail-wm1-f44.google.com with SMTP id z5so15463622wmf.0;
        Sun, 10 Feb 2019 23:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j1zWKIlZsVjo0SP2EC7fZlyHxeWBFLCgtgW8EIbDbOE=;
        b=QugwUPgcpfU3+Tm9+uRiY+VeoOW1hrVgrzjfbonMin4cw7g0zWY7xW+3Mit8PQfprX
         QPeCFmub2fnVz6mKV4rLOkZE0BJ3RX4AxWW5dSA6I9alAM9EnEpQiM5EEJg/Q3NN25w9
         Sksw1pfELw9mSjghnPIG5gPaKrMz49anPYySUg6RzUppp3MHsd4BR4WQQvy0BL7EGBb7
         5u2uvV7tKrN/HdTBi8u8Dg7tWUi+LHlqKfAZr49t/fMVgzjMfVmRex+57Sckpoalu05B
         LM6RFLVkUPg8iY5FadJ7YAkqHe/N9pHEV2ZD69QaiIh0ha2DBdykzx8mHYbwRQfeh8E0
         OszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j1zWKIlZsVjo0SP2EC7fZlyHxeWBFLCgtgW8EIbDbOE=;
        b=o9ccwyvGkLUXseMZkR1qJdSqVfRzTqJf6j2jJejAHW1E3gU/GPTIfAK835kq3MC84W
         UPd0M7KqC5N0kckhWqcWCA7UiPAyLniln2F/psTxpxboy22J4EBeP5haMqZeyQRZhu2S
         SiQsDZEINCLhDmsCEu8cq2voTPAm3gqJL/SHJppAMkmWj5f0pQJBJ1FRPbIg/JtZZVaE
         m5OyaRaO5b7Tc9lSuOwq8lHDCFVCpyYBRuvMo9nvh0qIJvScndaHzkZl01tHtjHEZ4e1
         ZtxkUsCQAfOFRCf8eC8hV2vwrhUcOizLnanOn5aAnVYdhQ588sQmVxAZ98KZmq0gHFX8
         3M+Q==
X-Gm-Message-State: AHQUAubvJbB0NZIJTpS/z7BqP9MqYBUccZWmq1o0tQF4yHhe+uxbAuAu
        04DXD9nqmy9bPyeRzMXEs5g=
X-Google-Smtp-Source: AHgI3IabznfRCQX4qyQonoc9mGE4Iu1ZLqbFlbxiVnApqa0fDXIc+az+/yufddL5FoyENYBy8lVfbg==
X-Received: by 2002:adf:e290:: with SMTP id v16mr12077501wri.100.1549870711601;
        Sun, 10 Feb 2019 23:38:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x3sm12933033wrd.19.2019.02.10.23.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 23:38:30 -0800 (PST)
Date:   Mon, 11 Feb 2019 08:38:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Message-ID: <20190211073828.GB106308@gmail.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190207195119.lglz4lb7cnf4ndn2@linux-r8p5>
 <45b7bbb8-c953-9951-ae6f-e2c3202e5cf2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b7bbb8-c953-9951-ae6f-e2c3202e5cf2@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> On 02/07/2019 02:51 PM, Davidlohr Bueso wrote:
> > On Thu, 07 Feb 2019, Waiman Long wrote:
> >> 30 files changed, 1197 insertions(+), 1594 deletions(-)
> >
> > Performance numbers on numerous workloads, pretty please.
> >
> > I'll go and throw this at my mmap_sem intensive workloads
> > I've collected.
> >
> > Thanks,
> > Davidlohr
> 
> Thanks for getting some of the performance numbers. This is the initial
> draft after more than 1 years of hibernation. I will also get other
> performance numbers in subsequent revision of the patch.

If you could sort all the invariant preparatory patches to the head of 
the series I can merge them to reduce overall complexity and simplify 
performance testing and review of the rest.

Thanks,

	Ingo
