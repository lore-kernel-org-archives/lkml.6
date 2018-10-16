Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0329BC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC7A208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPQJ1pqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC7A208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJPI6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:58:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43256 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeJPI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:58:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so10109741plb.10;
        Mon, 15 Oct 2018 18:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jg4nzIGB7QtdoRL7x2OyUuHApbndmi/XN8GQm5zFfmI=;
        b=jPQJ1pqKE3ifShdMCpSve1gKqyD/tfSRoV8+YeyL9C/22SK2tbI8auZ6mV/ss2PHbo
         GVSH4bggBFN2Bkn2Xy0ncLClLXpMVPtOpc6CKV6e9MyocEFBaG2OU22iT+5A32sbHl4A
         AplVJvFVxfpiTdW4IEKUYrRXkTrdC8yq7X8JVPkz8F3N0DnbPSYIkdcXrlJn+nD/HP2Z
         AHk/Tw+L46St+Ku9z4edjpQe6jSlw8ECYbVuFT7Ugwg5f9pNBREn5kKWiCr9syDAipnX
         D7f2XnvA+uijfV0ff68V97vmiKyINdmKiDtRABk3SEzL4K1ntEby0Znl7n/ncKPZHmpQ
         mkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jg4nzIGB7QtdoRL7x2OyUuHApbndmi/XN8GQm5zFfmI=;
        b=Pc9Vyg91hp5DYOuarq2/+0yNO7e63/1yj4r/Qvpq5hs3zxBx5vv+j2ufXig+HMiX8n
         up0KbyQH224iiX0TW91zB0PVVkxjZlXFPFilftEKnWZg8lapkFwJDBXf0SaHY1Ga9uvx
         CH+XuLrnrAmU3rNKlAkdBp0D++R51AoITNEx4InrjtQVaQUYNO7YU8J4rvFbr1CyHF/F
         sqAkWztY37zIdi9mwT0m8sfrcihh1bKsWgU/Zwb5gq9DPU9F53vPDKvoxEuasUlmiZjb
         rTe+66VSb+1b8bf+jdyW50BeciF3/6ZPb1LWnOQEnnNgQ40UkTBCm8FcfJi7YGX38339
         8uYQ==
X-Gm-Message-State: ABuFfogiTjkF4OrY9aX/djCc8BgWAhoyuT+ZsROdSr3yu2j5ImbvNbsG
        4jB55+Q79RgyLaAXWUAasiY=
X-Google-Smtp-Source: ACcGV638/NkZj3qYrt99JzmkFSa+xsK/qiNoJ6ykTn0KKMwZd5z+txUnn105MYsHDDGMz2uPksZuGA==
X-Received: by 2002:a17:902:bd8d:: with SMTP id q13-v6mr19262591pls.167.1539652215201;
        Mon, 15 Oct 2018 18:10:15 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([60.240.252.156])
        by smtp.gmail.com with ESMTPSA id i5-v6sm14654796pgl.46.2018.10.15.18.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 18:10:14 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:10:04 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] powerpc/traps: restore recoverability of machine_check
 interrupts
Message-ID: <20181016111004.662d16cf@roar.ozlabs.ibm.com>
In-Reply-To: <ab520cc1-11b7-ddc6-2393-8f1315db4db3@c-s.fr>
References: <f79824d5da910441ede885fa32a25083c4cc9359.1539422122.git.christophe.leroy@c-s.fr>
        <ab520cc1-11b7-ddc6-2393-8f1315db4db3@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 09:40:50 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Cc: stable@vger.kernel.org <stable@vger.kernel.org>
>=20
> Le 13/10/2018 =C3=A0 11:16, Christophe Leroy a =C3=A9crit=C2=A0:
> > commit b96672dd840f ("powerpc: Machine check interrupt is a non-
> > maskable interrupt") added a call to nmi_enter() at the beginning of
> > machine check restart exception handler. Due to that, in_interrupt()
> > always returns true regardless of the state before entering the
> > exception, and die() panics even when the system was not already in
> > interrupt.
> >=20
> > This patch calls nmi_exit() before calling die() in order to restore
> > the interrupt state we had before calling nmi_enter()
> >=20
> > Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskabl=
e interrupt")
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

This looks good to me and probably the simplest fix.

powernv will need a fix on top of this, to remove the die and let it
just fall through unrecovered to the traps.c code. pseries seems to
be okay. But this patch looks good.

Thanks,
Nick
