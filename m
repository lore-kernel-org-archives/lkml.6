Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B5AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F379321531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bkzHwcxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F379321531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbeITV1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:27:55 -0400
Received: from mail-by2nam01on0083.outbound.protection.outlook.com ([104.47.34.83]:63136
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732673AbeITV1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UNPU4nlotRa2OOYJCeO7oNOvcC37B02sUGqzEH5E/4=;
 b=bkzHwcxPlmcIJx1tUI+ZGFxUXPYzU/XyKYnR6U7QRcxhaRI5OnArGrvGRijJaW/ZNWZrjE/N72NcqIPPhie3uSRSo/jMGYkPazRIfhUZkiY0ebvZJTkFxUEliigbPnF6G1Knb/qKhg9Kb+TPvlfErHMj3q9NcjE4Iw7LOD2EM30=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2830.namprd12.prod.outlook.com (20.177.250.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 15:43:49 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::5dfa:d467:f32:4d51]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::5dfa:d467:f32:4d51%4]) with mapi id 15.20.1143.019; Thu, 20 Sep 2018
 15:43:49 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Hook, Gary" <Gary.Hook@amd.com>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH 1/2] Fix static checker warning
Thread-Topic: [PATCH 1/2] Fix static checker warning
Thread-Index: AQHUTHrdKH6c0cCINUiex5Ey6ioQpKT3o86AgAAEswCAAa/2gA==
Date:   Thu, 20 Sep 2018 15:43:48 +0000
Message-ID: <7aa02bf8-8813-98e5-6729-af4ae63da7d0@amd.com>
References: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
 <31c49295223e51f5c1c4e36e7a09fe100dab1711.1536959537.git.Janakarajan.Natarajan@amd.com>
 <8dfca0f4-6639-3444-148f-eb0b0817fec6@amd.com>
 <20180919135741.5icpyesntcfbgtcr@mwanda>
In-Reply-To: <20180919135741.5icpyesntcfbgtcr@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:404:8e::15) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2830;20:hX9yWODLv0fuEjFMrfyl89UDCAh9qIq5QMvXoxHKQFuhvwXvTxiajeT1IgMbW8Q/pY5JafIs/07gFpvc1MHlWkTOIOBKSkAQ0gs6v+qWBDNjZBr/0VrAftwCm0fIldIkamG1drEHezbdHTM7v3mMz+qWkho9kd8tjIwylPAiCtn3YX7pvDzluMO2U8PpTLJSVF7C3MMAAAkipRAgvQrCyh1bpAzyNNU3/uDZuVb4/8xJgU+/zaxeVjIujw6pn6+m
x-ms-office365-filtering-correlation-id: aaa5601e-cd92-417d-669b-08d61f0fdb4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2830;
x-ms-traffictypediagnostic: SN6PR12MB2830:
x-microsoft-antispam-prvs: <SN6PR12MB2830B49A07D8FA136F6AC401E7130@SN6PR12MB2830.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:SN6PR12MB2830;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2830;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(366004)(376002)(199004)(189003)(2616005)(6116002)(76176011)(7736002)(446003)(86362001)(105586002)(316002)(26005)(6486002)(8676002)(6636002)(54906003)(256004)(110136005)(6436002)(229853002)(5660300001)(97736004)(305945005)(81156014)(72206003)(25786009)(53546011)(386003)(11346002)(99286004)(14454004)(68736007)(478600001)(52116002)(31696002)(476003)(186003)(102836004)(81166006)(93886005)(2900100001)(486006)(6246003)(8936002)(5250100002)(2906002)(6506007)(4326008)(31686004)(106356001)(6512007)(53936002)(36756003)(3846002)(66066001)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2830;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CWpdIwhEi70INCSEICkL0ubYorVtyLSFaOHWmMR+CDnOcGtq2liQBKFKxbX2W20l5UXSa/15Qy9DI7BMWcxV91+iPUo+QXM2HsZIyxS92UMsZqsc8IYvN13yrCrLa6K/6dxOH5BALrIlrF1wdxdtn+r+mHje5HtOvT+ru+5TyAfxxms4YqEu/hoCN2mL/olQ46yZP1KTrX6QaMIHVZUcVtOG3+eqrPjwUwrmiSQp9m6i7knT2snz2XKb/H7SPl8fkldZh4lTn+nbeDZnwTLI04iVTZ+dLmWWUFs2ElPDBidRo79/z0+yj0d4GdtxVx2MyF+0E1yKD91ypV+IW/Q/OACqtUW67G3qagYHHijJJ6E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <204A5A755F5C124CA257A74B32CF0552@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa5601e-cd92-417d-669b-08d61f0fdb4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 15:43:48.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xOS8yMDE4IDg6NTcgQU0sIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IFNvdW5kcyByZWFz
b25hYmxlLiAgVGhlIHN1YmplY3QgbmVlZHMgYSBzdWJzeXN0ZW0gcHJlZml4IGFuZCBpdCBtaWdo
dA0KPiBiZSBiZXR0ZXIgdG8gbWFrZSBpdCBtb3JlIHNwZWNpZmljLiAgTGlrZSBzbzoNCj4NCj4g
W1BBVENIIDEvMl0gY3J5cHRvOiBjY3AgLSBwb3RlbnRpYWwgdW5pbml0aWFsaXplZCB2YXJpYWJs
ZQ0KDQpJJ2xsIHB1dCBvdXQgYSB2MiB3aXRoIHRoZSBzdWJqZWN0cyBmaXhlZC4NCg0KVGhhbmtz
Lg0KDQo+DQo+IEkgZG9uJ3Qga25vdyBpZiBIZXJiZXJ0IGZpeGVzIHRob3NlIHRoaW5ncyB1cCBo
aW1zZWxmIG5vcm1hbGx5Pw0KPg0KPiByZWdhcmRzLA0KPiBkYW4gY2FycGVudGVyDQo+DQoNCg==
