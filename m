Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A7FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADE0206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfvUU3/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADE0206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeIZNYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:24:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33334 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZNYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:24:25 -0400
Received: by mail-io1-f65.google.com with SMTP id l25-v6so9372334ioj.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9bIXZLzJ7jUFS0/wlaunLKXPPS9gwJiu0fKbgkvIH48=;
        b=LfvUU3/GMAnAuGqjxZFRJA0/Q9iVZbAeHkSCTHxD78yeXp2stoWDIYgz/Rweh7Lxw8
         C05pQcStt0gU6a9dzELWAdA3fgqhF6/0ecINMqqllv6ThVAXtoZybvd/M7tZQ0VSeQgo
         GIezZdcjWNElBXD1+r6G/VQw60vmECd3xUbqIFNhOR8s0XpD9Kyp7ezUEILkeS0CXSBN
         wQD+fv0w5louEhjxyG7SvfREByM2IN54HdBS8mGXquMhfkEmUF29FZkyknlaJt95q8SZ
         aZEfptMy94mfy+HyODjBpzw99Afjsq2onpm02s/ZViXqPPnYRumgncUUJfWoBFrpabm2
         RXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9bIXZLzJ7jUFS0/wlaunLKXPPS9gwJiu0fKbgkvIH48=;
        b=d0+1DDejrRVb0uZsN8Q15e+3E+lvvHmc9Zx6mmk1jamBvpsPngSqcK/oqt455ExVpW
         WitRB7EM1VFY/4svKPGGe+Gby3gTstoFe6q8xuKHX520YRxDVLekKglcr/hcd79D+ojA
         NxxAKa2oJYIy7c1+Yjg3q8oedC3eWB7JOM7JWWCtTIk+NIFRuC0lAdOnUxVFPYdpyVIx
         8pDShqdTaEZD1QzAkSZFFDZwPi/3L/Z8uU+s2nk+Dw8PDNRK4W9k2PALT7yMqK4RZXYT
         JOFyjZb1oWv+V37aNRFI101ZrdASzjQ3yZyOHWTXvIqXgGI0ZO/FTyhKmw2nLlSyYb7E
         BmEQ==
X-Gm-Message-State: ABuFfohVdGZVqCKAURbHEVwESCnQh5C+4QwfDTxBgaKxISbQLR5SgJSI
        dFu79sM3D2szXtDOx5F/Nsyrxz+8Ej4nlJHt4i4=
X-Google-Smtp-Source: ACcGV62KypCputrv2j62PhFXSTV3RLo/Lmo9tUIs7Le1y4/NnydCuplOa82LAbe1mj+oMHdhkFuEax2/H34N1qR1FDg=
X-Received: by 2002:a6b:9ace:: with SMTP id c197-v6mr3931139ioe.63.1537945976223;
 Wed, 26 Sep 2018 00:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537260207.git.zongbox@gmail.com> <2ccc6c0758624dbb22f6fe451a3e476a000108ef.1537260207.git.zongbox@gmail.com>
 <20180921070006.GC8401@infradead.org> <CA+ZOyaiJv-NZWk3ec_3zhRTSn7G-NGgyaiPTXOmuWfTWD7KSJw@mail.gmail.com>
 <mvmefdicabq.fsf@suse.de>
In-Reply-To: <mvmefdicabq.fsf@suse.de>
From:   Zong Li <zongbox@gmail.com>
Date:   Wed, 26 Sep 2018 15:12:45 +0800
Message-ID: <CA+ZOyagnA=NRjRH4qWw8FgOTBr1uAvDvK1Pk8MAw8ysQdgdfPA@mail.gmail.com>
Subject: Re: [PATCH 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library routines
To:     schwab@suse.de
Cc:     hch@infradead.org, Palmer Dabbelt <palmer@sifive.com>,
        aou@eecs.berkeley.edu, Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> =E6=96=BC 2018=E5=B9=B49=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:20=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sep 25 2018, Zong Li <zongbox@gmail.com> wrote:
>
> > The RV32 need the umoddi3 to do modulo when the operands are long long
> > type, like other libraries implementation such as ucmpdi2, lshrdi3 and
> > so on. I encounter the undefined reference 'umoddi3' when I use the in
> > house dma driver, although it is in house driver, but I think that
> > umoddi3 is a common function for RV32.
>
> You probably should use the macros from <asm/div64.h> instead.

Hi Andreas,

This doesn't work for me, the divisor of my case is also long long type.
