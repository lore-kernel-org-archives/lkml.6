Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECFDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCD620663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="sgSZuq+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfBXUhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 15:37:34 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:14636 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbfBXUhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 15:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1551040652; x=1582576652;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ouLq6qhPsC5uqLCloLXsx/O1VoonV05Fq/qiNr0X9Ko=;
  b=sgSZuq+FI4Pr0x0jGTz3wxhQFIoYISIC8gjRcTRALr20A7RJAG8qTeCe
   6aG3hJGfdhhL4xybaTS84rwtfq8VubTnXb14CIJpqKiB8ochkoKWn4bsm
   LxmI5uDugeYso5BeKxfikYoFDvZ/I2AUykDKOIdVKYhOy41GrnjE1tIuX
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G8AAC7/3JchieV50NlGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBZYJagRQnCox2jQSBfZY1gWcLAQEshECEASI4EgEDAQECAQECAQE?=
 =?us-ascii?q?CEAEBAQoJCwgpL4I6IoJwAQEBAxIoPxACAQgYHhBXAgQBDQUIGoJ+gXOeMz0?=
 =?us-ascii?q?CbYEBiQcBAQGCHooijEiCFoN1LoRpGIVhAooHggiEQJMKCQWSUyGBcYkciAK?=
 =?us-ascii?q?HYYJtkg4CBAIEBQIUgV6BeHCDPIIoDgmOHkExgSiNRAGBHgEB?=
X-IPAS-Result: =?us-ascii?q?A2G8AAC7/3JchieV50NlGwEBAQEDAQEBBwMBAQGBZYJag?=
 =?us-ascii?q?RQnCox2jQSBfZY1gWcLAQEshECEASI4EgEDAQECAQECAQECEAEBAQoJCwgpL?=
 =?us-ascii?q?4I6IoJwAQEBAxIoPxACAQgYHhBXAgQBDQUIGoJ+gXOeMz0CbYEBiQcBAQGCH?=
 =?us-ascii?q?ooijEiCFoN1LoRpGIVhAooHggiEQJMKCQWSUyGBcYkciAKHYYJtkg4CBAIEB?=
 =?us-ascii?q?QIUgV6BeHCDPIIoDgmOHkExgSiNRAGBHgEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2019 14:37:32 -0600
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1OKXBAP102492
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 15:37:32 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com [68.232.154.99])
        by mx0a-00154901.pphosted.com with ESMTP id 2qu19xmykk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 15:37:32 -0500
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Feb 2019 02:37:31 +0600
X-LoopCount0: from 10.166.135.137
X-IronPort-AV: E=Sophos;i="5.58,409,1544508000"; 
   d="scan'208";a="359013811"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <torvalds@linux-foundation.org>, <jonathan.derrick@intel.com>
CC:     <linux-nvme@lists.infradead.org>, <keith.busch@intel.com>,
        <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-kernel@vger.kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Topic: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Index: AQHUyksMhaVeVw7H30qZ9nZ8VEPxSQ==
Date:   Sun, 24 Feb 2019 20:37:30 +0000
Message-ID: <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-24_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=758 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902240162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 3:29 PM, Linus Torvalds wrote:=0A=
> On Thu, Feb 21, 2019 at 5:07 PM Jon Derrick <jonathan.derrick@intel.com> =
wrote:=0A=
>>=0A=
>> Some platforms don't seem to easily tolerate non-posted mmio reads on=0A=
>> lost (hot removed) devices. This has been noted in previous=0A=
>> modifications to other layers where an mmio read to a lost device could=
=0A=
>> cause an undesired firmware intervention [1][2].=0A=
> =0A=
> This is broken, and whatever platform that requires this is broken.=0A=
> =0A=
> This has absolutely nothing to do with nvme, and should not be handled=0A=
> by a driver.=0A=
> =0A=
> The platform code should be fixed.=0A=
> =0A=
> What broken platform is this, and why is it causing problems?=0A=
> =0A=
> None of this wishy-washy "some platforms". Name them, and let's get them =
fixed.=0A=
=0A=
Dell r740xd to name one. r640 is even worse -- they probably didn't give =
=0A=
me one because I'd have too much stuff to complain about.=0A=
=0A=
On the above machines, firmware-first (FFS) tries to guess when there's =0A=
a SURPRISE!!! removal of a PCIe card and supress any errors reported to =0A=
the OS. When the OS keeps firing IO over the dead link, FFS doesn't know =
=0A=
if it can safely supress the error. It reports is via NMI, and=0A=
drivers/acpi/apei/ghes.c panics whenever that happens.=0A=
=0A=
Does this sound like horrible code?=0A=
=0A=
As I see it, there's a more fundamental problem. As long as we accept =0A=
platforms where firmware does some things first (FFS), we have much less =
=0A=
control over what happens. The best we can do is wishy-washy fixes like =0A=
this one.=0A=
=0A=
Did I mention that FFS's explicit intent on the above machines is to =0A=
make the OS crash?=0A=
=0A=
Alex=0A=
=0A=
=0A=
=0A=
=0A=
