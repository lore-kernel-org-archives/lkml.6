Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964FCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F38B214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="F1Nq8BLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F38B214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbeIRTwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:52:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38660 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbeIRTwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:52:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33-v6so2072140edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBhX2TRNJ9P3pkSE5XPyJv3tCGYVNDx6KSZRsqnzGnA=;
        b=F1Nq8BLJK8CK60IhpWS9o/8xUf3WBIjGlZt2jl4rdNB4ArZ2zczPl1bZzyu6Yl89V0
         evcV4KDYr8rVoO7tJHN2LDtodoKWvy3KnkjwZTfi1KSsIUz/IjIVjEFKCq6DdrowjDMo
         hemjAFUNvaDHVYU5+wiL2nlrGFfOKGud7rDbft9dMGQLaePIwyYXRf0/CLlONdlt8CmS
         BlluKziUF8Dmpl6FVa2daupPI/b0ePdJmuYmn0cQ6kPlYqkWVl4YUWBr5nmFmN0lXRUz
         514Hp8mF86cTVsL0gegMKzvZH3Puv2g7qrpvWX+yuH0gxU/5FHUCSu1bVGdNj/BO8vq8
         6Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBhX2TRNJ9P3pkSE5XPyJv3tCGYVNDx6KSZRsqnzGnA=;
        b=PfWRUjlnQfqqW/7hjVMU9JVknmVH+Cb3YXB4IAJxig1pq+4ml29qRLYDTuV+3d5Kfp
         tyqZR8n49fkxpSYMv88r51q4XENHTzv9GfnADVpWHapoa5yvuAFm6OiAR1sXz+LTz/+W
         PYoTsI/uc2ddsI1yeSgO/boQtJHGwkJ5W0CK0ydoBPDi8pO7nCkuaFkNpSTbhYrK938P
         KW9ZMcDpk3oBPP62PmHG/cj0z+kEFgbHvM/TlIskoujt6/7PWcEE2Y27zZeqiwa1vKBF
         af69wfhc552N/1/m2ZcvFZ4OKKM91tdw4x+nceGUzbJmSpp5jPcUTw8c5h5fdHzwf6do
         j0YQ==
X-Gm-Message-State: APzg51DXBxeCkA/k5T+Hob6EtQdFvp531iR3jnwWjMWW4td/yO0Hg7O3
        CkkgiV0sJm4O21BZ9N+Psz+eRA==
X-Google-Smtp-Source: ANB0VdYwC5lt/M+8PLwxUqzCb/oyqjk9tX1pmpNFTR5avPOZTUpVIMp6tPhcnOKB4dZ18ffLPdKSJQ==
X-Received: by 2002:a50:bf0d:: with SMTP id f13-v6mr50414524edk.157.1537280359835;
        Tue, 18 Sep 2018 07:19:19 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o12-v6sm248595edo.0.2018.09.18.07.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 07:19:19 -0700 (PDT)
Message-ID: <1537280357.21380.7.camel@arista.com>
Subject: Re: [PATCHv5 3/7] tty: Hold tty_ldisc_lock() during tty_reopen()
From:   Dmitry Safonov <dima@arista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Date:   Tue, 18 Sep 2018 15:19:17 +0100
In-Reply-To: <20180918134734.GE23431@kroah.com>
References: <20180917235258.5719-1-dima@arista.com>
         <20180917235258.5719-4-dima@arista.com> <20180918134734.GE23431@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-18 at 15:47 +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 12:52:54AM +0100, Dmitry Safonov wrote:
> > tty_ldisc_reinit() doesn't race with neither tty_ldisc_hangup()
> > nor set_ldisc() nor tty_ldisc_release() as they use tty lock.
> > But it races with anyone who expects line discipline to be the same
> > after hoding read semaphore in tty_ldisc_ref().
> > 
> > We've seen the following crash on v4.9.108 stable:
> > 
> > BUG: unable to handle kernel paging request at 0000000000002260
> > IP: [..] n_tty_receive_buf_common+0x5f/0x86d
> > Workqueue: events_unbound flush_to_ldisc
> > Call Trace:
> >  [..] n_tty_receive_buf2
> >  [..] tty_ldisc_receive_buf
> >  [..] flush_to_ldisc
> >  [..] process_one_work
> >  [..] worker_thread
> >  [..] kthread
> >  [..] ret_from_fork
> > 
> > tty_ldisc_reinit() should be called with ldisc_sem hold for
> > writing,
> > which will protect any reader against line discipline changes.
> > 
> > Backport-first: b027e2298bd5 ("tty: fix data race between
> > tty_init_dev
> > and flush of buf")
> 
> What does this mean?
> 
> Does this require that patch for a stable patch?  If so, just do:
>  Cc: stable@vger.kernel.org  # b027e2298bd5 ("tty: fix data race
> between tty_init_dev and flush of buf")
> in the signed-off-by area.  The stable documentation should describe
> this pretty well.  If not, we can modify it to make it more obvious.
> 
> can you fix this up for the next resend of this series?

Sure, sorry about that non-obvious tag.

-- 
Thanks,
             Dmitry
