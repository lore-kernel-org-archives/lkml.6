Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF14BC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A392148D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6z6KiSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfBBDb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 22:31:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40851 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfBBDb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 22:31:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so4187723plq.7;
        Fri, 01 Feb 2019 19:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fXSseKejZ+Rxu0lrggy3RtPPUwxLcNh1ntr2K06TgaA=;
        b=b6z6KiSFlGwOsPtUUIlhFFekCU2X70+zkaNX8dXbLF2EU3/zz0unDTxzhyqDRQWyiA
         n4rg77vHAXfqUCkzCh7Wp/s9F71yvYsejJq7mXe/8LPs8ejPjnKn15Qakz3HmA8ftyp2
         nEzYeFvB/pd9VnvUUH574Rk4zaBCcStmXD47rcQ+LGc+S4P4pKR8/z49gVPd2rVqG16+
         PmLXTvAlqNj8lUo+kI4t3fjSmnwF/FIEF8GAESogXtAI4Hi1Tx0NeWy/+LTAM9AO87GK
         hlzS3yqLQHAgrtudLnNjtkLKQ0YJj7drl3ZH1Eg/PhRLlgtoLmeDZedOdXmS+egU6kjl
         PfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fXSseKejZ+Rxu0lrggy3RtPPUwxLcNh1ntr2K06TgaA=;
        b=axsWIBcXD2ekS6KwDaH23ED8pej36O3zpbnONldF2FN8cskrIP5n6CVJ8cJ7IdNUgG
         0wVRZaTWkyQ2OC9ZueOjQaZ8w5mu273D1rE8cavM6CdRdM8p3epA2bJj5YVGV4MX04BN
         QkftM0xANX4CKLl2JF8H7W/UmuzdbURRKjDhRolfV1J9/WkNhWBCw4U1y0iNiwkNNT2K
         qYsJM8VgLTHX3mxYM1Xm6syYI/rNqE50rYwaJHkRyVkLGosqP7B3JNqtlnD/C61j8b33
         ouYxWwTNYTFyJaHspY+2hdl6bxiW6FvfOg0uBS4jFpEMWi6hk10UsnMB7JhFO8PzfZJQ
         f4xA==
X-Gm-Message-State: AJcUukeGRQKKxaZuRIytAAk+WWKWxFKxLj6loQCLXZGLKvk+SelT+JaE
        Zel93DuhQaadOr5AAeL04Cycrp9Ybu4=
X-Google-Smtp-Source: ALg8bN66vv+/t7OBSUJmTy2SIigv6X2a/6TL0u7Ke3ku2tXZ0ss5642PN8FLJXsBmxS+rb8V5t8w5Q==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr41448786pln.324.1549078287095;
        Fri, 01 Feb 2019 19:31:27 -0800 (PST)
Received: from [192.168.0.101] ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id q5sm15361110pfi.165.2019.02.01.19.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 19:31:26 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v4 02/12] socket: move compat timeout handling into sock.c
From:   Deepa Dinamani <deepa.kernel@gmail.com>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <CAF=yD-LNyuywx4_ktyy3JcOd1pvFeKb1wyvDj59kbZoVLp4Lxg@mail.gmail.com>
Date:   Sat, 2 Feb 2019 09:01:24 +0530
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF27547C-75C5-4F10-819C-77546340DD46@gmail.com>
References: <20190201154356.15536-1-deepa.kernel@gmail.com> <20190201154356.15536-3-deepa.kernel@gmail.com> <CAF=yD-LNyuywx4_ktyy3JcOd1pvFeKb1wyvDj59kbZoVLp4Lxg@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 2, 2019, at 12:28 AM, Willem de Bruijn <willemdebruijn.kernel@gmail=
.com> wrote:
>=20
>> On Fri, Feb 1, 2019 at 7:48 AM Deepa Dinamani <deepa.kernel@gmail.com> wr=
ote:
>>=20
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> This is a cleanup to prepare for the addition of 64-bit time_t
>> in O_SNDTIMEO/O_RCVTIMEO. The existing compat handler seems
>> unnecessarily complex and error-prone, moving it all into the
>> main setsockopt()/getsockopt() implementation requires half
>> as much code and is easier to extend.
>>=20
>> 32-bit user space can now use old_timeval32 on both 32-bit
>> and 64-bit machines, while 64-bit code can use
>> __old_kernel_timeval.
>>=20
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>> ---
>=20
>> @@ -1121,7 +1155,8 @@ int sock_getsockopt(struct socket *sock, int level,=
 int optname,
>>                int val;
>>                u64 val64;
>>                struct linger ling;
>> -               struct timeval tm;
>> +               struct old_timeval32 tm32;
>> +               struct __kernel_old_timeval tm;
>=20
> nit: not used?
>=20
> same for stm added later in the series

The sock_get_timeout() should actually be passed in v instead of optval. Thi=
s seems like a typo. I will post an update to fix this.

So these are needed.

Thanks,
Deepa=
