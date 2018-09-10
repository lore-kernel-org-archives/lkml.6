Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2B6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF5820870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="NfsxJTIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF5820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeIKCVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:21:52 -0400
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:58320 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbeIKCVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1536614753; x=1568150753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f0rfzX9+GAxuHVKMgi7xFWSw/8Fu8Q2eXfgvjk3h++w=;
  b=NfsxJTIp0davYMRDGlCn4hEeugOdNstZgr4BfBn8ChFCpKPl5h9/SIYa
   hNmLgQNmIkSS0pcjJqPXQZV/mNLkA0LCV1IwZ1e4eVirl/2l/cNSsrq1p
   AR7v5jNQgLEpR/6dyznUOxtLAW25KYsfJ8QOLgB3RJs9qPYv4zBN5ER/V
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HrAADF4JZbhyWd50NbGgEBAQEBAgE?=
 =?us-ascii?q?BAQEIAQEBAYUyKAqMWotAgg2BdpQ+gXoLhGwCg3shNhYBAgEBAgEBAgEBAhA?=
 =?us-ascii?q?BAQEKCwkIKS+CNSKCYgEBAQQSFRM/DAQCAQgRBAEBAR4JB0YJCAIEDgUIGoJ?=
 =?us-ascii?q?/ggKaUIlXAQEBgWgzigaKZYIXgRKDEopWAohIhjCNEAcCj3ofjnCTZgIEAgQ?=
 =?us-ascii?q?FAhSBSQqBfXCDPIIlDgmOF28BjHyBHQEB?=
X-IPAS-Result: =?us-ascii?q?A2HrAADF4JZbhyWd50NbGgEBAQEBAgEBAQEIAQEBAYUyK?=
 =?us-ascii?q?AqMWotAgg2BdpQ+gXoLhGwCg3shNhYBAgEBAgEBAgEBAhABAQEKCwkIKS+CN?=
 =?us-ascii?q?SKCYgEBAQQSFRM/DAQCAQgRBAEBAR4JB0YJCAIEDgUIGoJ/ggKaUIlXAQEBg?=
 =?us-ascii?q?WgzigaKZYIXgRKDEopWAohIhjCNEAcCj3ofjnCTZgIEAgQFAhSBSQqBfXCDP?=
 =?us-ascii?q?IIlDgmOF28BjHyBHQEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2018 16:25:52 -0500
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8ALJFFN049373
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 17:25:51 -0400
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2mdsb4aru7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 17:25:51 -0400
From:   <Mario.Limonciello@dell.com>
Received: from ausxippc110.us.dell.com ([143.166.85.200])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Sep 2018 03:25:44 +0600
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.53,357,1531803600"; 
   d="scan'208";a="701626579"
To:     <whitequark@whitequark.org>
CC:     <heikki.krogerus@linux.intel.com>,
        <mika.westerberg@linux.intel.com>, <linux-kernel@vger.kernel.org>
Subject: RE: USB type-C altmode support for UCSI
Thread-Topic: USB type-C altmode support for UCSI
Thread-Index: AQHURRvNkCnRMgofNUaEjdqM0tpgmqThs/fggABa34CAAu/ZgIAE9GIw
Date:   Mon, 10 Sep 2018 21:25:48 +0000
Message-ID: <3b76178ca0de4990a38362cfd4836fdc@ausx13mpc120.AMER.DELL.COM>
References: <1e8398f2c1790890f40b69f12e2934e3@whitequark.org>
 <20180903140623.GD15112@kuha.fi.intel.com>
 <28522bb57c5d8f49416b9174b19b1625@whitequark.org>
 <20180905132429.GB25121@kuha.fi.intel.com>
 <4df3faaee8904d81bf7737b5f2daaff5@ausx13mpc120.AMER.DELL.COM>
 <a2f79cc4d9a0aab4a832de31b7ddc52d@whitequark.org>
 <3a666f66d6e342e2971b800caae7c889@whitequark.org>
In-Reply-To: <3a666f66d6e342e2971b800caae7c889@whitequark.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-10_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809100210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: whitequark [mailto:whitequark@whitequark.org]
> Sent: Friday, September 7, 2018 6:04 AM
> To: Limonciello, Mario
> Cc: heikki.krogerus@linux.intel.com; mika.westerberg@linux.intel.com; lin=
ux-
> kernel@vger.kernel.org
> Subject: Re: USB type-C altmode support for UCSI
>=20
> On 2018-09-05 14:13, whitequark wrote:
> > On 2018-09-05 13:50, Mario.Limonciello@dell.com wrote:
> >> Some Dell XPS systems do not support that TBT2<->TBT3 adapter. I think
> >> I
> >> tried this on XPS 15 9550 and XPS 13 9365 and in both cases it is
> >> rejected. I think it has something to do with the PD controller
> >> firmware. Same goes if you Plug TB16 dock and to that dock then
> >> connect
> >> the adapter + device.
> >
> > This is my understanding as well, however I'd like to fix this issue.
> > From looking at the BIOS image I can see that the 9360 uses a TPS65982
> > USB PD controller. The adapter uses a TPS65983A (confusingly remarked
> > by Apple as CD3215B). I've seen reports on the web that there is some
> > inherent incompatibility between TPS65982 and TPS65983, however TI is
> > for some reason extremely secretive about TPS65983 and I wasn't able
> > to get anything definitive about it.
> >
> > Anyway, I've reverse engineered a nontrivial part of the TI TPS6598x
> > firmware and register layout, however my understanding of Thunderbolt
> > and USB PD is not sufficient to proceed.
> >
> > Mario, do you think you could get in touch with the people at Dell who
> > work with USB PD and ask if:
> >
> >   (a) the adapter advertising an altmode with SVID:0x8087
> > VDO:0x00010001
> >       is the problem here, and
> >   (b) whether configuring the register 0x52 Intel VID Configuration in
> >       the adapter's USB PD controller to set TBTModeDataTXSOP=3D0x0000
> >       would help.
>=20
> I have been able to verify two things by reflashing the adapter with
> upstream
> (non-Apple) firmware and experimenting with the configuration:
>=20
> (a) the altmode with SVID:0x8087 VDO:0x00010001 (16th bit set) means
> that
>      this is an altmode advertised by a legacy Thunderbolt (3 to 2)
> adapter.
>      So the adapter is fine here.

Be really careful flashing to "upstream firmware" when it  comes to PD
controllers.  The configuration is usually tied to behavior of the firmware
on there and on in some instances can be modified at runtime via various
mechanisms.

>=20
> (b) the Dell USB PD controller doesn't try to negotiate the altmode even
> with
>      advertised VDO:0x00000001. Something else is missing in the
> configuration.
>=20
> --
> whitequark

I did inquire to folks who work on PD (not for this notebook)
and they told me that that indeed it's likely it's an alt mode bit missing =
in
the configuration.

Also they had said it would be interesting to know if anything newer suffer=
s
this same fault (such as XPS 9370 or Precision 5530).

I'll reach out to the right folks for this system to see if we can get that=
 changed,
but this will take some time, so don't expect a quick turnaround.
