Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F84CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D47221529
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/Ca+Dqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D47221529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeHXTC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:02:59 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33261 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHXTC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:02:58 -0400
Received: by mail-io0-f193.google.com with SMTP id r196-v6so7451267iod.0;
        Fri, 24 Aug 2018 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQs85uBAOvHrNmagn+vPzHhSsY4OMqApYpJq9uBqLyw=;
        b=l/Ca+DqdIgeHJhiGGSwZAMk6aR1Pn0hNXLCg8aFnnk7o61dY6UPpZTEOBV4p3tbmJL
         PAcJLU32t2N89IuHP7lc84TQmOCeN5OxwUmbhBRLuH4Z7jHvOnec1P2umzVoWJ0nVWp9
         +29wY0wF6Gd5ZYN9VE7KSOnGzMb7X+qGphySIEB1TZLhZvAmVwxOFw1iFP5o3rNnrOhP
         00cngHg5QrcXWjx5qAedDuIPTnUvwDPfgnK96DlBRDU7h8KNXc9CpoDz4WqrT7UcXVNP
         n7yOJF7Cm4jY9eGsE2iNbjKleOHLMu4Jdu38GK1QlaXR9leHx36JqrXsHs6o/brpxyGL
         /czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQs85uBAOvHrNmagn+vPzHhSsY4OMqApYpJq9uBqLyw=;
        b=rQ/ADhYbFhpkzNPPFZz4U1xiYzngO4GIKsJc3euFn3qeAQdImxYhkfPb6/pkyC0YUq
         hEqRN91wLRxVs6HXjhI6H97ct9hEPdE1o4n0t/B9DUqEJ8neskY9ACKAJHIzTSlIdfUv
         SsekpNhnpN0cLtW48TyNJaGE4eSOstwPTvADC6q2FloIOLyvppzlS/hmycez5TGcRspw
         K+pG9KBheFUe1iaDCUENuJfkziXvJjBrjBwj30ngCRmmzq70WKbO4I5FSptLbwojpYm+
         /Vr0vm7Ih1R6BmxKbjkUSM6+pmCndsdMnfwdZS3OF8jFgHYQAxhXQ8w/3YCAfdtk0Jhl
         TpGA==
X-Gm-Message-State: APzg51CEBUScrSBFlpmRoLVMowB0qNeXgrolhKOyk7Uk2OsrVxKz5tN+
        TkVE3izQDH5Ruka6GQhTaHLLlc3g1/nhLFQsKtuJHugH
X-Google-Smtp-Source: ANB0VdYnX5AGqGSoLAeagKar9f19n+Swjv4vkagrR6GHdHBMXDhsYcBeJjrLoHR/OpgLGDeBXYdbRziAASl4wWONk00=
X-Received: by 2002:a6b:15c2:: with SMTP id 185-v6mr1764437iov.161.1535124470400;
 Fri, 24 Aug 2018 08:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ccaf1d0574297b6b@google.com> <20180824125150.GL5311@localhost.localdomain>
In-Reply-To: <20180824125150.GL5311@localhost.localdomain>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 24 Aug 2018 23:27:39 +0800
Message-ID: <CADvbK_dWirKTx7rwhuYqbBfwS32YqOaHab8fra0RFVg6+9e+4g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in sctp_transport_get_next
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     syzbot+fe62a0c9aa6a85c6de16@syzkaller.appspotmail.com,
        davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlad Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 8:51 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Fri, Aug 24, 2018 at 12:40:03AM -0700, syzbot wrote:
> > CPU: 1 PID: 12694 Comm: syz-executor0 Not tainted 4.18.0+ #107
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
> >  print_address_description+0x6c/0x20b mm/kasan/report.c:256
> >  kasan_report_error mm/kasan/report.c:354 [inline]
> >  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
> >  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> >  sctp_transport_get_next+0x11c/0x140 net/sctp/socket.c:5008
> >  sctp_transport_get_idx net/sctp/socket.c:5022 [inline]
>
> It is iterating over transports but then also accessing the
> association directly, without checking any refcnts before that.
>
> struct sctp_transport *sctp_transport_get_next(struct net *net,
>                                                struct rhashtable_iter *iter)
> {
>         struct sctp_transport *t;
>
>         t = rhashtable_walk_next(iter);
>         for (; t; t = rhashtable_walk_next(iter)) {
>                 if (IS_ERR(t)) {
>                         if (PTR_ERR(t) == -EAGAIN)
>                                 continue;
>                         break;
>                 }
>
>                 if (net_eq(sock_net(t->asoc->base.sk), net) &&
>                     t->asoc->peer.primary_path == t)
>                         break;
>
> and these t->asoc->  are risky because transport may be laying dead on
> the water already, as transports are freed by RCU and associations are
> not.
Thanks,
I will move sctp_transport_hold into sctp_transport_get_next():
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ce620e8..4bd5c2d 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4881,9 +4881,14 @@ struct sctp_transport
*sctp_transport_get_next(struct net *net,
                        break;
                }

+               if (!sctp_transport_hold(t))
+                       continue;
+
                if (net_eq(sock_net(t->asoc->base.sk), net) &&
                    t->asoc->peer.primary_path == t)
                        break;
+
+               sctp_transport_put(t);
        }

        return t;
@@ -4896,8 +4901,10 @@ struct sctp_transport
*sctp_transport_get_idx(struct net *net,
        void *obj = SEQ_START_TOKEN;

        while (pos && (obj = sctp_transport_get_next(net, iter)) &&
-              !IS_ERR(obj))
+              !IS_ERR(obj)) {
                pos--;
+               sctp_transport_put(obj);
+       }

        return obj;
 }
@@ -4958,8 +4965,6 @@ int sctp_for_each_transport(int (*cb)(struct
sctp_transport *, void *),

        tsp = sctp_transport_get_idx(net, &hti, *pos + 1);
        for (; !IS_ERR_OR_NULL(tsp); tsp = sctp_transport_get_next(net, &hti)) {
-               if (!sctp_transport_hold(tsp))
-                       continue;
                ret = cb(tsp, p);
                if (ret)
                        break;
