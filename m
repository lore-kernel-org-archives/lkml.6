Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301ACC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C5B2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkEzTq16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C5B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeKCBbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:31:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43027 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCBbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:31:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id r71so3897236qkr.10;
        Fri, 02 Nov 2018 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BAvjcK8A5XuTrgmtpTYvTmpPAYLWoklzSs822kSSOW0=;
        b=kkEzTq16xWnTnI1yXOADqUBzZPtEtsoeiTt3+7PE0N+Al843Ox+5DUX5XFy+EhLdV7
         zGqdFNmm5oyZtku4NqocHvO4edSf2VBhgOAZ1Tw7VvGi0QoWrvrW+/cZ5ZCZ/UvAr02w
         LJ2IUNR7bQFxIHSRxtZJU/tJBOhuAxY/I/O5zbYV0WTaHccVBJa/XZ6ADCLMKCo12xlU
         uqp3HsNMpJN+iP9Lk3cByYEcaVODkDuh/+szZs/aZM8SZz/7nQD7vWgWjsvNuiUtmZI9
         5H+qYnHjxcrnnA3m8V1LTgZPZXCIipwXwvJhaaO+lyOrfno8V7JnIn2RQKJBBBK1Sv9/
         iBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BAvjcK8A5XuTrgmtpTYvTmpPAYLWoklzSs822kSSOW0=;
        b=OFq7px2uvahkjA/Ra1G6XuLzwyKw0I5tvhy7qMYG5MXArrlb5R9NZyaf419xktuALL
         SqV69c/Da6wXgyFSUbHvfMi6I2XVgcHoIuaY7rCsWj3BIXCucvFrnL2i28tUhAJRSh5O
         mKPrM1xzbFRaBq7mvCASf3VFfPD9QY1oK09am/C7v8MC7eDoquGl0hB/vcTsWa7wuI2U
         meN9SfXpBujJ2Z81AHP6f4zxwec/mXDPCtz7KYqWgP7+3crizWJ/jwHag2RxDQIR+Y9V
         eUrH4+pVNzweJy+dMW5qMqMsMtVbRu5HtxBVAutw/4ASD3OOq/PEFZvP3kuEOUQIo6zz
         aAxg==
X-Gm-Message-State: AGRZ1gJapg7avn9RrqoYW59YhUedUnvP+fgoJlvKQRbKm/vqTzgfiEde
        uWZgp2gLEpF/do1UWsnybFs+08FZZRSzG4mIwFiuqQ==
X-Google-Smtp-Source: AJdET5c1tGOa/LmH/D8P2tiqI8fTPuaKeRLswkqJUiXvBCz8dvZvDf77cGnogpaGwftPfdzIFFELsmOv4leSQfDC2N8=
X-Received: by 2002:ac8:410a:: with SMTP id q10-v6mr10992695qtl.96.1541175807431;
 Fri, 02 Nov 2018 09:23:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 09:23:26 -0700 (PDT)
In-Reply-To: <20181102160858.GA17096@ziepe.ca>
References: <20181102153316.1492515-1-arnd@arndb.de> <20181102160858.GA17096@ziepe.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Nov 2018 17:23:26 +0100
X-Google-Sender-Auth: cJ85zqjFsXGez0pdSuxH1K8yRR8
Message-ID: <CAK8P3a2pvkfR1A6dHAMm8ETd13E1LSxXrEsQHSOFYWbr-7R2Sw@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5e: fix high stack usage
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Fri, Nov 02, 2018 at 04:33:03PM +0100, Arnd Bergmann wrote:
>> A patch that looks harmless causes the stack usage of the
>> mlx5e_grp_sw_update_stats()
>> function to drastically increase with x86 gcc-4.9 and higher (tested up =
to
>> 8.1):
>>
>> drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: In function
>> =E2=80=98mlx5e_grp_sw_update_stats=E2=80=99:
>> drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:216:1: warning: the
>> frame size of 1276 bytes is larger than 500 bytes [-Wframe-larger-than=
=3D]
>
> Why is the stack size so big here? The mlx5e_sw_stats is < 500 bytes
> and all the other on-stack stuff looks pretty small?

I am not entirely sure, but my analysis indicates that gcc tries loop unrol=
ling
or some other optimization that leads to two copies on the stack.

>> By splitting out the loop body into a non-inlined function, the stack si=
ze
>> goes
>> back down to under 500 bytes.
>
> Does this actually reduce the stack consumed or does this just suppress
> the warning?

It definitely reduces the total stack usage, the separate functions just
had the expected stack usage that was a few hundred bytes combined.

       Arnd
