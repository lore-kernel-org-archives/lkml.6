Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F30C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822B2208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMyq9s7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822B2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933908AbeGJPNm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:13:42 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35678 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933688AbeGJPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:13:38 -0400
Received: by mail-yb0-f195.google.com with SMTP id x15-v6so8742857ybm.2;
        Tue, 10 Jul 2018 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UQ8bbylzxAhAdhrVv4IG2Qk/bpo1YEeSpHL22m6lBME=;
        b=mMyq9s7FL0rn32NiYLK8LuWOKex8UOmtCEYUn+yY+Waaj8/y9jGH/ELE4byNa0gPZ6
         hGftMifFDM39iWBJmgZ0M/WCun8tJQTG9ANi0SkJzewOBMpl691BoWdagwIdywxopAtW
         LiCf1havo0EHW9VqVB16oICynyeoEWclbxjduVi3mkD6DRiY2BjHuEnBmaE0KPKSbpCT
         j5cILggngHLzZH14pTJntnoVSIU7e6pS/m9InZpATfzzPX90nYOWRV5sId6SHyxmWwVy
         xxE4WStzLkdKYG2Lhbx3di/f647astKE6+UjJ+yZsjRYy5eTabx9uCl+Vmk/Voad5YsF
         C2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UQ8bbylzxAhAdhrVv4IG2Qk/bpo1YEeSpHL22m6lBME=;
        b=KjCOYj3uy9/frUdu2ttAiXoAUcq7NGXedPSl12igm3JH1O11DK7OoYF9LdYFe7WPqJ
         6yWWU8SsqumWY3AuUQ+RRa43GBE3o1WsQe6TFtA3b0SP2N3fUQbVYzvtb6w4C+iq9mTW
         1hhGA+GqxX/Bat37zSUc/GBZWLBuqfeLhMc544Upio+2hkojdVcsp3AQPHlVF1f8WD01
         EhjS6bHChxvjwVedF2AUNbAXWDPasnl9Lw7wbP6sl/z9c1/gC0JyoZmRxxcApSUUFQQu
         uIk5VWTApkAhp7sIVfqYzdDt670QGSm2ZE4oGV/GyLNFILuIbPs3FxuUF9JaCCnkfznm
         sFoA==
X-Gm-Message-State: APt69E1DHqIIbnV3IG8oF0cAX9hdbBI8bXz8pp0akK1SzuoKR36UvsvO
        2iYigqzNaCliVgZygzZEtjCHxHO0EnCpan1p5/CfxA==
X-Google-Smtp-Source: AAOMgpdXd/hr+4gJ3CR7GhG/GrCnECOKiAVJFM07+Os2DrJJnGAY9x5KVYW52coH8kAzJ622fVHZ/8RuBSnKT7GY8HA=
X-Received: by 2002:a25:8102:: with SMTP id o2-v6mr13151479ybk.379.1531235617641;
 Tue, 10 Jul 2018 08:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140802.22666-1-peron.clem@gmail.com> <ac0ff951-627d-9694-741d-03f6bc4d6ddc@datenfreihafen.org>
In-Reply-To: <ac0ff951-627d-9694-741d-03f6bc4d6ddc@datenfreihafen.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 10 Jul 2018 17:13:26 +0200
Message-ID: <CAJiuCceN4uW1zOEwqNXFHgNn=HTHLT3Fy=bv78_dqw8LvRbpMQ@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
To:     stefan@datenfreihafen.org
Cc:     Romuald Cari <romuald.cari@devialet.com>,
        linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
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

Hi Alexander, Stefan,

Thanks for your feedbacks,

On Mon, 9 Jul 2018 at 10:49, Stefan Schmidt <stefan@datenfreihafen.org> wro=
te:
>
> Hello Clement.
>
> Finally coming to review the patch. Sorry for the delay.
>
> On 07.06.2018 16:08, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Romuald CARI <romuald.cari@devialet.com>
> >
> > The Link Quality Indication data exposed by drivers could not be access=
ed from
> > userspace. Since this data is per-datagram received, it makes sense to =
make it
> > available to userspace application through the ancillary data mechanism=
 in
> > recvmsg rather than through ioctls. This can be activated using the soc=
ket
> > option WPAN_WANTLQI under SOL_IEEE802154 protocol.
>
> I can see that it makes the application life a lot easier to have data
> send out and LQI value synced up by using the socket approach instead of
> dealing with socket and ioctl's. I am good with this patch in general.
>
> So you have some public code that uses this approach? I would be
> interesting in the userspace part of yours. A demo would be fine. If the
> network handling part of your application is public anyway that would be
> even better. :-)

I'm sorry but the userspace code that use this isn't open.
I will check if I can share this part.
Just the idea is to compute an average LQI and when it reach a
threshold we allow the remote to control the device.

>
> As Alex mentiwe oned have some socket examples in the wpa-tools package
> to give people a head start when wanting to use the subsystem. Having
> such a simple example for the LQI feature would really give you bonus
> points. :-)

Indeed, add an example for this feature will be really interesting.

>
> https://github.com/linux-wpan/wpan-tools/tree/master/examples
>
> >
> > This LQI data is available in the ancillary data buffer under the SOL_I=
EEE802154
> > level as the type WPAN_LQI. The value is an unsigned byte indicating th=
e link
> > quality with values ranging 0-255.
> >
> > Signed-off-by: Romuald Cari <romuald.cari@devialet.com>
> > Signed-off-by: Cl=C3=A9ment Peron <clement.peron@devialet.com>
> > ---
> >  include/net/af_ieee802154.h |  1 +
> >  net/ieee802154/socket.c     | 17 +++++++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
> > index a5563d27a3eb..8003a9f6eb43 100644
> > --- a/include/net/af_ieee802154.h
> > +++ b/include/net/af_ieee802154.h
> > @@ -56,6 +56,7 @@ struct sockaddr_ieee802154 {
> >  #define WPAN_WANTACK         0
> >  #define WPAN_SECURITY                1
> >  #define WPAN_SECURITY_LEVEL  2
> > +#define WPAN_WANTLQI         3
> >
> >  #define WPAN_SECURITY_DEFAULT        0
> >  #define WPAN_SECURITY_OFF    1
> > diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> > index a60658c85a9a..bc6b912603f1 100644
> > --- a/net/ieee802154/socket.c
> > +++ b/net/ieee802154/socket.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/termios.h>   /* For TIOCOUTQ/INQ */
> >  #include <linux/list.h>
> >  #include <linux/slab.h>
> > +#include <linux/socket.h>
> >  #include <net/datalink.h>
> >  #include <net/psnap.h>
> >  #include <net/sock.h>
> > @@ -452,6 +453,7 @@ struct dgram_sock {
> >       unsigned int bound:1;
> >       unsigned int connected:1;
> >       unsigned int want_ack:1;
> > +     unsigned int want_lqi:1;
> >       unsigned int secen:1;
> >       unsigned int secen_override:1;
> >       unsigned int seclevel:3;
> > @@ -486,6 +488,7 @@ static int dgram_init(struct sock *sk)
> >       struct dgram_sock *ro =3D dgram_sk(sk);
> >
> >       ro->want_ack =3D 1;
> > +     ro->want_lqi =3D 0;
> >       return 0;
> >  }
> >
> > @@ -713,6 +716,7 @@ static int dgram_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> >       size_t copied =3D 0;
> >       int err =3D -EOPNOTSUPP;
> >       struct sk_buff *skb;
> > +     struct dgram_sock *ro =3D dgram_sk(sk);
> >       DECLARE_SOCKADDR(struct sockaddr_ieee802154 *, saddr, msg->msg_na=
me);
> >
> >       skb =3D skb_recv_datagram(sk, flags, noblock, &err);
> > @@ -744,6 +748,13 @@ static int dgram_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
> >               *addr_len =3D sizeof(*saddr);
> >       }
> >
> > +     if (ro->want_lqi) {
> > +             err =3D put_cmsg(msg, SOL_IEEE802154, WPAN_WANTLQI,
> > +                            sizeof(uint8_t), &(mac_cb(skb)->lqi));
> > +             if (err)
> > +                     goto done;
> > +     }
> > +
>
> I am wondering a bit about the LQI you get back here. Maybe Alex can
> also shed some lights on it. The LQI value stored here is always from
> the last frame send (to any peer)? Or is it the last frame send to this
> specific peer?
>
> I have not put much thoughts into the LQI thing so far.Just thinking we
> need to be careful what we are providing to not let userspace make bad
> decisions (e.g. wrong routing changes due to link values given for a
> different peer connection).
>
> >       if (flags & MSG_TRUNC)
> >               copied =3D skb->len;
> >  done:
> > @@ -847,6 +858,9 @@ static int dgram_getsockopt(struct sock *sk, int le=
vel, int optname,
> >       case WPAN_WANTACK:
> >               val =3D ro->want_ack;
> >               break;
> > +     case WPAN_WANTLQI:
> > +             val =3D ro->want_lqi;
> > +             break;
> >       case WPAN_SECURITY:
> >               if (!ro->secen_override)
> >                       val =3D WPAN_SECURITY_DEFAULT;
> > @@ -892,6 +906,9 @@ static int dgram_setsockopt(struct sock *sk, int le=
vel, int optname,
> >       case WPAN_WANTACK:
> >               ro->want_ack =3D !!val;
> >               break;
> > +     case WPAN_WANTLQI:
> > +             ro->want_lqi =3D !!val;
> > +             break;
> >       case WPAN_SECURITY:
> >               if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
> >                   !ns_capable(net->user_ns, CAP_NET_RAW)) {
> >
>
> Review wise I am happy with the patch. I will give it a test.

Thanks, for the review,
Clement

>
> regards
> Stefan Schmidt
