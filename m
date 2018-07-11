Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC6720878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4U3DBvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC6720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbeGKDly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:41:54 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35114 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbeGKDly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:41:54 -0400
Received: by mail-yw0-f196.google.com with SMTP id t18-v6so8660811ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 20:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uqioZc0ceXcuYNZ4LD2MS8V7oLz2TzNhftmFyS3N4jA=;
        b=U4U3DBvUu66xwjD4wOzhHVal+lGHNlJzfGHQmlXZHQd7orU78cAKUXni72iJrzYN/I
         ICJHSrTNzlF+8n6Pu0YJcYWpTAsvds+yFl0O/hf+Xy6E+b/KZrNPfJcIaZ0EEt+ty1gO
         KVfSYUr8ZsiYtxQeaL+9N586mPeA4MIWP6rvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uqioZc0ceXcuYNZ4LD2MS8V7oLz2TzNhftmFyS3N4jA=;
        b=KjWIpyJyBu5shunqnZeuidFoKAY7Rkjv9y6si3mYs1ixn8IYbVFnqmClyz+M2ZJphC
         F24nt4qOMK1npUuAKIykHbjdfy0x0NqSqRCaquX0IBT5XaLhbrKtzaBofNT7r8CuoEXK
         SNRba+cOjPif2WeGsUcr5qejzYOvPb8lcAvYvE6Qen9lST5FM1+2jyJG9ijqMI34bk7M
         P+CV6+Rb2BeL82xyCeDPMBu73H5PbYTvyN7ANMtIdL7S0eq2A5grB3OrbamjEFV/DDys
         FBEXosbjdfJNky67HZzGI+0/3HHyiEeL5/HD12rumdYd/sGXQOOki6MzRtQZ4/SDqGkS
         FX7g==
X-Gm-Message-State: APt69E3rhDtm59dEyruLcPlSrDo+5kFrgg0+ql8p7c2v0KvzB0sfCEsD
        vYVzXmeX3B4ZprHYfYG3OAKsgN5RXvA=
X-Google-Smtp-Source: AAOMgpePAyh2ZiK1NfVUPe3UBag4llM98v7XlvWflPPmu0DlZmr/7n4TzHwbXWM8vd+56e8I/zNubA==
X-Received: by 2002:a0d:ff07:: with SMTP id p7-v6mr14059301ywf.241.1531280381157;
        Tue, 10 Jul 2018 20:39:41 -0700 (PDT)
Received: from [192.168.1.121] ([108.189.82.217])
        by smtp.gmail.com with ESMTPSA id g31-v6sm19289708ywk.84.2018.07.10.20.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 20:39:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/3] vt: preserve unicode values corresponding to screen characters
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <CAGXu5j+KLvJ-n_QRrfq15E8iO_rqfpp+K7PDAZHZMHcemy9y7g@mail.gmail.com>
Date:   Tue, 10 Jul 2018 23:39:39 -0400
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-console@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <79334C7E-6E76-4B5C-9A32-C6DA40D8E88E@linaro.org>
References: <20180627035642.8561-1-nicolas.pitre@linaro.org> <20180627035642.8561-2-nicolas.pitre@linaro.org> <CAGXu5j+KLvJ-n_QRrfq15E8iO_rqfpp+K7PDAZHZMHcemy9y7g@mail.gmail.com>
To:     Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am on vacation away from an actual keyboard until next week. Will look at i=
t then.=20

> Le 10 juill. 2018 =C3=A0 20:52, Kees Cook <keescook@chromium.org> a =C3=A9=
crit :
>=20
>> On Tue, Jun 26, 2018 at 8:56 PM, Nicolas Pitre <nicolas.pitre@linaro.org>=
 wrote:
>> The vt code translates UTF-8 strings into glyph index values and stores
>> those glyph values directly in the screen buffer. Because there can only
>> be at most 512 glyphs, it is impossible to represent most unicode
>> characters, in which case a default glyph (often '?') is displayed
>> instead. The original unicode value is then lost.
>>=20
>> This patch implements the basic screen buffer handling to preserve unicod=
e
>> values alongside corresponding display glyphs.  It is not activated by
>> default, meaning that people not relying on that functionality won't get
>> the implied overhead.
>>=20
>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>> Tested-by: Dave Mielke <Dave@mielke.cc>
>> Acked-by: Adam Borowski <kilobyte@angband.pl>
>> ---
>> drivers/tty/vt/vt.c            | 220 +++++++++++++++++++++++++++++++--
>> include/linux/console_struct.h |   2 +
>> 2 files changed, 211 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> index 1eb1a376a0..7b636638b3 100644
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> [...]
>> +static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigne=
d int b,
>> +                            enum con_scroll dir, unsigned int nr)
>> +{
>> +       struct uni_screen *uniscr =3D get_vc_uniscr(vc);
>> +
>> +       if (uniscr) {
>> +               unsigned int s, d, rescue, clear;
>> +               char32_t *save[nr];
>=20
> Can you adjust this to avoid the VLA here? I've almost gotten all VLAs
> removed from the kernel[1], and this is introducing a new one. :)
>=20
> Thanks!
>=20
> -Kees
>=20
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqPXydA=
acU1RqZWA@mail.gmail.com
>=20
>> +
>> +               s =3D clear =3D t;
>> +               d =3D t + nr;
>> +               rescue =3D b - nr;
>> +               if (dir =3D=3D SM_UP) {
>> +                       swap(s, d);
>> +                       swap(clear, rescue);
>> +               }
>> +               memcpy(save, uniscr->lines + rescue, nr * sizeof(*save));=

>> +               memmove(uniscr->lines + d, uniscr->lines + s,
>> +                       (b - t - nr) * sizeof(*uniscr->lines));
>> +               memcpy(uniscr->lines + clear, save, nr * sizeof(*save));
>> +               vc_uniscr_clear_lines(vc, clear, nr);
>> +       }
>> +}
>=20
>=20
> --=20
> Kees Cook
> Pixel Security
