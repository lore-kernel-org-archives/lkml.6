Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC36C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545A42081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z3aI61ZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfBEQ7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:59:35 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:54920 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfBEQ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:59:35 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 1EEC910C1DB1;
        Tue,  5 Feb 2019 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549385975; bh=eeYRgkWCV8jsW4Lvig4pB6Af6JV5bmhv4wSczmN76Ig=;
        h=From:To:CC:Subject:Date:References:From;
        b=Z3aI61ZSSVhgXf3qeJsZSd+nxv65+TAls2h3AFisY5nKAGo90QCLEHxtNBuY78hUv
         MZGsAKXWOZYV++rD4oHyrab/dhjL33zobtPdJgdiB43X2V2Nf0Ixs5mBtaTBGPjDoj
         6+OOBWiteUL57geB88NORvJZp6pPe+FmEUYd11X7TTElZ70yvoOrR54OhxInUXd72b
         34rXDSvQdjCPb3NEO8JLArmcvtuJkSvg78tBH96/miMy2rbo7yck2aH9hzlpsrb++L
         ZZ5irFc/ZmTcjDr/dgVisQbD7IIviI6OycY8IgNUq+6Kxosr4YzqPfZsMgXwggGVCE
         bPOhhBHuGis9g==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1154BA006D;
        Tue,  5 Feb 2019 16:59:35 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Tue, 5 Feb 2019 08:59:20 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: fix actionpoints configuration detection
Thread-Topic: [PATCH] ARC: fix actionpoints configuration detection
Thread-Index: AQHUvLlPkoxJxNoo1EGChYpnNrLEEg==
Date:   Tue, 5 Feb 2019 16:59:20 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642EC15@US01WEMBX2.internal.synopsys.com>
References: <20190204184151.9113-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 10:41 AM, Eugeniy Paltsev wrote:=0A=
> Fix reversed logic while actionpoints configuration (full/min)=0A=
> detection.=0A=
>=0A=
> Fixies: 7dd380c338f1e ("ARC: boot log: print Action point details")=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
LGTM.=0A=
=0A=
Thx,=0A=
-vineet=0A=
=0A=
=0A=
> ---=0A=
>  arch/arc/kernel/setup.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c=0A=
> index feb90093e6b1..def19b0ef8c6 100644=0A=
> --- a/arch/arc/kernel/setup.c=0A=
> +++ b/arch/arc/kernel/setup.c=0A=
> @@ -212,7 +212,7 @@ static void read_arc_build_cfg_regs(void)=0A=
>  	READ_BCR(ARC_REG_AP_BCR, ap);=0A=
>  	if (ap.ver) {=0A=
>  		cpu->extn.ap_num =3D 2 << ap.num;=0A=
> -		cpu->extn.ap_full =3D !!ap.min;=0A=
> +		cpu->extn.ap_full =3D !ap.min;=0A=
>  	}=0A=
>  =0A=
>  	READ_BCR(ARC_REG_SMART_BCR, bcr);=0A=
=0A=
