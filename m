Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22336C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21AD20833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bb2QW5JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21AD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeIKRsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:48:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41634 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbeIKRsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:48:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so19113918edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nHJ/v7W1DSFpBMS8EBbbFqk0cpjhvjbNdPU/+LgkS0=;
        b=bb2QW5JC5N/vafUbYxI+QP1ED7XAyqKyfOdK2GzfCEHCtCVYuRVpEW9NySDT7JT76s
         8v8mDEDpCiG4//h67UA2LrYqh7MtlWmVozJZUTImJ4GwXDwn3omHI+VxwaCqyNQpYG7B
         BAN/os50gA/yO6z452PC+vSS2TQnEaNnnjREAZBMJFKzCF9ZrAsPfU98Sq12P0QasdzL
         32Bt5IKql0o44y9DDGnoztN4NChPJXa7rgLL6ZlrKBNrdJAMedOljW0QgCnGaGgC/Obx
         jowrcOUweiCb5beJ0KZnT91kLNvFOKzF9LpDXXwZ9+jHRIKzxh0opK0oY1Pj5/MsMl2C
         mSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nHJ/v7W1DSFpBMS8EBbbFqk0cpjhvjbNdPU/+LgkS0=;
        b=DjTQfUqMAM8is4X98oq6YKJCZVr0H93bgGUtAJwiih3PM93UdhudxZBBtT6JSqjah9
         X1yl79rPtzvlZKTj9G1w2eYsqtRtwLEXyLPb3JpwdJ7jtKy8M8I3RjEwLLWLs6TWzAYT
         hwm2A5RUx1Cpc+3rg1f8BslM01Z38t7vg5SfFPEFIcEXFvwhtDqpeUfybuxeBDhF3d5S
         /CaO1OsMPsXIA4yspcI+IPWnAKUoq67WodZcK1m4doqphcEVP+dcLslNpMrwUvQ9CrRn
         QuWNGcA6DcaHPwqsY4Gz9xpDOeDjLK/tTZgLTvhHHNtfz6D89EMhHqCOKWGVMVMV5vjt
         X3ag==
X-Gm-Message-State: APzg51AzPxSVi91dt6+Vk9uv0DoQZtcP7j48u+3HbxOSdWosBKXE2Udq
        +It62R5QgOSp4h60HqZDYll5CQ==
X-Google-Smtp-Source: ANB0Vda2qbSpPGSp0aid5rVZqmFJw9AAhsHt0eA6Sw7L2aLwWV2UAW+fv+IGsBcY6bri3E5LdUbVnw==
X-Received: by 2002:a50:b1d1:: with SMTP id n17-v6mr28065812edd.52.1536670140557;
        Tue, 11 Sep 2018 05:49:00 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n15-v6sm11010049edn.44.2018.09.11.05.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 05:48:59 -0700 (PDT)
Message-ID: <1536670138.2710.20.camel@arista.com>
Subject: Re: [PATCHv3 2/6] tty/ldsem: Update waiter->task before waking up
 reader
From:   Dmitry Safonov <dima@arista.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date:   Tue, 11 Sep 2018 13:48:58 +0100
In-Reply-To: <20180911114043.GR24106@hirez.programming.kicks-ass.net>
References: <20180911014821.26286-1-dima@arista.com>
         <20180911014821.26286-3-dima@arista.com>
         <20180911114043.GR24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-11 at 13:40 +0200, Peter Zijlstra wrote:
> On Tue, Sep 11, 2018 at 02:48:17AM +0100, Dmitry Safonov wrote:
> > There is a couple of reports about lockup in ldsem_down_read()
> > without
> > anyone holding write end of ldisc semaphore:
> > lkml.kernel.org/r/<20171121132855.ajdv4k6swzhvktl6@wfg-t540p.sh.int
> > el.com>
> > lkml.kernel.org/r/<20180907045041.GF1110@shao2-debian>
> > 
> > They all looked like a missed wake up.
> > I wasn't lucky enough to reproduce it, but it seems like reader on
> > another CPU can miss waiter->task update and schedule again,
> > resulting
> > in indefinite (MAX_SCHEDULE_TIMEOUT) sleep.
> > 
> > Make sure waked up reader will see waiter->task == NULL.
> > --- a/drivers/tty/tty_ldsem.c
> > +++ b/drivers/tty/tty_ldsem.c
> > @@ -118,6 +118,8 @@ static void __ldsem_wake_readers(struct
> > ld_semaphore *sem)
> >  		tsk = waiter->task;
> >  		smp_mb();
> >  		waiter->task = NULL;
> > +		/* Make sure down_read_failed() will see !waiter-
> > >task update */
> > +		smp_wmb();
> >  		wake_up_process(tsk);
> 
> This is 'wrong', wake_up_process() should imply sufficient for this
> to
> already be true. 

Yeah, thanks.
It was stupid of me not to check that..
Saw the smoke that would describe the reports and made too long-going
conjectures. Need more covfefe and staring into that code.

> 
> >  		put_task_struct(tsk);
> >  	}

-- 
Thanks,
             Dmitry
