Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966BAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6BA2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="uOWNKphS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6BA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeKBRp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:45:26 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:44161
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725986AbeKBRp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOj+JT2YGgDSdOV+v1z2ay94dRvAPcrbM2uTve8dv9w=;
 b=uOWNKphSEfpn42aEgFPLZ5ECGM75zFdzanBPYOeF52w0WUeuliUX0aVp1+kx80FaUiYZPBQJBR0GZQZS45bbqU4+Y391JsDuhEzM7mDZaeklvD05zQUd+lKntuaXMtNHjbIJzAyQ1nM+KuaU3KnbCm0oPX+tz4R+DvUBBaNbyXw=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB5580.namprd02.prod.outlook.com (20.177.222.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Fri, 2 Nov 2018 08:38:55 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::7c6d:415e:343a:ed8d]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::7c6d:415e:343a:ed8d%4]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 08:38:53 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
Thread-Topic: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
Thread-Index: AQHUbCkGImIFRcuRaEmaBKZIdJs+DaU8NmMQ
Date:   Fri, 2 Nov 2018 08:38:52 +0000
Message-ID: <DM6PR02MB52271A9C7D7829CA1467B657C1CF0@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB5580;6:2F9xAn5S6syJ24cYTnTwtMgz0BOQfjKsyC+UJwdrgxODDuJOErOlD0ackLOIuPakQ0fEUuf5QkjahA6DDeXZPVOhKACNld7XmzAc3kGgKmhmEqBUSOC6s/EkRror2BP5nKp0M78n/mE8Sh+B2YLAww8c05EYMrgrHcFjLAkGrr9YZNirOhshF+3RPC0dKO9YHMdS7/0Ich6JEEx2lV4BjKoqIg3cY3WVF4yl1btERrMY213qDgtNHIMTJZLnQ2XcCmBggKg1veBzwRmpd6cTebPHKvgCMDccCo0k/LyukInN6oQBk1Ht3JjOs19f7NGcMPS+bn3dUunRWm/SybPXTu3awaOZubSxeC6M8BbQ+9fmHH4AAqCYHUOQrV7A9kg6W2Gp6yWwxkGp1J7GsVHMIy2qw4Q0MPGs1Ev70Z/T54lHj2s5Sg4ONonyvR2uPJzlBL72AU91opmZYCaUL4SqoA==;5:YpHecZT7h8accTqHer2+HT9ICzSfbCyTRNLhsHs6aVqkC/pB1vj6r36YyFSEgNzf/TDQ5Q5hDulrETMTTYQ7v7AmMKNTr4f46LMK7XxzrLuuYtxxu582klM0HkpnX8n5mRC+P68WFH2Hdzt/aM11ITpUl86/9q3uBU9havtOtWk=;7:3hahLbNQFqPGA7dmqghVZt2147mZU8g1UC0T7oApzYCg2+jdtxiCylXSXjnlc8TJHDc338/T/UZpHyAM7jvKfmPW4jILwFNnW2lP7uPWUuu3Wz4zxwwzWYCzD1qQ+6BGMDGmfEgvH9NAfb6cLwA+dw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 1e8d5a4a-9361-4a44-e93a-08d6409e9eb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB5580;
x-ms-traffictypediagnostic: DM6PR02MB5580:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB5580F2CD7881EA8CAFCE5368C1CF0@DM6PR02MB5580.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(180628864354917)(185117386973197)(9452136761055)(258649278758335)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB5580;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5580;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(13464003)(55016002)(26005)(53936002)(4326008)(6306002)(6246003)(5660300001)(14454004)(72206003)(9686003)(66066001)(53546011)(6506007)(966005)(110136005)(2201001)(54906003)(86362001)(6436002)(6116002)(97736004)(486006)(3846002)(8936002)(68736007)(256004)(7696005)(11346002)(76176011)(33656002)(2501003)(316002)(186003)(105586002)(106356001)(229853002)(99286004)(81166006)(476003)(7416002)(74316002)(2900100001)(71190400001)(102836004)(8676002)(81156014)(25786009)(2906002)(305945005)(7736002)(446003)(478600001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5580;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZRcGp0t+sfIFiveyETYzTChwMTWfiMTysl91JlRq2bE7fw/iYeJqUWOuS84y5tM0OvyVhrqkStrNs455mgLXZs7rHZ4LqzCcr6A6sjehbKa/RDyBTM2yMDgmwLMttDVHgaExMaOlY1FBiD6G4HlUfwqA3Ddk4I7m5sksAu8CSHp/+Mgi5JGVHV/1GP+EEtX6aG+LL6Gxfbxoc1qawZxRN+9v+KLC8F1zIIJNVXC05jnv5tTPPP8ytvCmwVtomUKOeNr9iTJfAnRjDcsYjWMiNxlOrcsyrSIG5sN+v+TbCCy4VJWa1yAGzsGcMQX+cPPaTPmcquu9TErFBcHqUF8sja0uUNm41bijKTRsGF+zThY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8d5a4a-9361-4a44-e93a-08d6409e9eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 08:38:53.0117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!


> -----Original Message-----
> From: Manish Narani [mailto:manish.narani@xilinx.com]
> Sent: Thursday, October 25, 2018 11:37 AM
> To: robh+dt@kernel.org; mark.rutland@arm.com; Michal Simek
> <michals@xilinx.com>; bp@alien8.de; mchehab@kernel.org; Manish Narani
> <MNARANI@xilinx.com>; amit.kucheria@linaro.org; sudeep.holla@arm.com;
> leoyang.li@nxp.com
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-edac@vger.kernel.org
> Subject: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
>=20
> This patch series enhances the current EDAC driver to support different
> platforms. This series adds support for ZynqMP DDRC controller in synopsy=
s
> EDAC driver. This series also adds Device tree properties and relevant bi=
nding
> documentation.
>=20
> Changes in v2:
> 	- Moved checking of DDR_ECC_INTR_SUPPORT from (1/4) to (3/4) as it
> is
> 	  a feature of ZynqMP DDRC
> 	- The Binding Documentation in (2/4) is modified as per the review
> 	  comments
>=20
> Changes in v3:
> 	- The commit message in (2/4) is modified (Synopsys EDAC Driver -->
> 	  ZynqMP DDRC)
>=20
> Changes in v4:
> 	- Updated the commit message in (1/4)
> 	- Renamed function pointer names removing 'synps_' in (1/4)
> 	- Shortened unnecessary long lines as per the review comment on (1/4)
>=20
> Changes in v5:
> 	- Updated the commit message in (2/4) and (4/4).
> 	- Removed the unnecessary check for match data in probe() in (1/4)
> 	- Some Indentation changes for better readability in (1/4) and (3/4)
> 	- Removed repeated code in (3/4)
> 	- Used 'zynq' and 'zynqmp' instead of 'synps_enh_edac' in function
> names
>=20
> Changes in v6:
> 	- Splitted the patches according to functionalities
> 	- Addressed code style comments from v5 review
> 	- Moved the Error Injection to CONFIG_EDAC_DEBUG mode
>=20
> Changes in v7:
> 	- Included DTS patch (6/7) which was missed in v6 patch set
>=20
> Changes in v8:
> 	- patch (1/7) from v7 is split in to 3 different logically different pat=
ches
> 		1. functional changes like code cleanup
> 		2. functions renaming
> 		3. comments cleanup
> 	- Added a separate patch (4) for making always successful functions as
> void
> 	- Corrected 'Too many parentheses' review comment in patch (5)
> 	- Corrected comments as per the v7 review feedback
> 	- Made dedicated functions for IRQ setup, IRQ enable and IRQ disable
> in patch (8)
> 	- Addressed review comments in patch (10)
>=20
> Changes in v9:
> 	- Added check for return value of of_device_get_match_data() function
> 	  in (1/6).
> 	- From v8 the first 5 patches are removed in this series as they are
> 	  applied on:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/?h=3Dedac-for-
> 4.20-synps
> 	- Updated Kconfig to check for ARCH_ZYNQMP instead of ARM64
>=20
> Change in v10:
> 	- Moved the checking for ce_cnt and ue_cnt before the readl() call
> 	- Aligned arguments on the opening brace in setup_irq()
>=20
> Manish Narani (6):
>   edac: synopsys: Add error handling for NULL in probe()
>   dt: bindings: Document ZynqMP DDRC in Synopsys documentation
>   edac: synopsys: Add macro defines for ZynqMP DDRC
>   edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
>   arm64: zynqmp: Add DDRC node
>   edac: synopsys: Add Error Injection support for ZynqMP DDRC
>=20
>  .../bindings/memory-controllers/synopsys.txt       |  27 +-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
>  drivers/edac/Kconfig                               |   2 +-
>  drivers/edac/synopsys_edac.c                       | 911 +++++++++++++++=
+++++-
>  4 files changed, 918 insertions(+), 29 deletions(-)
>=20
> --
> 2.1.1

