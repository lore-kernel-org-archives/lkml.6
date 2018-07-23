Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFEECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2848320852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p/VBtyWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2848320852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbeGWPP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:15:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40034 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbeGWPP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:15:58 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6NEEDCN068483;
        Mon, 23 Jul 2018 09:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532355253;
        bh=DdR/A2jd1TP/9FvA327CtC+H4W7Jqq2lCGl0uc/qhwg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=p/VBtyWN8hBCPeSIa8WITALgM1WK6DyAWcTA3WVaq0A3BZ95ByQhyl6ooOiiXTCkU
         0VgA3HZTtvfI7ZW0oLyWeEsew/LPkyJcgKk778gHVYOzDtrtsMGV9EYEcTx559HWDG
         qzxqoYb7GqLWavDQp5ju8qDAij4XAtiIQzbgku24=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6NEED6T023514;
        Mon, 23 Jul 2018 09:14:13 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 23
 Jul 2018 09:14:12 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 23 Jul 2018 09:14:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6NEECQp008249;
        Mon, 23 Jul 2018 09:14:12 -0500
Date:   Mon, 23 Jul 2018 09:14:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 0/6] mailbox: ti-msgmgr: Add support for AM654 Secure
 Proxy
Message-ID: <20180723141412.7zd6wp6y6pql7bm7@kahuna>
References: <20180716180607.16526-1-nm@ti.com>
 <20180723132956.tcsuxychhlhiwz6v@kahuna>
 <CABb+yY1_SBTDPyUNGSr8=tpU4oObz060nJ3NrgR8JyQye23cfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABb+yY1_SBTDPyUNGSr8=tpU4oObz060nJ3NrgR8JyQye23cfg@mail.gmail.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:56-20180723, Jassi Brar wrote:
> On Mon, Jul 23, 2018 at 6:59 PM, Nishanth Menon <nm@ti.com> wrote:
[...]
> >>  .../bindings/mailbox/ti,secure-proxy.txt           |  50 +++
> >>  drivers/mailbox/ti-msgmgr.c                        | 353 +++++++++++++++++----
> >>  2 files changed, 336 insertions(+), 67 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
> >
> >
> > Jassi,
> >
> > I dont see this in next-20180723. You'd asked me to hold off on pings
> > https://lkml.org/lkml/2017/12/16/353 -> so, held off as much as I could
> > before wondering on the status.
> >
> I didn't ask you to not ping me. I said I didn't miss your patchset. I
> still didn't.
> 
> Especially for purely platform specific changes, that I don't have
> knowledge about, I leave them to cook in public as long as possible,
> before pulling them in around rc7.

Understood. Thanks.

> You submitted V2, 7days ago only and we are at rc6 today. So chill.

v2 is just wording of mailbox node example change recommended by Rob.
I was hoping to get any further changes prior to reposting a v2.. but
anyways.. Looks all good..

-- 
Regards,
Nishanth Menon
