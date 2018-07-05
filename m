Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A13C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996462403D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAohnvsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996462403D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbeGENdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:33:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41367 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbeGENdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:18 -0400
Received: by mail-io0-f195.google.com with SMTP id q9-v6so7743011ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uqYEDBkc/dlcXJasQLr53OUx/dTCchuCyvNt0JIK5Vo=;
        b=LAohnvsD3790baWG1UnmicBOYPBnpSXCXKOlX68YbupcPHGr9L5E1wwOglmrt8wG+l
         oAj+karIGdHWTDkUmPkvRNPE/t8Jy9DIxnrOMvgpc1ZszIvAsMt/oEIFMrmvvZ4Bkwxl
         UYCbGME2SIqtePyhCOMmRRxV3cIzaygi66QrZohu3RhAt9ecqGilVBWZXQsmjvoct7O9
         lqybK1vwG7fFzCINUkaIevCC0Dh7EidVL4VHkjoanJGL37eixDmuRT1szOXUnkq267Ig
         zXMOCaEmSjv/K15P/ufEbH3KpoopmG6nkQDydI3muRlHsfoY1vBotkxiZIARmljrAOZi
         G/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uqYEDBkc/dlcXJasQLr53OUx/dTCchuCyvNt0JIK5Vo=;
        b=VvpHaKFGCFMsJQfqyLc9xUQ/GgEpkA3kt3O/i4GQc4LDByKROkWR21zb5NyjaTNpk2
         nlpvt9eLOmX3I/qbcZyKVN3ny04FahBZkYLuCV3MOaI50/XHF5Mriyvl6D3+ieM5Mwnk
         fxg7PGDaJ4nSLxFaWvEFc5O0t1tehCsCiIhxZZ50qiyS3EtAjA/nOKVnUhB2T+71s0y7
         pBCD6kVzj2hVETOtcUsaHzF4YPeFyRCouJaqSMxG/XwMyUCK2CqfMJMjycz1/QY23x8y
         qUB/6rs1uvWhkwjKBRsNyFhtEKiuufpCLG8c8W59qCU/KrjgGwVDryZhpeqGV03rPxKp
         6cgA==
X-Gm-Message-State: APt69E1zgnaJesJhgwuduBqEuFZo++sKEnMaxNeIwGoK1FoPK8H7YGG0
        T9B+QuKOCXiGJtfkQPJq2B4E/WVuanpuDTE9HHc=
X-Google-Smtp-Source: AAOMgpdV7r9ayWyNH9eo4+5IrwmAOpGmKkLkPSJWC3AF0jeUa+ndiyG8Wp7xDtK8ar95BoRtSFTZ4uir2eyFLtopH3U=
X-Received: by 2002:a6b:a58f:: with SMTP id o137-v6mr4927701ioe.63.1530797597671;
 Thu, 05 Jul 2018 06:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ZOyahLiGS-7DQO8ncJ_=w-Mkav33FBBOC9-K08XSyhPgjtGg@mail.gmail.com>
 <mhng-640c8a78-7e3a-4ccf-9951-fc85a0969b9c@palmer-si-x1c4>
In-Reply-To: <mhng-640c8a78-7e3a-4ccf-9951-fc85a0969b9c@palmer-si-x1c4>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 5 Jul 2018 21:33:07 +0800
Message-ID: <CA+ZOyaggr-Y2-Yh_o4+XQLoT5-o6PM9m4_T3sHHUq13+CgJYEQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] RISC-V: Add definiion of extract symbol's index
 and type for 32-bit
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     hch@infradead.org, Zong Li <zong@andestech.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@sifive.com> =E6=96=BC 2018=E5=B9=B47=E6=9C=885=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 29 Jun 2018 09:53:49 PDT (-0700), zongbox@gmail.com wrote:
> > Christoph Hellwig <hch@infradead.org> =E6=96=BC 2018=E5=B9=B46=E6=9C=88=
29=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:12=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>
> >> On Mon, Jun 25, 2018 at 04:49:39PM +0800, Zong Li wrote:
> >> > Use generic marco to get the index and type of symbol.
> >>
> >> Why do we even need this in a uapi header?  Shouldn't ELF_RISCV_R_SYM
> >> and ELF_RISCV_R_TYPE move to module.c?  In that case we could just
> >> use CONFIG_64BIT.
> >
> > Make sense. I even think the all definitions can be move to include/asm=
/elf.h.
> > How do you think about that?
>
> Sorry I've been slow about reviewing this, but I think just in the intere=
st of
> getting a sane RV32I port up and running quickly (so we can try to get gl=
ibc in
> shape) I'm going to take this for now.
>
> Do you mind submitting a cleanup patch?

I will send a patch to clean up. Thanks everyone to review this patchset.
