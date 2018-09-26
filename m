Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994E220843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsPkd9rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994E220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeIZUvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:51:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37065 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeIZUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:51:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id e15-v6so2109839edr.4;
        Wed, 26 Sep 2018 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eujZo+iPsc3p1wxSXjlMjH8RwKx+Rf4KvBqVfOImDOo=;
        b=JsPkd9rv88dJtZJksokx6TkVRjBwyZNULiK3aNJUXDWeFaOUTGO40iM+3vPnbntW9Y
         SEibZrIppuF7LDeBjTDQZHMHihsEk+N2gYyrdI0tO69/e7GVsYZLvaDkp3T9SI+nboXb
         f8gPa1MabJxdwUcAr3IwA5h5SFBTdNFwzkf9En7L4/Gai4KI6kQRTw6kV0h7DR7wyoI7
         0dtXHFw/RH3dpPKSEBiOvyrU6IgHIZootl8texLbnPLI6Fdao9pnXak6QDJJJL2S3OLV
         yHv41Km/UorFv2ZuAqDVMPJ3E20Ynv6cILWVrEDigneIPEBNzjphkW/O5AUjjR92H5bb
         OuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eujZo+iPsc3p1wxSXjlMjH8RwKx+Rf4KvBqVfOImDOo=;
        b=OYBs0/w5RIjSuDK9OXLGLIHIBn5Us+p1xhOHkvZa6EsS+EtiqLcjH8l7vJG/UsBO+w
         czGMU4ITCRxMiKfgc0KpTAEudK6YiqkuqZR7jMFHbK9J16MfzvfILixmuVOJ/SY0Dx42
         K2lxrAWSl5MUSgYWFxLUxOt5rXugXdgrM64Vdo4UXH/p227tp6Oph3VYwB3GNWnZ9WMS
         fqIEUnzyf3C5q7IpJVcZLoYIUoQVnonnca3A5Co0mWOuRVT5nTcJR3X0v0Z66ZQ7O66D
         gV23Tlhg2v5TP92ehwlL3gliZj8U+VwZnakg7Y+Z3Z0gKlZt2RU5Iw5spzQT11n+r9bC
         37UA==
X-Gm-Message-State: ABuFfoj2G8EM7AhnmmosyDOOuYIdrFa31916/tkRaTjwasP8f1ZFGIl1
        MLF4kz/99kVR9M4tImACmpYoIRNgk4QZoYDaF7w=
X-Google-Smtp-Source: ACcGV63tq0nehJHCMGsF5InDDW0DEgP4Sax0Yba8Y3qAE4qh0g/knB9PIqEqmZLmQHqJuXSy5rKRFj2/H+65xuliyJE=
X-Received: by 2002:a17:906:f28d:: with SMTP id gu13-v6mr816869ejb.2.1537972670712;
 Wed, 26 Sep 2018 07:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
 <20180925203701.13605-2-dangtranhieu2012@gmail.com> <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
In-Reply-To: <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
From:   =?UTF-8?B?xJDhurduZyBUcuG6p24gSGnhur91?= 
        <dangtranhieu2012@gmail.com>
Date:   Wed, 26 Sep 2018 21:37:39 +0700
Message-ID: <CAAObPoHOEYrDj8uoFK-gW8jvy8i-vtRhTkEEm5aVNn8ucLxRMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: Option to allow stalling
To:     robh@kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> DT bindings should be sent to DT list.
>

DT bindings already sent to DT list, included here for completeness
sake. Of course, this is my first patch to the kernel so I might have
completely been wrong about the process. I can create another patch
set to send to correct list if necessary.

> On Tue, Sep 25, 2018 at 3:37 PM Hieu Tran Dang
> <dangtranhieu2012@gmail.com> wrote:
> >
> > This patch add fsl,allow-stalling property documentation for fsl-lpspi
> >
> > Signed-off-by: Hieu Tran Dang <dangtranhieu2012@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> > index 4af132606b37..2b012b8cb05e 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> > @@ -6,6 +6,8 @@ Required properties:
> >  - reg : address and length of the lpspi master registers
> >  - interrupts : lpspi interrupt
> >  - clocks : lpspi clock specifier
> > +- fsl,allow-stall : allow stalling of transfers when the transmit FIFO is empty
> > +  or when the receive FIFO is full
>
> This seems odd. That seems like what normal behavior should be.
>
> Rob

Default value of the register is to allow stalling (NOSTALL bit not
set) but the spi-fsl-lpspi driver defaults to setting the NOSTALL bit
in CFGR1. To me, it's more logical to leave the NOSTALL bit off with
fsl,nostall binding to set the bit but as I am not sure if there are
other drivers depending on the NOSTALL bit being set and not wanting
to break other drivers hence introduction of this binding to keep the
current default behavior.
