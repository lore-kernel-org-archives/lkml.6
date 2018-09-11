Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD33C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3600720839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jy7FF3fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3600720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeIKUD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:03:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38471 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKUD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:03:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33-v6so19495643edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZ/EUDvoCmBysHygpJwOL5mhfvQ90kH5W5YCgMvKwTs=;
        b=jy7FF3fSNq2EYXCw6RFrBked1wa1UkVU0Q1AIv7g6LslmGi2Aq2Lex6DC0E73TOBUF
         L4Pg3q3DqG7NH1kvZkGb+FjGSM3jZivZyEwQ/qqcX39imNtJVSOtUVX29ejPQaKmo1El
         9LM3PEDO9MnJRhDyaoH1NBW8roBkG5KNvpS/QvEB8Y+c5uOK9EKzsNn0trA09uwH5kIf
         MhsQaKZyIQcCzFXtx7vetePbUKKLM44mUYgcMSqlTAllFYjA8BQCqbbKJpqHevv7iSzz
         qwKbivbn2yvxl16YlrAse96m11g1iyo+wAXPWlYlxc+g/DNBSjGQRNR5MS6pxkapqhLk
         Ez4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZ/EUDvoCmBysHygpJwOL5mhfvQ90kH5W5YCgMvKwTs=;
        b=jxbJoJXRWsUUeQNsXIo0rV14qDTK9VrMcclqIXhn7kRAsA/x9Cqq3Y1HK9v8FxK+Fj
         pTLlMiXeDrpmVG+5SWCvtjSxzODvJfXIVHqjCL5W900Z3Lq265BFOtX3lwzNQ1lRE5lX
         ATcWqQE0xGkPuaFtrxDtElhs/fqFSIn8W2z+prcb46Vowle5V2bkIDyTV0dMOHh2OdsG
         cgz0j6Ff6VTUPI/fLMgeZ+Gc8cNbGglzKpq60RnDCBnnJZeh2hoHo4NRggccto6TsRLP
         zS4OxSMtxaVHraCWLQUSqD++sUSDbMTFo7yTxKdKntya70PD7bJ03Wy/5mT4hQ7TYU/W
         nFUw==
X-Gm-Message-State: APzg51ArlFOnBhe+GZeprrqqBZBfi5iQO4NeUR6Tao6PfjswEquvsPVc
        NQzZoSqvlvhiKVzrJVp4RYmvdg==
X-Google-Smtp-Source: ANB0VdaGdruf167z7+g3qZLyTbte5RRtZaMcsi+xmHaEXYKuZ11BGxBWX7Mc1CReAIWYaNkm0d+kRw==
X-Received: by 2002:a50:8141:: with SMTP id 59-v6mr28884328edc.61.1536678254276;
        Tue, 11 Sep 2018 08:04:14 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v14-v6sm11613540edm.97.2018.09.11.08.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 08:04:13 -0700 (PDT)
Message-ID: <1536678251.2710.38.camel@arista.com>
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
Date:   Tue, 11 Sep 2018 16:04:11 +0100
In-Reply-To: <20180911135004.GU24106@hirez.programming.kicks-ass.net>
References: <20180911014821.26286-1-dima@arista.com>
         <20180911014821.26286-7-dima@arista.com>
         <20180911120258.GC19234@hirez.programming.kicks-ass.net>
         <1536670918.2710.29.camel@arista.com> <1536672802.2710.33.camel@arista.com>
         <20180911135004.GU24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-11 at 15:50 +0200, Peter Zijlstra wrote:
> On Tue, Sep 11, 2018 at 02:33:22PM +0100, Dmitry Safonov wrote:
> > > > You might want to think about ditching that ldsem thing
> > > > entirely,
> > > > and use a regular rwsem ?
> > > 
> > > Yeah, but AFAICS, regular rwsem will need to have a timeout then
> > > (for
> > > write). So, I thought fixing this pile would be simpler than
> > > adding
> > > timeout and probably writer-priority to generic rwsem?
> > > 
> > > And I guess, we still will need fixes for stable for the bugs
> > > here..
> > > 
> > > I expect that timeouts are ABI, while the gain of adding priority
> > > may
> > > be measured. I'll give it a shot (adding timeout/priority for
> > > linux-
> > > next) to rwsem if you say it's acceptable.
> > 
> > Actually, priority looks quite simple: we can add writers in the
> > head
> > of wait_list and it probably may work.
> > Timeout looks also not a rocket science.
> > So, I can try to do that if you say it's acceptable (with the gain
> > measures).
> 
> So why do you need writer priority? The comment that goes with ldsems
> doesn't explain I think, it just says it has it.

Well, as far as I can fetch from the  commit 4898e640caf0, it describes
that you should halt and scrap pending i/o (reader side) to prevent the
loss or change of the current line dicipline (write lock).
So, AFAIU, line discipline is expected to change within 5 sec by ABI
and write-priority makes it more likely.

> In general I dislike unfair locks, they always cause trouble.
> 
> > After this can of worms that I need to fix regardless.
> 
> Sure.

-- 
Thanks,
             Dmitry
