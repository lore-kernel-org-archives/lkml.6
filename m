Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2BCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B95214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WPxjjq7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B95214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeIRTpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:45:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34569 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeIRTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:45:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so2066977eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZCyrFXpOWSaRIcXLoBiVVGz+PK5DesZTR7fOYTyRYg=;
        b=WPxjjq7fJuRhdLZ2p4mF1avsYLh/ANN1LuKyFP/G5otZzYh167EHgDUGEbZl5VzB01
         //Rdp+DVmqDQwIOoSbW4Hb+mzBJ+Pjkf5uiNFPkIX6PxSFHcRST7TbZfuWXr4bus9x47
         QMdzGq6K2PDDfLWKrzSlJjvjPlvsm4hAdlmy7DNp/9gO9DlcpOv/Mk/mAFPAZgMePq0s
         6TlxTRZnf4jHZBt1U89ItpvnpJNlcZahkToI7v9a471YF/kWd5y+bDUuZH/k9KN9+zVD
         F0ze95SMTlSfP/7grgVySPdLlUZhT32O9gddZ5K+QJqlfbuSSrz0fZ5e5XkRzUeboZcI
         XZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZCyrFXpOWSaRIcXLoBiVVGz+PK5DesZTR7fOYTyRYg=;
        b=YXay+MC0oV9egKM9tE0n7ik5p/NFVl9HE3ztqFVM6IMdH6IwEIYjIuZVNA+lfwNYPz
         IK+oYNUILrbzE87fGIOna47ApQahdZYJ3ALIXzEN+bNYQvxGq/6sVdkP2eijbhJfNQ6j
         tVMA+Y0AhljbwGCXGnXRs38JxmqFh9WvZEepldV5ep3dWkvgLxF0/H1bKDUQuxAGHTMO
         GSuHzwOGFTYwkbGiIc9s9v1xbhQFe4jFOwmQxCbhxVhTHQD3Mgo5az5tDR9YqHxTBTMF
         hFelOziFhZXSexxemukphT2ko3U85oI9fhkOKGrOav7jYxYP+w8F/5aOSUuYUMYVhRov
         wZvA==
X-Gm-Message-State: APzg51Dg26rQ7pwpl3fFEcyW/3ysUGRiVL2mnoqZxrCIsp+c8flH5hH2
        5dTyJCoPdhnsRWIUD6cGT2IQOQ==
X-Google-Smtp-Source: ANB0VdYamSOOM0zlhmHF4+ud2YOQ6THHcQq1ZWsKVW9Ig9TZxFHAX9vcweQmAR6JNMDDJqjFab1kxQ==
X-Received: by 2002:a50:898b:: with SMTP id g11-v6mr29335962edg.82.1537279971312;
        Tue, 18 Sep 2018 07:12:51 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s7-v6sm167453eda.19.2018.09.18.07.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 07:12:50 -0700 (PDT)
Message-ID: <1537279969.21380.3.camel@arista.com>
Subject: Re: [PATCHv5 2/7] tty/ldsem: Wake up readers after timed out
 down_write()
From:   Dmitry Safonov <dima@arista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.com>
Date:   Tue, 18 Sep 2018 15:12:49 +0100
In-Reply-To: <20180918134347.GD23431@kroah.com>
References: <20180917235258.5719-1-dima@arista.com>
         <20180917235258.5719-3-dima@arista.com> <20180918134347.GD23431@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, 2018-09-18 at 15:43 +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 12:52:53AM +0100, Dmitry Safonov wrote:
> > ldsem_down_read() will sleep if there is pending writer in the
> > queue.
> > If the writer times out, readers in the queue should be woken up,
> > otherwise they may miss a chance to acquire the semaphore until the
> > last
> > active reader will do ldsem_up_read().
> > 
> > There was a couple of reports where there was one active reader and
> > other readers soft locked up:
> >   Showing all locks held in the system:
> >   2 locks held by khungtaskd/17:
> >    #0:  (rcu_read_lock){......}, at: watchdog+0x124/0x6d1
> >    #1:  (tasklist_lock){.+.+..}, at:
> > debug_show_all_locks+0x72/0x2d3
> >   2 locks held by askfirst/123:
> >    #0:  (&tty->ldisc_sem){.+.+.+}, at: ldsem_down_read+0x46/0x58
> >    #1:  (&ldata->atomic_read_lock){+.+...}, at:
> > n_tty_read+0x115/0xbe4
> > 
> > Prevent readers wait for active readers to release ldisc semaphore.
> > 
> > Link: lkml.kernel.org/r/<20171121132855.ajdv4k6swzhvktl6@wfg-t540p.
> > sh.intel.com>
> > Link: lkml.kernel.org/r/<20180907045041.GF1110@shao2-debian>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
> 
> Why isn't this ok for the stable trees?

I guess it is ok for stables, but I would prefer to have an ack from
Peter before that.

Peter, could you look if my analysis and fix are proper?
I'll fill more confident about it going to stables if it had your ack.

-- 
Thanks,
             Dmitry
