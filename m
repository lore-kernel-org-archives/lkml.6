Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C4C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8244621537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OSh534o1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8244621537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbeHOBtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:49:52 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:60495 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbeHOBtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:49:52 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BD8D024E0BD1;
        Tue, 14 Aug 2018 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534287628; bh=4ICGTsEGSXcmusNDEvuG2KbgASsJhtwMNbSIM+bAc0U=;
        h=From:To:CC:Subject:Date:References:From;
        b=OSh534o1mfjE04/qPVNGI/84qB/w5vOx5l2BbuZXlgLk1aYn9AhckOph1oJQN740Z
         XRs/HheIivC4KLW6ztiAzf1/HcYdiF2XBTo5Gz4qeYgoN4E4/zIFUVTHfsB+mqxlId
         QYQj6e0KGN3R/0aL2hrC2PusVry18wtGZPwfVP1M8qTzNAv5wJQE3YThsbcY0lA7Y/
         6yKBuz9t7/8isz1ej5yfUYrOSNbYAQN8+cSNrBTUK3sSgXVNgyU2iOI4NRgU0Yjx//
         PKx0U77QQuhhIbntZWl34CkzCJAbgE1z22tZzKn/CkBisC/wZSQ/WR/Pvn+zjBtx0a
         eoClEJbwu+mYg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6DFBC33A0;
        Tue, 14 Aug 2018 16:00:28 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue, 14
 Aug 2018 16:00:28 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ingo Molnar" <mingo@kernel.org>
Subject: Re: linux-next: manual merge of the arc-current tree with Linus'
 tree
Thread-Topic: linux-next: manual merge of the arc-current tree with Linus'
 tree
Thread-Index: AQHUNBvQfOLwQkVAeEqvzWxvxncsEQ==
Date:   Tue, 14 Aug 2018 23:00:27 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08D198@us01wembx1.internal.synopsys.com>
References: <20180815081141.3f1b1059@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 03:11 PM, Stephen Rothwell wrote:=0A=
> Hi Vineet,=0A=
>=0A=
> Today's linux-next merge of the arc-current tree got a conflict in:=0A=
>=0A=
>   arch/arc/include/asm/atomic.h=0A=
>=0A=
> between commit:=0A=
>=0A=
>   ab0b910490fe ("atomics/arc: Define atomic64_fetch_add_unless()")=0A=
>=0A=
> from Linus' tree and commit:=0A=
>=0A=
>   39456148db74 ("ARC: atomic64: fix atomic64_add_unless function")=0A=
>=0A=
> from the arc-current tree.=0A=
>=0A=
> I fixed it up (I just used the version from Linus' tree for now) and=0A=
> can carry the fix as necessary. This is now fixed as far as linux-next=0A=
> is concerned, but any non trivial conflicts should be mentioned to your=
=0A=
> upstream maintainer when your tree is submitted for merging.  You may=0A=
> also want to consider cooperating with the maintainer of the conflicting=
=0A=
> tree to minimise any particularly complex conflicts.=0A=
=0A=
Thx for the report Stephen. I've dropped my patch for now, let the dust set=
tle and=0A=
then we can add it.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
