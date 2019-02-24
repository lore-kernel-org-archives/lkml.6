Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124BBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 23:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E8C2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 23:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="mHAux39N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfBXX1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 18:27:42 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:33562 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfBXX1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 18:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1551050860; x=1582586860;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8DXOkbpe6o1DADs4lbUWuoyAKW066RFTsQbaHWCjKII=;
  b=mHAux39NT3a6fjt35E4ME6ErSTRBDcn5Q7DgQ/Vs4lFgj2sH7xyRfKjb
   vNMKfDGjO6ZWrStgcNmiLyGXxbXqercZ5jBWoY4EYCW3Fs3OVsXT34P4n
   JlOm/ggeQfJ5mG0ofoqgvelrptTdtcXmOjlou7/7Q3AM/TBJvvL6KMXex
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EVAwB1J3NchyWd50NlHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZQKBWIEAgRQnCox2jQR8gQGYHAsBASyEQIQBIjgSAQMBAQIBAQIBAQI?=
 =?us-ascii?q?QAQEBCgsJCCkvQgEQAYFmIoJvAQEBAQIBEig/BQsCAQgYHhBXAgQOBQgagjV?=
 =?us-ascii?q?JgWsInj89Am2BAYkHAQEBgh6KIoxIghaBEYIUSQcuhQGFYQKKBoIJhECTCgk?=
 =?us-ascii?q?FklMhgXGJHIgCh2GUewIEAgQFAhSBXoF4cIM8gjaOJ0ExgSiGLYVpBYEpAYE?=
 =?us-ascii?q?eAQE?=
X-IPAS-Result: =?us-ascii?q?A2EVAwB1J3NchyWd50NlHAEBAQQBAQcEAQGBZQKBWIEAg?=
 =?us-ascii?q?RQnCox2jQR8gQGYHAsBASyEQIQBIjgSAQMBAQIBAQIBAQIQAQEBCgsJCCkvQ?=
 =?us-ascii?q?gEQAYFmIoJvAQEBAQIBEig/BQsCAQgYHhBXAgQOBQgagjVJgWsInj89Am2BA?=
 =?us-ascii?q?YkHAQEBgh6KIoxIghaBEYIUSQcuhQGFYQKKBoIJhECTCgkFklMhgXGJHIgCh?=
 =?us-ascii?q?2GUewIEAgQFAhSBXoF4cIM8gjaOJ0ExgSiGLYVpBYEpAYEeAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2019 17:27:39 -0600
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1ONOVqn060451
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 18:27:39 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2qu1kfw82f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 18:27:39 -0500
Received: from ausxipps301.us.dell.com ([143.166.148.223])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Feb 2019 05:27:28 +0600
X-LoopCount0: from 10.166.135.114
X-IronPort-AV: E=Sophos;i="5.58,409,1544508000"; 
   d="scan'208";a="303145076"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <torvalds@linux-foundation.org>
CC:     <jonathan.derrick@intel.com>, <linux-nvme@lists.infradead.org>,
        <keith.busch@intel.com>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-kernel@vger.kernel.org>,
        <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Topic: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Index: AQHUyksMhaVeVw7H30qZ9nZ8VEPxSQ==
Date:   Sun, 24 Feb 2019 23:27:09 +0000
Message-ID: <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-24_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902240184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/19 4:42 PM, Linus Torvalds wrote:=0A=
> On Sun, Feb 24, 2019 at 12:37 PM <Alex_Gagniuc@dellteam.com> wrote:=0A=
>>=0A=
>> Dell r740xd to name one. r640 is even worse -- they probably didn't give=
=0A=
>> me one because I'd have too much stuff to complain about.=0A=
>>=0A=
>> On the above machines, firmware-first (FFS) tries to guess when there's=
=0A=
>> a SURPRISE!!! removal of a PCIe card and supress any errors reported to=
=0A=
>> the OS. When the OS keeps firing IO over the dead link, FFS doesn't know=
=0A=
>> if it can safely supress the error. It reports is via NMI, and=0A=
>> drivers/acpi/apei/ghes.c panics whenever that happens.=0A=
> =0A=
> Can we just fix that ghes driver?=0A=
> =0A=
> It's not useful to panic just for random reasons. I realize that some=0A=
> of the RAS people have the mindset that "hey, I don't know what's=0A=
> wrong, so I'd better kill the machine than continue", but that's=0A=
> bogus.=0A=
=0A=
That's the first thing I tried, but Borislav didn't like it. And he's =0A=
right in the strictest sense of the ACPI spec: a fatal GHES error must =0A=
result in a machine reboot [1].=0A=
=0A=
> What happens if we just fix that part?=0A=
=0A=
On rx740xd, on a NVMe hotplug bay, the upstream port stops sending =0A=
hotplug interrupts. We could fix that with a quirk by clearing a =0A=
proprietary bit in the switch. However, FFS won't re-arm itself to =0A=
receive any further errors, so we'd never get notified in case there is =0A=
a genuine error.=0A=
=0A=
>> As I see it, there's a more fundamental problem. As long as we accept=0A=
>> platforms where firmware does some things first (FFS), we have much less=
=0A=
>> control over what happens. The best we can do is wishy-washy fixes like=
=0A=
>> this one.=0A=
> =0A=
> Oh, I agree that platforms with random firmware things are horrid. But=0A=
> we've been able to handle them just fine before, without making every=0A=
> single possible hotplug pci driver have nasty problems and=0A=
> workarounds.=0A=
> =0A=
> I suspect we'd be much better off having the ghes driver just not panic.=
=0A=
=0A=
Keith Busch of Intel at some point suggested remapping all MMIO =0A=
resources of a dead PCIe device to a read-only page that returns all =0A=
F's. Neither of us were too sure how to do that, or how to handle the =0A=
problem of in-flight DMA, which wouldn't hit the page tables.=0A=
=0A=
> What is the actual ghes error? Is it the "unknown, just panic" case,=0A=
> or something else?=0A=
=0A=
More like "fatal error, just panic". It looks like this (from a serial =0A=
console):=0A=
=0A=
[   57.680494] {1}[Hardware Error]: Hardware error from APEI Generic =0A=
Hardware Error Source: 1=0A=
[   57.680495] {1}[Hardware Error]: event severity: fatal=0A=
[   57.680496] {1}[Hardware Error]:  Error 0, type: fatal=0A=
[   57.680496] {1}[Hardware Error]:   section_type: PCIe error=0A=
[   57.680497] {1}[Hardware Error]:   port_type: 6, downstream switch port=
=0A=
[   57.680498] {1}[Hardware Error]:   version: 3.0=0A=
[   57.680498] {1}[Hardware Error]:   command: 0x0407, status: 0x0010=0A=
[   57.680499] {1}[Hardware Error]:   device_id: 0000:3c:07.0=0A=
[   57.680499] {1}[Hardware Error]:   slot: 1=0A=
[   57.680500] {1}[Hardware Error]:   secondary_bus: 0x40=0A=
[   57.680500] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x9733=
=0A=
[   57.680501] {1}[Hardware Error]:   class_code: 000406=0A=
[   57.680502] {1}[Hardware Error]:   bridge: secondary_status: 0x0000, =0A=
control: 0x0003=0A=
[   57.680503] Kernel panic - not syncing: Fatal hardware error!=0A=
[   57.680572] Kernel Offset: 0x2a000000 from 0xffffffff81000000 =0A=
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)=0A=
=0A=
=0A=
Alex=0A=
=0A=
=0A=
=0A=
[1] ACPI 6.3 - 18.1 Hardware Errors and Error Sources=0A=
=0A=
"A fatal hardware error is an uncorrected or uncontained error condition =
=0A=
that is determined to be unrecoverable by the hardware. When a fatal =0A=
uncorrected error occurs, the system is restarted to prevent propagation =
=0A=
of the error."=0A=
=0A=
=0A=
