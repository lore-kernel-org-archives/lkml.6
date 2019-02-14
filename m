Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BC5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE2F222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="WcpwtNEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408060AbfBNQm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:42:27 -0500
Received: from mx08-00287e01.pphosted.com ([62.209.51.156]:56886 "EHLO
        mx07-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727643AbfBNQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:42:26 -0500
Received: from pps.filterd (m0111315.ppops.net [127.0.0.1])
        by mx07-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EGeFLe002413;
        Thu, 14 Feb 2019 17:42:14 +0100
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56])
        by mx07-00287e01.pphosted.com with ESMTP id 2qmy9s0tu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 17:42:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIjDLxx3Sim+RaHvjabeWNcB6N0XypSE5YZsXoXczGo=;
 b=WcpwtNEpbmh6Hz91eHUyYclRLm+Ko6M/S+aAc2hqH2r3gfR5w+31rfl+/LsHKs/R39FRqA8YAUfcc0jNvNVgE6vDRh92fjBRsurCJxuXdcCOjXEBK+O+DRQeyjbP3gj038VuuZxfKBILn0D3LII4HA1IA1UbVhYKtw8Aly+27aQ=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB5216.eurprd04.prod.outlook.com (20.177.51.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 16:42:10 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045%4]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 16:42:10 +0000
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
Thread-Index: AQHUw5aitGKSKy+IPEu9VYMAMc3KbKXfGNuA///+XgCAAGoMAA==
Date:   Thu, 14 Feb 2019 16:42:10 +0000
Message-ID: <8158d558-bbcd-fabe-6c8a-8de840807dc0@criteo.com>
References: <20190213122105.14270-1-e.velu@criteo.com>
 <ae38f70b-f352-8567-2dac-5f6c7723a668@criteo.com>
 <CAJZ5v0geHMDMLqg98BZEGLjNrSRy3juB9y54ots357wVeK-shQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0geHMDMLqg98BZEGLjNrSRy3juB9y54ots357wVeK-shQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0206.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::26) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65dbd9df-087c-46b7-4cc7-08d6929b5d2d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5216;
x-ms-traffictypediagnostic: VI1PR04MB5216:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1MjE2OzIzOm4zNTQwNlJFak9zbGVYMVE3clhTQ0pTaU9E?=
 =?utf-8?B?eDR3cXZFRTdOUncvbmFYbVdSTko5alFhUmtqTlFRanZpSmxrVHg5eTJMRjJE?=
 =?utf-8?B?MTBNZDZaYTFhSTc1L2srSndveVZKK1pBdWRRV2tjMXNTek1DTzNqUEtRV2hu?=
 =?utf-8?B?emVuUkF1ZEJqS2pwU3RRVHFWbXdoSSs2ZHdwL1dKZmk1cCtPZGVtQksyVnlo?=
 =?utf-8?B?NEN3dWNBQ01CSTg3SHZwUEZyQXJOZHJJS1lPZEhnNWZ2TThyL0JEdi9CRk5q?=
 =?utf-8?B?QlJKSEJpU3AzTGRJd1dreWhWTHl3L3BSdGk4TDZPNCtLdkhBQ1FDbEYzZjh3?=
 =?utf-8?B?T2llU3BKTFdFVEZCMWNKb3Vqak9FZXJyTStFOGdoWU0yUHJvTGZZZVJXU3Z4?=
 =?utf-8?B?cmNoOURwREY2ZE5aZlVNWHJac3lxTjBBUHVybDNJMVQzMllKQ1Bxdk42aGhF?=
 =?utf-8?B?SlhDUEphOVc3cFY2dVhKbU5Vd1k0TzZodDFhQ0VKMEQ0SGlBYWErQ0tyZGxo?=
 =?utf-8?B?NFhBYVdMY1lqVi9SWHVlT3ZWKzJBZmpxeU8wWEFXTHhjeGhBQXRCWFFmd3Ru?=
 =?utf-8?B?S2sxakFWc3c2bXVScjZEdVdrSXZoZmtkVWJWdFFnYjlZZm83dk5kZXNGTWJz?=
 =?utf-8?B?K2pXVWVQZVFhWWd3dUVySmgwbmJ4SkgrMk4xTkxPbFJIZlpyVWIyQkVQWk5G?=
 =?utf-8?B?QTNiRisxZ3NzbDgzL0dhSVh0a2Y5TjRzazU2Z0Z4aitZWWMwVDl2Q3pDeThK?=
 =?utf-8?B?SmpIODNybC9MMTlWdjI2dyt1QnBHYUhTSlk5Ui9JU09NS3NHMUlTRGRCdXRC?=
 =?utf-8?B?S0UzSUJpT015STBkZGRFNGEwc0xFTmFhTjVKWElOTWFFNTk5TnBYR0FaWlcw?=
 =?utf-8?B?Uy9pTUkvd1FucG05Zmdrc3ZiSDdXcjZzOGVRZ1lzaWZRQjlTcTBYTGMySEJJ?=
 =?utf-8?B?bmtDclRRYTdWNmFHNXl1T0Y1R3FYMFc0a3FTUmhsKzZ4cmt1R3VVRHZZQS9w?=
 =?utf-8?B?S3ZFVzZjUWxUbU5QM1ArL3RmeDN1dktxOUx1c3o4dVc4TS84eWFzQnFjekdw?=
 =?utf-8?B?WFdPTDd6YmJ2cjI5M00zOHEwQUEwdVBwcGpENHhZMmRGUlJSZlQ1bmFic3Jt?=
 =?utf-8?B?Y0pBYUg4ak1WWTJEdGlwV1I2ODhXSTMwUFBKQW5mVGc0bHdHb0g2N3QvZXky?=
 =?utf-8?B?Z2dQeTUyd3VaRTZVaUgweCtpdTluWm9WakhwMWZSc1FwYkxWMzNtWnVIdlNw?=
 =?utf-8?B?VGc1OXZzWWNMekRiU0ExNnVFQlNFQm9KeFZuWFZWSVVXV2dCNmFEKytZdlpX?=
 =?utf-8?B?bGltRXNZK29xZm1zNnBBRHo2YWRwR0tmNUsyOG80S0RQTmlmVEQ3R2NpOU9k?=
 =?utf-8?B?SXVKZXA2am9ub0ZMRUsyUTd3Lys1ZmlnS3FHa09YOW92WGFmQlJiOUpaWVlM?=
 =?utf-8?B?NFhkTkRiRXNVMWdnV0FrZnI3M2RYR08vNk9PcnhwblpNT1h6R2U1QlFYTVNF?=
 =?utf-8?B?TXJZNDdWcmFUcWM2ai94cm96Z1c2ZGU5b2NpTmsvOWRuQmdHK1dyeVJFWFJj?=
 =?utf-8?B?elhkVGpyVHZFaGJyYkZ4dWFJL3pjT0crWGhkQndBaUR2Uk1teGlBNC95RU9P?=
 =?utf-8?B?WkNLMVVzVGd3QzZnWTh1dmNOZFc0RkY1Z3dDRnJuNjZXZ0RodzdtTElJbGkw?=
 =?utf-8?Q?4mcQjqqCa0kYBBWlyTQYtAbVeSlAVgV4duTAzxh?=
x-microsoft-antispam-prvs: <VI1PR04MB52165156FA22DB3236B3A71FF2670@VI1PR04MB5216.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(6916009)(4326008)(25786009)(2906002)(52116002)(476003)(446003)(66066001)(11346002)(6506007)(386003)(76176011)(2616005)(186003)(486006)(102836004)(6246003)(26005)(36756003)(105586002)(99286004)(53936002)(97736004)(478600001)(71190400001)(316002)(31686004)(14454004)(81156014)(6512007)(256004)(6436002)(229853002)(68736007)(86362001)(31696002)(71200400001)(305945005)(81166006)(6116002)(3846002)(6486002)(14444005)(4744005)(8676002)(66574012)(7736002)(8936002)(106356001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB5216;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yljGRLhKWLY7ilrUNfdjfBNHDGVIZOUoUP6QKK+y+AGzk6IbeGrRM0gwWkYbCGYthVmXy6lOCqniB5+WaIwcoRnoeNGkxnCf+oUNC+pk+gM9l3xi4HR6Mk2OPzOlkUooC/U2+5J0BcRNeCP2+7ppckmvT/lbB4nGhGP1FkRH4WNxLZfXsQJ0C3oYZ3JCUZHjGt1s5CF+VfRveOyn8PAK7pyPdJIMZtOSMt6q1CRSEtjApOjSyidTPS11HeYjSgPprD/55vygeMmEcaz0AXjoXkt40ZGOXTH7kuQ933C+75hgcPPT50xcxu7YCwoNtOxgC7pEF/wQ4nWSuY6j/L/BqIMw/t/CyRQUQ5X8rV+D15oV8AI0U6jZjHeAH1zKlqhci+Aod4ZQOv2EGoxxnuxyEAfviU9UgJBimb+ID3b8Feo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF0E74F8E8D3A04D90BBA2FE55580C16@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dbd9df-087c-46b7-4cc7-08d6929b5d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 16:42:09.5386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAxNC8wMi8yMDE5IMOgIDExOjIyLCBSYWZhZWwgSi4gV3lzb2NraSBhIMOpY3JpdMKgOg0K
PiBJJ3ZlIHF1ZXVlZCBpdCB1cCB3aXRoIHNvbWUgbWFudWFsIGNoYW5nZXMuICBObyBuZWVkIHRv
IHVwZGF0ZS4NCg0KQXMgdGhpcyBjb3VsZCBoZWxwIHRyb3VibGVzaG9vdGluZyBwbGF0Zm9ybXMg
YW5kIGFzIHNvbWUgY29tbWl0cyBsaWtlIA0KdGhlIFBTUyBvbmUgb24gUHJvbGlhbnQgc2VydmVy
cyB3ZXJlIGJhY2twb3J0ZWQgdG8gc3RhYmxlLCBJIHdvdWxkIA0Kc3VyZWx5IG1ha2Ugc2Vuc2Ug
dG8gYmFja3BvcnQgaXQgdG8gdGhlIG90aGVyIHN0YWJsZS4NCg0KSSBrbm93IHRoaXMgaXMgb25s
eSBhIHRyaXZpYWwgcHJpbnQgcGF0Y2ggYnV0IGFzIG15IGluaXRpYWwgaXNzdWUgDQpzdGFydGVk
IHdpdGggc29tZSBvZiB0aGUgNC4xNCBzZXJpZSwgaXQgY291bGQgYmUgbmljZSB0byBoYXZlIGl0
IHRvby4NCg0KRXJ3YW4sDQoNCg==
