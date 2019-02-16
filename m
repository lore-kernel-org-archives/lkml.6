Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186B7222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBPYVPc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfBPIii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:38:38 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44770 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbfBPIih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:38:37 -0500
Received: by mail-vk1-f194.google.com with SMTP id h128so2784367vkg.11;
        Sat, 16 Feb 2019 00:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cVJFHTD2Y//RqTAoXqxhP1FHe1eeOfYAgNjfhZgiz7A=;
        b=UBPYVPc+DkED3Sqk5m+jXIGq2Id7jrhp3bt1hYODgYSfwsjw1iU+6k3UeKzzNtu1Xe
         Qi9ohHGwWHMCP/WAEZDCqCaGuxOlaP1NkLBhfLiT1qXfHQ5+gg1Po2znut9hv3kawecW
         nMLiIml4w+84Aj80Y654/FMSJurDQGj35wv7pts88tRdEFLMH9iD1SFMoYgvrd+scX+s
         AwrC0RV+jnso2DXvs4hWL8PNMkFGbrk3WwH1FujLajoUrHnB/BUJtdcp4/4BxwhnhUP2
         wvycCjptsZSXm++d9gaQF+WHOND+Q7aeYJ1hKUqRMqTHYS8tC599EqnzgYrbqcNPBo8Y
         LwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cVJFHTD2Y//RqTAoXqxhP1FHe1eeOfYAgNjfhZgiz7A=;
        b=KIXSS9hQ1Gl+Ib0RS5LIZhBc5khuFXsHt3OJjqabF/QUHE7G0ZufZNRwyvigNaFxfP
         IOTHo+Yolp9AguT92SO5JgnIQkZe+knT2eTOs2PnBGenwCmRWv3ZB4lqyXYGevF0Lhpw
         SlRpV8nal8NHRNrd5xvaHnEqv4M1IW3z+UvlsLW4aWrTnnDHceJac3LiMlvXb2XRVUo5
         FetSyvCoiSnWHCKEOQhHvsMLcgCzWv3TnNmxi032fG0BjkdKDR3d5xAZlxOcoN4lNuPb
         z+Nkt7SpSEwdDQzdbMOlLcMGmtmNA9I2i1P5HiBnXK0uRnEP/ZLYJaIsen0T8LaeRaO+
         Z/PA==
X-Gm-Message-State: AHQUAuZ4F1eUVv9ArM961vyl/hqiJbq0D5mU9Q6eKo3tQaSE4a2nzXYY
        3ocLVhqHS+K6buqbiuU9zG3gN0L9qOf+GxvK2g==
X-Google-Smtp-Source: AHgI3IZOXx59AUr2KWvqsNVJsQPOM25phW0PjOHXCfgdcU4+NCTgiJYIIsrolYYB28TvAJ1m48AXMj7NLkR0rMWOG0w=
X-Received: by 2002:a1f:52c2:: with SMTP id g185mr7023754vkb.57.1550306317026;
 Sat, 16 Feb 2019 00:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20190216083524.860-1-rdong.ge@gmail.com>
In-Reply-To: <20190216083524.860-1-rdong.ge@gmail.com>
From:   Rundong Ge <rdong.ge@gmail.com>
Date:   Sat, 16 Feb 2019 16:38:25 +0800
Message-ID: <CAN1Lvyqo4K3OJEO-RAnp03tM5SgBr3ZK=NTCtKOc+YTymjw8CA@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: Implement flow_dissect callback for tag_dsa.
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     vivien.didelot@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

I have tested the L3 forwarding throughput performance of my box (with
an intel 4-core processor and each core=E2=80=99s frequency is 2.20GHz).
In my test scenario, I generated 200 UDP flows (frame size is 64
bytes) with different src/dst pairs from eth1 to eth0. Eth1 is a slave
DSA device from mv88e6190x, eth0 is an intel NIC. Then get the max fps
with no frame losing.

The max fps with RPS working is 400235fps, frames are hashed to four
cores=E2=80=99 backlog.
And the max fps without RPS is 199686fps.

Rundong

Rundong Ge <rdong.ge@gmail.com> =E4=BA=8E2019=E5=B9=B42=E6=9C=8816=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=884:35=E5=86=99=E9=81=93=EF=BC=9A
>
> RPS not work for DSA devices since the 'skb_get_hash'
> will always get the invalid hash for dsa tagged packets.
>
> "[PATCH] tag_mtk: add flow_dissect callback to the ops struct"
> introduced the flow_dissect callback to get the right hash for
> MTK tagged packet. Tag_dsa and tag_edsa  also need to implement
> the callback.
>
> Signed-off-by: Rundong Ge <rdong.ge@gmail.com>
> ---
>  net/dsa/tag_dsa.c  | 9 +++++++++
>  net/dsa/tag_edsa.c | 9 +++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
> index 8b2f92e..67ff3fa 100644
> --- a/net/dsa/tag_dsa.c
> +++ b/net/dsa/tag_dsa.c
> @@ -146,8 +146,17 @@ static struct sk_buff *dsa_rcv(struct sk_buff *skb, =
struct net_device *dev,
>         return skb;
>  }
>
> +static int dsa_tag_flow_dissect(const struct sk_buff *skb, __be16 *proto=
,
> +                               int *offset)
> +{
> +       *offset =3D 4;
> +       *proto =3D ((__be16 *)skb->data)[1];
> +       return 0;
> +}
> +
>  const struct dsa_device_ops dsa_netdev_ops =3D {
>         .xmit   =3D dsa_xmit,
>         .rcv    =3D dsa_rcv,
> +       .flow_dissect   =3D dsa_tag_flow_dissect,
>         .overhead =3D DSA_HLEN,
>  };
> diff --git a/net/dsa/tag_edsa.c b/net/dsa/tag_edsa.c
> index f5b87ee..234585e 100644
> --- a/net/dsa/tag_edsa.c
> +++ b/net/dsa/tag_edsa.c
> @@ -165,8 +165,17 @@ static struct sk_buff *edsa_rcv(struct sk_buff *skb,=
 struct net_device *dev,
>         return skb;
>  }
>
> +static int edsa_tag_flow_dissect(const struct sk_buff *skb, __be16 *prot=
o,
> +                                int *offset)
> +{
> +       *offset =3D 8;
> +       *proto =3D ((__be16 *)skb->data)[3];
> +       return 0;
> +}
> +
>  const struct dsa_device_ops edsa_netdev_ops =3D {
>         .xmit   =3D edsa_xmit,
>         .rcv    =3D edsa_rcv,
> +       .flow_dissect   =3D edsa_tag_flow_dissect,
>         .overhead =3D EDSA_HLEN,
>  };
> --
> 1.8.3.1
>
