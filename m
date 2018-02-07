Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-506915-1518029452-2-18051040832203835517
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518029451; b=QUpZQL/z2Gh4tD2J3PBfo23rmeYjJtqceWHTsL/C5jmpNe7
    XoNTAi+NKSMEcnzvQ0uuVmMVuGZcj4Y5TO3eXy3+0O0yWACLaEdOX9Xymr/a9+3s
    vlH8XQhzsnJQAPBc6osMhYFsHVAQr255PA38B/we7QNAKe0OZIsQSDI39RM+CFW8
    MpTF9YqgpP8qJQV17lbrE4v9tCAT8nIfUa2FonzUp5OyJIIcwEnIerYP8RTyTe76
    d5VPaUH2bgbP1A5EnMMKEtQzdkjRibBczSQ4ZOBpwKK6dLqM+pvar+SzXzUrOhS5
    zbb5SCYDREOBQypWEuccVP1JEw90+DPJKOkYUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518029451; bh=SD+4hv0TpcU8C6zSWOKTj5u733xESEDU+NzbHaDmv90=; b=G
    UXbTH9cXcDiMAQMcjIW2ASd0VLs616c1DIMnIDHcPG8vMgxMXSrGI/d1hs+kN7vP
    Yr7qbHGcF9yujXzzs5du1VAjajRXov7NsdhitKvsY3FzQwR2fQ8aJACx3iohBgi9
    6/X8s9/seiCb+K86ODniiIa+vUWXEVBNx7AB/MfDNLkv3mwo/Dj+0klEsqyBths9
    DdGr1fyhRa9Kk1fSwv6/PSEUCaDmwXgAALAp2CuEkunmxOSSsdp0xLORHW4z9gD4
    A5usuTT90V1Vs79SB22rKin5taOiHyXPZldR4NWx3oRVgtwooMM3W99kSfmCsB33
    ywRTNWxqP9DzHmYDcCLEQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Cm40kRqP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g/FqmxuC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Cm40kRqP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g/FqmxuC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932183AbeBGSuc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 13:50:32 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45603 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbeBGSua (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 13:50:30 -0500
X-Google-Smtp-Source: AH8x226MYHwbbRMpYxxq71X5DlKUP5GSArF2//gsUkVA/MiuTOQ6UN0++dUwHeu+vUSm7UhRslN7L50Vccb2XiZPPH8=
MIME-Version: 1.0
In-Reply-To: <1518024182.2136.3.camel@debian.org>
References: <1518021487.2100.2.camel@debian.org> <1518023139.2100.7.camel@debian.org>
 <1518024182.2136.3.camel@debian.org>
From: Mike Maloney <maloneykernel@gmail.com>
Date: Wed, 7 Feb 2018 13:50:29 -0500
Message-ID: <CAJegeYkqg97ZyiJRe9ZZAk_C_KX_NrcmuK9SRrEbLzHMXfdv1Q@mail.gmail.com>
Subject: Re: Regression for ip6-in-ip4 IPsec tunnel in 4.14.16
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Mike Maloney <maloney@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, debian-kernel@lists.debian.org,
        Tobias Brunner <tobias@strongswan.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 12:23 PM, Yves-Alexis Perez <corsac@debian.org> wrot=
e:
> On Wed, 2018-02-07 at 18:05 +0100, Yves-Alexis Perez wrote:
>> I'll try to printk the mtu before returning EINVAL to see why it's lower=
 than
>> 1280, but maybe the IP encapsulation is not correctly handled?
>
> I did:
>
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 3763dc01e374..d3c651158d35 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1215,7 +1215,7 @@ static int ip6_setup_cork(struct sock *sk, struct i=
net_cork_full *cork,
>                         mtu =3D np->frag_size;
>         }
>         if (mtu < IPV6_MIN_MTU)
> -               return -EINVAL;
> +               printk("mtu: %d\n", mtu);
>         cork->base.fragsize =3D mtu;
>         if (dst_allfrag(rt->dst.path))
>                 cork->base.flags |=3D IPCORK_ALLFRAG;
>
> and I get:
>
> f=C3=A9vr. 07 18:19:50 scapa kernel: mtu: 1218
>
> and it doesn't depend on the original packet size (same thing happens wit=
h
> ping -s 100). It also happens with UDP (DNS) traffic, but apparently not =
with
> TCP.
>
> Regards,
> --
> Yves-Alexis

Hi Yves-Alexis -

I apologize for the problem.  It seems to me that tunneling with an
outer MTU that causes the inner MTU to be smaller than the min, is
potentially problematic in other ways as well.

But also it could seem unfortunate that the code with my fix does not
look at actual packet size, but instead only looks at the MTU and then
fails, even if no packet was going to be so large.  The intention of
my patch was to prevent a negative number while calculating the
maxfraglen in  __ip6_append_data().  An alternative fix maybe to
instead return an error only if the mtu is less than or equal to the
fragheaderlen.   Something like:

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 3763dc01e374..5d912a289b95 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1214,8 +1214,6 @@ static int ip6_setup_cork(struct sock *sk,
struct inet_cork_full *cork,
                if (np->frag_size)
                        mtu =3D np->frag_size;
        }
-       if (mtu < IPV6_MIN_MTU)
-               return -EINVAL;
        cork->base.fragsize =3D mtu;
        if (dst_allfrag(rt->dst.path))
                cork->base.flags |=3D IPCORK_ALLFRAG;
@@ -1264,6 +1262,8 @@ static int __ip6_append_data(struct sock *sk,

        fragheaderlen =3D sizeof(struct ipv6hdr) + rt->rt6i_nfheader_len +
                        (opt ? opt->opt_nflen : 0);
+       if (mtu < fragheaderlen + 8)
+               return -EINVAL;
        maxfraglen =3D ((mtu - fragheaderlen) & ~7) + fragheaderlen -
                     sizeof(struct frag_hdr);
                        (opt ? opt->opt_nflen : 0);

But then we also have to convince ourselves that maxfraglen can never
be <=3D 0.  I'd have to think about that.

I am not sure if others have thoughts on supporting MTUs configured
below the min in the spec.


Thanks.
--
Mike Maloney
