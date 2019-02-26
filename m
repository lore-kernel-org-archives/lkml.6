Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500BAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0583D218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="EcA2/rGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfBZWha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:37:30 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:48537 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729030AbfBZWha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1551220649; x=1582756649;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IGuNNSXe/d+0vf16KUo4wyQO8aI/dpMbNvq0/t1q7L4=;
  b=EcA2/rGsxq5+uHRKRtbvVwNNM3qI3AIevP7GNT5yIkaKVVNuDNnFGgA6
   2xMwKUVMNt+0Iwq06Jb1msnmZ2Fb3MWnLxMpDQi2oPscj5F41dJs4ByWD
   uxboIAD+6E2475e5kd0+19XbQhgvgxa2g2akig4OCkOcwkJUcQuSSpw33
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ERAACTvnVchieV50NlGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUwQBAQELAYFZgQCBFCcKjHeNC4F9liGBewsBASyEQIQFIjYHDQE?=
 =?us-ascii?q?DAQECAQECAQECEAEBAQoJCwgpL4I6IoJwAQEBAxIoPxACAQgYHhBXAgQOBQg?=
 =?us-ascii?q?agjVJgXOfHz0CbYEBiQcBAQGCHooxjEiCFoERgmQuhQFNhRQCjBKXUwkFkls?=
 =?us-ascii?q?hkxqHa5UDAgQCBAUCFIFOBoICcIM8gjaBCQEIjRVBMYEokAwBgR4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2ERAACTvnVchieV50NlGwEBAQEDAQEBBwMBAQGBUwQBA?=
 =?us-ascii?q?QELAYFZgQCBFCcKjHeNC4F9liGBewsBASyEQIQFIjYHDQEDAQECAQECAQECE?=
 =?us-ascii?q?AEBAQoJCwgpL4I6IoJwAQEBAxIoPxACAQgYHhBXAgQOBQgagjVJgXOfHz0Cb?=
 =?us-ascii?q?YEBiQcBAQGCHooxjEiCFoERgmQuhQFNhRQCjBKXUwkFklshkxqHa5UDAgQCB?=
 =?us-ascii?q?AUCFIFOBoICcIM8gjaBCQEIjRVBMYEokAwBgR4BAQ?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Feb 2019 16:37:28 -0600
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QMbSag080939
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 17:37:28 -0500
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2qw9b1hwyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 17:37:28 -0500
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Feb 2019 04:36:42 +0600
X-LoopCount0: from 10.166.135.136
X-IronPort-AV: E=Sophos;i="5.58,416,1544508000"; 
   d="scan'208";a="277504395"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <keith.busch@intel.com>
CC:     <torvalds@linux-foundation.org>, <axboe@fb.com>,
        <sagi@grimberg.me>, <linux-kernel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <mr.nuke.me@gmail.com>,
        <hch@lst.de>, <jonathan.derrick@intel.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Topic: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Index: AQHUyksMhaVeVw7H30qZ9nZ8VEPxSQ==
Date:   Tue, 26 Feb 2019 22:37:26 +0000
Message-ID: <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 9:55 AM, Keith Busch wrote:=0A=
> On Sun, Feb 24, 2019 at 03:27:09PM -0800, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> [   57.680494] {1}[Hardware Error]: Hardware error from APEI Generic  Ha=
rdware Error Source: 1=0A=
>> [   57.680495] {1}[Hardware Error]: event severity: fatal=0A=
>> [   57.680496] {1}[Hardware Error]:  Error 0, type: fatal=0A=
>> [   57.680496] {1}[Hardware Error]:   section_type: PCIe error=0A=
>> [   57.680497] {1}[Hardware Error]:   port_type: 6, downstream switch po=
rt=0A=
>> [   57.680498] {1}[Hardware Error]:   version: 3.0=0A=
>> [   57.680498] {1}[Hardware Error]:   command: 0x0407, status: 0x0010=0A=
>> [   57.680499] {1}[Hardware Error]:   device_id: 0000:3c:07.0=0A=
>> [   57.680499] {1}[Hardware Error]:   slot: 1=0A=
>> [   57.680500] {1}[Hardware Error]:   secondary_bus: 0x40=0A=
>> [   57.680500] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x97=
33=0A=
>> [   57.680501] {1}[Hardware Error]:   class_code: 000406=0A=
>> [   57.680502] {1}[Hardware Error]:   bridge: secondary_status: 0x0000, =
> control: 0x0003=0A=
> =0A=
> This is a reaction to a ERR_FATAL message, right? What happens if we=0A=
> ignore firmware first and override control of the AER masking with a=0A=
> set to the Unsupported Request Error Mask in the root and downstream=0A=
> ports? You can do a quick test like this for the above's hardware:=0A=
> =0A=
>    # setpci -s 3c:07.0 ECAP_AER+8.l=3D100000:100000=0A=
> =0A=
> You'd probably have to do the same command to the root port BDf, and any=
=0A=
> other switches you have them in the hierarchy.=0A=
=0A=
Then nobody gets the (error) message. You can go a bit further and try =0A=
'pcie_ports=3Dnative". Again, nobody gets the memo. ):=0A=
=0A=
Alex=0A=
=0A=
