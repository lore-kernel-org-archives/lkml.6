Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23F5C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A955020665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sUNvKCaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A955020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJWKfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:35:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45188 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWKfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:35:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id u12-v6so20837211pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qVl+ltsDoIEg6/kf09jIdkMEjHU2C5V80FGb24zqHek=;
        b=sUNvKCaUYqGMQvkQaGVNtl+J+LPWVJEz5Ij4f29K8x4Pn2ISpih+GDotATL7g41Yg5
         B0rugXo+J9z5owv4or55TIS0FudkdR9FQnQSOrtC/bbyiuKCv0gLT1STx+FWqmbM4aPJ
         qGd7R8/jmq1jdOo4Ahfc6GdWkIrqqps/7mAfNHboYnwvEKJEzEWKAqh+dEwKhkd7oh4U
         VrJmpW70BL+pTgJQhs1Nh1AkotaTD/B21la3HvXhgumSLP6r7nVcfNeaJHtRohmhL4A5
         RihajTaMpS0TsR+pUBV4e6bUrRD5skb1Se3XyCHhpAXF3rJUJQypiiu7zuyoyH9BlcAp
         ZnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qVl+ltsDoIEg6/kf09jIdkMEjHU2C5V80FGb24zqHek=;
        b=jsulWRJ8P5Z2PqAjepnERaN2jNx0y/NDgJjGZq7T43RpJUisaLM9BnNzgjcu4FJG52
         agX1m7dVp9BBUIx4moL9XT19wouA3CS7Z8bMFa6rlMoMEa244laWJBe4Nh8FHXhXIIm6
         MRkIPWa3HeBiBesty5blJ8tM6+18L6CAbSxtyu9Bl80SfMbdV6uJhfDuYEAdeg+iCqBr
         kyFAwGwV0GSDChbEjds8oqKqEzrKKXLyOKLos2dJXtk/nVtFxK41PErI6Gsb0h7bojdR
         e2ArsP1nxNrqzD0H77MhAt470sjfwadRJ5dqOy1SxXG39H+1riV2b9qE++DcJJ/unQIy
         lzPg==
X-Gm-Message-State: ABuFfoisEZxqk6EIrsZZCVxO+naef5xhHZGnsrvK+/TwwjEngQQiF0Pk
        NPiPgGQOeQSX3diaEo+8ZpxPdf2LA3U=
X-Google-Smtp-Source: ACcGV61mKRhsnK5n0k/PtIQiSQC4OtgWa63kziIrYMSTlNxbW3tcFuAQuADt7AVx897klDs0GV05fw==
X-Received: by 2002:a65:6204:: with SMTP id d4-v6mr44742975pgv.121.1540260834987;
        Mon, 22 Oct 2018 19:13:54 -0700 (PDT)
Received: from [172.20.15.125] (68-233-204-20.static-ip.telepacific.net. [68.233.204.20])
        by smtp.gmail.com with ESMTPSA id t85-v6sm48619202pfi.73.2018.10.22.19.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 19:13:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/5] x86/vdso: Renames variable to fix shadow warning.
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181023011022.GA6574@WindFlash>
Date:   Mon, 22 Oct 2018 19:13:53 -0700
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <93692F0D-D25B-4225-B127-4988E43B4CE1@amacapital.net>
References: <20181023011022.GA6574@WindFlash>
To:     =?utf-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 22, 2018, at 6:10 PM, Leonardo Br=C3=A1s <leobras.c@gmail.com> wrot=
e:
>=20
> Renames the char variable to avoid shadowing a variable previously
> declared on this function.

How about =E2=80=9CThe go32() and go64() functions has an argument and a loc=
al variable called =E2=80=98name=E2=80=99.  Rename both to clarify the code a=
nd to fix a warning with -Wshadow.=E2=80=9D

Other than that, Acked-by: Andy Lutomirski <luto@kernel.org>

Ingo or Thomas, it probably makes sense to just apply this to tip:x86/vdso, s=
ince it=E2=80=99s an improvement regardless of the fate of the rest of the s=
eries.
