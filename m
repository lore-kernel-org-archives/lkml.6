Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB35C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC02208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDJHTkI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC02208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756620AbeFPDb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 23:31:28 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:46144 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753944AbeFPDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 23:31:26 -0400
Received: by mail-vk0-f41.google.com with SMTP id b134-v6so6747305vke.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 20:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b6KrVhLor0O8a72b4GeRd/LDC27tOdsrt5RC5q3HN6s=;
        b=dDJHTkI7U9kd8z2lMCbU4fgRxwd0QtK/w57TUM5ZDU2MOdPsrJo+wM69PXrlOyh0jp
         vR1g+42ap5sL01+pnf6AUZP4umfutSMbbVnsYASgxI50rmG5mXg43SfB/BqJvKh9teVO
         ujxbwVj8tiTKj5e2ouTRRLSKojNBYunUfqok3dBDIqlaFwyMsfgnXdZYjv4Z70m7nl/T
         d4KMg2FkqGan19a3i0E3DgnxmtghzTl7nw4wIzqnk8iGjGG53VDsYTPhnJDJXUMgIqgC
         JLt8MLMI10jz3+Kmo0Qxk56uq1rGt/cuYHhKp1L8Ln2Njg2XezypzJLAhm3uOdMYIfv1
         GaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b6KrVhLor0O8a72b4GeRd/LDC27tOdsrt5RC5q3HN6s=;
        b=Ga6cKnF5a58bRUI7M/eQXXHmVM/R6YWAlBazkabNZXGrdGxM9lBdSgcKtQ5D29jEVf
         Z8jagzktM3Vc3NqdrBO5D0jryOHDh2RULR9RpXqu1zZ0u22PCml2Ub9sjktJC3i9qV2p
         4QrRSPecIyzXMLnqjWS9pkAeKRFvLN4px0FYvHXIZTmsBVpjTw0RqBnxvLqleLHLBDxG
         ASEJ3LmpH4vVTLYaUv42ukZ8qF3gxmcVeCd+ytGK/72AY36f7VKKWy9r++hPVNH7p9wO
         zAX+0jKb619r2Ia5Q9cZDIjpN9p1x0afjfOMNqtp9eyhgBgOV3oRaWhKylWrnvjhlAT5
         betA==
X-Gm-Message-State: APt69E2EeqInbmfIgDC+taJEaNyAseCXZvI5u3uIpuPyjml5szFqqRZm
        kPwR8ArVujUAYHc0YkXQOWx2zJw+ctuhbmVEMps=
X-Google-Smtp-Source: ADUXVKIpeleJQGb2FlEM13El+WsydHGS176RBtgVmvUql9vSazONUJiqajaV9pVcNyBVzw2YcqXTrZDVgFrLBdxZoIY=
X-Received: by 2002:a1f:a285:: with SMTP id l127-v6mr2524933vke.95.1529119885779;
 Fri, 15 Jun 2018 20:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180614142852.22226-1-jhogan@kernel.org> <CAEbi=3d_muKnGnmfu8OJZqO=2EUTSf-YjLPChupDVXxcacJejQ@mail.gmail.com>
 <20180615123445.GA335@jamesdev>
In-Reply-To: <20180615123445.GA335@jamesdev>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Sat, 16 Jun 2018 11:30:47 +0800
Message-ID: <CAEbi=3d+3dMjUF3FEfp8HgTRtBSitu0uvqYukbFiYmMoPNeqgA@mail.gmail.com>
Subject: Re: [PATCH v2] nds32: Fix build error caused by configuration flag rename
To:     jhogan@kernel.org
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, matt.redfearn@mips.com,
        palmer@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Hogan <jhogan@kernel.org> =E6=96=BC 2018=E5=B9=B46=E6=9C=8815=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Jun 15, 2018 at 02:12:58PM +0800, Greentime Hu wrote:
> > Thank you James and Guenter.
> > Should I pick it in my tree? It will be ok to put in your tree. :)
> >
> > Acked-by: Greentime Hu <greentime@andestech.com>
>
> I think your tree makes most sense for this patch, since it only touches
> nds32 code and it was nds32 that got broken (and I haven't actually
> build tested it for nds32).
>
> Though it'd have to be based on that MIPS merge I mentioned or 4.18-rc1
> when it is released.
>
> Thanks
> James

ok. I will pick this patch in my tree after 4.18-rc1 released. :)
