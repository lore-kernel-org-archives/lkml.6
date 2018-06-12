Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D876DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9637920693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9637920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933862AbeFLIek (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:34:40 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:46424 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933432AbeFLIeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:34:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 4C29F2018D;
        Tue, 12 Jun 2018 10:34:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jt7ru6Hm6jmb; Tue, 12 Jun 2018 10:34:35 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 90C1D2005D;
        Tue, 12 Jun 2018 10:34:35 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Tue, 12 Jun 2018
 10:34:35 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 21C9B3182400;
 Tue, 12 Jun 2018 10:34:35 +0200 (CEST)
Date:   Tue, 12 Jun 2018 10:34:35 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        <herbert@gondor.apana.org.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: mainline: x86_64: kernel panic: RIP:
 0010:__xfrm_policy_check+0xcb/0x690
Message-ID: <20180612083435.7f7k4exergraaa2u@gauss3.secunet.de>
References: <CA+G9fYuuiYES7ucAhgf8P-YXJPaYY2pi6kRKf6eBrfHvXJbQiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+G9fYuuiYES7ucAhgf8P-YXJPaYY2pi6kRKf6eBrfHvXJbQiw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 779B130E-03D7-4A84-8B74-DE279D4AFC48
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:11:46PM +0530, Naresh Kamboju wrote:
> Kernel panic on x86_64 machine running mainline 4.17.0 kernel while testing
> selftests bpf test_tunnel.sh test caused this kernel panic.
> I have noticed this kernel panic start happening from
> 4.17.0-rc7-next-20180529 and still happening on 4.17.0-next-20180608.
> 
> [  213.638287] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000008
> ++[ ip xfrm poli  213.674036] PGD 0 P4D 0
> [  213.674118] audit: type=1327 audit(1528917683.623:7):
> proctitle=6970007866726D00706F6C69637900616464007372630031302E312E312E3130302F3332006473740031302E312E312E3230302F33320064697200696E00746D706C00737263003137322E31362E312E31303000647374003137322E31362E312E3230300070726F746F006573700072657169640031006D6F64650074756E6E
> [  213.677950] Oops: 0000 [#1] SMP PTI
> cy[ add src 10.1.  213.677952] CPU: 2 PID: 0 Comm: swapper/2 Tainted:
> G        W         4.17.0-next-20180608 #1
> [  213.677953] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [  213.726998] RIP: 0010:__xfrm_policy_check+0xcb/0x690
> [  213.731962] Code: 80 3d 0a d8 f1 00 00 0f 84 c1 02 00 00 4c 8b 25
> 2b af f4 00 e8 66 a6 6a ff 85 c0 74 0d 80 3d eb d7 f1 00 00 0f 84 d5
> 02 00 00 <49> 8b 44 24 08 48 85 c0 74 0c 48 8d b5 78 ff ff ff 4c 89 ff
> ff d0

This looks like a bug that I've seen already. If it is what I think,
then commit 2c205dd3981f ("netfilter: add struct nf_nat_hook and use
it") introduced this bug.

There was already a fix for this on the netdev list, but
I don't know the current status of that patch:

https://patchwork.ozlabs.org/patch/921387/

