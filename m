Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA2ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA802077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAnd2XhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA802077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbeGQWFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:05:24 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40982 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbeGQWFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:05:24 -0400
Received: by mail-ua0-f196.google.com with SMTP id t14-v6so1623512uao.8;
        Tue, 17 Jul 2018 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IB+S9R6am3lT0ggeX1v9NqkNR06cnM9Rr0oHlTw/k30=;
        b=MAnd2XhYBy0/0nibXURTmxE5xZV/1Iib+32Mnc1ccRHu9kWBIFKp7TYZ7o9+Dbc9Ns
         E43lF0vvSz5uwi/NSu2v8wcCeBR5krJD5IvFe5Kc2xKtVhl8yuWx+F2OeQiYYsdHvK6l
         vXtXwJY2l7fVZvOOYixfBUz82yOHsYbhmQda9DJMstDsuk2S6nv2Vzjw+MfQNU4CxJQL
         mmFiLBQh6FW1D9fsITVYkWeS4r47JVv/ORTNAXNDhVBfkOl5iaWo8alrwwavYjnTOVZ0
         bb9RNtOf07+Syy9to65RZeBYo6J+8hqxuzb1+LFvUBNas9LUWBfghNt5gCwysh3QTXgr
         BApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IB+S9R6am3lT0ggeX1v9NqkNR06cnM9Rr0oHlTw/k30=;
        b=SoN89w8wvdnehIMY2e792f27I8ayNde4MTt/wxoeamYyFzr7Y2+2xAGKJfkapzOgw9
         KrhWwtKl1Sk5GzqO4BPK50Iyk66VDl27GEtzZJ9jzVj7jmn1ku6c6NAci/E1+rScHFui
         Asux9dkutuZ3xv5Wiy5wosXGVlxjGC+PocTLN386iUaoXapEGgIN/3XhJIJr3zpg8OI7
         lweZSk0B9lkm25pNiOInEqbR8iMKarShTtat2gVlv2MBp+pNXAVS+4gS1gKkgQE+d3Tp
         TY1lXn9esrtwFSzreciL2TfpjKb7B4SMN6RpolUdqteuOI7CGnOIDJ0ocZ1hltjuQJtL
         BKhA==
X-Gm-Message-State: AOUpUlEmKVI84vHoqYS+QHnDV7DzHk4jXQ6m2EJKAD8+ogR+bJUmA/SL
        ihe4jgaj2Mvwm66Lzwt3BDmCRDjrLBjWObGkMbg=
X-Google-Smtp-Source: AAOMgpeGBNBwsB8dHZMI2xYlox+0Pk6algpITuWJGqr2lkr9CeLtupIwJqcxt0EBB1vOKTFF/zXAkNrWiV04UvTcP9I=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr2344195uac.49.1531863050590;
 Tue, 17 Jul 2018 14:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 14:30:49
 -0700 (PDT)
In-Reply-To: <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com> <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 00:30:49 +0300
Message-ID: <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:30 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Shouldn't it have a Fixes tag?

-- 
With Best Regards,
Andy Shevchenko
