Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA52ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB3D2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="wABftpyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB3D2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeIQUXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:23:40 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:47090 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbeIQUXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:23:39 -0400
Received: by mail-pg1-f177.google.com with SMTP id b129-v6so7780151pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xUvroLhvRsEG9OIU/Mt4H8iKRdk3WXKJKyjupTfUBPQ=;
        b=wABftpyEBJCbeNmh0Y2b7dV4oZRoEUGBBHI1L2hQgHsEk6zEvuh36gOlu910xJhL1y
         lad2ex3IWq61eZevOLRlzYhwe7sgT2+OzRjTQeg8QeeLtn0Bhcx9GzbA0/qj411rj+sg
         Irce1a17DaBgCycc0oToneRnV8k0fMIRJSmrrhgvmUwDxWT4MAw1TZvPy/zb7cjwv61U
         cqGVdsSbj/dMPjLv0yZhBpLJBz4On5zZVaBEJItb2A6qxbgkbo48ZkO2KwR7eSdd9Hwk
         c7CWk+YzNSyiBqtQqc+8DKhybCeo/OIh5ZEn00Qz+cdYSVC6q8DGBYbLyoQlA3BSSu0p
         2uUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xUvroLhvRsEG9OIU/Mt4H8iKRdk3WXKJKyjupTfUBPQ=;
        b=bmZi0tr3s+kmufkPMm2fSuqlpo/TnE20wODjv/R9VOIiXzYIvpA/iPtrfJsjCqYYeE
         AEy+sL85SvZG5RBkZFYApFpWZH9B29II385RVzLr58M1Y8YJqLuAvuVjDjVrFnwFdAmm
         r0TDZzTAcffH8U+fY4ivJrLn4xQ0pfjoiAYCP5AVRksipm3lPNdiDrWThn/yksdYaC6e
         FrGarYOr+wCiv99ZRWRHzQSMplHWuWTYFuWfrP8yolTMYXX+PGsh0TaUDaFqR0L206+I
         /Q/k9ta0xfXjXjzBnh/7Z8VNwIj4F+TI+1w9jTN+QY5ZqHDH1xutTfJS5ti21YROkAFD
         RMkw==
X-Gm-Message-State: APzg51D3aa6mzcPAbXpr7KgoNJkGIKU8pekYYbWUPn87rZyc7GFgpTNV
        NSStYtMqJwd0Agwo6rWd3oWxyA==
X-Google-Smtp-Source: ANB0VdbwI5o4H0UqPy1VwN7NNNJ1qs5mh6qf//dvvNDJSBG407ZkXirM0OzaabMM9vaZXhQpHphQtQ==
X-Received: by 2002:a63:740f:: with SMTP id p15-v6mr24226590pgc.395.1537196158130;
        Mon, 17 Sep 2018 07:55:58 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:d8c5:6393:c455:3e7? ([2601:646:c200:7429:d8c5:6393:c455:3e7])
        by smtp.gmail.com with ESMTPSA id s14-v6sm31148693pfj.105.2018.09.17.07.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 07:55:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180916.214549.234387075817326903.davem@davemloft.net>
Date:   Mon, 17 Sep 2018 07:55:56 -0700
Cc:     luto@kernel.org, andrew@lunn.ch, Jason@zx2c4.com,
        ebiggers@kernel.org, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, sneves@dei.uc.pt,
        jeanphilippe.aumasson@gmail.com, linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <40088431-D4EE-4D1C-A369-2CE15F758483@amacapital.net>
References: <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net> <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com> <20180916.214549.234387075817326903.davem@davemloft.net>
To:     David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 16, 2018, at 9:45 PM, David Miller <davem@davemloft.net> wrote:
>=20
> From: Andy Lutomirski <luto@kernel.org>
> Date: Sun, 16 Sep 2018 21:09:11 -0700
>=20
>> CRYPTO API
>> M:      Herbert Xu <herbert@gondor.apana.org.au>
>> M:      "David S. Miller" <davem@davemloft.net>
>> L:      linux-crypto@vger.kernel.org
>>=20
>> Herbert hasn't replied to any of these submissions.  You're the other
>> maintainer :)
>=20
> Herbert is the primary crypto maintainer, I haven't done a serious
> review of crypto code in ages.
>=20
> So yes, Herbert review is what is important here.

Would you accept Ard=E2=80=99s (and/or Eric Biggers=E2=80=99, perhaps, as an=
 alternative)?  Or, if you really want Herbert=E2=80=99s review, can you ask=
 him to review it?  (Hi Herbert!)=
