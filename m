Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BFB2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="WVjj3stn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BFB2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeKRBLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 20:11:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44017 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 20:11:04 -0500
Received: by mail-oi1-f193.google.com with SMTP id u18so3798021oie.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 06:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IMpAl41uA4NZzmux89GC9Cn0TuXoGZWdv6wH9YzGp6k=;
        b=WVjj3stnKhZttJrXFDElqeDIHJV6pPgwc8ifhmervh5+OIDnKpS1mj0YuYYvNGBTJH
         XyJnm4xiHVUqhPo5nuu+ge1JxCQQvlnrI0B8Zahj5qim4A1iYXcOzsvU+V4JasMhmozl
         mjSRCNJHMznQ/QGYEZb8RXSYu0doc5cZ1v1kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IMpAl41uA4NZzmux89GC9Cn0TuXoGZWdv6wH9YzGp6k=;
        b=Eq5vrg0m0i06UL9AddvUi27kWM9QflEhyDEpCJcVmrC3ECLYKZmJnEH86Km9SGn9k4
         hJSfjK7vEGQvpZCAx2fO72wnFeMOl/pgNJILvL/XluI7FytCAIs689EydoeCQDNu68DX
         /PxtY5k0uxqBiLEWgBoqNw0HRrBgbeztIfqNise3O6yMJTjImXL/g/SAGKr8ZtIlFqOI
         Z7pj6ce3ebtoAdGOD0dJYXsJmk22gJVVpFCODOj4kCZtaNjhXWpjFG3EqDkW4gb7GMy5
         YQ08NFsHw46F7qa9wEhd3Ae5uS+h5vIMXs+iGOeqcyoUzQpkImYQaD96pXhOSbpG58h0
         lS5Q==
X-Gm-Message-State: AGRZ1gJXVi29Jp33iFOVJhBcEn0Dfac3PcUm9vvXkphGvEvlGJ8mKcjL
        /nqmwZ70Q2Llw7DFn5T3gjFo2Q==
X-Google-Smtp-Source: AJdET5fsoJOE6ehZnONA50s14YU7GQhPA5U61Z8mQP7btFVWIJOUeUzqCiEmyBPl2ZBJcBLvydAW5Q==
X-Received: by 2002:aca:eccb:: with SMTP id k194mr3142410oih.104.1542466448799;
        Sat, 17 Nov 2018 06:54:08 -0800 (PST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id i34sm1631487otd.44.2018.11.17.06.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 06:54:08 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id w25so23244748otm.13;
        Sat, 17 Nov 2018 06:54:07 -0800 (PST)
X-Received: by 2002:a9d:620f:: with SMTP id g15mr8403657otj.296.1542466447144;
 Sat, 17 Nov 2018 06:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
 <20181114160126.4445-3-starnight@g.ncu.edu.tw> <20181116.203200.1638720313402188457.davem@davemloft.net>
In-Reply-To: <20181116.203200.1638720313402188457.davem@davemloft.net>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Sat, 17 Nov 2018 22:54:08 +0800
X-Gmail-Original-Message-ID: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
Message-ID: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/7] net: lorawan: Add LoRaWAN socket module
To:     "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> =E6=96=BC 2018=E5=B9=B411=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8812:32=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> Date: Thu, 15 Nov 2018 00:01:23 +0800
>
> > +#define      lrw_get_mac_cb(skb)     ((struct lrw_mac_cb *)skb->cb)
>
> Please make this a static inline function.  If the identifier is all lowe=
rcase
> programmers expect it to be real code not a CPP macro.

Okay!  Sure

> > +#define      LORAWAN_MODULE_NAME     "lorawan"
> > +
> > +#define      LRW_DBG_STR(fmt)        LORAWAN_MODULE_NAME": "fmt
> > +#define      lrw_info(fmt, ...)      (pr_info(LRW_DBG_STR(fmt), ##__VA=
_ARGS__))
> > +#define      lrw_dbg(fmt, ...)       (pr_debug(LRW_DBG_STR(fmt), ##__V=
A_ARGS__))
>
> Just define "pr_fmt()" appropriately and you don't need to play these kin=
ds
> of games.
>
> Set pr_fmt() and call pr_info() and pr_debug() directly.

After checking printk.h again, I get the idea of the comment.
"pr_fmt()" is more convenient!

Thanks for the reviewing.  I will make new patches.

Jian-Hong Pan
