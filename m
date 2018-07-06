Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF93C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAE720020
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQYjMRwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAE720020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeGFOuu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:50:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39519 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeGFOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:50:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id t7-v6so9353152ljj.6;
        Fri, 06 Jul 2018 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kfQd/b3q1o3JpFPE8GDUf2uY7Kctpe09+7xRxhi8iDU=;
        b=sQYjMRwFh0KrjmrsOO1N3vK0GtVxqfE7b//y2N+lqZ+6iXfnvIWB5Iw/JOpiXLhGA9
         fit8Or/LdMbiZiIgnm8wrhyGgCJG7SQArUrfHHZJEwvQvznkP8Nb/VjCSp4FT3Lgz3hj
         ZC+rdr+HM9IEfzmZViLfiGc3QZT53NDUPwe8J2mpXp7k6zQjd2ysp24NZUKHz0iHEVVg
         ICy1wAE/g2j/QvdLxiUizU++Jx+wKkBJmxu93LsNwqaeanewsSbR/PUrTQ3nokIpGFB7
         1kv+FklHgj0HhRZw5uFWwylsnBvvF8muOxDvWHOVZrcZsyF40mgwfb6SAAX3LNDeHkHE
         bDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kfQd/b3q1o3JpFPE8GDUf2uY7Kctpe09+7xRxhi8iDU=;
        b=CtBgPzPy5bjg7QBQb/gTgYdIfYzdY4PiHAlND/BOE5qYAZ5waaxs5UZUZUvDSFipaV
         IMlQnCioTXpYJATB6z0p2+3A9rZ3XE9nMPCurqNOn/I8h0Y+IQCJi4B270R+Y5lQtWYq
         WeqBkn+WliWWA+tz/Dnq7OcNM2/tHqWIckxij8vGQXtM8X8Fiz9EBXtoOsxLtbYiJBhA
         oF56PrezZp4aXTpnci8YKu1T0vTd6iiIaEoX70bKKLCMDLjxv5HWRCk6YbMxGeBKyp6M
         nNgjIp0OvsOycpMVKHZ9mTlSp3W27tNSDQhrfjKO91Mw7w3rQvXnI/8Ua1mIvuLryfF1
         oZHQ==
X-Gm-Message-State: APt69E1oXuU2KlK0/vLhreOpjqS0VBI2GWlsNgh0Rh6jDQaE1b33++Fz
        Cm5IawtjgCzNN3rxTy2rzPoZofQWZzyCyQzi/x1XNYXd
X-Google-Smtp-Source: AAOMgpdq62F4/SYF2a4/KjRjxx4bPGUHfQrEY3vtN1uvWU7IrRXIeG1jIZnKR3oC8FjqAQnMIDvdNiYff/m2YtWaI+U=
X-Received: by 2002:a2e:118f:: with SMTP id 15-v6mr6815327ljr.38.1530888646162;
 Fri, 06 Jul 2018 07:50:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 07:50:45 -0700 (PDT)
In-Reply-To: <20180706135516.viz6pjtkdmcoqq2l@breakpoint.cc>
References: <20180706130005.3640993-1-arnd@arndb.de> <20180706135516.viz6pjtkdmcoqq2l@breakpoint.cc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Jul 2018 16:50:45 +0200
X-Google-Sender-Auth: 76LTAzmV-tfWNCygcOBE5U5p3SU
Message-ID: <CAK8P3a1o6+dcZuW_iMGzwBBw_dcW41QAQ2Mu4A5Ru9ScnwaYDA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: conntrack: add weak IPV6 dependency
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?TcOhdMOpIEVja2w=?= <ecklm94@gmail.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "Pablo M. Bermudo Garay" <pablombg@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 3:55 PM, Florian Westphal <fw@strlen.de> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
>> Now that the conntrack module contains code for ipv6, we can no longer
>> have it built-in while IPv6 itself is a loadable module:
>>
>> net/netfilter/nf_conntrack_proto.o: In function `nf_ct_netns_do_get':
>> nf_conntrack_proto.c:(.text+0x88c): undefined reference to `nf_defrag_ipv6_enable'
>
> AFAICS this is caused by
>
> CONFIG_NF_CONNTRACK=y
> CONFIG_IPV6=m
> CONFIG_NF_DEFRAG_IPV6=m
>
> This is exported via nf_defrag_ipv6.ko.
>
> nf_defrag_ipv6 has an ipv6 dependency, but i think it might be avoidable
> so this would work:
>
> CONFIG_NF_CONNTRACK=y
> CONFIG_NF_DEFRAG_IPV6=y
> CONFIG_IPV6=m

I've tried it like this now:

diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
index 07516d5c2f80..18b9f8f37c97 100644
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -5,10 +5,6 @@
 menu "IPv6: Netfilter Configuration"
        depends on INET && IPV6 && NETFILTER

-config NF_DEFRAG_IPV6
-       tristate
-       default n
-
 config NF_SOCKET_IPV6
        tristate "IPv6 socket lookup support"
        help
@@ -352,3 +348,6 @@ endif # IP6_NF_IPTABLES

 endmenu

+config NF_DEFRAG_IPV6
+       tristate
+       default n
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index e42c38c99741..51be519a3802 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -49,9 +49,8 @@ config NETFILTER_NETLINK_LOG
 config NF_CONNTRACK
        tristate "Netfilter connection tracking support"
        default m if NETFILTER_ADVANCED=n
-       depends on IPV6 || !IPV6
        select NF_DEFRAG_IPV4
-       select NF_DEFRAG_IPV6 if IPV6
+       select NF_DEFRAG_IPV6 if IPV6 != n
        help
          Connection tracking keeps a record of what packets have passed
          through your machine, in order to figure out how they are related

and that resulted in a new build failure:

net/netfilter/nf_conntrack_proto.o:(.rodata+0x788): undefined
reference to `nf_conntrack_l4proto_icmpv6'
net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_expire':
nf_conntrack_reasm.c:(.text+0x2320): undefined reference to
`ip6_expire_frag_queue'
net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_init':
nf_conntrack_reasm.c:(.text+0x2384): undefined reference to `ip6_frag_init'
nf_conntrack_reasm.c:(.text+0x2394): undefined reference to `ip6_frag_init'
nf_conntrack_reasm.c:(.text+0x2398): undefined reference to `ip6_rhash_params'
net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_expire':
nf_conntrack_reasm.c:(.text+0x10bc): undefined reference to
`ip6_expire_frag_queue'

I don't think we can get CONFIG_NF_DEFRAG_IPV6=y to work with IPV6=m.

      Arnd
