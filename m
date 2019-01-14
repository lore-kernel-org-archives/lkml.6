Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A91AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676CD20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X96IbwxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfANUhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:37:37 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52173 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANUhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:37:37 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so1648820ite.1;
        Mon, 14 Jan 2019 12:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHx/tBNv0XiIGAnQUaDsznrgTpkI55fwt+sl3UVxk78=;
        b=X96IbwxP/MSsUvZ6fTQOUWYL2S2Nhm3tcIPvq5tlultQurncIajso0w1RnOI1xiWM8
         +KqGsNd/dSzhz0BJmiWiuBPUjtbp/LT6WLNIzgVyrEpW1GWG5kYTlGHgFa92yJBhYXJZ
         33BdvxRpba3jASQi6BSZp6I3a1Z/x6jHlecxObS8C3h92IBTmZt4i43J5RcagIyGhpqj
         mBoh7/3up14XQp4f6WOoWHiganraKkN1167j52RpN6nb/1UJipSLdlYWpg+IOKfs8XQq
         2nb3HvlBUTiOqI1yhfI2Od+js5btTmT+7CiFFp7jcVng/StwU5iwmo/jNKPsN05xdTND
         IwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHx/tBNv0XiIGAnQUaDsznrgTpkI55fwt+sl3UVxk78=;
        b=qNjHGksXIlm2OsBXW1mJ6WWRZCNEh30uOPyjMaW2Nrb1CahzhtTjQWCp+d7OaD4YNX
         c2FfS+zl6AmnVgfRvEd1hrCrvrNT0KbivYQ4gTySUul0HSiccTN2CQi8PDtmA4szeOaU
         avb7DRdAVUEY0zEz4HJwKBWgrx6TISXwGZBiNc+nB24CNm2H0BPVtwV7ccY/NOr6ZJqr
         gJLsPrvL8ccJectmOeASe3uINmu1fhxc+CW1eVwLq4NW6CJcgsc+3VD8t+9hZd+sNldF
         7hHAwP90BRJJYqPL7Yc/t7QA9efr/+pXbZfs0N7ftrA6U6eI+X3wZAwL4sQhgy7wFwLP
         URcw==
X-Gm-Message-State: AJcUukfZVfcaMMk5/6TgGjJ7I6zE+2ZcSY3cWB8QQGojShw6etZy0RnJ
        7Fg8bkQpoijtke7k7G68h0oqS0XJ1MwkJvVjrio=
X-Google-Smtp-Source: ALg8bN5QUArnWHCO85LPqcFHwlBLEdVhENbPrluPT652uHqucScJ8KgSERKuTRKdwyNXO17fqIvDASYjZjkTZQ94AO8=
X-Received: by 2002:a02:7b09:: with SMTP id q9mr191737jac.39.1547498256382;
 Mon, 14 Jan 2019 12:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20181227190842.GA19565@myunghoj-Precision-5530>
 <CAOi1vP9G=-ZLBKH6Y5MoDRUjX4YkN6GUWKm1=fnM02odQX8GWA@mail.gmail.com> <20190103035027.GA26674@myunghoj-Precision-5530>
In-Reply-To: <20190103035027.GA26674@myunghoj-Precision-5530>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 14 Jan 2019 21:37:25 +0100
Message-ID: <CAOi1vP-FC+X+DeLMBcefYuSjxzLgAsxQg+RNskaZsUvVbmXuYA@mail.gmail.com>
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

On Thu, Jan 3, 2019 at 4:50 AM Myungho Jung <mhjungk@gmail.com> wrote:
> I reproduced on vm using syzkaller utils and verified the fix by syzbot.

Hi Myungho,

I think this might be a better fix:

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d5718284db57..c5f5313e3537 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3205,10 +3205,11 @@ void ceph_con_keepalive(struct ceph_connection *con)
 {
        dout("con_keepalive %p\n", con);
        mutex_lock(&con->mutex);
+       con_flag_set(con, CON_FLAG_KEEPALIVE_PENDING);
        clear_standby(con);
        mutex_unlock(&con->mutex);
-       if (con_flag_test_and_set(con, CON_FLAG_KEEPALIVE_PENDING) == 0 &&
-           con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
+
+       if (con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
                queue_con(con);
 }
 EXPORT_SYMBOL(ceph_con_keepalive);

WRITE_PENDING can be set without con->mutex held from socket callbacks.
This is the reason we use atomic bit ops here, so testing WRITE_PENDING
under the lock didn't make sense to me.

At the same time, KEEPALIVE_PENDING could have been a non-atomic flag.
I spent some time trying to make sense of conditioning queue_con() call
on the previous value of KEEPALIVE_PENDING and couldn't see any, so I'm
setting it with con_flag_set(), making ceph_con_keepalive() symmetric
with ceph_con_send().

Thanks,

                Ilya
