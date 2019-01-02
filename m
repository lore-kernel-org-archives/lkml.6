Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D292C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F373A20657
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfMzQWqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfABPmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:42:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46599 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfABPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:42:42 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so24775560ios.13;
        Wed, 02 Jan 2019 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiLFLhBXdYY3jCFedCfq4+ipsrmddGhUNvb7y4N22Q0=;
        b=PfMzQWqA0fsH3hxPX7VWjU7CPeSK+TecUSnK5LmZfhxktqVOzVz/ZlDOHzwbSFhsrh
         ZTRjCfC4TqrMgbM+fjagH1rf5xX8+LB1nq0ltwJavTV6KOJHebD0IgN+AqIaFRv1ZDbQ
         8Lc5yjPOt6aSD3j1cIJFwUfyOtuSNyRPKSFaG9MweqAyE2dZRuH8+OYr8P7XdaduOaUj
         bV0CJdpR80DUqzaT4syC8CdQHi6Sq2tHTpQPitzKkrVMaV67RWubgUqkNPC72ggQ2l+O
         nwENTUGo7fXvtcO1x0jOXxHXUIwf6x6ENzxQ+GN0+8WiwsjKjGffTe+0xSiZxvWRKuCP
         droA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiLFLhBXdYY3jCFedCfq4+ipsrmddGhUNvb7y4N22Q0=;
        b=IHsL/Ot09INdpBk4zZr2Q7ZhxcnC2AN4rG8QPU2QBfrMiot7HeN7Ct7rviQ7KFLaP3
         0YW0BkUU681R1k1x/YJXdHw1SmS+yBaupoQrkHLS1aQ5tx9eiRSTB41sOCeFREqUzaHe
         rZrKsDUn+n2ebqsliv8tHvg5gmV6U8JEc075sBLu1UltxUZL2ONJK6pNN7+rIrgOOnhW
         AqLh/3ihur3MAEqRTXZOXWx6+8XOntGrlwgulqCc80tgdtyH7HezCM7wuoc4XuBQSgWY
         7k2V2mVPsxlmq0H/LNhYX71ggJw7bCzRqOzwFIhbSHIRTy3vzMv7nUBaa5576/wCaPAz
         bzUA==
X-Gm-Message-State: AJcUukegxeXKWdE+lW1dHYv4s9SxHSqBHW0096OfpvSvys8gzHL9g3Tx
        I63TCqPqa3OlhzRrhBNTKC0YshSvXgabYTCAg4w=
X-Google-Smtp-Source: ALg8bN7IHSH8uhEovlOjlbXgzOQAIbIVZbrO9eR/lRL0F4UeLZQU609aV+ak/Y4zALdhZSFv6s9h4qKuE1pdrAicqTo=
X-Received: by 2002:a6b:2b95:: with SMTP id r143mr31789591ior.217.1546443761377;
 Wed, 02 Jan 2019 07:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20181227190842.GA19565@myunghoj-Precision-5530>
In-Reply-To: <20181227190842.GA19565@myunghoj-Precision-5530>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 2 Jan 2019 16:42:47 +0100
Message-ID: <CAOi1vP9G=-ZLBKH6Y5MoDRUjX4YkN6GUWKm1=fnM02odQX8GWA@mail.gmail.com>
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

On Thu, Dec 27, 2018 at 8:08 PM Myungho Jung <mhjungk@gmail.com> wrote:
>
> con_flag_test_and_set() sets CON_FLAG_KEEPALIVE_PENDING and
> CON_FLAG_WRITE_PENDING flags without protection in ceph_con_keepalive().
> It triggers WARN_ON() in clear_standby() if the flags are set after
> con_fault() changes connection state to CON_STATE_STANDBY. Move
> con_flag_test_and_set() to be called before releasing the lock and store
> the condition to check after the critical section.
>
> Reported-by: syzbot+acdeb633f6211ccdf886@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
>  net/ceph/messenger.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 2f126eff275d..e15da22d4f37 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -3216,12 +3216,16 @@ void ceph_msg_revoke_incoming(struct ceph_msg *msg)
>   */
>  void ceph_con_keepalive(struct ceph_connection *con)
>  {
> +       bool pending;
> +
>         dout("con_keepalive %p\n", con);
>         mutex_lock(&con->mutex);
>         clear_standby(con);
> +       pending = (con_flag_test_and_set(con,
> +                                        CON_FLAG_KEEPALIVE_PENDING) == 0 &&
> +                  con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0);
>         mutex_unlock(&con->mutex);
> -       if (con_flag_test_and_set(con, CON_FLAG_KEEPALIVE_PENDING) == 0 &&
> -           con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
> +       if (pending)
>                 queue_con(con);
>  }
>  EXPORT_SYMBOL(ceph_con_keepalive);

Hi Myungho,

Were you able to reproduce?  If so, did you use the syzkaller output or
something else?

Thanks,

                Ilya
