Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB826C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7465224001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUeQujcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7465224001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeGFNFV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:05:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43701 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbeGFNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:05:16 -0400
Received: by mail-lf0-f65.google.com with SMTP id m12-v6so9741659lfc.10;
        Fri, 06 Jul 2018 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AzkE0hAic0oZP7I+oKtwQ7Ie656n/H0uXg7a8sY7oj8=;
        b=cUeQujcFO2U7CYvpSEl6f3xLon+ycv9/jbx076s7fhvycR2XhgA8q3L2NVMWO+HSRA
         i4lH18xlMq/dzJciqKAbRSCDBs6lZzR1fIGXJXfksBq6YY57Sw9d924p6IF9sL2J6X1o
         SvBxrfmjDcDzvDkCrX6C68FDJ34vQmhTn7Jcz0aMhbJYleR3JkHMaSFpn5WaEu7C5/oF
         lyR9SmLhJeJnEbL1qQNEbXdQ7xoQrk54k7R3Zodn2L86+k/uGoCDNVuTtKOvb/Ft/0hl
         xsx6z7dRyPEqgSX/9FaGC1SYj40/E+GYAAmQsU/WZaJFsJpfgf+yrSwFEddpw0WWJR/Z
         pz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AzkE0hAic0oZP7I+oKtwQ7Ie656n/H0uXg7a8sY7oj8=;
        b=ZCJ3XtIcbrY4bg5inULto4yl+p6XH8HkcL0IdTWvXPcE0lWyINak9RK/EWgtkRXdHh
         n36aQHQecfLaMTqbCKZgP4etrR0GAQIfD0Tf6H2sv+pSwB0g9LPkn+GwObHWS/T2JUEe
         S98nVtH5+d4/ERbm0Lv86W1gkZ+K/TEbEde0JIaFkvFm3u8QmfTK57SumYOZK8ocneZ1
         UPS+uELVgWlWRcXICjvzqYHehVrQxzE6aJG+1PGNzKvcCBrjbxrvY5kFTt/2n1w9IzUX
         YOi3J/bRaPlvGK+kC776n6rWt0JJOZ2COckT/INoCkKksiD8OatkmmEVJfS93lHJ2GRT
         wspA==
X-Gm-Message-State: APt69E0mXl82LVKmqodLCe9dG8V083c2LI8+XCe61OBdeMSMp9khnJYm
        1yzYyLLa5n9Us0DcQIfpuHTy+Yk4imW5YYYmRtk=
X-Google-Smtp-Source: AAOMgpfCSmvrwbgteXtg2hbV12gTUixdfeKazIuM7ZoP+APJucl2xemkf9ya3ZdxyUu6+M4nRuYY6U+y9Y7O0qRE4RU=
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr7365250lfe.60.1530882314505;
 Fri, 06 Jul 2018 06:05:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 06:05:13 -0700 (PDT)
In-Reply-To: <20180706124827.xwho2rgu3jkk3hp5@salvia>
References: <20180706123805.2852900-1-arnd@arndb.de> <20180706124542.jybscbmzixyt4rx2@salvia>
 <20180706124827.xwho2rgu3jkk3hp5@salvia>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Jul 2018 15:05:13 +0200
X-Google-Sender-Auth: rn__ZeaPzdkKwLQ0GBkKVoSoL3U
Message-ID: <CAK8P3a23rdqk-5i_6jLtCH6Z+_SSJ-0=5r=KfPuL-Xaas=6VyA@mail.gmail.com>
Subject: Re: [PATCH net-next] netfilter: fix NETFILTER_XT_TARGET_TEE dependencies
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
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

On Fri, Jul 6, 2018 at 2:48 PM, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Fri, Jul 06, 2018 at 02:45:42PM +0200, Pablo Neira Ayuso wrote:
>> On Fri, Jul 06, 2018 at 02:37:58PM +0200, Arnd Bergmann wrote:
>> > With NETFILTER_XT_TARGET_TEE=y and IP6_NF_IPTABLES=m, we get a link
>> > error when referencing the NF_DUP_IPV6 module:
>> >
>> > net/netfilter/xt_TEE.o: In function `tee_tg6':
>> > xt_TEE.c:(.text+0x14): undefined reference to `nf_dup_ipv6'
>> >
>> > The problem here is the 'select NF_DUP_IPV6 if IP6_NF_IPTABLES'
>> > that forces NF_DUP_IPV6 to be =m as well rather than setting it
>> > to =y as was intended here. Adding a soft dependency on
>> > IP6_NF_IPTABLES avoids that broken configuration.
>>
>> Applied to nf.git, thanks Arnd.
>
> Sorry, let me reconsider.
>
> We many need similar patches to other spots in 35bf1ccecaaa ?
>
> If so, it would be good to fix in the one go.

I'm fairly sure that  NETFILTER_XT_TARGET_LOG is safe, since
NF_LOG_IPV6 already depends on IP6_NF_IPTABLES.

NF_SOCKET_IPV6 like NF_DUP_IPV6 does not depend on
IP6_NF_IPTABLES, so we may have a similar problem there, though
I have not come across that. I have done only a few hundred randconfig
builds since I started yesterday, so I may have missed something,
but I think this is safe because CONFIG_NF_SOCKET_IPV6 is
used like a 'bool' symbol these days, we don't actually control building
a module with it, only a small portion in the nft_socket file.

       Arnd
