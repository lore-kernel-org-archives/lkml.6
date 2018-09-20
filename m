Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4752EECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA3C21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X+yY5HwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA3C21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbeITIN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:13:56 -0400
Received: from mail-eopbgr700136.outbound.protection.outlook.com ([40.107.70.136]:39456
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbeITIN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feqNIZ3VO/3wTbAEf/UNMh3LSmUVJ4B1WPpg/8zeB50=;
 b=X+yY5HwFKVhM2pua3Anfwy0k3LLlWPlEqQd1Yh1Fmi1CamP7CXStl5OJQe3TMpZkntlDrrr6my3ieaYBOS06GFJUYY6b3jnoeaHl0On2ZynWPF3t5Z66sIYNj1RtvzDruurSYDfUsh3BVXFo6fcJdz2ADCYa5iTCtDx/3K3tKuI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:32:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:32:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH AUTOSEL 4.18 10/92] mtd: rawnand: fscm: Avoid collision on
 PC def when compiling for MIPS
Thread-Topic: [PATCH AUTOSEL 4.18 10/92] mtd: rawnand: fscm: Avoid collision
 on PC def when compiling for MIPS
Thread-Index: AQHUTJObi/I7gCXaC0WUwfjLl+BWU6Txl9eAgAbjfYA=
Date:   Thu, 20 Sep 2018 02:32:58 +0000
Message-ID: <20180920023257.GR3821@sasha-vm>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
 <20180915012944.179481-10-alexander.levin@microsoft.com>
 <20180915192111.59105520@xps13>
In-Reply-To: <20180915192111.59105520@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:tnYhRyyRkMDhqS30ZJcF5Uc0m1zfOSK4nCNZvvjm+dAdJhrtxWDDNoHKxCjrwEs/h/yT64TMLECAL6riJvXLJLZFPsbQz1OpguBZu0KAB7uCc6E4tTA4CNgKYpsuui41YpR3EawL+PceXJ9qqp31T+KKrnl181zWyIDK3rt56fM63/RUGWjfgpkfiYmZ5PF2KjFsqAdtI2dTrISPfrWWvF+iAfKVLObqKyxo5XFJ4rGMMp07g0VGxyi+4ITOd7Z4G2H2OAjPXwaxUIcQIh5KnoAdF1KmSGrKikIAkRllhFCETCAbfU1R2ii+u5t+FpfnnXnGimpW+8t+pHIqTYP6IOQaDuSX9GHCOiPZUJOawe8OfvGwidh6k93mP8eNhAm73QdV/wBfRR8TSd+ZDiMnKqy/fl17/LIlUiDG1zDgMfYdk0BIZMKfPbMtdcSh7q1IYnFfmWt89R3l4frb9qMSjQ==;5:g8RXjKWBMVuzOsFXpueOutSKCGjM2DbnOQ2MB+ELGyTrIL3/ojELxlJTL0LBQR02rN53SgKOrAAMbLihng6BoVjx98fEhJeb+RaQzbMlVMEDS73V8GfhSIW1XEV+x6P9Pud235I77equ3F/wU/VRpLomr2jkTT2y3dEzY12y4tk=;7:P0goGXTAjdArk42JE/92/B+sHdgXT2hbSZSeotNySUaPPXWsuoHnOWP6uzJD+yS9hPHioFPaYbWg1/7MVuLfguMi/eErJ3XtReSYl6+m/8NbnUVDOqLrftSDIof/bL5uXHqQ/vwM/7jlnrnIU9Nnd/1qvedX9AfvZCyC5bPMZu2FuV3voXQGxWoVL/zMGvwTJkuBgYxenMXXDifx/2ozITTwNK2KY92jB0Bw2bzpSBWXvvPrcQxBCP3Jy3yHv2mi
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cab62730-64c4-4221-972b-08d61ea16141
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB01504623CDBF88AD7BBC1758FB130@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(105586002)(217873002)(2906002)(10090500001)(71200400001)(256004)(71190400001)(25786009)(6246003)(86362001)(53936002)(2900100001)(33896004)(54906003)(99286004)(106356001)(22452003)(97736004)(76176011)(5250100002)(86612001)(316002)(6116002)(305945005)(3846002)(6916009)(486006)(66066001)(68736007)(1076002)(6506007)(9686003)(81156014)(6512007)(8936002)(8676002)(81166006)(229853002)(6346003)(5660300001)(10290500003)(478600001)(186003)(4326008)(7736002)(102836004)(14454004)(6436002)(446003)(11346002)(26005)(33656002)(33716001)(6486002)(72206003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HDXtl/GZi4UhfCID4OeHp+AQp/qLg6p/tohd6jQ+CHg54CXACj9AhSKjdQsbhR544h/HLxaszAAjAbh4B9PEmuTz3nBnS0Da6ixK+HnlflYVb012AVbetoRT9D9fCP2g8xQDDt3OQJFK+eDqiWzo8tVgC1ml4rI/qzydwv3zB9PUtRNIKcaEOsUoXE4bFi4YDEZyu8f5Pkzhl57W1cd9CCCY4T4t5mRGrbqyhiAP35fvyMz6bw5SpKFuvI441HCrpVMrNGqDiCjjoL+5TBXc3YCIEIR3dKBLkDU4vzbl+A0fMrFLofIo+zSgfC1BTynbx6tx7GQn1BVuFRtcvgeXBjFwRwhwmASRFMqMiWHI0vY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D57A790914B8249AF72F1A07F1F5454@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab62730-64c4-4221-972b-08d61ea16141
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:32:58.7729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 07:21:11PM +0200, Miquel Raynal wrote:
>Hi Sasha,
>
>Sasha Levin <Alexander.Levin@microsoft.com> wrote on Sat, 15 Sep 2018
>01:29:55 +0000:
>
>> From: Boris Brezillon <boris.brezillon@bootlin.com>
>>
>> [ Upstream commit 8f3931ed975e1d775b87ce85d65ecacd54138359 ]
>>
>> We want to allow this driver to be selected when COMPILE_TEST=3Dy, this
>> means the driver can be compiled for any arch, including MIPS. When
>> compiling this driver for MIPS, we end up with a collision on the 'PC'
>> macro definition (also defined in arch/mips/include/asm/ptrace.h).
>>
>> Prefix the fsmc one with FSMC_ to avoid this problem.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>
>I don't know what the exact policy is regarding backporting patches to
>stable but this one, while harmless, will have no effect on
>stable kernels AFAICT because it fixes issues discovered when allowing
>COMPILE_TEST on a few drivers, which is a change that is not going to be
>stable materials anyway.
>
>Same situation for:
>[PATCH AUTOSEL 4.18 11/92] mtd: rawnand: sunxi: Add an U suffix to  NFC_PA=
GE_OP definition
>[PATCH AUTOSEL 4.14 08/57] mtd: rawnand: sunxi: Add an U suffix to  NFC_PA=
GE_OP definition
>[PATCH AUTOSEL 4.9 04/34] mtd: rawnand: sunxi: Add an U suffix to  NFC_PAG=
E_OP definition
>[PATCH AUTOSEL 4.4 04/20] mtd: rawnand: sunxi: Add an U suffix to  NFC_PAG=
E_OP definition

I'll drop it from all branches. Thanks!=
