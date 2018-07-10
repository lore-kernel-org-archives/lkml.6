Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E22F20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsw3A1qV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E22F20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932172AbeGJJKp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:10:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46298 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeGJJKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:10:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so5134173ljj.13;
        Tue, 10 Jul 2018 02:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1J8GtKyRPKpFyeKkRRHVAMbIUHykXlh1jfvtumb++7M=;
        b=Dsw3A1qVl18iNBuxGvYN3H+dSbiBMR8+oGw6hi6T1X0KaaboikaiGtwKJh0reQ0U0x
         k7F4MijqBRf32dSAFD//UO3RsADe6jRh+GP4XIwwN5zDfDwVgHBgJ/RBA+llLqdctng5
         9cVGsnaapJwwGd/AjGR6Lvh1KY9aqgXHpU2RJ9lMJ4wyN/885mShRSNyhbBnxvZBQ5qA
         RlBld8ZHU2RDuTcf+66N2nGh3ziwvskWvDodI8hiEQr5K/97YLqUG6lJxozjUzlRU7wZ
         NtiVI4SLIje6/wElGPmOmCA60r65SuA/zXk0zeHI5j+7N1BmW8isuD/oYkc9aALWXkEB
         nGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1J8GtKyRPKpFyeKkRRHVAMbIUHykXlh1jfvtumb++7M=;
        b=r5HpLlMAwhZt23pgr7RTzy62IN828gCgqYPb+OAQVU6eNkzcOactbGgm35swMXaNKt
         8/V+LhLvTRGm0kMK9k3Lr4huBAYnRo81jWDUw7hPmAXEDrKIZ2KhpHLkbHCDTmM8/tH+
         VCS6i93PDKqWC/zmUrtpBoRMlX2NfXpIbDPie9D8ru92yz+kWtjQRe2SBXSoHtYspeMe
         4UtMg17KNWdYZ8Dt9iwTPwLbrSxWf2QY+SSxJ+EONx8em3WHJ9F6Mu4HLeLDDRcx6fMd
         OUNmLDknbBT3f45eXCRnnz23tU/qW0mntUogmwWThZSVuFRtRxU0ylk9W8/ROfDGiI8q
         4P2g==
X-Gm-Message-State: APt69E02KJ+dJCHVRySFIjXP3qIFA9zH3k+84spPniHCKCO2P4ria8RH
        Btw907RMJ729+1Wtzn9vExrBfMhk0U75iOBa9wA=
X-Google-Smtp-Source: AAOMgpcIz1pYRqzCYTBSVr8flxoYpNOf90+W4PbBO/RyxhhjPE3cj5YBNN+Zy2pJdv8ZdC5kQi5Oe/RHlM53W3cYfpk=
X-Received: by 2002:a2e:1bcc:: with SMTP id c73-v6mr14442684ljf.0.1531213841176;
 Tue, 10 Jul 2018 02:10:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 02:10:40
 -0700 (PDT)
In-Reply-To: <20180710080538.d7xqpjdvpksfrx6o@sch.bme.hu>
References: <20180709213537.2748896-1-arnd@arndb.de> <20180710080227.qwh53ahq26j6phhd@sch.bme.hu>
 <20180710080538.d7xqpjdvpksfrx6o@sch.bme.hu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Jul 2018 11:10:40 +0200
X-Google-Sender-Auth: n8ONqyvIbAT9EE9YKSwKApTir7Y
Message-ID: <CAK8P3a0zYmdoMdWdFDcWprZY_4w2hbMYq4--iZB=JE4x2UiscA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: NFT_SOCKET don't use NF_SOCKET_IPV6 without NF_TABLES_IPV6
To:     =?UTF-8?B?TcOhdMOpIEVja2w=?= <ecklm94@gmail.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Flavio Leitner <fbl@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:05 AM, M=C3=A1t=C3=A9 Eckl <ecklm94@gmail.com> w=
rote:
> On Tue, Jul 10, 2018 at 10:02:27AM +0200, M=C3=A1t=C3=A9 Eckl wrote:
>> On Mon, Jul 09, 2018 at 11:35:09PM +0200, Arnd Bergmann wrote:
>> > It is now possible to build the nft_socket module as built-in when
>> > NF_TABLES_IPV6 is disabled, and have NF_SOCKET_IPV6=3Dm set manually.
>> >
>> > In this case, the NF_SOCKET_IPV6 functionality will be useless accordi=
ng
>> > to the explanation in commit 35bf1ccecaaa ("netfilter: Kconfig: Change
>> > IPv6 select dependencies"), but on top of that it also causes a link
>> > error:
>> >
>> > net/netfilter/nft_socket.o: In function `nft_socket_eval':
>> > nft_socket.c:(.text+0x162): undefined reference to `nf_sk_lookup_slow_=
v6'
>> >
>> > This changes the compile-time check so we don't attempt to use
>> > the NF_SOCKET_IPV6 code when it cannot be used, and make it all
>> > compile again. That may lead to unexpected behavior when a user
>> > enables NF_SOCKET_IPV6 but cannot use it, but seems to be the
>> > logical conclusion of the 35bf1ccecaaa change.
>> >
>> > Fixes: 35bf1ccecaaa ("netfilter: Kconfig: Change IPv6 select dependenc=
ies")
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> I think this should be fixed in the Kconfig rather than inside the modul=
e(s).

Should we revert your patch then, or do you have a better idea?

>> I did some investigation and it turns out that you missed a circumstance=
. This
>> link error occures only if NFT_SOCKET=3Dy && NF_SOCKET_IPV6=3Dm && NF_TA=
BLES_IPV6=3Dy
>> (cannot be m here if NFT_SOCKET is y).

No, if NF_TABLES_IPV6=3Dy the problem cannot happen, since NFT_SOCKET then
selects NF_SOCKET_IPV6=3Dy as well. Before your patch, it would always sele=
ct
NF_SOCKET_IPV6 when it could, so it worked in all configurations.

>>  And probably the same with
>> iptables-related modules. Probably this possibility should be eliminated=
.
>
> NF_TPROXY_IPV6 might be in the same situation.

I tried coming up with a combination that is broken for NF_TPROXY_IPV6=3Dm
but could not. From what I can see with

config NETFILTER_XT_TARGET_TPROXY
       tristate '"TPROXY" target transparent proxying support'
       depends on IP6_NF_IPTABLES || IP6_NF_IPTABLES=3Dn
       select NF_TPROXY_IPV6 if IP6_NF_IPTABLES

and

#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)

inside of net/netfilter/xt_TPROXY.c, there is no way we can end up with
xt_TPROXY calling into the nf_tproxy_ipv6 loadable module from
a built-in context. This is the same approach I used in my patch,
just with IP6_NF_IPTABLES instead of NF_SOCKET_IPV6, in both
the Kconfig dependency and the module.

      Arnd
