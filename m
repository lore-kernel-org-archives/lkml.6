Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2910C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAF6217FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1mMooLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbeLPK0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:26:43 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:55580 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeLPK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:26:43 -0500
Received: by mail-wm1-f45.google.com with SMTP id y139so9494990wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 02:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fpAPHfcglU8qSED++bf1cv5aMUAdVZslGXg/IcXoxsU=;
        b=t1mMooLV1zZQ6NrcNe9WveG0d+93W/UXrFXQHlcVZ5y0fAUnlmN1f41u+SpJ/eju7H
         zJEDozXjvxAtayw72z4Dbn2qLC2YFe30OjXnkXjw/xLHDcA67bFX983AUcHRwe6mvNQ9
         BcFcRFUfCju782an8mbzfCqGUtrRLYdBrz7mO4yJyn+0cbnFfWsu0VgUPsXM8G3Tpkxl
         7Bhzfj+KTYv71yMLKEQ5ZjJ7/JYolBLZ4/s66IfDjssgfAwRe8ArB7WQJkTeqk4lv6yM
         oejpU7YL47XGg5H7mTVyag/XJuhj00Sr+482NSECCrB2y+OnSOsbuAgdvk8aBrA6rzDl
         kYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fpAPHfcglU8qSED++bf1cv5aMUAdVZslGXg/IcXoxsU=;
        b=njhzRpfDTsB34nZqemrOnYIZa66mnACxf13PF7QcHdnxpvryKGXbc6gcVZn9ITNMhy
         ptBOEo5+o71goyrWlv9XazgByMwbhCYoHmwQ2v5fr5ti+7cJI9nXSeev9gViMwbrWWdR
         gTOZIgNx2FrI5RUiXPkvW+GJhwhnPeNC+1BCwu9jE/+8Nj6cutbI2M6IwX3u8lMt3xV4
         KS6tbPvaYdtUmZaGZEQ7+CvfSVlUSEXQq9Ye3QsacSXOo27J4bzTNS6IqFM71UkxuN0e
         x8mifICmH/YsJavoBl+5I1aoAdc1214I/W+MQlFdmXxzg5D4h9AKFsBLwI3qIYVsqlsH
         f7tw==
X-Gm-Message-State: AA+aEWZC6d3uEwzpIHJ1hwksZ7MK/mo+5HGvizuH93PyDFIoy10odSlw
        EzZIhZMgAoZ+0agrfh/H4Zlpf7MOX4w1JDq0HqVqvMiV
X-Google-Smtp-Source: AFSGD/W6YR/zIzF0KuwxBh0MTQfUVwDyNreTTWdHuaW4Z4wBu63O0V14Be14As/kh2T5GTQS19NnxTHcQWSBawpo5VQ=
X-Received: by 2002:a1c:5545:: with SMTP id j66mr6383459wmb.15.1544956001278;
 Sun, 16 Dec 2018 02:26:41 -0800 (PST)
MIME-Version: 1.0
References: <CACna6ryhfaOFS4qjZoLjJqcu5LQd05_jDndL5+GpADTHhu3_7Q@mail.gmail.com>
 <20181216000510.GC6693@zn.tnic> <bac495ca-ccfd-3551-97ca-1444a391fa40@gmail.com>
 <20181216100645.GB815@zn.tnic>
In-Reply-To: <20181216100645.GB815@zn.tnic>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Sun, 16 Dec 2018 11:26:29 +0100
Message-ID: <CACna6rynZtBC8YiGOD_YkwobvUsYxRqzsqwG0fNjs-LL+K2Oig@mail.gmail.com>
Subject: Re: Problem with late AMD microcode reload/feedback
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2018 at 11:06, Borislav Petkov <bp@alien8.de> wrote:
> > For my hack tests I'd like to replace my 0x0810100b with a 0x08101007.
>
> Why would you even want to downgrade the microcode?!

Debugging CPU errors. I have two notebooks:

1) HP EliteBook 745 G5 with Ryzen 5 PRO 2500U
It runs 1.03.01 BIOS with 0x0810100b microcode and suffers from MCE
logged CPU errors.

2) MateBook D with Ryzen 5 2500U
It runs 1.12 BIOS with 0x08101007 microcode and MCE doesn't report any
CPU errors.

I wanted to downgrade microcode on HP EliteBook and upgrade microcode
on MateBook to see if that makes a difference for them. For that I
need to:
1) Dump old microcode from MateBook & run it on EliteBook
2) Dump new microcode from EliteBook & run it on MateBook

--=20
Rafa=C5=82
