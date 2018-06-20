Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F3C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ADC2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nfDhzB51";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lyZVGw1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21ADC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932091AbeFTEn0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:43:26 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:37304 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFTEnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:43:22 -0400
Received: by mail-yw0-f193.google.com with SMTP id j134-v6so713579ywg.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lj1IIzR1NND1YVyjhwcm6i6yNxGh0ELYIYI0eJwd758=;
        b=nfDhzB51JGomowjMHvYoy8aPVHEAforyF9meTRdsfzWvQiOur6NJVMXXtPJ6O6PFwo
         Ylr7yYw5AmI7Ym8yM/D9RlDP6UyhoF/IQts8UH4Tg26bNKa+kAtn0exW6sDvdfEPFm9l
         Fon+q227vlCblf2U+ewQN6Y3cXL1P7ORLnYkYqX6Ds+L84gIZs5AjEH4XuTxQgFs16Sz
         3j3xGbMsRj5dhp6CgQTRolwMPmPuFrtRWZH7WxKfKakMeSqSfdx6jYEBXTyBKlHZpSCE
         TEAGyapOjma1hsiH1Iz+64/ZlQjHLAyezyrPBUErjwC2wsm0thNISrhM2fNfoJ7oi8wc
         8chQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lj1IIzR1NND1YVyjhwcm6i6yNxGh0ELYIYI0eJwd758=;
        b=lyZVGw1N6Z90Vi5C+6N5+Q3dEwRALUBfhEAQM41ojaqCbIxxwkXipnSQwcJWLNl04I
         /6NqEtwfZu3n4DrnVDaQGyYIXC7rYFQAaIfh+ToWcovFwcoCVWTy5VyCORA7HsMSshEL
         DvGOhTLQChmeGIOm/AuyTx3ajmTe0Ba9EWxKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lj1IIzR1NND1YVyjhwcm6i6yNxGh0ELYIYI0eJwd758=;
        b=ChBk/U5EFYmIP40x9ZV2pxwEDBKx2QCfS+GKfIKNpzd35hjPS5emv6XnrvTNZQkzCY
         /EAmNupBeSjBOAXMpslT45eVnyXBfHGagXyHz2w4zHzbzXeHQ3lrfhmUg82GOxojvDt0
         FCMW8R9/3qbtgQZ9+HvWSB12MJsscYVIN0bPDimqRI0Vj1HI99Q3V3bag/fUbIXXdE58
         ryy3NQBz9TJdET+BmC3kgAEcWBgVUoI5XOaY/uc7ItKw3ZiU8qdKTZzY1FwzOxU0vnPz
         Q+ZQ1ozp4E3at0nqRKATxKSa64wjyMThpBXAMRsDbxD4jiTswhzR+oX8qyp2xVeqmawR
         XCHg==
X-Gm-Message-State: APt69E04e8snSUGlk8JOxzDWcpL2+QcJ/HWyP82zJCce6hdr3NdIhWvk
        v2JrZpJIARGe2zL+faUCvfQTJCvxieqJdzk/qdwqFg==
X-Google-Smtp-Source: ADUXVKIjYRauid5mCt/uMDnENgmUVjEp1yyWjbgoHolizZyp8q+GZ+aHM3HsrTkk9mS1TPodBMmievJ0ktjFFU0stUs=
X-Received: by 2002:a81:4a05:: with SMTP id x5-v6mr9783739ywa.116.1529469801916;
 Tue, 19 Jun 2018 21:43:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 21:43:20
 -0700 (PDT)
In-Reply-To: <1525706596-13601-1-git-send-email-s.mesoraca16@gmail.com>
References: <1525706596-13601-1-git-send-email-s.mesoraca16@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 19 Jun 2018 21:43:20 -0700
X-Google-Sender-Auth: HGyiSGuOyaXd7UqjzM_gNBEsmwg
Message-ID: <CAGXu5j+Xyb0hD5iMqQHKaGdjBx2TftwU8kNgOT_rKswLsc2=qg@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: drop some VLAs in switch.c
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 8:23 AM, Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> We avoid 2 VLAs by using a pre-allocated field in dsa_switch.
> We also try to avoid dynamic allocation whenever possible.
>
> Link: http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> Link: http://lkml.kernel.org/r/20180505185145.GB32630@lunn.ch
>
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>

Friendly ping. What's needed to take this into the tree? It looks like
all the issues in v1 were addressed here.

Thanks!

-Kees

> ---
>  include/net/dsa.h |  3 +++
>  net/dsa/dsa2.c    | 14 ++++++++++++++
>  net/dsa/switch.c  | 22 ++++++++++------------
>  3 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 60fb4ec..576791d 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -256,6 +256,9 @@ struct dsa_switch {
>         /* Number of switch port queues */
>         unsigned int            num_tx_queues;
>
> +       unsigned long           *bitmap;
> +       unsigned long           _bitmap;
> +
>         /* Dynamically allocated ports, keep last */
>         size_t num_ports;
>         struct dsa_port ports[];
> diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
> index adf50fb..cebf35f0 100644
> --- a/net/dsa/dsa2.c
> +++ b/net/dsa/dsa2.c
> @@ -748,6 +748,20 @@ struct dsa_switch *dsa_switch_alloc(struct device *dev, size_t n)
>         if (!ds)
>                 return NULL;
>
> +       /* We avoid allocating memory outside dsa_switch
> +        * if it is not needed.
> +        */
> +       if (n <= sizeof(ds->_bitmap) * 8) {
> +               ds->bitmap = &ds->_bitmap;
> +       } else {
> +               ds->bitmap = devm_kzalloc(dev,
> +                                         BITS_TO_LONGS(n) *
> +                                               sizeof(unsigned long),
> +                                         GFP_KERNEL);
> +               if (unlikely(!ds->bitmap))
> +                       return NULL;
> +       }
> +
>         ds->dev = dev;
>         ds->num_ports = n;
>
> diff --git a/net/dsa/switch.c b/net/dsa/switch.c
> index b935117..142b294 100644
> --- a/net/dsa/switch.c
> +++ b/net/dsa/switch.c
> @@ -136,21 +136,20 @@ static int dsa_switch_mdb_add(struct dsa_switch *ds,
>  {
>         const struct switchdev_obj_port_mdb *mdb = info->mdb;
>         struct switchdev_trans *trans = info->trans;
> -       DECLARE_BITMAP(group, ds->num_ports);
>         int port;
>
>         /* Build a mask of Multicast group members */
> -       bitmap_zero(group, ds->num_ports);
> +       bitmap_zero(ds->bitmap, ds->num_ports);
>         if (ds->index == info->sw_index)
> -               set_bit(info->port, group);
> +               set_bit(info->port, ds->bitmap);
>         for (port = 0; port < ds->num_ports; port++)
>                 if (dsa_is_dsa_port(ds, port))
> -                       set_bit(port, group);
> +                       set_bit(port, ds->bitmap);
>
>         if (switchdev_trans_ph_prepare(trans))
> -               return dsa_switch_mdb_prepare_bitmap(ds, mdb, group);
> +               return dsa_switch_mdb_prepare_bitmap(ds, mdb, ds->bitmap);
>
> -       dsa_switch_mdb_add_bitmap(ds, mdb, group);
> +       dsa_switch_mdb_add_bitmap(ds, mdb, ds->bitmap);
>
>         return 0;
>  }
> @@ -204,21 +203,20 @@ static int dsa_switch_vlan_add(struct dsa_switch *ds,
>  {
>         const struct switchdev_obj_port_vlan *vlan = info->vlan;
>         struct switchdev_trans *trans = info->trans;
> -       DECLARE_BITMAP(members, ds->num_ports);
>         int port;
>
>         /* Build a mask of VLAN members */
> -       bitmap_zero(members, ds->num_ports);
> +       bitmap_zero(ds->bitmap, ds->num_ports);
>         if (ds->index == info->sw_index)
> -               set_bit(info->port, members);
> +               set_bit(info->port, ds->bitmap);
>         for (port = 0; port < ds->num_ports; port++)
>                 if (dsa_is_cpu_port(ds, port) || dsa_is_dsa_port(ds, port))
> -                       set_bit(port, members);
> +                       set_bit(port, ds->bitmap);
>
>         if (switchdev_trans_ph_prepare(trans))
> -               return dsa_switch_vlan_prepare_bitmap(ds, vlan, members);
> +               return dsa_switch_vlan_prepare_bitmap(ds, vlan, ds->bitmap);
>
> -       dsa_switch_vlan_add_bitmap(ds, vlan, members);
> +       dsa_switch_vlan_add_bitmap(ds, vlan, ds->bitmap);
>
>         return 0;
>  }
> --
> 1.9.1
>



-- 
Kees Cook
Pixel Security
