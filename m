Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F212C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C48B206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hc81N4aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfADKcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:32:25 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:35055 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfADKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:32:24 -0500
Received: by mail-it1-f177.google.com with SMTP id p197so991104itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 02:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJ/yfDmBuHnO+ny/3gz+6yKNZoIKZ4geGslJZE7/HDc=;
        b=Hc81N4aPRSL5BP2i73Q9Qh5rOpNKWvIbjC1eFxdqhb7CrT55gnMzZpVvA8nthiul+L
         1OVZ31hY24eKNlOzzVYXGmnlZS++kuD0EabLf+ToSatKk2lbm46XLx+SC5CJIv2KmtA5
         o0Qd0QzxQkvZGpaIeKTzFB3h1P51fEW8ogJiTNQFk5lggewM7gziRcBV1M3FuPZ3teSw
         UY4LXluTL+G2b++GXFqhPOTR8HL4OSjr+zT7jUYehjYZkkA3m6mmgdEouwIxVmqjghtI
         djnQn+8ur/12oHiR+gOJeoJDHQ7hoJXdvK10RMXqQP9W83InOSuCzkpUG5Pjrj9tO4ux
         Ig8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJ/yfDmBuHnO+ny/3gz+6yKNZoIKZ4geGslJZE7/HDc=;
        b=dKyUwrd44EOAcQiRHrNzoMtJAUSw1ZaPlVPnRvu328+eNT3Yij12nllLAVbBs+njs7
         qvvPBOsRkYtCX3gabbwFRdt4UGYUic6CdlYwaJoUlKVp6E+IKw287a7GiNbjPi2EYTKm
         8fxBKSaPNggh3m+PASrLkc+tvRm+qAPX8DXZasHz1vUNI2RbzBTib6Qrs8QwsQa9FA1m
         4YqEhka/6sidfoB8Foc3eH6i9UZW+RNLT6Vou0cPMDAtmhMKUSo/JiIYxP/5upckYqZI
         bIOB1IrAYdSdKOSk0OlMrKlZaXpu3Gl34boXfvEZkyjYQ/cG1z3BPCxMF/BVkD3ikErA
         nGHA==
X-Gm-Message-State: AA+aEWbplbwEN80sLa5VNecp5LcllyAlz3xuWTQE1W98c83l1AUsK14z
        hF6xfciZgg4tBv4Kvg91dklEnWuMidk0JtG8wofZ7w==
X-Google-Smtp-Source: AFSGD/VUXOmDDH5enYML2voV6ZmKeOdQIur9FVf0W9Ax2YDQ3kCO9uuHsm/AiTWLdQya7SQnKtBjQBWfVDMEMmca3bI=
X-Received: by 2002:a02:8904:: with SMTP id o4mr33246713jaj.35.1546597943666;
 Fri, 04 Jan 2019 02:32:23 -0800 (PST)
MIME-Version: 1.0
References: <000000000000513fb7057e8d7013@google.com> <f2e566ac-5c4c-11ae-d436-ebb3522a2195@gmail.com>
 <20190103210743.6518841e@redhat.com> <CA+FuTScFwA3F44MvbaWrOYJ2EYgdKAmoMzEGjOLcz3ZPVQLLDA@mail.gmail.com>
 <20190103225404.66b0ec9f@redhat.com>
In-Reply-To: <20190103225404.66b0ec9f@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Jan 2019 11:32:12 +0100
Message-ID: <CACT4Y+aAofhchOpKTjLGGkQb5PAa74Uyp7kowdSoAwt130ZpAg@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 10:54 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Thu, 3 Jan 2019 15:15:06 -0600
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
>
> > syzbot generated stack traces with
> >
> > [  183.517380]  udpv6_err+0x46/0x60
> > [  183.520739]  ? __udp6_lib_err+0x1890/0x1890
> > [  183.525054]  gue6_err_proto_handler+0x199/0x280
>
> Where? I can't find that in any logs linked from the dashboard at
> https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0 :(

Stefano, there are these 4 bugs reported that have similarly looking
reproducers involving udp sockets and that crash modes that looks like
stack corruption/overflow:

https://syzkaller.appspot.com/bug?extid=14005fa30c9a07192934
https://syzkaller.appspot.com/bug?extid=d14090007dc9ba5fa9b7
https://syzkaller.appspot.com/bug?extid=137ed32ec9a6d5b0d5fe
https://syzkaller.appspot.com/bug?id=d5bc3e0c66d200d72216ab343a67c4327e4a3452

Are these the same bug as this?
