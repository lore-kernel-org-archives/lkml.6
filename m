Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76123C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442E720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8NLbULV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfAOHPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:15:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39858 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfAOHPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:15:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so860157pld.6;
        Mon, 14 Jan 2019 23:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=tPcehZOGYi8efMte2RmC3IbUFUAe9O6iguwqRKIlURU=;
        b=c8NLbULV2xTZBAAamJ/RkgMy9pXbiLFaHzLFzjsoeKU09fWGKi3L3dLAft12UQ+Iw0
         cGoUTfPeefVwmA0IeiwvDwQrC/if94+Dk6L9wO8WVRHAVPVlBoa+B7g/ZYKfyhKbYrW8
         3fgYPuvtSNEK87VAm1wfCIyh5/5vhHoRebV1gmjIaII9DEvqKwrQGdchP0DjBEw4+1Fb
         JrJRi6MWrH/qPLPJXkED47bsfkOuHZFEdBWtO5fW32GpLfmEOnEQy6JyRmWp9pIOB085
         +VkOxazJGwTDKtpKLkL2I3ORpiRltyVHs4hGn0KCvJBk/a/j5V0OeXVVSewmi5sXGYoA
         cjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=tPcehZOGYi8efMte2RmC3IbUFUAe9O6iguwqRKIlURU=;
        b=uaFSTJtn68iGSunsRkLCts6lHwlDb8aU/kzx0/d+WsLjM8zgkofGkBGW1FowQU6qxE
         Oby2Mu5sKUAPx2AcaaVf2ra/cWiSCJrK2XLfs64XSNZtT0qcCIlfrjTR2mfmOvtJl/Cz
         0PPc5jFBT5ez2R6/bVTkD2x6kGCDkJ9avrPS+N5TGxIxn852P82i6JAiRnt3uiFNsCBc
         GtFEWC8lerpV7duDsH6MfOW9rjMIlvf6BMIshPdYIy0y6c3Fk/cCxxONym863SIaB5Fs
         vnEFOGQHPpdumUet0AxypNDZasH7m75sxVK/y70O3D5zU4R4kX3rxQxnX6I8h/HbnVAS
         /QMQ==
X-Gm-Message-State: AJcUukc5m56B+B3/jeDj4VtsV4k92fCtO9GApjXozmVoFImaZCcpxWkc
        WDRL1J7FunoH+LalxlTyTEsO1DS6
X-Google-Smtp-Source: ALg8bN5A45781f9CWDi/UMg+xmj2DL8EiEXnEC7PCXHxEX1ChRBa+Umu2ZSxtpCJNAE228rOh0ejwA==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr2663144plo.27.1547536546020;
        Mon, 14 Jan 2019 23:15:46 -0800 (PST)
Received: from localhost (193-116-118-220.tpgi.com.au. [193.116.118.220])
        by smtp.gmail.com with ESMTPSA id x19sm3390093pfk.14.2019.01.14.23.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 23:15:44 -0800 (PST)
Date:   Tue, 15 Jan 2019 17:15:39 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] kbuild: remove top-level built-in.a
To:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <1547436479-10491-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547436479-10491-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1547536378.afs6amsrzj.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada's on January 14, 2019 1:27 pm:
> The symbol table in the final archive is unneeded because it is passed
> to the linker after the --whole-archive option. Every object file in
> the archive is included in the link anyway.
>=20
> Pass thin archives from subdirectories directly to the linker, and
> remove the final archiving step.

This seems like a good improvement. As far as I remember, it was slower=20
to do the final link without the index built. Maybe I was testing it=20
in a revision before moving those files into --whole-archive? If there
is no slowdown, then I have no objection.

Acked-by: Nicholas Piggin <npiggin@gmail.com>
=
