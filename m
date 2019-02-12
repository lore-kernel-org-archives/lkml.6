Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3A8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811E2214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aD1hLkwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfBLReS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:34:18 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:34252 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731314AbfBLReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:34:17 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 052EF24E1161;
        Tue, 12 Feb 2019 09:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549992857; bh=vg1TPQfWdsxJZpZWI17rvpr8eGcvlcDHMvdEafPNt9A=;
        h=From:To:CC:Subject:Date:References:From;
        b=aD1hLkwWsNobGr09/UW81UmyAutpA+p0zBZkd2TC+HeHbQKd0o2r9kl8/A8Xo5MLJ
         xQ3CzH91vaaJ/wmP1qUXC+P3XFSOdIeABljOC5IkgIm9edUkZNw9E6qbjQaCyWNAVn
         448+lKCZQVvT9yubwuzpnTDK456KDgWBSTxBUOZznWepCXyO9aQfXNL+ZhR2YTDu7Q
         dCJ36xF26opqieZyFZr6gyl/QvvL3rl3zfILrrpbSUizGUCM1LGjYNbO4za/Zvpn1l
         kztT0vEEJR8rOfWLHNczSV7oyfErMvPoFajwexrO0ZQj/xd8OJ2JMUNvAAH9ZybYFl
         Jv0QzfFIVvLoQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 642A1A005A;
        Tue, 12 Feb 2019 17:34:16 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Tue, 12 Feb 2019 09:34:14 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "clabbe@baylibre.com" <clabbe@baylibre.com>
Subject: Re: [PATCH 1/2] ARC: U-boot: check arguments paranoidly
Thread-Topic: [PATCH 1/2] ARC: U-boot: check arguments paranoidly
Thread-Index: AQHUwukx1Fnw5f+naU+WRGyYwF4mHg==
Date:   Tue, 12 Feb 2019 17:34:13 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014643369A@US01WEMBX2.internal.synopsys.com>
References: <20190212153932.28371-1-Eugeniy.Paltsev@synopsys.com>
 <20190212153932.28371-2-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075014643364E@US01WEMBX2.internal.synopsys.com>
 <1549992326.27724.98.camel@synopsys.com>
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

On 2/12/19 9:25 AM, Eugeniy Paltsev wrote:=0A=
>> This is technically changing the ABI - I think we don't need to enforce =
this -=0A=
>> keep ignoring this=0A=
> I think it's better to add this check:=0A=
>  * This check doesn't break backward compatibility. ARC U-boot pass zero =
to r1=0A=
>    from the beginnings, I specially checked this. So we doesn't change AB=
I,=0A=
>    we only document it ;) =0A=
=0A=
OK good.=0A=
=0A=
>  * By adding this check we can cheap and easily minimize problems in JTAG=
 case.=0A=
=0A=
Prior to your patch this register was irrelevant - it didn't matter for jta=
g or=0A=
uboot cause what its value was since it was not being checked at all. Now y=
ou=0A=
enforce this be 0. Simple reasoning tells me it will likely cause problems,=
 if=0A=
any, but won't reduce them at all. So I'd insist we keep ignoring it even i=
f uboot=0A=
was zeroing it out. Atleast this leaves the door open any future changes.=
=0A=
