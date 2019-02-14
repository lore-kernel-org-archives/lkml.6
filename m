Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D96C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A480222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="ce8qtA17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407526AbfBNPSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:18:22 -0500
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:34886 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393603AbfBNPSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:18:21 -0500
Received: from pps.filterd (m0111314.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EF5H23024364;
        Thu, 14 Feb 2019 16:18:08 +0100
Received: from eur04-db3-obe.outbound.protection.outlook.com (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59])
        by mx08-00287e01.pphosted.com with ESMTP id 2qmva9gwmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 16:18:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK1SjIXDhABe+hnzc71luJ270PNIX+dIG/2z4j0Cyuc=;
 b=ce8qtA17I8VbzqihidF8jSJ6Jm4yiT/0J8pjeM+++zrHRS3RkwFc+Y4WOdKxwDX7DBb4Cr7VZ3ptqaeT3BLDDe+ymTaPvsYqVe22pj4oj4raBMLpMoCgOsDCs+UGbg9Hr6XapxCmoMf/y9Sw9f9Bf70OSp1HFszmI/XrY3N5zeA=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB4109.eurprd04.prod.outlook.com (52.133.14.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 15:18:06 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045%4]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:18:05 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Erwan Velu <erwanaliasr1@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Thread-Topic: [PATCH v6] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Thread-Index: AQHUw5aitGKSKy+IPEu9VYMAMc3KbKXfGNuA///+XgCAAFKPAA==
Date:   Thu, 14 Feb 2019 15:18:05 +0000
Message-ID: <4c1e9d87-6e4c-2bca-f069-c071ad561788@criteo.com>
References: <20190213122105.14270-1-e.velu@criteo.com>
 <ae38f70b-f352-8567-2dac-5f6c7723a668@criteo.com>
 <CAJZ5v0geHMDMLqg98BZEGLjNrSRy3juB9y54ots357wVeK-shQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0geHMDMLqg98BZEGLjNrSRy3juB9y54ots357wVeK-shQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2P264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::33)
 To VI1PR04MB5629.eurprd04.prod.outlook.com (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eec3e31f-2601-4529-8aee-08d6928f9e6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4109;
x-ms-traffictypediagnostic: VI1PR04MB4109:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0MTA5OzIzOjUvQVJ2ZVFEakFjL1k2ME1YMFhuWDR5V05Z?=
 =?utf-8?B?NFhIVHp3eW1SYjl5UmloaFk0dEpRc0xIamJrZFdUU2RUZ1ZjUTlRNXRGNCtD?=
 =?utf-8?B?THpIWnZtWWRseFVzWmhDMEpWSVQ1OHlxbTRHWDZnbDhrN2xZWEdhRUN1M1A4?=
 =?utf-8?B?bVIvZGRzTFJVWCs0djI2VVlFclBRcjdIdlExOUtOenNlSXZHQTJ5dUFkT1JE?=
 =?utf-8?B?bE9xZDhVT0N4NVVqVWhGaTU1TFV2NjNweDBDT2FOc0crZmxiTTR4QWE1dkRh?=
 =?utf-8?B?S0NlTWZ3Z2IweC9iRENwYVZnT01iT0dETGxadURnOVdYcXJIQjJySFdxK1px?=
 =?utf-8?B?cWIzOCtYdEpLWnlPMEkrUTBIZGl2eXZmeVlWSjU2K2I4all2WjlJdW5lSEhD?=
 =?utf-8?B?YWNaeW9vQk8yZG5kUGRZZkVWeXlZa296bHcvd3lKTkVTZVNodk5tRlQyTVdL?=
 =?utf-8?B?VWFhNGQrNm1UWWgxcmZHQWdhZzZrTEp3L2wvcXZZUVl1VTdMbzU0Mjd0UVFo?=
 =?utf-8?B?Vjc5d2xqUkJ0YXIrVlFKWDVqRGM0L2x4RUpYNVZOdEx6WjdNS3RvOHhmM3d6?=
 =?utf-8?B?MmZubEpTajZZclJmaXhSTndDL05HbkpWeXBWRVJYcUdzallrQm9lYWpjVDQr?=
 =?utf-8?B?eHViRGhnaHl6MGNoM1ZUUWx2VWpGSHZUckIxdlA5aGhab3U1K0JxVzBRdmVu?=
 =?utf-8?B?NkxxQWpWbE92TmpNVGJ3MjdZb2xYS0JHY285VGhHcFlpNE9tOWpyN3lkSFFO?=
 =?utf-8?B?VVpWNG5rdUNSMnJzNWs0aUR2dXVtU01BSDI3Mk1UcGR6UmZFV2dCa0RsN1Rm?=
 =?utf-8?B?OEQzWHNONjErZHpOY2F4OSt6emVOL3ZTcXdGQ3Q1R3AzbUxKY210amhFTWl2?=
 =?utf-8?B?RDh0QWMzQ3htcDFGcEpFYjREZkovb3dZd01jUmlGbUpkYkJYbklJdWdvWEVy?=
 =?utf-8?B?TTl4VkFnSG9FZExUNWxBZG03ZHBRaHZ3czhsV2Mvdm5CQW5ndXZsQTVScXhT?=
 =?utf-8?B?VUdTSWllZzhKRnZWbU1PdUVMeW85eFBKRnVpdjBQazFxa3lvb3laaFB5NUtD?=
 =?utf-8?B?aW1nWmEzSWoxditoMXFGejZPQXpFT3ROQkdvTnhrdkgzRWZPbUlscHlGb2kw?=
 =?utf-8?B?UFRqZWkwNDVrRlJwZ2pDYmZNUTZISG5vN3NPWkhVNnhTTnZXUWNFMVV6MGla?=
 =?utf-8?B?cENmL3ZDNmtTNlZCdmRpWHV6bmIwemhzWnBiLzNzdno1enB1cmQ5bXVhbXlz?=
 =?utf-8?B?cTgyZmFIcTZHUDJzNjQ1NUVWcEROalc4YlB2RzArVmtLVHRDT2lCeHJJc0VH?=
 =?utf-8?B?Sm9Jak9CVjlSTDluYVZKOVZ1YU1oektPbXNFbmNCZm04U2dpSXZHQzMra0pS?=
 =?utf-8?B?TFdka3JPdjltZ28ya2tic2xXS0U4aEU5NDZZSGtxU29uMmd3ZXgyTWVmTTFG?=
 =?utf-8?B?MjhVRitYK3RyNkpTV0ZBQW9nVzFBRzdqaS9kVlVjNUJpMm4rMUFZaEtkRklq?=
 =?utf-8?B?bWU5Vkk4RlFOanRQemU2ZldZTUpGTkZQam1mWXRPRGdDN3lZVmpHTm1TZlln?=
 =?utf-8?B?QzRHM1pqSUtYRUIvVzVlTVVFbkVuY1JBMEtpb2pLQVpkVFVQUW1JYVJwdU1S?=
 =?utf-8?B?enBINmZmRDB1NVhMNXlxMmZhaTFUSkpuRTUxWDUzeVlEOWdXbUxGVWVHc0pn?=
 =?utf-8?B?ZkV1ZW5HTHVJYVJUVmpSWGUyYWJzRDIrYkZnWWVsb2R5Smp2alZ2N3Vnd3JT?=
 =?utf-8?B?eFJ3MUpyT3lRS3NBc0l0UT09?=
x-microsoft-antispam-prvs: <VI1PR04MB4109293C648B754517740587F2670@VI1PR04MB4109.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(71200400001)(71190400001)(6512007)(66574012)(478600001)(54906003)(86362001)(2906002)(52116002)(305945005)(25786009)(14454004)(6246003)(105586002)(446003)(8936002)(106356001)(53936002)(31696002)(186003)(4744005)(36756003)(316002)(76176011)(81156014)(81166006)(97736004)(8676002)(4326008)(31686004)(66066001)(14444005)(386003)(6506007)(26005)(7736002)(68736007)(53546011)(3846002)(6116002)(486006)(6916009)(6436002)(2616005)(11346002)(6486002)(99286004)(256004)(102836004)(229853002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB4109;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6fynOORxRwwJzLGKcERzaD/TbuwgE2nbTfyhfxwFgJF96pHUwPFBpomwybv/glsSuF4UhJWZOgq1gPKZdDg1UWrFS+pNkectOJKdhEaSkBr4gX/5tMsz2oEtNpqQd/JA9JbimQPs9/PualIpHdErUaMJo4np5C6xYvNhp3LfksRtHQDeUa7Y41hG70BjiTDI5RDy2nZWHypaUUVjf6mIltJvZgCncD8u77EFIhAUsKe81u21oga1I945egNDk11kPKKqJ94stSgRNlZRHPGim5+04iXq7iFW777YGA/2HCzNiZpgHRVVtk3yQ3FQsGwFeu52Ty8XKZR3kA/bM+LfpHqfEKgL2m2NI+mNhj65vRDhmgOcy/8WPd3KNiKM3W02r9p1BUcR0QZwqQx9znWBvu7eQhI1o9Vt7VRlspoBxiQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E080BB06FB63D4DBEE4A9627843DD99@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec3e31f-2601-4529-8aee-08d6928f9e6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:18:05.1067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAxNC8wMi8yMDE5IMOgIDExOjIyLCBSYWZhZWwgSi4gV3lzb2NraSBhIMOpY3JpdMKgOg0K
PiBPbiBUaHUsIEZlYiAxNCwgMjAxOSBhdCAxMDoyOCBBTSBFcndhbiBWZWx1IDxlLnZlbHVAY3Jp
dGVvLmNvbT4gd3JvdGU6DQo+PiBIZXkgcmFmYWVsLA0KPj4NCj4+IERvZXMgdGhlIFY2IGxvb2tz
IGdvb2QgdG8geW91ID8NCj4gSSd2ZSBxdWV1ZWQgaXQgdXAgd2l0aCBzb21lIG1hbnVhbCBjaGFu
Z2VzLiAgTm8gbmVlZCB0byB1cGRhdGUuDQoNCk9rLCBjb29sLiBXaGF0IGtpbmQgb2YgY2hhbmdl
cyA/DQoNCkknZCBsb3ZlIHRvIHVuZGVyc3RhbmQgd2hhdCBJIG1pc3NlZC4NCg0KVGh4LA0KDQpF
cndhbg0KDQo=
