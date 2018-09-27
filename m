Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F42BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30012156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30012156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeI0Tad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:30:33 -0400
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:15611 "EHLO
        mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeI0Tad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:30:33 -0400
X-Greylist: delayed 672 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 15:30:31 EDT
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.231.133]) by mgwkm04.jp.fujitsu.com with smtp
         id 4f66_1136_2b7e1e32_61dc_4c12_be9f_1a07cea6c2d7;
        Thu, 27 Sep 2018 22:01:04 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
        by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 84D0BAC0171
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 22:01:03 +0900 (JST)
Received: from G01JPEXCHKW16.g01.fujitsu.local (G01JPEXCHKW16.g01.fujitsu.local [10.0.194.55])
        by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 74348BD675F;
        Thu, 27 Sep 2018 22:01:02 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw16 ([10.0.194.55]) with mapi id 14.03.0352.000; Thu, 27 Sep 2018
 22:01:02 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'Marc Zyngier' <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
Thread-Topic: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
Thread-Index: AQHUUeYpisctXpEhGkyHhq24W3KoEKUEH5Sw
Date:   Thu, 27 Sep 2018 13:01:01 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A005F4A@G01JPEXMBKW03>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Marc
> Zyngier
> Sent: Saturday, September 22, 2018 5:00 AM
> To: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Jeffrey Hugo; Thomas Gleixner; Jason Cooper; Jeremy Linton; Ard
> Biesheuvel
> Subject: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
> 
> The GICv3 architecture has the remarkable feature that once LPI tables
> have been assigned to redistributors and that LPI delivery is enabled,
> there is no guarantee that LPIs can be turned off (and most
> implementations do not allow it), nor can it be reprogrammed to use
> other tables.
> 
> This is a bit of a problem for kexec, where the secondary kernel
> completely looses track of the previous allocations. If the secondary
> kernel doesn't allocate the tables exactly the same way, no LPIs will
> be delivered by the GIC (which continues to use the old tables), and
> memory previously allocated for the pending tables will be slowly
> corrupted, one bit at a time.
> 
> The workaround for this is based on a series[1] by Ard Biesheuvel,
> which adds the required infrastructure for memory reservations to be
> passed from one kernel to another using an EFI table.
> 
> This infrastructure is then used to register the allocation of GIC
> tables with EFI, and allow the GIC driver to safely reuse the existing
> programming if it detects that the tables have been correctly
> registered. On non-EFI systems, there is not much we can do.
> 
> This has been tested on a TX2 system both as a host and a guest. I'd
> welcome additional testing of different HW. For convenience, I've
> stashed a branch containing the whole thing at [2].

We have done the test on our chip A64FX that When a write changes 
EnableLPI bit from 0 to 1, this bit becomes RES1. 
The result is that the kexec operation successfully works on our chip,
 and PCI based on LPI also works after kexec.

For detail:
We did "kexec -e" command, and the message, "Using preallocated 
redistributor tables", was shown.
After kexec, we can use our ssd normally.

Test environment
CPU: A64FX

Kernel version: v4.19 rc4 base
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gicv3-kdump
8bc67da irqchip/gic-v3-its: Allow use of LPI tables in reserved memory

kexec version:kexec-tools-2.0.14-17.2.el7.aarch64

Tested-by: Lei Zhang <zhang.lei@jp.fujitsu.com>

Thanks a lot.

Best Regards,
Lei,Zhang
FUJITSU LIMITED.


