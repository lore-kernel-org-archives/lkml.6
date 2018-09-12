Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8218C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A132A20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="Aae1ZQfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A132A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeILRSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:18:54 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:55970 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbeILRSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1536754478; x=1568290478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HE933SpMXvCi1cJ/MwptEAze3x7DlIoQJ3nHmTGwW5g=;
  b=Aae1ZQfQX5TRLqvWDr81cFC/9o25Zf03LtTPfa4FTYm98xbXha5lbymu
   KRwR7RKrsk+IWkvA2Yui1k5argvHFuLR45nYkrbIIxaYiS8JNG4fcGkxT
   SndD1VFV8dkwlazgl9bMfiYK2bNXjzD/v+Rlz1L/bRBk4Kz/ahtyIZbMC
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FFAAD6AZlbhyeV50NcGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYQzfygKi3tfiz2CDZY6gT87CyMLhD4Cg0shNBgBAgEBAgE?=
 =?us-ascii?q?BAgEBAhABAQEKCwkIKSMMgjUiDQRLOzABAQEBAQEBAQEBAQEBAQEaAg1jAQE?=
 =?us-ascii?q?BAQMSKD8MBAIBCBEEAQEBHgkHRgkIAgQOBQgagn8BggEPmWuJVwEBAYIbigA?=
 =?us-ascii?q?FimeCF4ESgxKDGwICGIIUhQsCnBEHAoY6iUQfjnWLP4gyAgQCBAUCFIFCgg5?=
 =?us-ascii?q?wgzyCM4NOilJvAY0IgR4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2FFAAD6AZlbhyeV50NcGQEBAQEBAQEBAQEBAQcBAQEBA?=
 =?us-ascii?q?YQzfygKi3tfiz2CDZY6gT87CyMLhD4Cg0shNBgBAgEBAgEBAgEBAhABAQEKC?=
 =?us-ascii?q?wkIKSMMgjUiDQRLOzABAQEBAQEBAQEBAQEBAQEaAg1jAQEBAQMSKD8MBAIBC?=
 =?us-ascii?q?BEEAQEBHgkHRgkIAgQOBQgagn8BggEPmWuJVwEBAYIbigAFimeCF4ESgxKDG?=
 =?us-ascii?q?wICGIIUhQsCnBEHAoY6iUQfjnWLP4gyAgQCBAUCFIFCgg5wgzyCM4NOilJvA?=
 =?us-ascii?q?Y0IgR4BAQ?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2018 07:14:37 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CC7qu1052667;
        Wed, 12 Sep 2018 08:14:36 -0400
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2mexwesdh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 08:14:36 -0400
From:   <Mario.Limonciello@dell.com>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Sep 2018 18:14:35 +0600
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.53,364,1531803600"; 
   d="scan'208";a="1192721405"
To:     <dvhart@infradead.org>
CC:     <andy.shevchenko@gmail.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] platform/x86: dell-smbios-wmi: Correct a memory leak
Thread-Topic: [PATCH 1/2] platform/x86: dell-smbios-wmi: Correct a memory leak
Thread-Index: AQHUSTBoczrRm2y1nEqC7V5VEMpeRaTqUZSAgAI/qVA=
Date:   Wed, 12 Sep 2018 12:14:34 +0000
Message-ID: <d140b6171dfe4e748b7491f4955c07be@ausx13mpc120.AMER.DELL.COM>
References: <1536602513-13861-1-git-send-email-mario.limonciello@dell.com>
 <20180910205139.GC5659@wrath>
In-Reply-To: <20180910205139.GC5659@wrath>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darren,

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Monday, September 10, 2018 3:52 PM
> To: Limonciello, Mario
> Cc: Andy Shevchenko; LKML; platform-driver-x86@vger.kernel.org;
> stable@vger.kernel.org
> Subject: Re: [PATCH 1/2] platform/x86: dell-smbios-wmi: Correct a memory =
leak
>=20
> On Mon, Sep 10, 2018 at 01:01:52PM -0500, Mario Limonciello wrote:
> > ACPI buffers were being allocated but never freed.
> >
> > Reported-by: Pinzhen Xu <pinzhen.xu@intel.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > Cc: stable@vger.kernel.org
>=20
> Thanks Mario and Pinzhen, both queued. That's an easy one to miss, the us=
age not
> being particularly obvious.
>=20

This cropped up and is fixed by that patch:
https://github.com/dell/libsmbios/issues/63

Given the impact and how small the patch is, I think it might be good if th=
is can come to 4.19-rcX if possible.
Thoughts?

I suspect this one might be the same issue too:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1627609


