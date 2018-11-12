Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F4522419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="sD22Xp8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F4522419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeKMJgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:36:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38009 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeKMJgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:36:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2-v6so8849576edi.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 15:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrG3aXaos4ImMX59gqYAGMxt6oGDGVNni16CPYvz2Uw=;
        b=sD22Xp8HPwG8pDAQOwjtV2mtd+zsL+KcnNp/+ATNRezONheb2+2Q62Z+e3kYsaAZv6
         eOdfhIqvzLxYAhHm1ReM4mGUiw4kc55EdELBdQNaog+9HIObMVScox4uYPtcbAxB8W4H
         CTcD4rgR6OnBX/X4vkXYq2aDjmV/E/a/OKDm491ygOJOGE1mtZUrlSqViEi7iMZkwT3Y
         rmeRdBrg/81dt8FbeCqU3cN9oWFL6zmi+bKONWARZ8+WpZRlrMgfF6gU02bZlNwiZoOS
         vxa8eDMcHVWOUAW1KJHkJDYYcp+y/ZadfsRfuVaLNlZbAPIZcqO5T6YtNxcth2yBK6cf
         hR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrG3aXaos4ImMX59gqYAGMxt6oGDGVNni16CPYvz2Uw=;
        b=tkFBPXXHtyGTLAYZH/nrgh3eG+sez65FRUmJEr9U5Ee5kVrwU3pJdN0DbzqUIQnmNz
         bc5KIePEaKuNvpyS6zspDw/UwfRSXL/VnCzssmlo/NHh19i/e1yOFV88Y1rXkhM7d5Q1
         YdFXwo/kyTa2w1qWJIlL7ewhKPKaKv4S4klyX6x1zCIkCSqH6/p4yF7PCQ26Stu/P57y
         P8+iI5bG+PbER/CBUPnbnHWDeS13rneEZULiuOWOCMhUpH8r29Yaj2toKFHX8l41MeqE
         KosvsquoGay3Q7s2M6g3ij6iFKVenJrtaq/313fxks2fL6S2ObDqLKNp3wevwoDfn7xa
         YFrw==
X-Gm-Message-State: AGRZ1gIO9FHIAabuvRdrsWFdC8XE+cRXe6VmuSudqKwXYogWK2LGyJ8J
        fd1O4ooCa+6EF5v+7/3Hr3hHy0JfxtC31F4tRHxTLA==
X-Google-Smtp-Source: AJdET5eRGIt7710S0e8MDo59JS7FD/hEAzyIJlTeU570/nRzADXyNWsu2Y8uQjRoVTR2gmruv/ft9g5AVAlxmafwRH0=
X-Received: by 2002:a17:906:f1c9:: with SMTP id gx9-v6mr10829794ejb.144.1542066085548;
 Mon, 12 Nov 2018 15:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20181029231447.3690-1-alex.williams@ettus.com>
 <20181029231447.3690-2-alex.williams@ettus.com> <5bea0e95.1c69fb81.88799.a282@mx.google.com>
In-Reply-To: <5bea0e95.1c69fb81.88799.a282@mx.google.com>
From:   Alex Williams <alex.williams@ettus.com>
Date:   Mon, 12 Nov 2018 15:41:14 -0800
Message-ID: <CAJZzcDhTKAXW4vomD2xazfDU=NWH6eAAbLubEhAo-SWuq5+EKQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: nixge: Update device-tree bindings with v3.00
To:     robh@kernel.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        mark.rutland@arm.com, mdf@kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Alex C. Williams" <alex.williams@ni.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 3:36 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 29, 2018 at 04:14:47PM -0700, alex.williams@ettus.com wrote:
> > From: Alex Williams <alex.williams@ni.com>
> >
> > Now the DMA engine is free to float elsewhere in the system map.
> >
> > Signed-off-by: Alex Williams <alex.williams@ni.com>
> > ---
> >  Documentation/devicetree/bindings/net/nixge.txt | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/nixge.txt b/Documentation/devicetree/bindings/net/nixge.txt
> > index e55af7f0881a..d0f9fb520578 100644
> > --- a/Documentation/devicetree/bindings/net/nixge.txt
> > +++ b/Documentation/devicetree/bindings/net/nixge.txt
> > @@ -1,8 +1,14 @@
> >  * NI XGE Ethernet controller
> >
> >  Required properties:
> > -- compatible: Should be "ni,xge-enet-2.00"
> > -- reg: Address and length of the register set for the device
> > +- compatible: Should be "ni,xge-enet-3.00", but can be "ni,xge-enet-2.00" for
> > +              older device trees with DMA engines co-located in the address map,
> > +              with the one reg entry to describe the whole device.
> > +- reg: Address and length of the register set for the device. It contains the
> > +       information of registers in the same order as described by reg-names.
> > +- reg-names: Should contain the reg names
> > +     "dma":  DMA engine control and status region
> > +        "ctrl": MDIO and PHY control and status region
> >  - interrupts: Should contain tx and rx interrupt
> >  - interrupt-names: Should be "rx" and "tx"
> >  - phy-mode: See ethernet.txt file in the same directory.
> > @@ -13,7 +19,9 @@ Required properties:
> >  Examples (10G generic PHY):
> >       nixge0: ethernet@40000000 {
> >               compatible = "ni,xge-enet-2.00";
>
> Shouldn't the compatible change here?
>
That's an oops... Will fix.

Should I leave the old example for the version 2.00 format and create
another for 3.00?
> > -             reg = <0x40000000 0x6000>;
> > +             reg = <0x40000000 0x4000
> > +                    0x41002000 0x2000>;
> > +             reg-names = "dma", "ctrl";
> >
> >               nvmem-cells = <&eth1_addr>;
> >               nvmem-cell-names = "address";
> > --
> > 2.14.5
> >
>
