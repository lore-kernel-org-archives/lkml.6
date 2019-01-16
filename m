Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC24C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAE4206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcjcCjFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfAPAK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:10:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34091 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfAPAK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:10:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so2117401pfg.1;
        Tue, 15 Jan 2019 16:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aa8XRWpGUNL4wsH6whaiJV0d5vKcTIKY0dS8vZoBt9E=;
        b=pcjcCjFk36vIXmfYhedH/LCItdC5wgOfzTrI2pzdF9JrHNAdw8ExCewzaqrpiQzS3Q
         wlmfilQmVKi3k/3CuVzE+OH8jDnCSDKLriFWu0Ge93e6xlAfLtfbuUaP19TagEX/ZUi5
         so0IaDh8jNKv64fIR0JTGGDyvX+DCI40X9JHGV26GQwUqDfHzM9cGQOvc7NopVEXIMaa
         lmbgrQ/JNpVcjkvEeggoraP4VUk9EeUDiDd+pIJva1oo6vaBi9hoEIQ6qUzdMEBADL2R
         jOtQKk6rL8T2V9U2wth+QanClAZlDwwkBVhGW18aTMepVd+cW3LttRh+Vl8NrrurLnnv
         I0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aa8XRWpGUNL4wsH6whaiJV0d5vKcTIKY0dS8vZoBt9E=;
        b=hIKLrnu2ArNxXDgzslubyVcqp0kDicpLB9/tz6F4hgs2jR5EG6a+G4lqjjshGrmJTY
         3I9mbR8JNO3hSojsw6khE3gJ2ZSZQ1rR7ntYoRQ/yVabU7r5w+xmg7hCMsGrtE565EH7
         vkDxYLXqp0AbNUzqjitxwFeGObAGf2v4AqiZQDncXNHAbTXCx/ub2cS5FpE45lVw6VtN
         EeAiOyDlNcjr/4xo5a9X5+ntwylfqd1Y+tK0WT/79jE1oEH4yfvNZwMaDs8d1THMNbYS
         ZQq8hKGer/RFj4Re48+XSlocQ714qxZcObdxrAWYRJm1aIZyEqO24/OZX39A8K+pLhpF
         trKg==
X-Gm-Message-State: AJcUukcADDomz/0Np2QJz1rmiO6znYPahiWS4sbCJQKErCxMwl4RiGNu
        eIhbk1tdhYt3Q+9SoxIq6CFpLAsm
X-Google-Smtp-Source: ALg8bN59Rb9Z2wjBIeulk5sGKSuQ5OtsjnepPnJKLC1WjFWnWl9WHhyhtTg9NJJRXrobJnITidT76w==
X-Received: by 2002:a62:be0c:: with SMTP id l12mr6582899pff.51.1547597457045;
        Tue, 15 Jan 2019 16:10:57 -0800 (PST)
Received: from ?IPv6:2600:380:4450:d53c:50e3:91cc:ff99:e9f6? ([2600:380:4450:d53c:50e3:91cc:ff99:e9f6])
        by smtp.gmail.com with ESMTPSA id d3sm4472102pgl.64.2019.01.15.16.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 16:10:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] input_event: Provide override for sparc64
From:   Deepa Dinamani <deepa.kernel@gmail.com>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <CAKdAkRQdO14OP7SgE=D4x5RG7=cjDoCAOmtnCcWw_DrToeEmhA@mail.gmail.com>
Date:   Tue, 15 Jan 2019 16:10:55 -0800
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        David Miller <davem@davemloft.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB606530-0E31-449D-8E04-CDFC1FF068CA@gmail.com>
References: <20181229183514.24644-1-deepa.kernel@gmail.com> <CAK8P3a1YG0+iMBiNy-g7KCusX3myV0tsuCEg1YLWW0cXrjk7PA@mail.gmail.com> <20190115.132928.900198180655535613.davem@davemloft.net> <CAKdAkRQdO14OP7SgE=D4x5RG7=cjDoCAOmtnCcWw_DrToeEmhA@mail.gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 15, 2019, at 2:32 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com> w=
rote:
>=20
>> On Tue, Jan 15, 2019 at 1:29 PM David Miller <davem@davemloft.net> wrote:=

>>=20
>> From: Arnd Bergmann <arnd@arndb.de>
>> Date: Tue, 15 Jan 2019 22:19:27 +0100
>>=20
>>> The correct check appears to be
>>>=20
>>> #if defined(__sparc__) && defined(__arch64__)
>>=20
>> That is correct.
>=20
> OK. Deepa, could you please send me a fixup as I already pushed out
> the original patch?

Ok, I=E2=80=99m traveling. I will post an update in a couple of days.

Thanks,
Deepa=
