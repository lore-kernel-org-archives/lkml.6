Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1E2C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D8720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="d9mf1oIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D8720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbeGXXNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:13:17 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:44295 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388479AbeGXXNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:13:17 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0B86010C0ABC;
        Tue, 24 Jul 2018 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532469886; bh=T2KFS2a20JuNJ0PBFKHGlWPE3OUqcQKsdG6DMNCtOnU=;
        h=From:To:CC:Subject:Date:References:From;
        b=d9mf1oIXNRe2nrTVfewgTWzQ+otb+KfZgFa7OYyeGgjcnohlc+VUtWDqvJQv7O5GZ
         OGfowmG92ahm8J/5asCYC8JWgbFC95v3WM/lKQ8rIIByeIxdAseWZOiA9cbjHHEDst
         yJvYzdqHBLC9FBNJU9gXeXzf/fUUWapkFcUR83OEPsImOmw9ZQvzKMFE/gnh/R0aRV
         Lu1gb+TS+1YmhE4JU5KOVHVpZhd2dGNwpDKyv0B4TCmXxmZYu/0gStqDsk3b385Vze
         +fYUeSUunJunxukxuObIY2nE3xkNHQpkaVu7YG0jVY/fijCfK+0S9SgaDgFWyTpGKs
         bZPGX+19KR/WQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id ED3F73B49;
        Tue, 24 Jul 2018 15:04:45 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue, 24
 Jul 2018 15:04:45 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 1/4] arc: fix some build issues in delay.h
Thread-Topic: [PATCH 1/4] arc: fix some build issues in delay.h
Thread-Index: AQHUI49oEnz0zzTrpk2bWyG/ZtOqLw==
Date:   Tue, 24 Jul 2018 22:04:44 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08394D@us01wembx1.internal.synopsys.com>
References: <20180724204622.2366-1-rd.dunlab@gmail.com>
 <20180724204622.2366-2-rd.dunlab@gmail.com>
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

On 07/24/2018 01:46 PM, Randy Dunlap wrote:=0A=
> From: Randy Dunlap <rdunlap@infradead.org>=0A=
>=0A=
> Fix build errors in arch/arc/'s delay.h:=0A=
> - add <linux/delay.h> for loops_per_jiffy=0A=
> - add <asm-generic/types.h> for "u64"=0A=
>=0A=
> In file included from ../drivers/infiniband/hw/cxgb3/cxio_hal.c:32:=0A=
> ../arch/arc/include/asm/delay.h: In function '__udelay':=0A=
> ../arch/arc/include/asm/delay.h:61:12: error: 'u64' undeclared (first use=
 in this function)=0A=
>   loops =3D ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;=0A=
>             ^~~=0A=
>=0A=
> In file included from ../drivers/infiniband/hw/cxgb3/cxio_hal.c:32:=0A=
> ../arch/arc/include/asm/delay.h: In function '__udelay':=0A=
> ../arch/arc/include/asm/delay.h:63:37: error: 'loops_per_jiffy' undeclare=
d (first use in this function)=0A=
>   loops =3D ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;=0A=
>                                      ^~~~~~~~~~~~~~~=0A=
>=0A=
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>=0A=
> Cc: Vineet Gupta <vgupta@synopsys.com>=0A=
> Cc: Ofer Levi <oferle@mellanox.com>=0A=
> Cc: linux-snps-arc@lists.infradead.org=0A=
> ---=0A=
>  arch/arc/include/asm/delay.h |    2 ++=0A=
>  1 file changed, 2 insertions(+)=0A=
>=0A=
> --- linux-next-20180723.orig/arch/arc/include/asm/delay.h=0A=
> +++ linux-next-20180723/arch/arc/include/asm/delay.h=0A=
> @@ -17,6 +17,8 @@=0A=
>  #ifndef __ASM_ARC_UDELAY_H=0A=
>  #define __ASM_ARC_UDELAY_H=0A=
>  =0A=
> +#include <linux/delay.h>=0A=
=0A=
this file in turn includes asm/delay.h - the header guards will catch neste=
d=0A=
inclusion still seems ugly. Should we just reference loops_per_jiffy here l=
ike=0A=
other arches do in theur delay.h=0A=
> +#include <asm-generic/types.h>=0A=
>  #include <asm/param.h>		/* HZ */=0A=
>  =0A=
>  static inline void __delay(unsigned long loops)=0A=
>=0A=
=0A=
