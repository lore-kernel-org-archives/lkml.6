Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF7BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F93D20661
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j9hizwfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F93D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbeGSRF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:05:29 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:35395 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbeGSRF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:05:29 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1623010C0E9D;
        Thu, 19 Jul 2018 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532017295; bh=OJK8EfutOcg55HEWf/pyKQ/uE7gYYFJ2MNXUwbXz0jQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=j9hizwfYzmwMMVb45r3m6/ILe5eFQrrDHFIhsGYEmfHAcTaeQFJImpTqCfwvpuEXL
         3Z2VjlTp1hstH6B/ivegP4depCzXMtE/A58ZJDb6qzP4yW7WOl2O189MS5ktG/MhGp
         nUSkXRma75BcATmrXGHUKDqH4s7MhkqB9Igo4oLKC3aci4JKlDAAr1SoYouMv2HJCx
         VN1b9qllBJNv3TStxfZmhpnW5PVq66TnntPuJ5Fu9ZTRNmNq68fRiivpkppRQaSlno
         DxodriqXhlbY4280dpVhenv0+36kcTfRwO93hrmlF7IFfgfmKVPQ9feI6fQ2lynif2
         zktXq9sex2m7Q==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7A35B3790;
        Thu, 19 Jul 2018 09:21:33 -0700 (PDT)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001;
 Thu, 19 Jul 2018 09:21:33 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Elad Kanfi <eladkan@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: arch/arc/ allmodconfig
Thread-Topic: arch/arc/ allmodconfig
Thread-Index: AQHUHyKW1M3GsAcZr0iuL832AquqnA==
Date:   Thu, 19 Jul 2018 16:21:32 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B0724EB@US01WEMBX2.internal.synopsys.com>
References: <e074d0ae-6d79-d21a-2278-15d516bb943e@infradead.org>
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

+CC some folks from Mellanox=0A=
=0A=
On 07/18/2018 10:37 PM, Randy Dunlap wrote:=0A=
> Hi,=0A=
>=0A=
> When I try to (cross-)build arch/arc/ allmodconfig, I get a syntax error =
here:=0A=
>=0A=
> ./arch/arc/plat-eznps/mtm.c: In function 'mtm_enable_core':=0A=
> ../arch/arc/plat-eznps/mtm.c:113:30: error: storage size of 'dpc' isn't k=
nown=0A=
>   struct nps_host_reg_aux_dpc dpc;=0A=
>                               ^~~=0A=
>=0A=
> There is no struct nps_host_reg_aux_dpc in the kernel tree.=0A=
>=0A=
> Can you do something about this, please?=0A=
=0A=
Thx for the report Randy. I'm calling out Mellanox folks to see if they can=
=0A=
provide a fixup, else we will revert the corresponding change.=0A=
=0A=
@Elad, upstream commit 3f9cd874dcc8705 "ARC: [plat-eznps] avoid toggling of=
 DPC=0A=
register" added reference to struct nps_host_reg_aux_dpc but the definition=
 is=0A=
missing. Can you please provide a fixup as I have no idea of that platform=
=0A=
specific struct.=0A=
=0A=
@ Leon, reaching our to you, since it seems you removed Elad from MAINTAINE=
RS=0A=
file, so I'm not sure if he is still at Mellanox.=0A=
The two folks I worked with on EZCHiip Linux port Noam Camus and Gilad have=
 left=0A=
Mellanox.=0A=
If you or someone from Mellanox are interested in maintaining this platform=
,=0A=
please update the arch/arc/plat-eznps section of MAINTAINERS file.=0A=
=0A=
=0A=
Thx,=0A=
-Vineet=0A=
