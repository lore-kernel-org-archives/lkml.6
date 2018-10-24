Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E6EC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892482081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/BVRuGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892482081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeJXSCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:02:54 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45835 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeJXSCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:02:54 -0400
Received: by mail-yb1-f194.google.com with SMTP id 131-v6so1827191ybe.12;
        Wed, 24 Oct 2018 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNb+D6KVYvJr2zCC5kwnb1pCzRAfzxIodsxOqhjkHv4=;
        b=g/BVRuGQ4ECFbnD67MDLK/kjwq/Z7mh10OJyoDNQync5rqBcyJIRAkalCKv6rnsXmi
         FzRzEj3opqY8CKVF4e54bE0Adu5XPCz/iWe3UDqCmh0yEhsTBNGTIY7otq3IrZAmaj0T
         Tqcm2VNkrZbcU9Pa8DPTe6SiQigC+S06ES7RLL3VkXCUWdUJ49VhT4u7VepR5t+7WR4u
         cumUeRYIq7ufrfNeINmDb5zCrgfE5HQQkDbK3/5d7og1+hnXvDQ1gEUBDpdEOpriXhRK
         uEcRztFo0O2cPkOMFgllXtpjQQwoBQThr/rlJ0ZKYh5XMo1uMnuy8XvmNgKxJiMsOrMC
         beCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNb+D6KVYvJr2zCC5kwnb1pCzRAfzxIodsxOqhjkHv4=;
        b=MOx8gOVy1yHeYTB7Ce8vWBGNJGWMp1LOjO0zJDLT4Zl5XXfD9I9FWa9O0txvDrWkBf
         Q8Ie8P4ww+lVUnNfKyuivU3vwv1qIiHOuLzhPJi9nxmGbxICTgmK/1lZwUfx5WZ+fXez
         vN56kriz8TzGHCD0Tx9RBysdgSw4WQFzlSqAQKECzJoveI6tgUKGOdWFr5+j7+sXvFsb
         3wAF++5Pd62ZvJWB4JWxvfyJYosdc5Mosqnc4ZMAhAjO2UuT0K+ASp+xx+IIVhFhG3UB
         iT2SPHAd0DmWNjOU6+0/5Fys3MIgcXhM04K/nRvrtgUZQsnEcCx5TKK6pnxloEFTbnjg
         I/tw==
X-Gm-Message-State: AGRZ1gJ/9OMe00FrHNGNA/ydENZDZRYQ8EJ47+1nkkAzRf6BeU4dReRc
        jq4zw4hz+2TyqctqoKHhtkReK0GzfblqFu4JoCI=
X-Google-Smtp-Source: AJdET5e+zjx9kc50H/ShV9PO3pBuVl0rdy4PhDGO0X0tnG9tViBIAMeb8E9+G/WZrBbI2IWCfFyUh59mmnXchyuyZ5c=
X-Received: by 2002:a25:fc0d:: with SMTP id v13-v6mr1474813ybd.320.1540373731835;
 Wed, 24 Oct 2018 02:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003852440576ef80b2@google.com> <CACT4Y+bR+9vy5ZKDN31gmvKk5hcoNojaBuD9Dz1wswfObyt0uw@mail.gmail.com>
 <CAOQ4uxhxON4EeWqVLN68YF4v=hr5wfQk9wZEZLZLZu7B_XGuUw@mail.gmail.com> <20181024090959.s5y3azpsmtswjyn5@mwanda>
In-Reply-To: <20181024090959.s5y3azpsmtswjyn5@mwanda>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Oct 2018 12:35:21 +0300
Message-ID: <CAOQ4uxi84ywY4BXJ1ZYDOQHZhbYr+GjJTrkGZvBbH4XUqR0nPw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in string (2)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs@googlegroups.com, Jan Harkes <jaharkes@cs.cmu.edu>,
        Jeff Layton <jlayton@kernel.org>, Mark Fasheh <mark@fasheh.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/fs/lockd/host.c b/fs/lockd/host.c
> > index d35cd6be0675..93fb7cf0b92b 100644
> > --- a/fs/lockd/host.c
> > +++ b/fs/lockd/host.c
> > @@ -341,7 +341,7 @@ struct nlm_host *nlmsvc_lookup_host(const struct
> > svc_rqst *rqstp,
> >         };
> >         struct lockd_net *ln = net_generic(net, lockd_net_id);
> >
> > -       dprintk("lockd: %s(host='%*s', vers=%u, proto=%s)\n", __func__,
> > +       dprintk("lockd: %s(host='%.*s', vers=%u, proto=%s)\n", __func__,
> >                         (int)hostname_len, hostname, rqstp->rq_vers,
> >                         (rqstp->rq_prot == IPPROTO_UDP ? "udp" : "tcp"));
> >
>
> Why wasn't this one applied?  It looks correct to me.  The rest seem to
> have been fixed already.
>

I did not send this patch to Jeff.
Jeff was CC'ed on the patch I sent to Miklos
and Miklos decided to only take the overlayfs bits:
https://marc.info/?l=linux-unionfs&m=153847248625015&w=2

So I guess it has fallen between the cracks.
Feel free to send a patch to Jeff.

Thanks,
Amir.
