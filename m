Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95486C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3522E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EoSNKDuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3522E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeIKSBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:01:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36255 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeIKSBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:01:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so19178272edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 06:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lrke4VbQ7+yBZTJS41ZArEV6cQ2kXmBxUJNlIS+0hqU=;
        b=EoSNKDuhbOSNi5XIEIw5eztebvUw3qQUDXAHk0HISsfAkQSv4/kNTdpAN/4qg5QaCQ
         dKdMr+aCRiz1yg4k6f2TarEYBKiylNrSq54fYCKOGUAcKgz9lbcfpzyBV1NwZo7g6wiT
         F0Y7FWOQSJLJbXVYblv7x/+eO6B3wwjnX+t5FoZWEfKzBmjJFFB9s21oc0oHTFWTymHV
         87mGx7b/2XOdmrTbQGuirGjsjYZnG8tT3xd6hFuMmBNTOVoB8G0/nCwPPznKywm9xXxk
         nRltqk8X4n3kwez70rNI26B0wyK4pndElqpRfneQ9YZIkqSxTOphA9YQ+FZrR1DJJm8X
         KFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lrke4VbQ7+yBZTJS41ZArEV6cQ2kXmBxUJNlIS+0hqU=;
        b=UGb1orMuPEMzXqCgzGCvSizAQXQr9JwgHDAWW3/zXUKID1IEhFDS2/U9g/XchZMThF
         TXYbmDZ8E1d43fTklThSqC1UZ2PU6/kjjd7wo0vE5TOw9LJKF2IjOTS+U4Da7FTkfaNG
         +BiFvpt3PAkod5QSyOgwYsfcACKmGR0iXxPPVwlIHRj2WdbRtZm0xplBsB/hnsoRYpLJ
         WN6DXDDysmB1PhcOdIG3H/TgkxjuFDZX2zjVH1AHFs4dvN6DO2z+yA8R2DoeeepeME1G
         bnPCtUQ0UPR1H6Q1chBPCNod66Tq1UmHCVPOYp/7kGo1UxDJlbMcA6bhtKfYxUKGTTk3
         /pig==
X-Gm-Message-State: APzg51D/hGwYU9Vc6qP8JH7ZphewaRmuPjogATMCkIJJEf6gKrEA9yS3
        /JSBCPoUpfuuHKuplnzePay75w==
X-Google-Smtp-Source: ANB0VdZk2teh120oSClpNfK/njYGVJSX0xXB3LcFjUp/NmmwQ2lfs/ggdE4R14pOasjm9iKzQRy9DA==
X-Received: by 2002:a50:94b3:: with SMTP id s48-v6mr27369151eda.125.1536670920812;
        Tue, 11 Sep 2018 06:02:00 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b47-v6sm9759408eda.79.2018.09.11.06.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 06:02:00 -0700 (PDT)
Message-ID: <1536670918.2710.29.camel@arista.com>
Subject: Re: [PATCHv3 6/6] tty/ldsem: Decrement wait_readers on timeouted
 down_read()
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Date:   Tue, 11 Sep 2018 14:01:58 +0100
In-Reply-To: <20180911120258.GC19234@hirez.programming.kicks-ass.net>
References: <20180911014821.26286-1-dima@arista.com>
         <20180911014821.26286-7-dima@arista.com>
         <20180911120258.GC19234@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-11 at 14:02 +0200, Peter Zijlstra wrote:
> On Tue, Sep 11, 2018 at 02:48:21AM +0100, Dmitry Safonov wrote:
> > It seems like when ldsem_down_read() fails with timeout, it misses
> > update for sem->wait_readers. By that reason, when writer finally
> > releases write end of the semaphore __ldsem_wake_readers() does
> > adjust
> > sem->count with wrong value:
> > sem->wait_readers * (LDSEM_ACTIVE_BIAS - LDSEM_WAIT_BIAS)
> > 
> > I.e, if update comes with 1 missed wait_readers decrement, sem-
> > >count
> > will be 0x100000001 which means that there is active reader and
> > it'll
> > make any further writer to fail in acquiring the semaphore.
> > 
> > It looks like, this is a dead-code, because ldsem_down_read() is
> > never
> > called with timeout different than MAX_SCHEDULE_TIMEOUT, so it
> > might be
> > worth to delete timeout parameter and error path fall-back..
> 
> You might want to think about ditching that ldsem thing entirely, and
> use a regular rwsem ?

Yeah, but AFAICS, regular rwsem will need to have a timeout then (for
write). So, I thought fixing this pile would be simpler than adding
timeout and probably writer-priority to generic rwsem?

And I guess, we still will need fixes for stable for the bugs here..

I expect that timeouts are ABI, while the gain of adding priority may
be measured. I'll give it a shot (adding timeout/priority for linux-
next) to rwsem if you say it's acceptable.

-- 
Thanks,
             Dmitry
