Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C8EC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FBD20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="b0Ylll5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FBD20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeJ1A7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 20:59:50 -0400
Received: from mail-eopbgr720103.outbound.protection.outlook.com ([40.107.72.103]:9706
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728789AbeJ1A7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 20:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRTpQH3Tvptw3LhONpLlTblNfauRdWTCCNc+shxvmoo=;
 b=b0Ylll5z6V6Aefh92SSGchfe+6Yp9VrlBlKU3VuJoyfMLewwcpHblNTDQ+1rZFy8jHUKad20sAoPtdCdQpDh5axKIwLyKtbupXSnyWfJoQnuUkfQEKbn5oBVFmYHtLCGcDFXD9Gl9t9kFx651VwBW5wwX68MTti3w+hEfj7il20=
Received: from BN6PR1301CA0018.namprd13.prod.outlook.com
 (2603:10b6:405:29::31) by MWHPR1301MB2031.namprd13.prod.outlook.com
 (2603:10b6:301:32::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.16; Sat, 27 Oct
 2018 16:18:16 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN6PR1301CA0018.outlook.office365.com
 (2603:10b6:405:29::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.9 via Frontend
 Transport; Sat, 27 Oct 2018 16:18:16 +0000
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail01v.am.sony.com (160.33.194.228) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Sat, 27 Oct 2018 16:18:15 +0000
Received: from usculsndmail11v.am.sony.com (usculsndmail11v.am.sony.com [146.215.230.102])
        by usculsndmail01v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9RGIDF1021074;
        Sat, 27 Oct 2018 16:18:13 GMT
Received: from USCULXHUB02V.am.sony.com (hubs.sonyusa.com [146.215.231.16])
        by usculsndmail11v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9RGICwP005469;
        Sat, 27 Oct 2018 16:18:13 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB02V.am.sony.com ([146.215.231.16]) with mapi id 14.03.0408.000; Sat,
 27 Oct 2018 12:18:12 -0400
From:   <Tim.Bird@sony.com>
To:     <viro@ZenIV.linux.org.uk>, <visionsofalice@redchan.it>
CC:     <linux-kernel-owner@vger.kernel.org>, <rms@gnu.org>,
        <ksummit-discuss@lists.linuxfoundation.org>, <mishi@linux.com>,
        <gregkh@linuxfoundation.org>, <bruce@perens.com>,
        <linux-kernel@vger.kernel.org>, <esr@thyrsus.com>,
        <bkuhn@sfconservancy.org>, <editor@lwn.net>, <neil@brown.name>,
        <moglen@columbia.edu>
Subject: RE: [Ksummit-discuss] The linux devs can rescind their license
        grant.
Thread-Topic: [Ksummit-discuss] The linux devs can rescind their license
        grant.
Thread-Index: AQHUbcc+0JSq+4qgKE+Fep8huwkDfqUzQMLg
Date:   Sat, 27 Oct 2018 16:18:12 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF88A2A727@USCULXMSG01.am.sony.com>
References: <20181020134908.GA32218@kroah.com>
        <87y3ar80ac.fsf@notabene.neil.brown.name>
        <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
        <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
        <20181025081911.GB11343@kroah.com>      <20181025193901.GD26403@thyrsus.com>
        <20181025204718.GB25649@thunk.org>      <20181025214123.GA2448@thyrsus.com>
        <20181025230656.GJ32577@ZenIV.linux.org.uk>
        <75eb4a46c8a2c1d4a927760fd1f2009d@redchan.it>
 <20181027073241.GM32577@ZenIV.linux.org.uk>
In-Reply-To: <20181027073241.GM32577@ZenIV.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.228.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.228;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(448002)(13464003)(199004)(189003)(2900100001)(66066001)(2920100001)(47776003)(97756001)(72206003)(85326001)(33656002)(106466001)(46406003)(50466002)(186003)(2906002)(6246003)(26005)(86152003)(246002)(336012)(55846006)(6346003)(102836004)(316002)(126002)(86362001)(7736002)(8936002)(93886005)(7416002)(8746002)(5660300001)(229853002)(446003)(426003)(476003)(55016002)(4326008)(11346002)(486006)(478600001)(356004)(76176011)(7696005)(110136005)(6116002)(23726003)(2876002)(3846002)(54906003)(305945005)(2101003)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1301MB2031;H:usculsndmail01v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail01.sonyusa.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT025;1:Dwc5v20HK/V0xAgxJ7mHZlSxrPxc3MLDIFH0my54RppSAtn3X63z88b2kh4VEcLJTM7DqR9S0S+4XBdQUUvgUR2zULJYGKIQnaU5krcY3dFNPM3/gk4wgi3+E8vg38Cu
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f45eb37-06db-4f7a-80fb-08d63c27ccc1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR1301MB2031;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2031;3:kYDG65+alX2OoeoQQMzH3jXAEMB3PZEVuQ4flJzMlhfl66j5t8keuQWCPj3I9SJQGA4kyEQ6jHk+FqthOcCbl3jqwigKp38n12SN/hCZKIi6DZz3kn6ot6xpY2EX9mIdLdBQU8TiefIwSB0EwTa9aX0FDGVNRsX7ReHOUbe2+apjBlDClV21DDQBZwpOgxawMc0NkxaiN5ofYdO18+wyodots8w3wKbg1IxPDvpMZkmvHgZe9abh9qVIQbuBMmxWL++jyzsoFS8a4BiNdLlQ4wAuPaOg5myyG4yDRHBVCZaRhjtUM4YN3HA0bjajmNdnVwXCR501Tu0r6nhYueEsedN8oNGesiSqJLIyj43uSKE=;25:nIpBueHvD/UhGA5NXMocWmSUOVs1SOQ/QhMvCpHEXNSj5Kb8D60VVKsD5LNSfRopDJQP7V3LwhuQA7e4T1bw7kwCY/f0Dglc2MH1hsk4H7ZWZLvvQwFi67ksPpG8w84VA+qdjrJDROWHcvI+MFF0ctceE6fzm1K7yILAl8IQ2k+dHR5iVKFqBMX/CmUmu5EoL0qMSD8s7q+k0xbvVOb5jXsUxtQS3+G092EhDot20DCq1y0aV4kDs+rSYJzShbAjIHlmUDi6atGjuNAG3XST4FSdH2Uzz6VCDYtk84gLYm8kJbz+cSuHHXMbSiu+2sDKensqLaVwV862L2Ypn8iPJw==
X-MS-TrafficTypeDiagnostic: MWHPR1301MB2031:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2031;31:rKS4gXZus7O5ZLRGF0fS6AOOwRDMK12wFx8xXrMqYoUR2oDmzP9GgbRFX6/jPmupnucY0Q/RhY9izSETDZazkgYnfxKYQNgu75zUJsinsPYxDl8jhc5ILleHGOSgXXyWS9G07MnIyebQrNzgGN0d0v4m9gdZKtO7UB6tKEEMBKTaeWXB2kJqP/WHqzTr1YWgO5KPp0wPSWV+InFPv8D9C9jg4FUX75npFoeNmGMKjhA=;20:Gv6a0HpbMiasnQQSHMsI8ZhHOPMQkdKgr9E2ieFibQPbCyvUq6nQujSSyYKesJwVcrcS14XF1/ddQRBgA1h4dabveaw8R41PS+T5WeY9h+D9Ygi9kgI94W9VjWqcOt8vT+AuYvJnfKSEJGIoLHtTg48BYYAXBw8m4LxWj+MVdrnUaBZvNBuSF6EXVFvz54e8t5ZO1/wdHzM5ELtLrPUY2xnZo16M11imiP9IFsyEj+82Oopg1P+4eUOjVVNbTi1I3EoUW3rwiWwuj4QwhfVMr3oxkdTWVCL28kWekmfshDfPZ3Sqet9Y5f+WDMRgE3WOT9gaokMwEIbrpuf5nhH0vAAU/Mj7d+eh6+FKg34EzzRdn7vhTgh4bqq82QRf06KQ/YVwGzb9UBr0JJAbW+F0GbhAePeu/ZJKL93rhzliVdn1uI+E5vbfZso0+37CuHrR5O4SxCGzQ8NqH3BqpK2sHab7J1EyMUvjVX03KoPGveP7FyNKpLRvzW0cEpOCI0Aq
X-Microsoft-Antispam-PRVS: <MWHPR1301MB20315E2548DD4C7AD774BF21FDF10@MWHPR1301MB2031.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93003095)(3231382)(11241501184)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR1301MB2031;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1301MB2031;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2031;4:pReKX/Fj+E2dCdCvLs6nFlyTnNRXLKZN2+9d+5viyWWFzhafqxQJxO4/KK8owdmekbs5uiFddlanfSl2w37t54s0k6IAG9GNbz826PafdiFc3GjwRq5kDEDqdUCP9f7aFu3F/PemL6W/P6e+/NVJVRi4GyZJEC6NFS7TCp827JibnV1zDvxM5JxCe82iptNAskjyCBNpfK+F8mthQKqM7bYWy9a965g/UpPIc4iCEkRRn93jk4IYUzegciDiWXRLvIFEyOknVMsLBjWicl+hOg==
X-Forefront-PRVS: 08381C729B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR1301MB2031;23:i6LuZL9GPZ61CNIsOMWGQwNNt2JS48+ciHlbcOm?=
 =?us-ascii?Q?47U/UgRzxLH4WliDxm+F63Q3APUFvJMaFlCqOo2nfnxe/2r5yMuXtwKMXGP2?=
 =?us-ascii?Q?kSPgOdptkmbI7evmrQJdxL9ftBv9+ffw573M2orJlatnyPXndqRUjxU6lwCp?=
 =?us-ascii?Q?DK7vJWblO9lx+i+BOE5xrLgLk1TrVurHif8drgrHnitrUBDt/EZjZbapt3tn?=
 =?us-ascii?Q?uMCU9B8jSQ8hXWQuwDXNbEL1Ss8IT2HivlnUdQ0Oqu0rsZiYuvNrZMAeyweT?=
 =?us-ascii?Q?aKEPxUeYCOqreVFzXnxT/xtP5wfxdZb7zdpHhftIlV5cOY6FwtNt9h3QTDER?=
 =?us-ascii?Q?00lJL9DVYtQFK0HE3+0s+dVG8wA4q3GJPxqr6pLSH9LWXMC81BpzHr+LdjGx?=
 =?us-ascii?Q?SHva/6dN++L1vCOid4f2NsTfrooP//ejLHsH/xT0bMSR34OWgGiB5WG5frRS?=
 =?us-ascii?Q?el6mQj0wLPhlwftB/eIft9T8w2NJ1mF4g/SLg7Qa58i7i6ZEsd6LwHCA2cu8?=
 =?us-ascii?Q?z4Qu3OBRQb/83uZ4aVEosgSZOr0vftsvhdupCBmIkKTHQ9Ka7AjqV4oW4YHf?=
 =?us-ascii?Q?Jcm6PW/R/B8JTcRojITVG/GbT6n4pvjgoRIkh5DPW1VrRc8iVVNwRxRFd2g1?=
 =?us-ascii?Q?zzGaWdz4DwQjNmSeZdUng4tgHXtS1asrSzl4GtFGEW+mUYBZv4r5f6ViIT1N?=
 =?us-ascii?Q?Al8+9isEHXI70Kn0ecSIeE1C14CoivHWRjellLvv5F6qP+NnC5isC6fL3o7l?=
 =?us-ascii?Q?2ONa12bpFicavlednUXr8zCQhBv24MBV/eVFwnwW3xgZoWY31nPBmGZgSXGB?=
 =?us-ascii?Q?sLsT8QS02yunoH4yeyyW6nh4MkQCThlyFwGr+lvHm/jtqzww+YwsNhOljZpI?=
 =?us-ascii?Q?pAM+BFMaP7Hg9tk0z3xnZGVhCidEsPYPiPUC80DiWKJScXjrTNIzJJUEsj9a?=
 =?us-ascii?Q?+afs1ELizgwBjS9nzS0cQZBMuUjYgeq2QoZUSDc9XY1e8Hb7m6wZ3o5bPSZl?=
 =?us-ascii?Q?uPGqpVuBOP7Rt96hLut1KFiNvxqmgl28/8gevuJM0guxZe8kWwQ/fD5c0Rdm?=
 =?us-ascii?Q?6mqiufP6tx06AVYf8UCv5PxiHVJohaOPzg9uYL3o8YMjMQb9Ixu2uY+xDUlG?=
 =?us-ascii?Q?hVj5/6UH8AgBWE/BdarGX1enFkXpSE89dAtsR+RAqWsoi+SspzMXtQv/HEFv?=
 =?us-ascii?Q?E1GqKVHajIR8ENcCp9PhNXpo65q8Z1WbssbueIXa8qHm3Ax1V7bLzLXDGCUr?=
 =?us-ascii?Q?b4Uzx/fl2s9oa3xoWhwnP5hSjQQ98pdQ7dfF0nkihb3kWczlFN03QbG+9zlC?=
 =?us-ascii?Q?WjO2f9xzkXN3U/ujlSX3yWXBft4M4YZwEAxfGk6CAqvAv?=
X-Microsoft-Antispam-Message-Info: zTiqbp/yM+wwBHRly6GXuT+Cda06L2B3Tl9i1azM8EMbECM+dtXONgbwW51LYYDalyzXOygtXCnLCVDYczHElJ31N5OXZ4BMRka9o0tUjGtrrS78II0oUL/vP045EIBrmpoi/4iZgxIGUD5+VYEL/KdJM4kU/UpBhsQCjqRTnQBb1D4+Yk9RcoPrBB/Wc9tGP1aGVmFSnXLv5L/Z28JEZKNtYEs4gDy2zF9Vjt9SpOSjJ1uduRV8muAgefR5J47cJFE9aPlgR/Zs+6IUjXPFzeT2dBAc2VuNZsuC6R7sUf4XI7KmziWijLW05LzphcUrFc8ZmPvE9mtp9SddfJpUvqS8sT8UnF9N3KnsEboEIQc=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2031;6:iYEafq0BmjNSilWUn8tkoK/3ZXys+a44GvM/kfZm9X0oLSInNzBT+NJ4SKcBCD24jxK41fAoGd1fWzJ9cu1y6qWGr5J7ZbXcp+RcaOSarKpJE2FKVTVCm40lAgZMNovnc79i/j3ZcH4LL2PV/Ct7CY8352yyCUWu+KtZ0CRC61SuBsJddr0oXiDDiPlcvfHh62Owz2V/nS8H3CJXMwEDStXZAox/1Seg7BVTyVuewj0aUenmcQs9585XswY8lR8RXWr7v6GfX3MOdvPbDDFYv1Za4Ljf54cSzb5kZ5hRJV9+HoYYP2OSuWamsMM928Q53gJ6tb1osQE1n24YCUECzoJHc0aDxNIjS49AlGwdccFiNliV5YQxmon+lI3jnlW0MrbY+6d2uNLIlRtJ31zNKI6sIIRSgxvuAIYZt9ILW8OUZgOSSvFYAr5GV7moo4Qefqh7P4XBRPalKP3wMYDqBQ==;5:B0kIzSWg5uWHP6CgEZP+0WwbAh0NtalDvTadgdPZ+ji0iHmlXW04o89vgQwF0riqNyemqJFSMEMxTJ0eDYxiZwTwpggvnT/OFTgKU5PzbvCxv5oKslHoEJ6Y5Tunlx7PcgG1RJ1kuFxwYVm7ki5C5ukLGPNdRe4XISiMnCqOJOw=;7:i1lJ2QI5CdEvXswYWzqpXuuHV8T1eQC2Hml15Bkj+sAudLZgvAUCzBEAZCsIgMeEHghxGElneaLYRzhdnfqPIFWUTepLjaUx1Acg1d8Nq7Nez9qNAS/lzeG7LYf+ESaU8rRSAg+noOe0BZLZOwXuqg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2018 16:18:15.0034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f45eb37-06db-4f7a-80fb-08d63c27ccc1
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.228];Helo=[usculsndmail01v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB2031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Al Viro
>=20
> On Sat, Oct 27, 2018 at 06:52:44AM +0000, visionsofalice@redchan.it wrote=
:
> > Al: the FSF was so insistent on the adoption of the GPL version 3
> > because the GPL version 2 is not operative against the grantor.
>=20
> Anonymous wankstain: sod off and learn to troll properly.  It *is* an art
> form, and the one you are clearly not up to.
>=20
> D-.  For the effort and successful use of spellchecker.  The style and
> contents are about F to E-, unfortunately, so take that in the spirit
> in which it is offered.  As a participation award, that is.

Al,
Can you please, even in the face of comments you find irritating, keep your=
 responses
more civil?  Calling someone a "wankstain" is unprofessional, and we're try=
ing
to raise the level of discourse here.

>=20
> *plonk*
I think this part of the response was sufficient to communicate that you do=
 not
take the suggestions of the other party seriously.  And it communicates
to others the right approach.  If someone thinks that another person is act=
ing in bad
faith, I think it's better to just stop listening to that person, and let t=
hat person know
it, and to let other community members know it.   De-escalation is preferab=
le to
engagement when working with someone who is acting in bad faith.

Although I disagree with the approach used in the top portion of this messa=
ge, I am
grateful that you are committed to protecting Linux and our development com=
munity.

Regards,
 -- Tim

