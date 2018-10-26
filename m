Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCDBECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E340520848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rZwYY45r";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BAbnhayw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E340520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJ0B6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:58:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49470 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726113AbeJ0B6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:58:06 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9QHA6Iv024635;
        Fri, 26 Oct 2018 10:20:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Ywgg3GtLWHp9rB/Si7eOADJz2/NE3JPHN4ncG9cyZgc=;
 b=rZwYY45rxmZxWRbN2q1vwHzYQ0m7K1mrE86JCCjEJEiz/+O7oJwBhWe0b7jMRnJ/qqiY
 IlFHeD9tKuIQ/szpUDM43zd4vwqvQS5SQ7Ft6SlvNqy8vBJdygTDpnyRVhdimOCynr5H
 reYYvb+AXghJkquULTP17JHwSGZo+Sz0n/M= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nc4arrju9-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Oct 2018 10:20:08 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 26 Oct 2018 10:19:51 -0700
Received: from FRC-CHUB05.TheFacebook.com (2620:10d:c021:18::24) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 26 Oct 2018 10:19:51 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 26 Oct 2018 13:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywgg3GtLWHp9rB/Si7eOADJz2/NE3JPHN4ncG9cyZgc=;
 b=BAbnhaywTnQlxgYU9zn+wLaXa0DkE1yetG32EGqW9LFwKTQAjzKXatDbwrf/1+BjdtLWn4ZcDbSq+OQCkwksNOE04JZ43Z1AZRowTeYcbX2RjLdbF8L+iISt7d7dVzTHprCQR9DONjoZksplYQtHkBL9wkW6RtEWbTCYEe96hSs=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1944.namprd15.prod.outlook.com (10.172.181.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Fri, 26 Oct 2018 17:19:49 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::ec34:3b6a:58ac:e1f2]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::ec34:3b6a:58ac:e1f2%7]) with mapi id 15.20.1250.028; Fri, 26 Oct 2018
 17:19:49 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     David Miller <davem@davemloft.net>
CC:     "sam@mendozajonas.com" <sam@mendozajonas.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "Justin.Lee1@Dell.com" <Justin.Lee1@Dell.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH net-next] net/ncsi: Add NCSI Mellanox OEM command
Thread-Topic: [PATCH net-next] net/ncsi: Add NCSI Mellanox OEM command
Thread-Index: AQHUbK68fT9fJ5/1+UWKPBgJowuNkKUwkcGAgAC/ugA=
Date:   Fri, 26 Oct 2018 17:19:49 +0000
Message-ID: <F0024535-93C3-4470-98A6-F57426587474@fb.com>
References: <20181025220413.2936698-1-vijaykhemka@fb.com>
 <20181025.155335.2132843393553452471.davem@davemloft.net>
In-Reply-To: <20181025.155335.2132843393553452471.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::6:75b9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1944;20:Cd5HHiguPpYKZqyBj5zIAn0/7ExWKJnYqvaHXxdyGi21JjvIBCkD/Lh2qnHDQPyeA/4/PA5xoAXx60mW1HaTUS5tVwrGdJOZcxFDTO0wf54eIeEu1IomA8aqMk3+Xx+ZrwFypI2X/BrX6XgEqYoqweK+AMd4oRjFBFlX6N8GGkc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f0266bf7-6607-460e-1f3e-08d63b673bea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1944;
x-ms-traffictypediagnostic: CY4PR15MB1944:
x-microsoft-antispam-prvs: <CY4PR15MB19444B5738C31F74CD730369DDF00@CY4PR15MB1944.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1944;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1944;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(106356001)(105586002)(2900100001)(316002)(5250100002)(6116002)(86362001)(33656002)(54906003)(36756003)(97736004)(53936002)(14454004)(446003)(68736007)(486006)(6246003)(2616005)(11346002)(6436002)(476003)(186003)(229853002)(6486002)(46003)(6512007)(5660300001)(8676002)(305945005)(83716004)(71190400001)(256004)(71200400001)(7736002)(81156014)(81166006)(82746002)(8936002)(2906002)(25786009)(4326008)(102836004)(6506007)(76176011)(6916009)(99286004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1944;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n43qenTGKnTJWvccObsqPQlQKc8fcHpQKA56ab5HBEsKPoTMtPjdxOW0qpyvGavW5DJvrEJ1D+JCwyAfjENZhkxSxO1xlUrmlbcLIlimfNSkrVBdvSlz9shmMOWyumixVqoco0dCNw7/EqUWI2iZHPEHshiAc3LulmrCpJIfMT6nqwYcyq54qbNkKhQvhbq34yOznyHuAbdo8+g3xPLheeImyTUnoa5/t7cXzLz4eobexvNbjYUOYtvHN0bPx7Fmae2G2EnqezoMeq1iuI/WS1p/ZihccxxTu5LG1sbGY7SQzdp+0+3fnCTh/T48LHaLEjairDaTqZv5C9ccCnZEiu8TdvquMVMRpNhxi8jaFcA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <52CD26BC41573E42A2A2393EA6B71597@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f0266bf7-6607-460e-1f3e-08d63b673bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 17:19:49.1279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1944
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-26_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIERhdmlkLA0KRG8geW91IGhhdmUgYW55IHRpbWVsaW5lIHdoZW4gaXQgaXMgZ29pbmcg
dG8gb3BlbiBuZXh0IG9yIGhvdyBkbyBJIGtub3cuDQoNClJlZ2FyZHMNCi1WaWpheQ0KDQrvu79P
biAxMC8yNS8xOCwgMzo1NCBQTSwgIkRhdmlkIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+
IHdyb3RlOg0KDQogICAgRnJvbTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+DQog
ICAgRGF0ZTogVGh1LCAyNSBPY3QgMjAxOCAxNTowNDoxMyAtMDcwMA0KICAgIA0KICAgID4gVGhp
cyBwYXRjaCBhZGRzIE9FTSBNZWxsYW5veCBjb21tYW5kcyBhbmQgcmVzcG9uc2UgaGFuZGxpbmcu
IEl0IGFsc28NCiAgICA+IGRlZmluZXMgT0VNIEdldCBNQUMgQWRkcmVzcyBoYW5kbGVyIHRvIGdl
dCBhbmQgY29uZmlndXJlIHRoZSBkZXZpY2UuDQogICAgPiANCiAgICA+IG5jc2lfb2VtX2dtYV9o
YW5kbGVyX21seDogVGhpcyBoYW5kbGVyIHNlbmQgTkNTSSBtZWxsYW5veCBjb21tYW5kIGZvcg0K
ICAgID4gZ2V0dGluZyBtYWMgYWRkcmVzcy4NCiAgICA+IG5jc2lfcnNwX2hhbmRsZXJfb2VtX21s
eDogVGhpcyBoYW5kbGVzIHJlc3BvbnNlIHJlY2VpdmVkIGZvciBhbGwNCiAgICA+IG1lbGxhbm94
IE9FTSBjb21tYW5kcy4NCiAgICA+IG5jc2lfcnNwX2hhbmRsZXJfb2VtX21seF9nbWE6IFRoaXMg
aGFuZGxlcyBnZXQgbWFjIGFkZHJlc3MgcmVzcG9uc2UgYW5kDQogICAgPiBzZXQgaXQgdG8gZGV2
aWNlLg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hl
bWthQGZiLmNvbT4NCiAgICANCiAgICBuZXQtbmV4dCBpcyBjbG9zZWQsIHBsZWFzZSByZXN1Ym1p
dCB0aGlzIHdoZW4gdGhlIG5ldC1uZXh0IHRyZWUgb3BlbnMNCiAgICBiYWNrIHVwLg0KICAgIA0K
ICAgIFRoYW5rIHlvdS4NCiAgICANCg0K
