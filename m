Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BDBC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105EA20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KIIpv1R+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105EA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeLGJ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:58:34 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:57114 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLGJ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:58:33 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D6ABE24E1FE8;
        Fri,  7 Dec 2018 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544176712; bh=wXJ28CsqNyO3qIe0i76T/UpG/FocBwgiW4Hvm3EYYfA=;
        h=From:To:CC:Subject:Date:References:From;
        b=KIIpv1R+t32bemalPfisURdSMLyQ4SPq6W8bSnzRIQxHcVxM3++qCBrGhaXzTguqf
         kJ+WeUj+6KsHvDI+/KcuhNO0H19RnQ/EIHEnlolC4dnWdmzxlXNUF6/p1Sp+D3Bh0/
         Usz8S5g+rjI+ITRu2OtPL/WIKpElYq12QkguBg//ZIpIIhf8seZNmtlzKe3be6DTyf
         4+FVoyUOFO3fgCN6+/3EsmICdu0K2yjKdjvXiwVyOflKmV4lwCg+k5/SkylWofOB2U
         cTWyP9RMVn1hP+0Tdz1GU0ldXZCg3utlGzo2G/uBFSl4uAKgB+zVV1/Ok4dSAmIkK/
         m/a28CUhYXreA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 738903F52;
        Fri,  7 Dec 2018 01:58:32 -0800 (PST)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Dec 2018 01:58:32 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 7 Dec 2018 13:58:29 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Maynard CABIENTE <maynard.cabiente@raritan.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on
 disconnect"
Thread-Topic: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on
 disconnect"
Thread-Index: AQHUgbE8ouTBXi+nzkarEEkfP9zP5Q==
Date:   Fri, 7 Dec 2018 09:58:28 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7B48EC@am04wembxa.internal.synopsys.com>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
 <20181121154504.13052-1-m.szyprowski@samsung.com>
 <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
 <20181123144307.GC2970@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
 <2b48a7b5-f806-d761-97f6-885ae6c69a7e@samsung.com>
 <410670D7E743164D87FA6160E7907A56013A7B47A2@am04wembxa.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Filipe,=0A=
=0A=
My patch dccf1bad4be7eaa096c1f3697bd37883f9a08ecb "usb: dwc2: Disable =0A=
all EP's on disconnect" applied to 4.20-rc1.=0A=
=0A=
I need to update this patch. What I should do. There are 2 options:=0A=
=0A=
1. Ack Marek Szyprowski <m.szyprowski@samsung.com> [PATCH] usb: dwc2: =0A=
Revert "usb: dwc2: Disable all EP's on disconnect" then submit final =0A=
fixed version of patch?=0A=
=0A=
2. Or submit new patch to fix existing "usb: dwc2: Disable all EP's on =0A=
disconnect".=0A=
=0A=
Please advise.=0A=
=0A=
Thanks,=0A=
Minas=0A=
