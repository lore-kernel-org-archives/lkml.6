Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC02206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Zg5KFdxc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HkW8eZQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbeLNSM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:12:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56334 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726662AbeLNSM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:12:29 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBEHtFc2029226;
        Fri, 14 Dec 2018 10:11:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uMLPRs03fGvOAzhYlqG5Ll4l/u8GF3sNWJYWIP4K35U=;
 b=Zg5KFdxcVz9LvLDw31cr4mcSnFE+MzWDOSMdvobls41kRsmeIQMfST2YNcwHELu9STYJ
 6TL5q5846IEV8SAUy4qQmdv0ylMGcIUhW+0mVM+QYLwWW9ZkxQxbxBseQeTdAwwUsuKT
 /92Kp+8Kh8/nu6XRL5WErSAPwU0Jz2zaPlE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2pcfs58ct6-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 10:11:55 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 10:11:24 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 10:11:23 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 14 Dec 2018 10:11:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMLPRs03fGvOAzhYlqG5Ll4l/u8GF3sNWJYWIP4K35U=;
 b=HkW8eZQJObaqYDZhs6bN2FmokzSCRzxUduBLvgj6hW/zaQ7/alcsOdWXImzoF6nuldhulgdDIoKn1aW6znbnXgM/i31brmmoJR1zP7ZjpoHCSi+uZFs9G7WhmsqrUK3nwcSFD13CR10lOsOS67se3M7q2siMlBFlEIevyPReANQ=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1544.namprd15.prod.outlook.com (10.172.162.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 18:11:21 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04%10]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 18:11:21 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "james.feist@linux.intel.com" <james.feist@linux.intel.com>
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
Thread-Topic: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
Thread-Index: AQHUkx2FLuLFnaparUSSS8WntKzruKV9R9KAgAC8q4A=
Date:   Fri, 14 Dec 2018 18:11:21 +0000
Message-ID: <B6C3C92D-1F9E-4425-ABF5-718D1A6755EB@fb.com>
References: <20181213195319.1333402-1-vijaykhemka@fb.com>
 <CACPK8XfAXDHqWcD=OKm4UhCh-+-7GBxL02Fi9_jgdmo2ZQZSjg@mail.gmail.com>
In-Reply-To: <CACPK8XfAXDHqWcD=OKm4UhCh-+-7GBxL02Fi9_jgdmo2ZQZSjg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::5:32a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1544;20:2TzQ0BGX/IEpR9Jo3t0CXEJzRQ/8nDm3YVN+6ObR2MI9ZKD2BNpcPUv3uaKoPtVETS0/z1GlQ4YcYB98ypPcQ7l87eeYW8CC8+f7iUhS7jBYkdLs4cQSRekZTSHDX1KjLpYkB3/jztYK2ZKkL5jGrki3jo+Qv2HKv6wWOlaoO20=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cf44c02e-608c-4f9f-6436-08d661ef8d70
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1544;
x-ms-traffictypediagnostic: CY4PR15MB1544:
x-microsoft-antispam-prvs: <CY4PR15MB15448B002778BB575204FA4ADDA10@CY4PR15MB1544.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1544;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1544;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(136003)(376002)(396003)(47680400002)(189003)(199004)(53936002)(99286004)(4326008)(86362001)(83716004)(46003)(6512007)(446003)(7416002)(6246003)(229853002)(478600001)(316002)(7736002)(2906002)(54906003)(110136005)(71200400001)(71190400001)(76176011)(102836004)(53546011)(6506007)(186003)(82746002)(68736007)(6436002)(6486002)(25786009)(106356001)(33656002)(6116002)(256004)(5660300001)(305945005)(11346002)(105586002)(14454004)(97736004)(486006)(2616005)(476003)(36756003)(8936002)(81166006)(8676002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1544;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 05SqbRHiDa2PCB6CtGnInyVq44EUhoJWgcUgfgHKB2KU7RJBxz24pKjm11+VMaPUFDGJBde5IUBfMcYKdWCzVIv1tFIZnbfI6AmdTiVAslgPsfCPL0/wWgP+XaBZyfmaXhw/x84+nU9o8Quw/Pw7mXbS0AvG7VDyJYseoYzn3spPaRgY82C+tQytZQyR6+cuYRrE9jSvSCHD8IwVj92eKSZmFRRg24PguyL/ZuNlqCqAc2nCYPuLjqo15R0noIBfC8VqYU8faSMO4yynlWqLYFuHHu6zD1fEVosU4n35eEiZIXuDL9tuHe3sV+t7IBJt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CA366D04D0E184A82A8F707A9625F7F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cf44c02e-608c-4f9f-6436-08d661ef8d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 18:11:21.6734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1544
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTMvMTgsIDI6NTYgUE0sICJKb2VsIFN0YW5sZXkiIDxqb2VsQGptcy5pZC5hdT4gd3Jv
dGU6DQoNCiAgICBPbiBGcmksIDE0IERlYyAyMDE4IGF0IDA2OjIzLCBWaWpheSBLaGVta2EgPHZp
amF5a2hlbWthQGZiLmNvbT4gd3JvdGU6DQogICAgPg0KICAgID4gQWRkZWQgQURDIGFuZCBvdGhl
ciBzZW5zb3IgZGV2aWNlcyBpbiBGYWNlYm9vayBUaW9nYXBhc3MgZGV2aWNlIHRyZWUuDQogICAg
Pg0KICAgID4gU2lnbmVkLW9mZi1ieTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+
DQogICAgPiAtLS0NCiAgICA+ICAuLi4vZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNz
LmR0cyAgICAgfCAzMyArKysrKysrKysrKysrKysrKy0tDQogICAgPiAgMSBmaWxlIGNoYW5nZWQs
IDMxIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQogICAgPg0KICAgID4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0cyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0cw0KICAg
ID4gaW5kZXggZjhlN2I3MWFmN2U2Li41OGJiZTA4ZDNiYTcgMTAwNjQ0DQogICAgPiAtLS0gYS9h
cmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLXRpb2dhcGFzcy5kdHMNCiAgICA+
ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0
cw0KICAgID4gQEAgLTIxLDYgKzIxLDI1IEBADQogICAgPiAgICAgICAgIG1lbW9yeUA4MDAwMDAw
MCB7DQogICAgPiAgICAgICAgICAgICAgICAgcmVnID0gPDB4ODAwMDAwMDAgMHgyMDAwMDAwMD47
DQogICAgPiAgICAgICAgIH07DQogICAgPiArDQogICAgPiArICAgICAgIGlpby1od21vbiB7DQog
ICAgPiArICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJpaW8taHdtb24iOw0KICAgID4gKyAg
ICAgICAgICAgICAgIG9lbW5hbWUwID0gIk1CX1AzVjMiOw0KICAgID4gKyAgICAgICAgICAgICAg
IG9lbW5hbWUxID0gIk1CX1A1ViI7DQogICAgPiArICAgICAgICAgICAgICAgb2VtbmFtZTIgPSAi
TUJfUDEyViI7DQogICAgPiArICAgICAgICAgICAgICAgb2VtbmFtZTMgPSAiTUJfUDFWMDUiOw0K
ICAgID4gKyAgICAgICAgICAgICAgIG9lbW5hbWU0ID0gIk1CX1BWTk5fUENIX1NUQlkiOw0KICAg
ID4gKyAgICAgICAgICAgICAgIG9lbW5hbWU1ID0gIk1CX1AzVjNfU1RCWSI7DQogICAgPiArICAg
ICAgICAgICAgICAgb2VtbmFtZTYgPSAiTUJfUDVWX1NUQlkiOw0KICAgIA0KICAgICJvZW1uYW1l
IiBpc24ndCBwYXJ0IG9mIHRoZSB1cHN0cmVhbSBiaW5kaW5ncy4gSXMgdGhpcyBzb21ldGhpbmcg
eW91DQogICAgaGF2ZSBwYXRjaGVzIGZvcj8NClRoaXMgaXMgYSB3b3JrYXJvdW5kIGZpZWxkIHVz
ZWQgYnkgZGJ1cy1zZW5zb3JzIGFwcGxpY2F0aW9uIHRvIGF2b2lkIG92ZXJsYXkgZm9yIGR5bmFt
aWMgZGV0ZWN0aW9uIG9mIGRldmljZXMgYmFzZWQgb24ganNvbiBmaWxlIGRlZmluaXRpb24uDQoN
CkNhbiB5b3UgcGxlYXNlIGFsc28gcmV2aWV3IG90aGVyIDMgcGF0Y2hlcyBpbiB0aGlzIHNlcmll
cy4NCiAgICANCg0K
