Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D361C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0FA2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H8z9qUSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0FA2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJXkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:40:15 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35200 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJXkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:40:15 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2973610C06E7;
        Wed, 10 Oct 2018 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539188243; bh=GaqN14qoAICVU2T4WktTylzPEZK+NDV46CB916MaxVA=;
        h=From:To:CC:Subject:Date:References:From;
        b=H8z9qUSx6tA8qPVuk3/Un3G63VlhtibeT2CZjNWEZ1tkja7Gg847kCVvYeuPAyfKR
         SYi5rh75LpS4vepU/BCjYGagiYnMsih46Y3O0nAbl6L09sOSujPn8wB0yDzYQk41Gj
         9Mr9rQf9HubtfKhxRGsY3WfTzZPrJGZ0wR14OqZOAGii1e/8v+RfD6h/vkhdB+ANea
         /wladNt8zvBsFa14EiwjBmQUeKr0fqUPON9+nr2LbJX6P5Cu+QbpvfK++pGKom7bUh
         qz4+Mtr9tLBM2AtYr/MNQq8iwbMTkeBfTZAwNICXUwyawBvRrUzwLIYWGHa4V0n6Go
         DLZywhXHZqAFw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id A034A4980;
        Wed, 10 Oct 2018 09:17:22 -0700 (PDT)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Wed, 10 Oct 2018 09:13:02 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: remove redundant 'default n' from Kconfig
Thread-Topic: [PATCH] ARC: remove redundant 'default n' from Kconfig
Thread-Index: AQHUYKgE2ahzNqv6/E+M6M7wSgEkXQ==
Date:   Wed, 10 Oct 2018 16:13:01 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B0ABCBC@US01WEMBX2.internal.synopsys.com>
References: <CGME20181010144619eucas1p2e4e6d3c43dd12e5b9cec7a29c4bf95ad@eucas1p2.samsung.com>
 <20181010144619eucas1p2e4e6d3c43dd12e5b9cec7a29c4bf95ad~cRpUq8hi71426914269eucas1p2J@eucas1p2.samsung.com>
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

On 10/10/2018 07:46 AM, Bartlomiej Zolnierkiewicz wrote:=0A=
> 'default n' is the default value for any bool or tristate Kconfig=0A=
> setting so there is no need to write it explicitly.=0A=
>=0A=
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO=0A=
> is not set' for visible symbols") the Kconfig behavior is the same=0A=
> regardless of 'default n' being present or not:=0A=
>=0A=
>     ...=0A=
>     One side effect of (and the main motivation for) this change is makin=
g=0A=
>     the following two definitions behave exactly the same:=0A=
>     =0A=
>         config FOO=0A=
>                 bool=0A=
>     =0A=
>         config FOO=0A=
>                 bool=0A=
>                 default n=0A=
>     =0A=
>     With this change, neither of these will generate a=0A=
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).=
=0A=
>     That might make it clearer to people that a bare 'default n' is=0A=
>     redundant.=0A=
>     ...=0A=
>=0A=
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>=0A=
=0A=
Nice ! Thx for you patch.=0A=
Applied to for-curr=0A=
=0A=
-Vineet=0A=
