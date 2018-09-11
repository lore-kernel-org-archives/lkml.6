Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79B7C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915922086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ACMsuGxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915922086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeIKScr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:32:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38014 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKScq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:32:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33-v6so19237728edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUfvWbNmojkePg9NAe1H0MLdWfRQ5KsQXF5Oh04nS+k=;
        b=ACMsuGxBSs0CZ02qcKD4qwaUIErg0yypo+pj+vecQ7lnVIKuPNtQsRBp11ybEZpITJ
         YuPQsgfrpXzeaM00Ke1tKW+bGLvw2LXzq8vz2t8rz2EXnfnoylXB5v97/auVZ0CDeXsB
         d+N+a6T2cjAT+0B2bdrE4LamHTHZ53RwhVo6fZVi+neKw7IUaXjdWYUmYvPfc9JwdpYg
         OzuvaFbFj8qUtgM+ezzMihGblVFuz6QYAILaVqcQovr7r7FKHCPxtngJJrZ+pwuXmKql
         HRq1vvxEjmWQvG4psckkZXu0ckrFE0TxT5aVsoh49pFgjY2Eyae1CvosNb+rkwyKWsVS
         hZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUfvWbNmojkePg9NAe1H0MLdWfRQ5KsQXF5Oh04nS+k=;
        b=btiZ2KUK/9hEiuQmOTXJhbvX/mo4Dt1SY0XhYwdQHapONVoQTXZpyPC/4ixxX12uO5
         gBXLW5/WdXC94FiUM2kQQHzcTg9CESmBoptR2KjUa9TZ9VlmrrHY0CgP5MFTTe8AN8Kh
         To/97dgIMfBe2cDxkB1jXuI8sxJZdvoN+zDUaszhqLbBl6WHV4mfHZCYzsShOhTYVAg4
         oxyx7YhL0ZG8FwRzADGtVgiza+2XhWRQ7oq4aw75a6uAk4Gb/ns9IqEuwPRAIs2HtUVz
         I8hJFx4AgIWc98ZqLsz3etpvAeM4IkGkMvgjhE7UNWJ+P5c8rhXNuXzwtstNR+EOdvr7
         uZIQ==
X-Gm-Message-State: APzg51A3pkij3nL/kp/bYSANyzjlU5P6bpQJxTNi9RTAB6w4bcKN8F3Q
        +kRonCmXRN30BWas+0T+xqr/vg==
X-Google-Smtp-Source: ANB0VdbZbze2fRZY9ig51PiTNtYnDZYS2+KKKXuU9zOs5cDH3nHyx00WiE+T4xPVZToW1J7MPVh4sg==
X-Received: by 2002:a50:a9e2:: with SMTP id n89-v6mr28282363edc.158.1536672804351;
        Tue, 11 Sep 2018 06:33:24 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y27-v6sm9895120edb.20.2018.09.11.06.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 06:33:23 -0700 (PDT)
Message-ID: <1536672802.2710.33.camel@arista.com>
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
Date:   Tue, 11 Sep 2018 14:33:22 +0100
In-Reply-To: <1536670918.2710.29.camel@arista.com>
References: <20180911014821.26286-1-dima@arista.com>
         <20180911014821.26286-7-dima@arista.com>
         <20180911120258.GC19234@hirez.programming.kicks-ass.net>
         <1536670918.2710.29.camel@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-11 at 14:01 +0100, Dmitry Safonov wrote:
> On Tue, 2018-09-11 at 14:02 +0200, Peter Zijlstra wrote:
> > On Tue, Sep 11, 2018 at 02:48:21AM +0100, Dmitry Safonov wrote:
> > > It seems like when ldsem_down_read() fails with timeout, it
> > > misses
> > > update for sem->wait_readers. By that reason, when writer finally
> > > releases write end of the semaphore __ldsem_wake_readers() does
> > > adjust
> > > sem->count with wrong value:
> > > sem->wait_readers * (LDSEM_ACTIVE_BIAS - LDSEM_WAIT_BIAS)
> > > 
> > > I.e, if update comes with 1 missed wait_readers decrement, sem-
> > > > count
> > > 
> > > will be 0x100000001 which means that there is active reader and
> > > it'll
> > > make any further writer to fail in acquiring the semaphore.
> > > 
> > > It looks like, this is a dead-code, because ldsem_down_read() is
> > > never
> > > called with timeout different than MAX_SCHEDULE_TIMEOUT, so it
> > > might be
> > > worth to delete timeout parameter and error path fall-back..
> > 
> > You might want to think about ditching that ldsem thing entirely,
> > and
> > use a regular rwsem ?
> 
> Yeah, but AFAICS, regular rwsem will need to have a timeout then (for
> write). So, I thought fixing this pile would be simpler than adding
> timeout and probably writer-priority to generic rwsem?
> 
> And I guess, we still will need fixes for stable for the bugs here..
> 
> I expect that timeouts are ABI, while the gain of adding priority may
> be measured. I'll give it a shot (adding timeout/priority for linux-
> next) to rwsem if you say it's acceptable.

Actually, priority looks quite simple: we can add writers in the head
of wait_list and it probably may work.
Timeout looks also not a rocket science.
So, I can try to do that if you say it's acceptable (with the gain
measures).

After this can of worms that I need to fix regardless.

-- 
Thanks,
             Dmitry
