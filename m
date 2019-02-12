Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E88BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0281B20855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ccOW6bcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfBLQlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:41:03 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:59952 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfBLQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:41:03 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id DD51724E0B70;
        Tue, 12 Feb 2019 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549989662; bh=airq4VujOdt9xuUjb7c5J2TPPDMvg/gArKBZLuj/fF4=;
        h=From:To:CC:Subject:Date:References:From;
        b=ccOW6bcODkJG3SYlE8AhoqXVHPG9kp2HY6Or13Pl0HM3oRZKLIqiapuzzJsStXDf2
         eKQ7nUnKzFEQbVa/nKobVllEqUPeV5ctXDizhsgu2dQ7O5lidUPLRA+RnHtirC8WZb
         7cwXAdTmCO41KhxYqGsChiIK2Xn2GGNEJm6c3zNtaz7mdrHVl0IlxP+V+j0HnLOTG5
         OGR6KqcEP2xnot8fj57KnD+lrP6KHUcy/FYyhPVGyMo/3/d+044NcV7gseXs0Ng1NE
         kZLDU0eJDZE09mLFTiXkRpgNdnz/xux1lwarB31v7Rn8BmN8xGMHj7inpm74XMESVs
         TAkhClmG9r+5g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0E572A0071;
        Tue, 12 Feb 2019 16:41:01 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 12 Feb 2019 08:41:01 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     LABBE Corentin <clabbe@baylibre.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] ARC: U-boot: check arguments paranoidly
Thread-Topic: [PATCH 1/2] ARC: U-boot: check arguments paranoidly
Thread-Index: AQHUwukx1Fnw5f+naU+WRGyYwF4mHg==
Date:   Tue, 12 Feb 2019 16:41:00 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014643363A@US01WEMBX2.internal.synopsys.com>
References: <20190212153932.28371-1-Eugeniy.Paltsev@synopsys.com>
 <20190212153932.28371-2-Eugeniy.Paltsev@synopsys.com>
 <20190212163904.GA14668@Red>
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

On 2/12/19 8:39 AM, LABBE Corentin wrote:=0A=
>> While I'm at it refactor U-boot arguments handling code.=0A=
>>=0A=
> Hello=0A=
>=0A=
> I have tried to test this serie, but this patch does not apply anymore on=
 current next tree.=0A=
> It conflicts with "ARC: boot: robustify u-boot arg referencing".=0A=
=0A=
I was carrying that patch in the interim - now dropped and pushed.=0A=
=0A=
-Vineet=0A=
