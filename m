Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DB0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A5120854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G76etjHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A5120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeIJKHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:07:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39300 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeIJKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:07:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id i190-v6so9833115pgc.6;
        Sun, 09 Sep 2018 22:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z8OMgRN4NKTc5ZOpoEH3mp+Anlbo2dOlvUJKfuvvS58=;
        b=G76etjHFxe9cuYyyg3ECa7glZMXN6DwB6yEJfFenR3ORteKzHFzJxuXUFInwTjUgrC
         8AFYgLZXXP+ryo/DsH+91q6IMNtpV+GQe1dYKRe3l4yx0d8B9AHwpmQvAUxuhWxfTcTV
         EuYq2bQfEPdm+P9hb84W2Nj8lsZf+5UqtaRTAUV0qHwwmMAh9AFPBYFe/E8ISWLtDgNJ
         0TkANU6/4b/g4M8iQXr2HATJvGsl66RM/wEzLYsU7LT9Bzcd88nnr1QeGH8yXUBAcmiU
         rptM9+8z8rxEj5dQdKIkf3A8YsGgiGVWEkfiNw5nPpWElPVe7BlzZIn/MHHZt959Uq8i
         ddSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z8OMgRN4NKTc5ZOpoEH3mp+Anlbo2dOlvUJKfuvvS58=;
        b=qDUTQrXs4BcUWdAvNldVwUlL9HdV5pvVdYhsZV18iw8fZY+vSFw/POv7t2LDMIkgjv
         PhuFt4OyyJ9/8JW0k+Jqi5SjDvFpju0vOT6QGLZjiRYOLr3biX8nliA0nBXGtoAcbtXg
         UIUadMri1oJcwmSEQJbCglDNsKLnifS3R77IfpMZKKgou056AUZnAcXKdm4lZ8/1ymmk
         lHaGnwYSpVh3yfW4iF1l6QQsuKoDN3jeHvCvIPk6Vc15ROa3NEXXyOBMzQVbF7fN1NPv
         DWYcmAeKGSrzgEEJsITPfwdoIKQRfztVAsJNMbr+YzdCPrjargYw5UVNHCHqtouzJcHQ
         SfZg==
X-Gm-Message-State: APzg51DzcgznPoUGnSfN1Ymu8kpJr6duyBGrJEoHnE1vOhPKjFg6SJqe
        A7Qxi9bUfxSUb51/qO4G7aM=
X-Google-Smtp-Source: ANB0VdaseV2Tq12T/9k8rtyopDT7AdHQV0KnHASKyvCFI4vSAHdJq+17amWQCRLnY1482Vyjc2HKZg==
X-Received: by 2002:a65:6143:: with SMTP id o3-v6mr21079047pgv.52.1536556498325;
        Sun, 09 Sep 2018 22:14:58 -0700 (PDT)
Received: from localhost ([175.223.44.246])
        by smtp.gmail.com with ESMTPSA id r23-v6sm29667290pfj.5.2018.09.09.22.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 22:14:57 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:14:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kernel test robot <rong.a.chen@intel.com>, lkp@01.org,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [LKP] [tty] 0b4f83d510: INFO:task_blocked_for_more_than#seconds
Message-ID: <20180910051452.GA518@jagdpanzerIV>
References: <20180907045041.GF1110@shao2-debian>
 <d5d23bc5-0e11-5cee-6d66-514dfc4fc25b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d23bc5-0e11-5cee-6d66-514dfc4fc25b@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/07/18 08:39), Jiri Slaby wrote:
> > [  244.944070] 
> > [  244.944070] Showing all locks held in the system:
> > [  244.945558] 1 lock held by khungtaskd/18:
> > [  244.946495]  #0: (____ptrval____) (rcu_read_lock){....}, at: debug_show_all_locks+0x16/0x190
> > [  244.948503] 2 locks held by askfirst/235:
> > [  244.949439]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x50
> > [  244.951762]  #1: (____ptrval____) (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x13d/0xa00
> 
> Here, it just seems to wait for input from the user.
> 
> > [  244.953799] 1 lock held by validate_data/655:
> > [  244.954814]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x50
> > [  244.956764] 1 lock held by dnsmasq/668:
> > [  244.957649]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x50
> > [  244.959598] 1 lock held by dropbear/734:
> > [  244.967564]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x50
> 
> Hmm, I assume there is another task waiting for write_ldsem and that one
> prevents these readers to proceed. Unfortunately, due to the defunct
> __ptrval__ pointer hashing crap, we do not see who is waiting for what.
> But I am guessing all are the same locks.

Hmm, interesting. Am I getting it right that the test did pass before.
And now we see that sort of/smells like live-lock right after the
introduction of tty_ldisc_lock() to tty_reopen().

> So I think, we are forced to limit the waiting to 5 seconds in reopen in
> the end too (the same as we do for new open in tty_init_dev).

If I got it right, LKP did test the 5*HZ patch

	retval = tty_ldisc_lock(tty, 5 * HZ);

At least it's
 In-Reply-To: <20180829022353.23568-3-dima@arista.com>

and
 Message-Id: <20180829022353.23568-3-dima@arista.com>

is the patch which does the 5*HZ lock timeout thing.

	-ss
