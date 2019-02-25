Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81474C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498C120C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4mQLGno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfBYXSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:18:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33008 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfBYXSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:18:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so5235504pfd.0;
        Mon, 25 Feb 2019 15:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2r7KQcFEYCbInnXvJwv3BFGpM2jlWEK8FXfVbc8EeFU=;
        b=R4mQLGnoLmAq123iNSisIWpZ2YUk3PTn4AE/cFPnB2rnr4KW5T2KArUH2OcIoOHY3z
         ZGB3Q2fsRV7E+Qp3RW9TAy9aXgWDYIaCysTDF3lcw1er1itz9dQWw2toOk8jZ2Zzbfz9
         +3kV8d9Ra4wXxxKzyk2LIA1VG+bp4ERigvryCP6ihjEMdjc+1KZYNt50yjvhOBIzWhBe
         F4RKINpAZxef9gNuPwAqc42vlPaZhVBZtRrjRkzV/CmlFtYz3B6+ycMAhiI/hCKk7fY9
         FMdgfdYXOIDUX+gqYR4nFjcLKb9UE/F42tIGaRUZkWC+RhLpoRrb8VVNd2Hfiu22nwXq
         CCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2r7KQcFEYCbInnXvJwv3BFGpM2jlWEK8FXfVbc8EeFU=;
        b=aodbWJh+Y79j27NlKUMlfDyRey6NZC9/mwYlmXXqv+ErlX+HEMvJyYvy8FpRS1iPEv
         L1fHxpDQ72hsSpn1hsdSwwZNwQgwMZpAqoNn2A9Meha7TlA8JcTuNLSSdh/M/+FBwoOB
         LDlEKyu8/yveSTYHY5Jzn7SBTZzQpP6rr+A5kJqNP8HypMqFIJ2YzU+ii2ITrMFH3Uax
         6glYf2cEi5X6NKnG8AGH4x/Bq+CJ5v/Lywwwyr7TxDRFZ4aDDfRREGNKu3UBraVFUu4G
         kyqbo01jglHZwqG2gSg1Gf1sv8ef6edpLANItegT9MmwhPwpAqdbOrB83u3EUvQGODin
         ofxA==
X-Gm-Message-State: AHQUAuZFJZGRDFvFqFOfrq8Gl0HHwd4gypAbKSVh7WvLfZEJWouLcMih
        lkOa5H/5P8V042kdqrTun38zFg0izmrbMfLU6+M=
X-Google-Smtp-Source: AHgI3IbGKqmIrDlDPJcuF6u/C2Eg9zB4V40OpxViFJrwZrzAv2k5Tq/qIAXKzS4DeVGEXndYPZjeuWsb3pjxHxSlHao=
X-Received: by 2002:a63:2586:: with SMTP id l128mr3667343pgl.104.1551136693261;
 Mon, 25 Feb 2019 15:18:13 -0800 (PST)
MIME-Version: 1.0
References: <CAM_iQpUePM2L5qStoq7XmQe-4sDrM9n6BRwa=FShfzZda=Lccw@mail.gmail.com>
 <20190225.142939.803768996918170563.davem@davemloft.net> <CAM_iQpUknnab0bwJgp3-F864-02LsH+J07c8SzMZyYK84yoezw@mail.gmail.com>
 <20190225.151141.792446098735157842.davem@davemloft.net>
In-Reply-To: <20190225.151141.792446098735157842.davem@davemloft.net>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 25 Feb 2019 15:18:01 -0800
Message-ID: <CAM_iQpWYcu1NZ2mm65tkdPfaTtgL_skA=GnMnAUrwunATT63HA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/2] net: sock: undefine SOCK_DEBUGGING
To:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc'ing LKML)

On Mon, Feb 25, 2019 at 3:11 PM David Miller <davem@davemloft.net> wrote:
>
> From: Cong Wang <xiyou.wangcong@gmail.com>
> Date: Mon, 25 Feb 2019 14:58:36 -0800
>
> > Please be specific, and ideally make it a formal doc in netdev-FAQ.txt.
>
> And this isn't happening either Cong, I reserve the right to apply my
> judgment as networking maintainer on a case by case basis as I so see
> fit.

Thanks for rephrasing non-transparency in such a wonderful way.
