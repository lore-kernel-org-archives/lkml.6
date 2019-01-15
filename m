Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D0BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB8220656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La6n67rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfAOKRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:17:34 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54642 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfAOKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:17:33 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so4163909ita.4;
        Tue, 15 Jan 2019 02:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ms+YpuQp7Oapmd+InaQg1EXZiirkQo/uM2cTbM4FmMo=;
        b=La6n67rzvh+uN2StVZ3+5+XHIugXHAeIhjzJmApG5VoCFRUED80Lal74/fxK3M69Na
         7WnRqXr5OFbnebxX5N/oBcWgHLa4Wk5DdTpELpj5U14orBtxf472k8I1zz47YUTjuYiG
         ADHJwY891nvjr8rQUXggJ/o9LRV70FpuaTc8VFiVp6WFGaMDZTA4G9pD61Rr3nhKGL6x
         UQzNqXTnbWyzLAfArqgOZf+HOhLLoT9bifVZDadunfFY9mAGfE/Ab5ju53fp7yzrMxRz
         hLy4zDUw0T1CQztfSvNBlpP08UgM+JIe6TzEgigCWGWWw2QgRi/df55VjvXPVylsb9Ak
         kgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ms+YpuQp7Oapmd+InaQg1EXZiirkQo/uM2cTbM4FmMo=;
        b=mpN8OTRNBIdlvuYTisKmUDZWftALmeAqAjD6UY4vHtyefJkjujsQSCJE0cUkh8G7gT
         t+zl9S9AJpqa5QGl9PXDAj/NwoCx6FaKsOr5ep84pezhh6WMTQt7SuH+6AfHk5G75tFZ
         KWukbooTgMI7C/QphFt0/z+yIJNblKZqTXQioE2+VsrgEBPsgcsFOQRaI/LncT5xsJWM
         5dPSC5OsXP1iMmIW/Ise40tXG6zNouoaT1Aoh4B98DW++BNM0e7BoK7EhkiIA6YgyxXY
         XPTvoPEfgI7HsYe/95UQ5e3o9qbe0k3juBNa4dd7Yb6uOR8Wq7DTyokRkbipN3vG8/UW
         LdQw==
X-Gm-Message-State: AJcUukfkpISwRxAIqlL8IkCjN4NOeVaZX5abJ7nlGggcIT5SYu8yDaju
        M2Fef50Ty0/+A3Fsg7hK1JFlDflRti7i24zPBwE=
X-Google-Smtp-Source: ALg8bN6yVzZ5DoyuIhl4ZMM30vWZVGMUywL2EbqxfTURrW9qPQneoUcY3TJwzF65DrYkt9Zv+8OsGNLjaQrvBPP6RVI=
X-Received: by 2002:a02:c943:: with SMTP id u3mr1628688jao.96.1547547452148;
 Tue, 15 Jan 2019 02:17:32 -0800 (PST)
MIME-Version: 1.0
References: <20181227190842.GA19565@myunghoj-Precision-5530>
 <CAOi1vP9G=-ZLBKH6Y5MoDRUjX4YkN6GUWKm1=fnM02odQX8GWA@mail.gmail.com>
 <20190103035027.GA26674@myunghoj-Precision-5530> <CAOi1vP-FC+X+DeLMBcefYuSjxzLgAsxQg+RNskaZsUvVbmXuYA@mail.gmail.com>
 <20190115065558.GA7165@myunghoj-Precision-5530>
In-Reply-To: <20190115065558.GA7165@myunghoj-Precision-5530>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 15 Jan 2019 11:17:20 +0100
Message-ID: <CAOi1vP9ntEg=Q5RnF9xkasqC3r_wjWzGvCC6hpwZQ=xPQM21Bw@mail.gmail.com>
Subject: Re: [PATCH] libceph: protect pending flags in ceph_con_keepalive()
To:     Myungho Jung <mhjungk@gmail.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 7:56 AM Myungho Jung <mhjungk@gmail.com> wrote:
>
> On Mon, Jan 14, 2019 at 09:37:25PM +0100, Ilya Dryomov wrote:
> > On Thu, Jan 3, 2019 at 4:50 AM Myungho Jung <mhjungk@gmail.com> wrote:
> > > I reproduced on vm using syzkaller utils and verified the fix by syzbot.
> >
> > Hi Myungho,
> >
> > I think this might be a better fix:
> >
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index d5718284db57..c5f5313e3537 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -3205,10 +3205,11 @@ void ceph_con_keepalive(struct ceph_connection *con)
> >  {
> >         dout("con_keepalive %p\n", con);
> >         mutex_lock(&con->mutex);
> > +       con_flag_set(con, CON_FLAG_KEEPALIVE_PENDING);
> >         clear_standby(con);
> >         mutex_unlock(&con->mutex);
> > -       if (con_flag_test_and_set(con, CON_FLAG_KEEPALIVE_PENDING) == 0 &&
> > -           con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
> > +
> > +       if (con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
> >                 queue_con(con);
> >  }
> >  EXPORT_SYMBOL(ceph_con_keepalive);
> >
> > WRITE_PENDING can be set without con->mutex held from socket callbacks.
> > This is the reason we use atomic bit ops here, so testing WRITE_PENDING
> > under the lock didn't make sense to me.
> >
> > At the same time, KEEPALIVE_PENDING could have been a non-atomic flag.
> > I spent some time trying to make sense of conditioning queue_con() call
> > on the previous value of KEEPALIVE_PENDING and couldn't see any, so I'm
> > setting it with con_flag_set(), making ceph_con_keepalive() symmetric
> > with ceph_con_send().
> >
> > Thanks,
> >
> >                 Ilya
>
> Hi Ilya,
>
> Yes, it looks clear and makes sense to have an atomic operation in if statement
> but it still triggers warning. KEEPALIVE_PENDING should be set after
> clear_standby() because con_fault() can be called right before acquiring the
> lock here which sets the flag in standby state. I tesed the change with syzbot
> and confirmed there was no warning.

Right, it still triggers one of the warnings.  I was too focused on
WRITE_PENDING and missed that in plain sight.  I'll update the patch.

Thanks for testing!

                Ilya
