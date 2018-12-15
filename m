Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAF2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8072084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BTdHtFKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbeLOKf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 05:35:56 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:38221 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeLOKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 05:35:56 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wBFAZnJW030700
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 19:35:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wBFAZnJW030700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544870150;
        bh=Se/CygLed0b2Rxr7lrdKfHP0lbTuOWGTz+r/5tfczSk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BTdHtFKHbZDfS+0Vxz17cs9QibrWyDT6zcIFnJnC9xGoqhxvijBbfsRQu3o8YUFI+
         5oReNW3P3xrC6RSde6a1w9j2iMWd73qdnThmV3eETKos9CPQ091MuYFh2BL29sO6jt
         zxcbk8mqmVfqpoxhzeyvT/j4SRjvrcg+dLpBtFp87xyahJEAX8CGL3EkxViwAbU5RU
         WHZ2Rcqk1JkWWU/sxKlEoUHDWJDoJ1UTENMBsBw8yNFkzqw1KhPTVplRTQjncoKw+7
         U6mOwHwt4tqFEmvBzA68T3+qPDchPT7xmdBwaJr4iBcQh77jHb4ZQPStS9U6xfToUa
         rivW74Rak8YIQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id g68so4923548vsd.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 02:35:50 -0800 (PST)
X-Gm-Message-State: AA+aEWazfJJI9ehnDrqgh9d1Nw1tuKDCGFKs2ho6nfwnnC9WaAmGLIYk
        EGO2g/UmDm43TOSkPD37a+EP220Lde9J/C2nsjE=
X-Google-Smtp-Source: AFSGD/UC+0s17aXtlgTP8bcHD2yOCmBmOGkUsoIU+GV9RLM5+f/gTn+cnkwh7s4c1BczcCkuQfoiKp2qeIJ9euBx/xo=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr2887640vsm.181.1544870148984;
 Sat, 15 Dec 2018 02:35:48 -0800 (PST)
MIME-Version: 1.0
References: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 15 Dec 2018 19:35:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvXCMMqqKo_+HupOhABaYZZ5yuZ9Dq+EycjytMdOk-Zw@mail.gmail.com>
Message-ID: <CAK7LNATvXCMMqqKo_+HupOhABaYZZ5yuZ9Dq+EycjytMdOk-Zw@mail.gmail.com>
Subject: Re: [PATCH 0/2] scripts: coccinelle: Improve boolinit
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 9:34 PM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> Reduce the scope of the rule and improve the warning messages.
>
> julia (2):
>   scripts: coccinelle: only suggest true/false in files that already use
>     them
>   scripts: coccinelle: Correct warning message


Applied to linux-kbuild. Thanks!


>  scripts/coccinelle/misc/boolinit.cocci | 43 +++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
>
> --
> 1.9.1
>


-- 
Best Regards
Masahiro Yamada
