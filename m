Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F70C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C45125046
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1BjO+L4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C45125046
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeGBNfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:35:14 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34087 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeGBNeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:34:36 -0400
Received: by mail-yw0-f193.google.com with SMTP id j68-v6so2987078ywg.1;
        Mon, 02 Jul 2018 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SCHRMPvqT/Y3R6XVcVW+m+vRK/SL3u5nd/d5GevTvd8=;
        b=J1BjO+L4z2h4+eSh7dsCe3NUBAQqCuXkihTaMCJ8xa2PNPY1yzshteP/p0YmLL/OCG
         AsW6DFrWKhIlcClphlyrJyDNeOA0zSEFVBFl+B2S+gINfkDZAc34vVchqmxU4/MqIVPo
         gdY1jRENJAksa4ttFaFgUHJsd48tW6H9Uy+IwY0v5v6qhZ6rAZapKSzhghHxO1voa1ni
         V0NGJyyARVCTo3enZ/0ZbiCsAGCD1TKFDrjpyY5opgjFTPTm43uBTdhqdd4+0pT7JSA6
         J5IfNOX54dRCg5xnDweOayjO4LhjmNpAVWK/5EX8DZuszpnLRZm4bs2wbt/c9Q6g4/Jv
         arJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SCHRMPvqT/Y3R6XVcVW+m+vRK/SL3u5nd/d5GevTvd8=;
        b=KfM9ygCTXNgllCyx9HZDDjt6FUHRFNSbYQcUWIgzatBeLpC+PBymTbbS89uMUReyUI
         D07FJeLl0lH9ovYVLPfJ4TwB7AE2xXlcGVjieEt1o7EgtAAB+1gdLxG9Zu/jjM4L3L0/
         7kGgJnus3E2olxqnKU9qjFRi76oIOlGeqg2eP6qmB1ZoNcSS3QY9Ms5fLfKY7DgSSf3x
         hB3lI9eUFrvPdZebraAI4PbgGKThQ1Y+/vPap5Cw1KaHeO4eKpirjVbWlnxmcJw9Rf7n
         HJjC6IX0nISJzO9n+LV6yrHAHVewNCkX8GdixsLJkY+lkSSzr2i6W3bUlfM31mL51TkC
         C0ug==
X-Gm-Message-State: APt69E1026tOsH043XpmHAgGghexPRHp1Ml+zVNwUaE3EtPgeDCoB54X
        HoPdttBBwEUXnIMYMgCrA/7CvVTXdt3FJL8r1Cc=
X-Google-Smtp-Source: AAOMgpdr2KSAPxUh2fD8x3qi2w83oZNp+bi8tAdq90xsIVZjrLuoKXT+vU35vj1onDVHyjyeQisjl3Ac/fOKBYUohc4=
X-Received: by 2002:a0d:fb45:: with SMTP id l66-v6mr12449592ywf.422.1530538095185;
 Mon, 02 Jul 2018 06:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140802.22666-1-peron.clem@gmail.com>
In-Reply-To: <20180607140802.22666-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 2 Jul 2018 15:28:04 +0200
Message-ID: <CAJiuCcdCE42FvWc0svNpQDD0rczYi7Xz-RW5PbbjAuvZe9dgwg@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
To:     Romuald Cari <romuald.cari@devialet.com>,
        linux-wpan@vger.kernel.org
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you review it please ?

Thanks,
Clement
On Thu, 7 Jun 2018 at 16:08, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> From: Romuald CARI <romuald.cari@devialet.com>
>
> The Link Quality Indication data exposed by drivers could not be accessed=
 from
> userspace. Since this data is per-datagram received, it makes sense to ma=
ke it
> available to userspace application through the ancillary data mechanism i=
n
> recvmsg rather than through ioctls. This can be activated using the socke=
t
> option WPAN_WANTLQI under SOL_IEEE802154 protocol.
>
> This LQI data is available in the ancillary data buffer under the SOL_IEE=
E802154
> level as the type WPAN_LQI. The value is an unsigned byte indicating the =
link
> quality with values ranging 0-255.
>
> Signed-off-by: Romuald Cari <romuald.cari@devialet.com>
> Signed-off-by: Cl=C3=A9ment Peron <clement.peron@devialet.com>
> ---
>  include/net/af_ieee802154.h |  1 +
>  net/ieee802154/socket.c     | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
> index a5563d27a3eb..8003a9f6eb43 100644
> --- a/include/net/af_ieee802154.h
> +++ b/include/net/af_ieee802154.h
> @@ -56,6 +56,7 @@ struct sockaddr_ieee802154 {
>  #define WPAN_WANTACK           0
>  #define WPAN_SECURITY          1
>  #define WPAN_SECURITY_LEVEL    2
> +#define WPAN_WANTLQI           3
>
>  #define WPAN_SECURITY_DEFAULT  0
>  #define WPAN_SECURITY_OFF      1
> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index a60658c85a9a..bc6b912603f1 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c
> @@ -25,6 +25,7 @@
>  #include <linux/termios.h>     /* For TIOCOUTQ/INQ */
>  #include <linux/list.h>
>  #include <linux/slab.h>
> +#include <linux/socket.h>
>  #include <net/datalink.h>
>  #include <net/psnap.h>
>  #include <net/sock.h>
> @@ -452,6 +453,7 @@ struct dgram_sock {
>         unsigned int bound:1;
>         unsigned int connected:1;
>         unsigned int want_ack:1;
> +       unsigned int want_lqi:1;
>         unsigned int secen:1;
>         unsigned int secen_override:1;
>         unsigned int seclevel:3;
> @@ -486,6 +488,7 @@ static int dgram_init(struct sock *sk)
>         struct dgram_sock *ro =3D dgram_sk(sk);
>
>         ro->want_ack =3D 1;
> +       ro->want_lqi =3D 0;
>         return 0;
>  }
>
> @@ -713,6 +716,7 @@ static int dgram_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>         size_t copied =3D 0;
>         int err =3D -EOPNOTSUPP;
>         struct sk_buff *skb;
> +       struct dgram_sock *ro =3D dgram_sk(sk);
>         DECLARE_SOCKADDR(struct sockaddr_ieee802154 *, saddr, msg->msg_na=
me);
>
>         skb =3D skb_recv_datagram(sk, flags, noblock, &err);
> @@ -744,6 +748,13 @@ static int dgram_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>                 *addr_len =3D sizeof(*saddr);
>         }
>
> +       if (ro->want_lqi) {
> +               err =3D put_cmsg(msg, SOL_IEEE802154, WPAN_WANTLQI,
> +                              sizeof(uint8_t), &(mac_cb(skb)->lqi));
> +               if (err)
> +                       goto done;
> +       }
> +
>         if (flags & MSG_TRUNC)
>                 copied =3D skb->len;
>  done:
> @@ -847,6 +858,9 @@ static int dgram_getsockopt(struct sock *sk, int leve=
l, int optname,
>         case WPAN_WANTACK:
>                 val =3D ro->want_ack;
>                 break;
> +       case WPAN_WANTLQI:
> +               val =3D ro->want_lqi;
> +               break;
>         case WPAN_SECURITY:
>                 if (!ro->secen_override)
>                         val =3D WPAN_SECURITY_DEFAULT;
> @@ -892,6 +906,9 @@ static int dgram_setsockopt(struct sock *sk, int leve=
l, int optname,
>         case WPAN_WANTACK:
>                 ro->want_ack =3D !!val;
>                 break;
> +       case WPAN_WANTLQI:
> +               ro->want_lqi =3D !!val;
> +               break;
>         case WPAN_SECURITY:
>                 if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
>                     !ns_capable(net->user_ns, CAP_NET_RAW)) {
> --
> 2.17.1
>
