Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4752EC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1813D20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1813D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeK3Sko convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:40:44 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:59610 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbeK3Skn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:40:43 -0500
Received: from mail.corsac.net (unknown [IPv6:2a01:e34:ec2f:4e20::5])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id 458B87802D7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 08:32:19 +0100 (CET)
Received: from scapa.corsac.net (unknown [IPv6:2a01:e34:ec2f:4e20:6af7:28ff:fe8d:2119])
        by mail.corsac.net (Postfix) with ESMTPS id F28E294
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 08:32:16 +0100 (CET)
Received: from corsac (uid 1000)
        (envelope-from corsac@debian.org)
        id a00aa
        by scapa.corsac.net (DragonFly Mail Agent v0.11);
        Fri, 30 Nov 2018 08:32:15 +0100
Message-ID: <fc025b4db1b05c62c0d8a9bf045d4c1d22e90fa8.camel@debian.org>
Subject: Re: Freeze when using ipheth+IPsec+IPv6
From:   Yves-Alexis Perez <corsac@debian.org>
To:     David Miller <davem@davemloft.net>, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, ishkamiel@gmail.com,
        dwindsor@gmail.com, elena.reshetova@intel.com,
        ktkhai@virtuozzo.com, viro@zeniv.linux.org.uk,
        xiyou.wangcong@gmail.com, mjurczyk@google.com, dvlasenk@redhat.com,
        dh.herrmann@gmail.com, netdev@vger.kernel.org, agk@godking.net,
        johannes.berg@intel.com, garsilva@embeddedor.com,
        arvind.yadav.cs@gmail.com, steffen.klassert@secunet.com,
        herbert@gondor.apana.org.au
Date:   Fri, 30 Nov 2018 08:32:07 +0100
In-Reply-To: <20181129.155200.484195944365513578.davem@davemloft.net>
References: <20180605085450.GA3506@scapa.corsac.net>
         <20180606082130.GA3730@scapa.corsac.net>
         <CAGXu5jKw-En2p3ffgfJja63E3WnF+Q7-b0S6QHOf3FOTjgu7ew@mail.gmail.com>
         <20181129.155200.484195944365513578.davem@davemloft.net>
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Thu, 2018-11-29 at 15:52 -0800, David Miller wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Thu, 29 Nov 2018 15:31:25 -0800
> 
> > Did you ever solve this?
> 
> I think it was fixed by:
> 
> commit 45611c61dd503454b2edae00aabe1e429ec49ebe
> Author: Bernd Eckstein <3erndeckstein@gmail.com>
> Date:   Fri Nov 23 13:51:26 2018 +0100
> 
>     usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Supposedly yes. Bernd Eckstein contacted me with his patch, unfortunately at
that time I wasn't able to reproduce the bug consistently so I wasn't able to
put a Tested-By tag on it.

Regards,
- -- 
Yves-Alexis
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlwA53cACgkQ3rYcyPpX
RFtB6wgAhwVbajsYNqii7OYSN+Mpd8u9iYKySYceJg2UO1NOkoTxY47iwuHwQ7Aq
QicVI2fgwC4E1kHj4ZnxdZ9w09XZ7k/za5uvc19ZWWopscsyEkq6JeyLWGp/l7xA
OFxUy0NxTi8qkUDXM25dqoLChCAI5NWsHO6LBwbDghI+2A7aCbI092gkbwKDZsja
NBpkVS1LNYoUPRH+aP+kXw+Hzln88pRP9aKyc2+WyEH7AmFGRSPU+qL1snvzLjg/
1bI09LuU56nJe9hr68222MQ1WclOs69HDcSjHxu21LISEpRAUrXzt9ZN6cbTOFD8
LvgtkBAr7/AsQE9/VStCRdswgsW08g==
=O+dv
-----END PGP SIGNATURE-----
