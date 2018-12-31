Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA61EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0572177B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS3OrEc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeLaIqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:46:11 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46008 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeLaIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:46:10 -0500
Received: by mail-lj1-f179.google.com with SMTP id s5-v6so23183708ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 00:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=femcIHqfWPQ8DXNi95oWmR/8eUbNyevi/oGhEtea1TY=;
        b=RS3OrEc47hIm/MtGxm64k+/w0xnTX2rXtmrX1sc/gNS0ng1tX6vuiCrALOJ1LcyXF2
         tWyaI6O4LG/GNApzk4xehFAnDRxoSOQueCia5Fjn8i9UgUAWyv3tv8qCvuGxQxz+2EFV
         1baBUvau1gveFYH/1yW5tN8s0d4MVnP98poqVZm8fqF74QqDn7QR4SQZ96BmSt5WN6Yv
         9mYq5ea5EUmrn5w1tMK8bA09LYR4e0MtyzLpkhykGVO6oF+5fqZJN95xLShuD9g69ULw
         XQnpJn9cFj7TUsRzHRz9h7iYhQ4Ut66IcwfMVcGbBXrIXEnxB/MbRkBcoqOJOVA0BQRG
         6nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=femcIHqfWPQ8DXNi95oWmR/8eUbNyevi/oGhEtea1TY=;
        b=lTlRydKnACJWSZ0LmkO5MkkWTOBxylkbzzuygnH3aNbsiorCEBgZZDXAN0CkNuQGWt
         Rs2dX9E/PmHh+ZfjPexm0geMz0EcKHvfC95eX0UmSXuEaT8nPnH0lwAUVn6mDnsqa6fS
         xhJBsso0v4jFaa/22x8KUqDUpHIFysjbVv1CYxZg2E+vLv5noUkJS2dja1nra3OEDw6u
         pxp8EM0XNDlobkiwWd8uwSSmbevFO37E+rRbJKvS+b0FxJ2phnkzUmarKORcINfLPv+t
         1pOoinkjygAnftswNF8WhGK7HI5CuhRrG6LyoSgm63plJCrplBZbETcRdJT7nbGOvsAA
         ykcA==
X-Gm-Message-State: AJcUukd+fTW/f+LU/p7O1UWafxQi2kYL7SnrHWXtC9XIlD2ESS8EwTrW
        A0QBcPaTZ5DO56VseqUMDMnPDz6FCTW+JtavqY8=
X-Google-Smtp-Source: ALg8bN44KwdsPZXlrCDThs4emT4vxfaAJ3Fopc1DdPeTQ9n6DQ5nWpE5aozqjQayz8NAGPfLd4xKYapgGaZRJk+G7S4=
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr22913687ljd.21.1546245967650;
 Mon, 31 Dec 2018 00:46:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a6f3c4d6d8c85f1db2e84682b8305339@memeware.net>
From:   Ivan Ivanov <qmastery16@gmail.com>
Date:   Mon, 31 Dec 2018 11:45:50 +0300
Message-ID: <CAAaskFBcotAXfRCsz84G_9vJnO+30Ky3F4q7W3Ua7p+LGg7eVQ@mail.gmail.com>
Subject: Re: CoC loving Linux programmers swear the GPLv2 is irrevocable. They
 are wrong. (As are the women they wish to empower).
To:     vnsndalce@memeware.net
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gentoo-user@lists.gentoo.org, ubuntu-users@lists.ubuntu.com,
        misc@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for this message, friend. We the people should
learn it and stop taking Cock of Conduct up our ass

=D0=BF=D0=BD, 31 =D0=B4=D0=B5=D0=BA. 2018 =D0=B3. =D0=B2 05:07, <vnsndalce@=
memeware.net>:
>
> Their take is that if you lent (licensed) them a lawnmower and told them
> not to wreck it, the fact that they did not wreck it entitles them to
> keep the lawnmower forever(they followed your instruction regarding the
> use of your property: "thus consideration, thus irrevocable license").
>
> They are wrong. You can revoke the license.
>
> You were paid nothing for this grant.
> The takers have nothing.
>
> Yet they are taking your positions, your seniority, controlling your
> speech, and ejecting you from your communities.
>
> You must fight back. They have already taken from you all the natural
> pleasures in life (which include pretty young girls as brides, ruling
> over your girls and family, being the master - not the servant of the
> woman and her state).
>
> Now they are taking this edifice, this refuge, which you have built for
> yourself.
>
> They see you as replaceable, expendable, removable employees.
> (See: Bruce Perens statements on slashdot and this and other mailing
> lists about how those who do not like the Code of Conduct can be easily
> replaced)
>
> But you are property owners and may elect to enforce your rights as
> such. And you should do so.
>
> And yes, You can trust my words. I am a licensed attorney, and I'm on
> your side. Not the side of the women. Not the side of people like Bruce
> Perens who see you as a replaceable cog: a worker... a chattel. Your
> side. The side of the dispossessed men who are ruled over by the women
> and the supporters of the women: who will not tolerate any corner of
> advertence not fixated on them.
>
>
