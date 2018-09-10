Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965D5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C482086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ATNkiWI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C482086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeIJXqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:46:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34702 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:46:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id u1-v6so17341540eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTct4abHBWajP1HfOai1RtaSmPzCQaGQ6D+sTVoERpw=;
        b=ATNkiWI7BTVxfGVQzedFq+Z+Y6C2dlaP7JBb7VRezW7zwIwQ6Hgk/JVGpnfs3x7zyc
         2y9mJJVWYhyUEgk0rtF2k1ddTPP7i7IzurLAgdZ9YXajPL6Uk6+sc1bd4PBX7NzCVlax
         Nv8dYnHT2bT3uTGB9u8UHlJmjuCrohSWA8h7EFgO7hvisErhivmIDl2zmMeYqbJZsWE5
         3GD/jUgT2PgZLUFgUZ3yF/AnSpCO0Elsa2wElgzMlQwhaWPEEf2ufBEi9lcNw/ASZsNE
         q6eyckev8H7a4c1gEiLH+TRebAscRB567SSTlkScGh6vP9Wh8zgOz2gJPAy7UKhsmQ2s
         w/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTct4abHBWajP1HfOai1RtaSmPzCQaGQ6D+sTVoERpw=;
        b=qWMDu0uqtoPBEg+p8DsI8pHjZBznDQ7pfhOtADKqsxFYgVM9vZqlNoxBdKazyU6mSu
         jSaX1FjjZytyQAe5s9lujlUG+ck4FK0uuoOe5UkKvwj1oUH3bn15mePkMfOzP5cOiNn+
         PFuLxDKRJQs8bOBRQoLuPyGi5hoCJ1vBzH0A+4OQZQyyLax+bV0u3ZwmMcuwxSU/rZrf
         /6xrx6ttohmWlqAuBx5QQUgCRTJlzMooebOL1QBYnkc/ES+DyUtkmnhKuct/ME6HtP7D
         +5a/FMs1LGGWYoTPVu1V/PfO7TZoCi+Jex/Ce8gvderWInHpM0igcRj1f53sWtHYC2vP
         AiOg==
X-Gm-Message-State: APzg51DtShLcDlWdwdkayAVSsU8XeDMImnPsLAm1OYkAEUdvmMpE3t6P
        Ntz2UUVgmxEcJFdknEvR11NL+g==
X-Google-Smtp-Source: ANB0Vdbh/sAqmFhPNwM4h0hX4EIniKcDCWPHNkM8c7xReHP5eLvqfQcFE90DG3U7ou6pLQPNJNxE7A==
X-Received: by 2002:a50:c082:: with SMTP id k2-v6mr11130239edf.294.1536605438522;
        Mon, 10 Sep 2018 11:50:38 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a11-v6sm7932529edn.95.2018.09.10.11.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:50:37 -0700 (PDT)
Message-ID: <1536605436.2710.5.camel@arista.com>
Subject: Re: [LKP] [tty] 0b4f83d510: INFO:task_blocked_for_more_than#seconds
From:   Dmitry Safonov <dima@arista.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jiri Slaby <jslaby@suse.cz>
Cc:     kernel test robot <rong.a.chen@intel.com>, lkp@01.org,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Mon, 10 Sep 2018 19:50:36 +0100
In-Reply-To: <20180910051452.GA518@jagdpanzerIV>
References: <20180907045041.GF1110@shao2-debian>
         <d5d23bc5-0e11-5cee-6d66-514dfc4fc25b@suse.cz>
         <20180910051452.GA518@jagdpanzerIV>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey, Jiri,

On Mon, 2018-09-10 at 14:14 +0900, Sergey Senozhatsky wrote:
> On (09/07/18 08:39), Jiri Slaby wrote:
> > > [  244.944070] 
> > > [  244.944070] Showing all locks held in the system:
> > > [  244.945558] 1 lock held by khungtaskd/18:
> > > [  244.946495]  #0: (____ptrval____) (rcu_read_lock){....}, at:
> > > debug_show_all_locks+0x16/0x190
> > > [  244.948503] 2 locks held by askfirst/235:
> > > [  244.949439]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x50
> > > [  244.951762]  #1: (____ptrval____) (&ldata-
> > > >atomic_read_lock){+.+.}, at: n_tty_read+0x13d/0xa00
> > 
> > Here, it just seems to wait for input from the user.
> > 
> > > [  244.953799] 1 lock held by validate_data/655:
> > > [  244.954814]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x50
> > > [  244.956764] 1 lock held by dnsmasq/668:
> > > [  244.957649]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x50
> > > [  244.959598] 1 lock held by dropbear/734:
> > > [  244.967564]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at:
> > > tty_ldisc_ref_wait+0x25/0x50
> > 
> > Hmm, I assume there is another task waiting for write_ldsem and
> > that one
> > prevents these readers to proceed. Unfortunately, due to the
> > defunct
> > __ptrval__ pointer hashing crap, we do not see who is waiting for
> > what.
> > But I am guessing all are the same locks.
> 
> Hmm, interesting. Am I getting it right that the test did pass
> before.
> And now we see that sort of/smells like live-lock right after the
> introduction of tty_ldisc_lock() to tty_reopen().
> 
> > So I think, we are forced to limit the waiting to 5 seconds in
> > reopen in
> > the end too (the same as we do for new open in tty_init_dev).
> 
> If I got it right, LKP did test the 5*HZ patch
> 
> 	retval = tty_ldisc_lock(tty, 5 * HZ);
> 
> At least it's
>  In-Reply-To: <20180829022353.23568-3-dima@arista.com>
> 
> and
>  Message-Id: <20180829022353.23568-3-dima@arista.com>
> 
> is the patch which does the 5*HZ lock timeout thing.

Yeah, I also noticed on the weekend that the commit in the mentioned
branch is from v1..

Currently, I tried to reproduce it like ~15-20 times, but unlucky :(

It looks like, the lockup wasn't introduced by this commit, but
unfortunately the commit made it more likely. At least, that's what I
suppose after I've found this report:
https://lkml.org/lkml/2017/11/21/216

It seems to me that the lockup is triggered by:
[  244.948503] 2 locks held by askfirst/235:
[  244.949439]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at:
tty_ldisc_ref_wait+0x25/0x50
[  244.951762]  #1: (____ptrval____) (&ldata->atomic_read_lock){+.+.},
at: n_tty_read+0x13d/0xa00

Looking into this..

-- 
Thanks,
             Dmitry
