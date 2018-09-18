Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7C1ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628DA2150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M4VDoy3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628DA2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbeIRWSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:18:46 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57281 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbeIRWSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:18:46 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 8a4c8f1d;
        Tue, 18 Sep 2018 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=we6n9ZS3EbU9E0kEmF3IfmEIGg4=; b=M4VDoy
        3Z64+UnM7gtMi6JZJupID2uoq6GxOsIcBrvjRKfFmIJxyOW2G+5j4dNe1g1uS9W+
        BdQVOrHwJTcuawMlvGFiuDnqlPUncPkzVYVi2USJ8gmlJ5sP496TNfLNxTdM0srX
        f9mzH/nRRBZofT0f3flwUbOU8Sg9g+XsLsBnmFZ1ulyUc3GW5N1OQM5D8UefEDk9
        2wx6b4E0jDbOJhN2xLBkUhGm2zY9ViIwg/fLxc0BJQizHxYbB4Llfa9gspe5jHll
        /8YM8HwHcO8AI/UeTAjsUyl6/PbWHpUAi+k3gySUdOd8fWSPkLmxg2L52BbkHfHw
        CTJFopJe7yo+U4Lw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e9eed4c9 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 18 Sep 2018 16:27:44 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id k12-v6so2406785oiw.8;
        Tue, 18 Sep 2018 09:45:18 -0700 (PDT)
X-Gm-Message-State: APzg51DFKkuOAcnweasUQgDwPMQahy+bChcHajVmaRzDuXbLv9rsjFkG
        vCLFwOM3krMQ6vnHqb/V07pW1xIxuT5mPwrt/n4=
X-Google-Smtp-Source: ANB0VdZ02vvPOtbI5P0TPV/pgh4NVxHhQkevLF6w1vTGxxM6/+OFaP4c7nPQjA0xwEPYOp9hD22PpWiYehz3qtRosoA=
X-Received: by 2002:aca:da56:: with SMTP id r83-v6mr2140979oig.265.1537289117797;
 Tue, 18 Sep 2018 09:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAHmME9ohGPTX-fkhP6zaWdx3SbkiqO5kWkWE-bDk=pm-nUqYvw@mail.gmail.com>
 <8937D6B1-D21C-4C47-8A89-A466CDB6FB04@amacapital.net> <CAKv+Gu-t5HPj+Y3-7JqkaKTdt-0ewOUobQaEuikpeOaX_SF+zg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-t5HPj+Y3-7JqkaKTdt-0ewOUobQaEuikpeOaX_SF+zg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 18 Sep 2018 18:45:06 +0200
X-Gmail-Original-Message-ID: <CAHmME9oCWv9J7=fpTCgDJeVNffYW1Y7MVukp8HT8RaVn8cDt_Q@mail.gmail.com>
Message-ID: <CAHmME9oCWv9J7=fpTCgDJeVNffYW1Y7MVukp8HT8RaVn8cDt_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Sep 18, 2018 at 6:06 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> as long as we have data that supports the claim  that it
> is actually faster on hardware people care about.

Seems reasonable. I'll next be turning my attention back to ARM
performance. I'll try to gather some numbers. Expect data at some
point next week.

Regards,
Jason
