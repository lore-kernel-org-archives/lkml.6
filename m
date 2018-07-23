Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB8FECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C5020856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0y32/3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C5020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbeGWTlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:41:53 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38259 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbeGWTlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:41:52 -0400
Received: by mail-qt0-f195.google.com with SMTP id y19-v6so1657316qto.5;
        Mon, 23 Jul 2018 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VggJN/uL5OgWToI3ef4x+05Yp/8H9hRSHoz1eHf1OWk=;
        b=s0y32/3nE6gm0XLqNeHwJxa1nb0JayWi2gviC+fMHZ8a/ESWdZA1PuJuwQJb2B90Gq
         CEamrKVaz3R5hPKItyNPi9zqri0GmYHSgmJ0132N1ls39XrzPBmCmwgXXJomcxekCJb1
         t373IrgJgfqQ7VJ7OyHMQcT739Uty3mthmUlVoaBFYzXJqDcLAaI2SaWbvvCwNRev9HH
         CJ/Xx3H4B08Clmif1Lv51Vbk5VTXNjw2rUEYDtoYE8OgO0XnJuIXteHBm5xyVBK0C9b3
         Y00IOTBxeWLiU2wbjVYMqhp7h9WCjdahVxRnEggylzU1HY2Blu3YRVYk4CAkaAd8A6eF
         ygHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VggJN/uL5OgWToI3ef4x+05Yp/8H9hRSHoz1eHf1OWk=;
        b=meVbI4uFZq/CXK6erIVrMVGjbju/i0SdGczGlFP56a2U+KO2j4v/RmEp5tzIDrRzTI
         aKzYRw1R+pF0gjuptPQQX0RmYM4R/iLfyajLYgxa9Dy38lQt4+vv0p2pDGjXP5xzEyCN
         1i5zPKPG1t1YkMHQ0HZq2tS4tWna9CB5FlN3QxYQZKpM6iIBY6SpzhZen/K6qdIoXzig
         0zElLy1xaC/UHCEVIt1hbGFuAGF46J09ps9u23uXDhNPlR1d4u9TYEni/UF5vtYTavVF
         ncjbDPvzjy49h8DZOpATOKNwbwsaEmMn+bKefS82MlOFd88KU2+/FZZ4066MRgRWgpSV
         f2VQ==
X-Gm-Message-State: AOUpUlG91BsO6XhkJA9fPS6ZEq8SCb129OiXLD7LrZZbTXJhk6FcpS4y
        7SUL48BsBEnnLBC7BhOUyVvX0Zb1jI1EbQ+z9/ozhQ==
X-Google-Smtp-Source: AAOMgpfq5E4CgVEIbxsFPXC4Y0NlMDTEliEsyeDbvWnoHsU5IrrCC99iwv9ZEUqJbzpNST/zevxpdHT2EVtLKLOehno=
X-Received: by 2002:aed:3b5d:: with SMTP id q29-v6mr12828305qte.389.1532371161234;
 Mon, 23 Jul 2018 11:39:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 11:39:20
 -0700 (PDT)
In-Reply-To: <20180723181424.3c07f5b8@bbrezillon>
References: <20180721200049.7553-1-anders.roxell@linaro.org>
 <a83ff193-be57-f566-cafb-132075025b56@infradead.org> <20180722082939.2de739f1@bbrezillon>
 <CAK8P3a1_8OSqyKsbw+m3ZzLWfPqDK4ynG3WoPTk+K2uJJsiq5A@mail.gmail.com>
 <20180723114107.664164d2@bbrezillon> <CAK8P3a10SsWuPXzOyRcNKa+ukvj_Gq13JyDTngoU8DJu6_MR0Q@mail.gmail.com>
 <CAK8P3a0p_8HWz0kLLrkwmpcbt4BsMiDG=hFK4SxeJygucZ1yMg@mail.gmail.com> <20180723181424.3c07f5b8@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Jul 2018 20:39:20 +0200
X-Google-Sender-Auth: gpI3OlnPd1jwPWSj6Xa0XacWIng
Message-ID: <CAK8P3a1D=zY9EBSvH6mXQbB01tSRsiKBiJ9_dqJJHCH05t0z=A@mail.gmail.com>
Subject: Re: [PATCH] drivers/memory/Kconfig: Add CONFIG_OF dependency
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 6:14 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Mon, 23 Jul 2018 18:04:52 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Mon, Jul 23, 2018 at 5:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Mon, Jul 23, 2018 at 11:41 AM, Boris Brezillon
>> > <boris.brezillon@bootlin.com> wrote:
>> >> On Mon, 23 Jul 2018 11:34:43 +0200
>> >> Arnd Bergmann <arnd@arndb.de> wrote:
>> >>
>> >>> On Sun, Jul 22, 2018 at 8:29 AM, Boris Brezillon
>> >>> <boris.brezillon@bootlin.com> wrote:
>> >>> > +Arnd, Rob and the DT ML.

> Yep, somehow io.h was indirectly included by gpio.h. I fixed that in my
> patch when replacing gpio.h by gpio/consumer.h by including linux/io.h.

Ok, looks good. With the patch from you plus the one from Anders,
I don't see any more randconfig failures in this driver.

    Arnd
