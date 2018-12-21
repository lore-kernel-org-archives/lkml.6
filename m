Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B512821905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="LvPUFcYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbeLUC50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:57:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42437 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732679AbeLUC50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:57:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so1785300plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 18:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24eEBE1DNaoYzJAX8F1cGsu7ikWEKHhNLqwnZLIAHEA=;
        b=LvPUFcYt3jy6W5+hW7SkPr7ANj4lHrRdrg4hsTSuHQJSXFd2KzobZ6RYXhuZVjbzaX
         x1NZhHPjcapJVmf/XDP+4KowmS5PsPmt60xlDEQ1lLCgRmD7iBaJgeKIhDmaOdHy6dIk
         nI/IdCKtv/kI9REo/DX8TLYVYCGJizTguBZajetbtPgETyIx62iHMHcjGIOC7xJ34ugx
         +N4D3xexJ2eQQKnjsqYd7OtGyFN1sbIPywVe/MXVmukQ0HK0XEoEQohCeT0R6TZniJA1
         ZLU5qUnzJe3EZpkYlCZlXtUX/W0ztQcBcEPYzfWjy+0i8ZvSyhOcg/PHAab98AowIQu1
         fSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24eEBE1DNaoYzJAX8F1cGsu7ikWEKHhNLqwnZLIAHEA=;
        b=JPJe9t4B7MjDVZYj8AgTcjlWc54OPK176KxwfHn+OhFdBxlNohbOcI5shLF8WIe8IP
         qyhN0DRBe7a8e66uGgk6huvAWFWRHBZ0EUkupKLocOI5sCcGiX/W4mwpULziJpD/zOxb
         hW+G9tMQOHpmDUZXlkP2UM7RTuQgP9wB55XT86yhQDPpXOCyy3gSV1IXbcRolDvs28pn
         5eO3YwqIcOAqC7D411KGTgbpOPkdB5JKEoj/XcCtidRTL2t71HWdaUVveSjkGfk/c82T
         dYtmult63Ft73h5tbliznLlhXz3VHhDq3WuW3CqYbax+vslFP3PgUdf+AO0ZXCb4527N
         8+/g==
X-Gm-Message-State: AJcUukcpKtybx9z+OxwoCe23jx/OcmkbrdXJJniYMit41/ZbHTjgPpMk
        ONKYY38lRRIhbnWruBS//YC6bLhFlFs=
X-Google-Smtp-Source: ALg8bN5eoD48NeQXDlIGNuSavc5ct/G+japQxzpamH6xCxCb2t6vnTTRiwC5Vd/G/wBXTJWUAnGCMg==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr764329pla.136.1545361045248;
        Thu, 20 Dec 2018 18:57:25 -0800 (PST)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d129sm33424487pfc.31.2018.12.20.18.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 18:57:25 -0800 (PST)
Date:   Thu, 20 Dec 2018 18:57:22 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: use indirect call wrappers at GRO
 transport layer
Message-ID: <20181220185722.1bc7540d@xeon-e3>
In-Reply-To: <fa7128969d8739cca9018c9577120fed8f44433a.1544032300.git.pabeni@redhat.com>
References: <cover.1544032300.git.pabeni@redhat.com>
        <fa7128969d8739cca9018c9577120fed8f44433a.1544032300.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Dec 2018 19:13:41 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> This avoids an indirect call in the receive path for TCP and UDP
> packets. TCP takes precedence on UDP, so that we have a single
> additional conditional in the common case.
>=20
> v1 -> v2:
>  - adapted to INDIRECT_CALL_ changes
>=20
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

This introduces a bunch of new warnings when kernel is built with W=3D1.
Please add the necessary prototypes in header files.

Putting prototypes in C file for global function is not the right way to fix
this.

net/ipv4/tcp_offload.c:310:17: warning: no previous prototype for =E2=80=98=
tcp4_gro_receive=E2=80=99 [-Wmissing-prototypes]
 struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *s=
kb)
                 ^~~~~~~~~~~~~~~~
net/ipv4/tcp_offload.c:323:29: warning: no previous prototype for =E2=80=98=
tcp4_gro_complete=E2=80=99 [-Wmissing-prototypes]
 INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int tho=
ff)
                             ^~~~~~~~~~~~~~~~~
  CC      net/ipv4/datagram.o
  CC      net/ipv4/udp_offload.o
net/ipv4/udp_offload.c:459:17: warning: no previous prototype for =E2=80=98=
udp4_gro_receive=E2=80=99 [-Wmissing-prototypes]
 struct sk_buff *udp4_gro_receive(struct list_head *head, struct sk_buff *s=
kb)
                 ^~~~~~~~~~~~~~~~
net/ipv4/udp_offload.c:533:29: warning: no previous prototype for =E2=80=98=
udp4_gro_complete=E2=80=99 [-Wmissing-prototypes]
 INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nho=
ff)
                             ^~~~~~~~~~~~~~~~~
  CC      net/ipv4/arp.o
  CC      net/ipv6/ip6_offload.o
net/ipv6/ip6_offload.c:188:41: warning: no previous prototype for =E2=80=98=
ipv6_gro_receive=E2=80=99 [-Wmissing-prototypes]
 INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head =
*head,
                                         ^~~~~~~~~~~~~~~~
net/ipv6/ip6_offload.c:328:29: warning: no previous prototype for =E2=80=98=
ipv6_gro_complete=E2=80=99 [-Wmissing-prototypes]
 INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nho=
ff)
                             ^~~~~~~~~~~~~~~~~
  CC      net/ipv6/tcpv6_offload.o
net/ipv6/tcpv6_offload.c:20:17: warning: no previous prototype for =E2=80=
=98tcp6_gro_receive=E2=80=99 [-Wmissing-prototypes]
 struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *s=
kb)
                 ^~~~~~~~~~~~~~~~
net/ipv6/tcpv6_offload.c:33:29: warning: no previous prototype for =E2=80=
=98tcp6_gro_complete=E2=80=99 [-Wmissing-prototypes]
 INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int tho=
ff)
                             ^~~~~~~~~~~~~~~~~
  CC      net/ipv6/exthdrs_offload.o
