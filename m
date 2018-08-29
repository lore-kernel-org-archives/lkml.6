Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90A8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CAC205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ITQM2TL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CAC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeH2UeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:34:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40547 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeH2UeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:34:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so4396665edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3kgpvui78MyCtiysS+db7aq1YPpHwu05uJeSHvX2Afc=;
        b=ITQM2TL4GPneKbbB1zH9yeNBZOR3Bg7pmIN8L9j5VkuIkNmsTyDXjH6jdnA2SrsTEa
         qT0tTgv0ReuECEFPZk/5G3XIaH60WadE6hdmV9ShoW7bNfcvP4YkOL0k+emBBJHeRHJ5
         eUm45uJemOsiHJ0KVvKty41yQdpjERQD5vMX/dW2adQq5YC2Ab26KGkV22l6vh0qgNaQ
         P1Sxcb3GVEi7fk3LzrDlR9z0izukP6x6pO14Nopo82Mjzt/notxNy4QOEqfqKBShGoyR
         jmp5VwnQ20jc+GXwa5007sgMRD1CyBBihhEsiGbyzWRfe4MaNX0zX+XO0jH+gV94v2Nk
         eAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3kgpvui78MyCtiysS+db7aq1YPpHwu05uJeSHvX2Afc=;
        b=hdbpb64e7mJIEJq2pct9xg7yc4Y0CP54mJouLGLEFTu0HA8Mc/IuVwbJSe1/Mv7lNA
         hHpyyuxYj1Wnlj+iV4ba6H9I7kFmMZxD8NuuoCBpjqoGiG3WXu06GOWbBm/Dxo0a4jJl
         6UaRJwITEmfC02muwkkHDIg3wf2WdGsmDQbUqNPSNIdYPmcPVnxBdUjh5F1cKf1LtqjO
         LuRQ1+HV+C9mLHLtL9QFxhMEn6kvazgaZ+lOiT+1CGmHxwp7/99n6JnBCU7D58r5cfvL
         jUPXyw5/1mDIhlZT2RuhaFsB/5od8W360MCnz54J18cV/jh6vYBgLZn03rzliWwhGNby
         9s2g==
X-Gm-Message-State: APzg51B7msS+ZCXiPPLkxOJDy0b1njIx6jgTB3Krx6IaqY6JSOMGk0mk
        NPJD4p+6op8hNWUoxhgMSCm5uQ==
X-Google-Smtp-Source: ANB0VdYm176r0q31vccVCaYFeZ5ADllgl03CaLp46uiSPn/mUyyyMa4yJQT185be76xLpr1KEkW4VA==
X-Received: by 2002:a50:9aa4:: with SMTP id p33-v6mr8599627edb.156.1535560582554;
        Wed, 29 Aug 2018 09:36:22 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 30-v6sm1991887edt.24.2018.08.29.09.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 09:36:21 -0700 (PDT)
Message-ID: <1535560580.23560.65.camel@arista.com>
Subject: Re: [PATCH 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()
From:   Dmitry Safonov <dima@arista.com>
To:     Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Daniel Axtens <dja@axtens.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>, stable@vger.kernel.org
Date:   Wed, 29 Aug 2018 17:36:20 +0100
In-Reply-To: <914d8184-d5e6-519c-b355-7f1360cfa6a0@suse.cz>
References: <20180829022353.23568-1-dima@arista.com>
         <20180829022353.23568-3-dima@arista.com>
         <914d8184-d5e6-519c-b355-7f1360cfa6a0@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 16:40 +0200, Jiri Slaby wrote:
> On 08/29/2018, 04:23 AM, Dmitry Safonov wrote:
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
> > I think, tty_ldisc_reinit() should be called with ldisc_sem hold
> > for
> > writing, which will protect any reader against line discipline
> > changes.
> > 
> > Note: I failed to reproduce the described crash, so obiviously
> > can't
> > guarantee that this is the place where line discipline was
> > switched.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
> >  drivers/tty/tty_io.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index 5e5da9acaf0a..3ef8b977b167 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -1267,15 +1267,20 @@ static int tty_reopen(struct tty_struct
> > *tty)
> >  	if (test_bit(TTY_EXCLUSIVE, &tty->flags) &&
> > !capable(CAP_SYS_ADMIN))
> >  		return -EBUSY;
> >  
> > -	tty->count++;
> > +	retval = tty_ldisc_lock(tty, 5 * HZ);
> 
> Why 5 secs? This would cause random errors on machines under heavy
> load.

Yeah, I think MAX_SCHEDULE_TIMEOUT will make more sense here..
Not sure, why I decided to go with 5*HZ instead.
Will resend with new timeout, if everything else looks good to you.
(having in mind my argument for count++ in 1/4)

> 
> > +	if (retval)
> > +		return retval;
> >  
> > +	tty->count++;
> >  	if (tty->ldisc)
> > -		return 0;
> > +		goto out_unlock;
> >  
> >  	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
> >  	if (retval)
> >  		tty->count--;
> >  
> > +out_unlock:
> > +	tty_ldisc_unlock(tty);
> >  	return retval;
> 
> So what about:
>         tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
>         if (!tty->ldisc)
>                 ret = tty_ldisc_reinit(tty, tty->termios.c_line);
>         tty_ldisc_unlock(tty);
> 
>         if (!ret)
>                 tty->count++;
> 
>         return ret;
> 

-- 
Thanks,
             Dmitry
