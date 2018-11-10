Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1266C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F54421104
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AP7q1VDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F54421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeKKEoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:44:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37790 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeKKEoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:44:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so4314748lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oyy0AgySa3Qa0v0Tk3dM0C4pnfQ6g5KgY8uor99UXs0=;
        b=AP7q1VDfP35bxPLoLsPvej7RGkMrdHiBE7Cprh0Kv09JoEE7pLLEmYl8L7y8fQlKx/
         KzuLFHuigBB+75rnS7jSDsbHeuN7IOsdeIduAfHLd3WzCN3Jx49uUgYYsXJo1BsFaVwE
         dbsVyL65uHnRAFUX/xPzlDg3pB0w6djlZIXXGTscK9ZJ4N+KK1NFKThADvLcbQYLYa7a
         +zIBG1YO8IXHjPQhBVIXgySR5rN/zN7YQxgE1SmAeRLzo6yUepFskNBs1ZM3lGkO9WK0
         WJkiWuKf7TEFsZ0HFb+wgoGaGtDZku5x4+dF2VAqJXBaCZ1u54BrPhNB2daIRhXwjHHn
         KtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oyy0AgySa3Qa0v0Tk3dM0C4pnfQ6g5KgY8uor99UXs0=;
        b=Qo2AdsqCs0cTDpk42t+BXajMMKbqpVj6WR8V6WIK3RRWM07AVkub7zj59V6ISg/Qig
         c5+5oblA8rBaNWC4kBHvvcHmBsiF+F8aLY14c1NxPn2KPiECvjUuhEOiDxwZ9qGoiA6c
         vIK3dBYs8UH9GbCZvx+huo/78STiX9SVz/WQq3hfsrRQL3abNZ4/iYs2BQV1W3wwSrHJ
         h9Zrei2zFoznqJ7QtnMSZpDeIZaZuWsH1qEzNyYPYLEKAkTPHWTKs6ayF4wf2Iab3bn6
         MM5b9hwZFViw8UFTTF509pWPiSERxLHj1w0W4JmER95EJvwukG6CaeZCJXzOfqUW6epw
         8UhA==
X-Gm-Message-State: AGRZ1gINV3Bt0iZnWs23hvAiBqZA6WPgo2aA9EMJuhQVRxkjPZekz9J+
        i8A2IC6mhydlDQwl/y2NVOiC8Zgs3nYf8IBzBvZfIQ==
X-Google-Smtp-Source: AJdET5dRrIoezTYotP4juCpaE17z3iM2U2fay7/Zd+dWSVnwKTHiPyd3eiSLixPK/cR2qxUxK4dKfnLU2WuWWQA1nyc=
X-Received: by 2002:a2e:2f1b:: with SMTP id v27-v6mr8203842ljv.31.1541876296047;
 Sat, 10 Nov 2018 10:58:16 -0800 (PST)
MIME-Version: 1.0
References: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
 <20181012105427.243779-1-dancol@google.com> <20181013023138.m445q6itdmyxdtoc@ast-mbp.dhcp.thefacebook.com>
 <CAEXW_YQFs9mcw5Qv04ZRv=ZAK7YeBLJKByQxXYLj34iigS-Q=Q@mail.gmail.com>
 <20181018154657.ehgj3ozy62zy47hi@ast-mbp.dhcp.thefacebook.com>
 <20181018233633.GA89903@joelaf.mtv.corp.google.com> <CAMOXUJ=YFEwzBdkQw8xUrQXd4ZRzX6ob0dOCCRA=uEbjvw9yEQ@mail.gmail.com>
 <20181110152232.GA24724@kroah.com>
In-Reply-To: <20181110152232.GA24724@kroah.com>
From:   Chenbo Feng <fengc@google.com>
Date:   Sat, 10 Nov 2018 10:58:05 -0800
Message-ID: <CAMOXUJkXVh=i4YVeo0W274iaLxx=WfFUsmqQdH=gSqzLzkELhw@mail.gmail.com>
Subject: Re: [PATCH v4] Wait for running BPF programs when updating map-in-map
To:     gregkh@linuxfoundation.org
Cc:     joel@joelfernandes.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        netdev@vger.kernel.org, Lorenzo Colitti <lorenzo@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linus's tree commit SHA is 1ae80cf31938c8f77c37a29bbe29e7f1cd492be8.

I can send the patch to stable directly if needed.

Thanks
Chenbo Feng
On Sat, Nov 10, 2018 at 7:22 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 09, 2018 at 06:01:54PM -0800, Chenbo Feng wrote:
> > Hi netdev,
> >
> > Could we queue up this patch to stable 4.14 and stable 4.19? I can
> > provide a backport patch if needed. I checked it is a clean
> > cherry-pick for 4.19 but have some minor conflict for 4.14.
>
> What is the git commit id of the patch in Linus's tree?
>
> thanks
>
> greg k-h
