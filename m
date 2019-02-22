Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34D32070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEj8/HbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfBVSGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:06:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34525 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfBVSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:06:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id d15so1447060plr.1;
        Fri, 22 Feb 2019 10:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fkpooVA+/bjG/wpbjjTokfN74hjq5FqsviGSd0J83k=;
        b=EEj8/HbBIMK1X8abUz/Tq9eBWzcw3WSTejlwf9Ti4uRdtPeGoMTBukVPckllyNbv2t
         7pWBeaRst6I9NjWtQWW69rSAhVptjxU4KhzRwaWiCSy8vKRypGFTtszXvU1ylSWGSFEn
         ejtvRcmqp+bBW/4ybUnR+DLqTExq7xU383sAqtDq+xVT84/yxu9+ngSLNyi1LR9bu1bi
         dbTW07cGncLXTLW95fLuVODU/iag5p4d5TZCuyh+n7bOZyqamNPX/F8BEMv+d6p8X+iM
         7hOKagCgB9JC+eRbnHD5NID7QxRtvSmgO7wQLvdZhtnd0GaYY+VraJESHLu8WB8D1qQP
         Y9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fkpooVA+/bjG/wpbjjTokfN74hjq5FqsviGSd0J83k=;
        b=QTRo1ESUxznXwtJ/T8qeVDK7cgHYbEEdK04s0c9ikNoXbK+jKFhGx+IWOmbJ7AeQms
         xEV21QKPExaDB/fhob4x0BRVU1uAPn54Z3hBf4mX6sBj1w7HCDGBexysiqolXehQ1tBX
         U2uIqa1BIPtQxqxf9O6hCqVJkd2GT+eWsIM0RtLSWPqKMbURcnUYGL3ZEoY2bxMPSJYb
         kXKqqJGd69LR0wQBc6HSFmgwnGNXanu0tJ6VO5sc65tgCM/TrBR+FNHw50zUQUve4FFD
         ly9LwTGonkBpiNd16O10jV2JLUyrVDRE+nHgTWXXIEYqXlEpNyHmUibNztwqZiHTH/1P
         Hk/g==
X-Gm-Message-State: AHQUAuYqXbd6GYOm4CSNjOwVIk/doYKP0jpb3gTfALAZCaN7zxM+A7lx
        N4wODwHlqfMX89CeWVBJigVPDtnby87MmimK1Yc=
X-Google-Smtp-Source: AHgI3Ia6ky2tD2Ue/ojxnH4WQ2b8ni9LOdWX/T9An5uHJ9CncnvtEA3Xrnb2YcFDiXpD8v8jsB+livOcZhM5ujZvmoI=
X-Received: by 2002:a17:902:2b8a:: with SMTP id l10mr5201458plb.70.1550858769012;
 Fri, 22 Feb 2019 10:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20190221221356.173485-1-ebiggers@kernel.org>
In-Reply-To: <20190221221356.173485-1-ebiggers@kernel.org>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 22 Feb 2019 10:05:57 -0800
Message-ID: <CAM_iQpV-QqUJZzvZ4reafkRr3c8uF+R2iW-wFxcEo2R7_etkcg@mail.gmail.com>
Subject: Re: [PATCH net] net: socket: set sock->sk to NULL after calling proto_ops::release()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Mao Wenan <maowenan@huawei.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 2:14 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Commit 9060cb719e61 ("net: crypto set sk to NULL when af_alg_release.")
> fixed a use-after-free in sockfs_setattr() when an AF_ALG socket is
> closed concurrently with fchownat().  However, it ignored that many
> other proto_ops::release() methods don't set sock->sk to NULL and
> therefore allow the same use-after-free:
>
>     - base_sock_release
>     - bnep_sock_release
>     - cmtp_sock_release
>     - data_sock_release
>     - dn_release
>     - hci_sock_release
>     - hidp_sock_release
>     - iucv_sock_release
>     - l2cap_sock_release
>     - llcp_sock_release
>     - llc_ui_release
>     - rawsock_release
>     - rfcomm_sock_release
>     - sco_sock_release
>     - svc_release
>     - vcc_release
>     - x25_release
>
> Rather than fixing all these and relying on every socket type to get
> this right forever, just make __sock_release() set sock->sk to NULL
> itself after calling proto_ops::release().
>
> Reproducer that produces the KASAN splat when any of these socket types
> are configured into the kernel:
>
>     #include <pthread.h>
>     #include <stdlib.h>
>     #include <sys/socket.h>
>     #include <unistd.h>
>
>     pthread_t t;
>     volatile int fd;
>
>     void *close_thread(void *arg)
>     {
>         for (;;) {
>             usleep(rand() % 100);
>             close(fd);
>         }
>     }
>
>     int main()
>     {
>         pthread_create(&t, NULL, close_thread, NULL);
>         for (;;) {
>             fd = socket(rand() % 50, rand() % 11, 0);
>             fchownat(fd, "", 1000, 1000, 0x1000);
>             close(fd);
>         }
>     }
>
> Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
> Cc: <stable@vger.kernel.org> # v4.10+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
