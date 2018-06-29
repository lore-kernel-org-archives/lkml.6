Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDC2C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65059277A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgPLVK5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65059277A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937101AbeF2QyC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:54:02 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:51827 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932296AbeF2QyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:54:01 -0400
Received: by mail-it0-f44.google.com with SMTP id o5-v6so2714658itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qTmqc3ee6M61Z5g3ySvGfK3UByZr3qSdgogvBjVnPNY=;
        b=TgPLVK5sbw1LMbFhD9Lz32Ge8JzrytyKZESb+payz0YMTzBzpJ8aUj9d39wUdKjlnM
         sWgNqH2SGJA+Y/UOtCR1AAS/c32lFRudv6xnq3WM4uJ5FmwZeVBE7ZCjTBIikmmGqzK7
         +XGmoHouzbmgtFPgj/gpmwTaCDMebnsEJs7bEdd1EBrrk4rBIf6jGroG0TtD2pDZ+jaQ
         vLvYCWoQLqjUPS7vLJ6u4nxVogPYKpfu4cJuDjuOqynSBrOVGgEc0HbMPJ6pzA7Z//Yc
         cEri2sZSHYKPkHUe782mYr11kiUOWYJNZ6Yrtogh/mxSpbf8j048t/0yQQ3iS3B1Sdw2
         S0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qTmqc3ee6M61Z5g3ySvGfK3UByZr3qSdgogvBjVnPNY=;
        b=uW1oQSzV9fuG0ebvEY1jn8XIHU9sPjItMLiTY4BnlvWZSLAeYstf/SBpUFjkk8clTG
         RfOCD8lnGAOu10zdwpo0l8Dv//xWDQdv6LQkRJfE5qfuDav3KJ68abDsi6nfNx+wQEpr
         r1SSStvGcjQ67rXo8wfz3n5BssIq+j0crz/J5pL8AvN/Tv7xCDKbS/YBC6oXs7u7lZvq
         vml3edhE6LmYliT33yJ910Jh4SRM7GG8uEwE9v9KXAnX1sSe0o9ZOPIuLYlRaunAo1FW
         KbwBFIdQI/v0lckrlf15pgXOKB0QanFgFBviSDWWtGAu/4gPa/759KAZkwU7etpMfEbY
         uSnA==
X-Gm-Message-State: APt69E0XjO2M3Y7Whfkguorl7cw5K+3wUVap2yf939Dummo60K97AWeE
        4zmcOFMQlBCoXF/XRvw1XVgNGfMYSp6oPs8bjH8=
X-Google-Smtp-Source: AAOMgpem1Svhj1V8ZNVfDWtzLniko6mojk/k06AGI0gcFsOHdBBVdnAQQUmbSwzmCJwyK5rUNoRRTEGrW1NvnKi1Jds=
X-Received: by 2002:a24:d51:: with SMTP id 78-v6mr2379461itx.103.1530291240634;
 Fri, 29 Jun 2018 09:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529915117.git.zong@andestech.com> <4c4def99db5e0392238947dc878c5018cc7aca3e.1529915117.git.zong@andestech.com>
 <20180629071200.GC12956@infradead.org>
In-Reply-To: <20180629071200.GC12956@infradead.org>
From:   Zong Li <zongbox@gmail.com>
Date:   Sat, 30 Jun 2018 00:53:49 +0800
Message-ID: <CA+ZOyahLiGS-7DQO8ncJ_=w-Mkav33FBBOC9-K08XSyhPgjtGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] RISC-V: Add definiion of extract symbol's index
 and type for 32-bit
To:     hch@infradead.org
Cc:     Zong Li <zong@andestech.com>, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E6=96=BC 2018=E5=B9=B46=E6=9C=8829=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Mon, Jun 25, 2018 at 04:49:39PM +0800, Zong Li wrote:
> > Use generic marco to get the index and type of symbol.
>
> Why do we even need this in a uapi header?  Shouldn't ELF_RISCV_R_SYM
> and ELF_RISCV_R_TYPE move to module.c?  In that case we could just
> use CONFIG_64BIT.

Make sense. I even think the all definitions can be move to include/asm/elf=
.h.
How do you think about that?
