Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D6E2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3hiMLkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfACDue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:50:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33650 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfACDue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:50:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so16076760pfb.0;
        Wed, 02 Jan 2019 19:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9cSZdFZ7CMzpwJQceG+W70npdrdymOLV0cQSdhHsyM0=;
        b=A3hiMLkt8H3cqPpfl9EQqXjTyoPPyh+lk4rTCalyWYI8S+uYtc8ZODaLdd+5DLDGqh
         qIDwIYig1zaQ9bz01xRXGwZ07cy7Jmpv7XKC5RdoB+4Gcuv5b74PFs8QuWSv6vmQi/or
         iVLhfPc75MliHie9pm3CEn7HeArz1F/Jk31iJaS4vFww0qC19IF+r2hzOQ1rjaSHBDQB
         NMdhjLmSKA0msGTeRSFyoHZtiuxl+0C5I5bL0BrETX7z2rFrgLtBLV0uAK8WlgwLbIzi
         Dl8sbU+JjB589WvAQhTVJ7oeR8Ans0XiFQU3SOv+yYwO/9ttVfa3xrAYAEGtJdOrvtbT
         zG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9cSZdFZ7CMzpwJQceG+W70npdrdymOLV0cQSdhHsyM0=;
        b=aBsVljBBsyjHkBzNVeDwU82mQynj8m7WUr5J7WWQxOTdzyecUQ8NpBa4jF7yO/+Cg/
         1kRk6e+7HhsMORNXB0o5fimFw765dGZxUl2ef1bWg9eU33lkYeeMkKBfV0caccsGLFoN
         +6rqVTDN5Sjf0bN41Ya+FNgzl1PFe+0r/HEfw5KjClES3sraT8asAvGCKTV3ajpb9Ip3
         L4ws5hh/k+fKNWs6cPJG42jHhPUGZGSC7vvBg32dfBceFnQk+grm/0BCPmKJX5iZdpRL
         ZwtU9QfHbep5dKvYq8EvO+G9sEuCS28G2i/dIWjRm9JIC7MMrwMvPnzwzbYhdyAo17Wk
         W/YQ==
X-Gm-Message-State: AA+aEWYpiROIuMzisniFx46hIpL4k77zk5LWC0JdX/Wcy++Mv480b4DY
        kITfq0EbWzdSzJNttjraJ5+8bVIH
X-Google-Smtp-Source: AFSGD/Wvg2hAa3fMMLR4Wu1yF9agqinCCW1zI3Cp6A0Rytd6Px/pdrBmfxNUGGoPH7EicKYgS/uB3g==
X-Received: by 2002:a62:4e83:: with SMTP id c125mr47242845pfb.101.1546487432667;
        Wed, 02 Jan 2019 19:50:32 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id n70sm84474538pfi.185.2019.01.02.19.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 19:50:32 -0800 (PST)
Date:   Wed, 2 Jan 2019 19:50:29 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: protect pending flags in ceph_con_keepalive()
Message-ID: <20190103035027.GA26674@myunghoj-Precision-5530>
References: <20181227190842.GA19565@myunghoj-Precision-5530>
 <CAOi1vP9G=-ZLBKH6Y5MoDRUjX4YkN6GUWKm1=fnM02odQX8GWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP9G=-ZLBKH6Y5MoDRUjX4YkN6GUWKm1=fnM02odQX8GWA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 04:42:47PM +0100, Ilya Dryomov wrote:
> On Thu, Dec 27, 2018 at 8:08 PM Myungho Jung <mhjungk@gmail.com> wrote:
> >
> > con_flag_test_and_set() sets CON_FLAG_KEEPALIVE_PENDING and
> > CON_FLAG_WRITE_PENDING flags without protection in ceph_con_keepalive().
> > It triggers WARN_ON() in clear_standby() if the flags are set after
> > con_fault() changes connection state to CON_STATE_STANDBY. Move
> > con_flag_test_and_set() to be called before releasing the lock and store
> > the condition to check after the critical section.
> >
> > Reported-by: syzbot+acdeb633f6211ccdf886@syzkaller.appspotmail.com
> > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > ---
> >  net/ceph/messenger.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index 2f126eff275d..e15da22d4f37 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -3216,12 +3216,16 @@ void ceph_msg_revoke_incoming(struct ceph_msg *msg)
> >   */
> >  void ceph_con_keepalive(struct ceph_connection *con)
> >  {
> > +       bool pending;
> > +
> >         dout("con_keepalive %p\n", con);
> >         mutex_lock(&con->mutex);
> >         clear_standby(con);
> > +       pending = (con_flag_test_and_set(con,
> > +                                        CON_FLAG_KEEPALIVE_PENDING) == 0 &&
> > +                  con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0);
> >         mutex_unlock(&con->mutex);
> > -       if (con_flag_test_and_set(con, CON_FLAG_KEEPALIVE_PENDING) == 0 &&
> > -           con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
> > +       if (pending)
> >                 queue_con(con);
> >  }
> >  EXPORT_SYMBOL(ceph_con_keepalive);
> 
> Hi Myungho,
> 
> Were you able to reproduce?  If so, did you use the syzkaller output or
> something else?
> 
> Thanks,
> 
>                 Ilya
Hi Ilya,

I reproduced on vm using syzkaller utils and verified the fix by syzbot.

Thanks,
Myungho
