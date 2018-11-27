Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B44CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC972086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="C9YHX0V9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC972086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeK1JWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:22:52 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:36818 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeK1JWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:22:52 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7FF7F24E08C0;
        Tue, 27 Nov 2018 14:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543357411; bh=Nw+HIKeWlJxGbqNsbwFc3jVBibSLsCoIBqFPvtaFPLo=;
        h=From:To:Subject:Date:References:From;
        b=C9YHX0V9eOQuReiR1g5aiblCg1ycT59pCVRwJApG18Sfmq61ZgRFidOn+HkwECylN
         FdbpvVOObf+jtdOPdiEYZDwe2Ct18CWMJM/01BSPy9HZxqvfmiPxrVCSdsnJ5Q/gU5
         zHoEN9mEHCxrktj+40q9DlOFh7l2n6SlkftjI8/JmhMQE/KNIoDwJaJvH9jg/sEsj3
         TYhaGP03EcHqAy4YNwUksgUaZlUn2fMApIcr7XyYtvUDTaRceQeJ+gZUv77VAZtX/8
         OEK9C5e3KypTjxlUPNikFsJso5LAcAG+vVLYkQTOwgR6Lic9YrX5GlNq4R/AWasfZl
         76ATY3omsEP8g==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6E5035C3E;
        Tue, 27 Nov 2018 14:23:31 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Tue, 27 Nov 2018 14:23:31 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: change defconfig defaults to ARCv2
Thread-Topic: [PATCH] ARC: change defconfig defaults to ARCv2
Thread-Index: AQHUhp9+KPpwRKkuK0WKMdrVDoAasQ==
Date:   Tue, 27 Nov 2018 22:23:30 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146419633@US01WEMBX2.internal.synopsys.com>
References: <20181127222045.18491-1-khilman@baylibre.com>
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

On 11/27/18 2:21 PM, Kevin Hilman wrote:=0A=
> Change the default defconfig (used with 'make defconfig') to the ARCv2=0A=
> nsim_hs_defconfig, and also switch the default Kconfig ISA selection to=
=0A=
> ARCv2.=0A=
>=0A=
> This allows several default defconfigs (e.g. make defconfig, make=0A=
> allnoconfig, make tinyconfig) to all work with ARCv2 by default.=0A=
>=0A=
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>=0A=
=0A=
Applied to for-curr=0A=
=0A=
Thx,=0A=
-Vineet=0A=
