Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A782AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C84B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Du0ROAoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C84B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeLAGFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:05:20 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:52384 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeLAGFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:05:20 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B1FB310C0DAB;
        Fri, 30 Nov 2018 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543604106; bh=LYzs+Sl42U8FD03te7SOYcSfCAkDom8Ozm5ACSo63kM=;
        h=From:To:CC:Subject:Date:References:From;
        b=Du0ROAoCVTQTYvxfiLQWv2Zxg8QxvgcCDDIzB2R2jzd2JGDk24dn3mlHplWjeHT4u
         K4yz/j306BEXjrXtEXneWpq1EhlmvtcwMZIJXCU/4dSABuudwQGSSUJMAJ6ipCX+l7
         WKDgNCMXzNHXpcz7AyLIPmjM4t7EDAb++oA+CSsLyIMKuTYv2r4tjTps0cqwLuXlek
         SiC1qcTvdCgG8QuRbWhkmmQrFrLllCDW00oCwDa2A8L+c3Cw5sm1xmgHGFhihjXYA7
         tavzIQcyz18CbyOsIPV/9VnAA9sHYuJYeijAJh5lTtKDTz7fg2VxA5xSPDrmjxWOlB
         PEMYfQpE3f4kA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8293832E6;
        Fri, 30 Nov 2018 10:55:06 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 30 Nov 2018 10:55:06 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] ARC: change defconfig defaults to ARCv2
Thread-Topic: [PATCH v2] ARC: change defconfig defaults to ARCv2
Thread-Index: AQHUiKuCip6n9/XcDEORYbFikMg7uA==
Date:   Fri, 30 Nov 2018 18:55:05 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641A3F9@US01WEMBX2.internal.synopsys.com>
References: <20181130125156.34460-1-abrodkin@synopsys.com>
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

On 11/30/18 4:52 AM, Alexey Brodkin wrote:=0A=
> From: Kevin Hilman <khilman@baylibre.com>=0A=
>=0A=
> Change the default defconfig (used with 'make defconfig') to the ARCv2=0A=
> nsim_hs_defconfig, and also switch the default Kconfig ISA selection to=
=0A=
> ARCv2.=0A=
>=0A=
> This allows several default defconfigs (e.g. make defconfig, make=0A=
> allnoconfig, make tinyconfig) to all work with ARCv2 by default.=0A=
>=0A=
> Note since we change default architecture from ARCompact to ARCv2=0A=
> it's required to explicitly mention architecture type in ARCompact=0A=
> defconfigs otherwise ARCv2 will be implied and binaries will be=0A=
> generated for ARCv2.=0A=
>=0A=
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>=0A=
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>=0A=
> Cc: <stable@vger.kernel.org> # 4.4.x=0A=
=0A=
Applied.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
