Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11007C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9591206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNli1Hum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9591206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJXL4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:56:39 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41742 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXL4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:56:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id c32so3591111otb.8;
        Tue, 23 Oct 2018 20:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ggV+ywjKf3q0Ak4QYOtHoDVSmG7i1LNnqaTdg3lP9vw=;
        b=SNli1HumAxDYKEMrxn0IepzjbLvZtbAP4b1uKwWldCtlLkkIIOpP6ygnja9ckGchp2
         zUcb0mAnY3x+92H4oeIGERY/4yNZijiZ4z8B/9E8TYSe3wCDqIHfZCUWvUgjbFeJ0F1z
         mpmvcmCh5ElKKiTM4x7Bd5AW8JnCsdBE+gXT+75SDyq5IslQY7ZUJXmgjLV2L4MMbzRu
         7RZrsruUSb7a1q6dy/6kAHssY0M3vgyfMLWHiG6vkIL1OGVXezJnX+Bk4HfyWft6NMiH
         NLSXMTQUT/1veqws8bP5L6omVLULIJtQBh/L84VOvnFbBJVItfv4rkFaV9tOgbuF3w0J
         IelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ggV+ywjKf3q0Ak4QYOtHoDVSmG7i1LNnqaTdg3lP9vw=;
        b=LifxeOjEOjwpV2vUEdo6YvRevRPoaOKyukQuQmlkZwvkdl83D1Xy6hVGU8rLbNrQps
         Bp9v9ibHMZgedB6cYCfK52ZBLtgvKxcJv+BfrN40T+546POQkb1wsi1/Vk45AHMp7QN0
         5ZmlooTSfIvHJaJQMMlJid1dRrNLy4DnoYrcfiUmYLhCBaVGweHfRTs9r59h6osIzfEh
         jqPkr8qWttcg01GzLbrZnEKywZd/9v2lW6/wml9MMK9uMmUBjj3XIoG7oFURfr+Lo5ou
         Dt7Mbek4Pppj2bB9gt6Z+F9SCJrnbBNu1rMt2Q2p1fTkpnmxEQ0f91fqfXl7nKYB1ayG
         9VVA==
X-Gm-Message-State: AGRZ1gKqCIrhJSZlhsfjGUBluKtWL/UFZnT3VMMleZXdrfKY6WZH9z9i
        nz6l2pNgV5Tjj11Cw832RFgpraRnLag7lx1JqH72og==
X-Google-Smtp-Source: AJdET5f0d6LhgH53CC0WuFyLn++sT+oA34PGB0du+WlX81Wh1OCHtnvQTNvPWiR2Mcvtyy3YAcacYnAo4hXtzwZ1H4s=
X-Received: by 2002:a9d:529:: with SMTP id 38mr304185otw.233.1540341584420;
 Tue, 23 Oct 2018 17:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181023011022.GA6574@WindFlash> <93692F0D-D25B-4225-B127-4988E43B4CE1@amacapital.net>
In-Reply-To: <93692F0D-D25B-4225-B127-4988E43B4CE1@amacapital.net>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Tue, 23 Oct 2018 21:39:33 -0300
Message-ID: <CADvQ+rEk-VE4uLZ_iRi26BnuEWFzCNZxdcdHRgWW6YbKS4R_tA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] x86/vdso: Renames variable to fix shadow warning.
To:     luto@amacapital.net
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Yeah, it's much better. I will replace this part of the commit message.
It will be fixed for v3.

Thank you!


On Mon, Oct 22, 2018 at 11:13 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:

> How about =E2=80=9CThe go32() and go64() functions has an argument and a =
local variable called =E2=80=98name=E2=80=99.  Rename both to clarify the c=
ode and to fix a warning with -Wshadow.=E2=80=9D
>
> Other than that, Acked-by: Andy Lutomirski <luto@kernel.org
