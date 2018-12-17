Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78C5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9E22133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hfKN3il5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbeLQQcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:32:14 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:10179 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbeLQQcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:32:14 -0500
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="25353860"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 09:32:13 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 09:32:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck16cDJn+JlKhxwedGFWv52l3YgBXVInFrL8IxgH3qk=;
 b=hfKN3il5L5/HsQJmwTxC27i1c1LGCmmyfFIg+HSDdxla+Fs0qSaiHR9nLa0Ith6irVx+OPHCBGjR0Yq/xpA+sacg3BxBY2/ZThbQEX1dZOoEuondJRmk/Ac1mCcTmpSFBI/N92psy2Q5JLEtVp9+adJzmGDPEX8gR9wGuiF6nag=
Received: from BYAPR11MB2855.namprd11.prod.outlook.com (52.135.228.141) by
 BYAPR11MB3477.namprd11.prod.outlook.com (20.177.187.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Mon, 17 Dec 2018 16:32:11 +0000
Received: from BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::1137:d81d:de30:c394]) by BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::1137:d81d:de30:c394%4]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 16:32:10 +0000
From:   <Don.Brace@microchip.com>
To:     <mironov.ivan@gmail.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <don.brace@microsemi.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <esc.storagedev@microsemi.com>
Subject: RE: [PATCH 0/6] Add support of the HBA mode on HP Smart Array P410i
 controllers
Thread-Topic: [PATCH 0/6] Add support of the HBA mode on HP Smart Array P410i
 controllers
Thread-Index: AQHUk7AP2GWqzt2GdE2cof/UTeWSraV+oF0ggAAP3ACAABdpQA==
Date:   Mon, 17 Dec 2018 16:32:10 +0000
Message-ID: <BYAPR11MB285502EFDD672C228F9FFB73E1BC0@BYAPR11MB2855.namprd11.prod.outlook.com>
References: <20181214132115.21440-1-mironov.ivan@gmail.com>
         <BYAPR11MB285586623125DD1C98EE87F1E1A10@BYAPR11MB2855.namprd11.prod.outlook.com>
 <449fb880e94d478fb35e01da93c5b1fa1732f7d8.camel@gmail.com>
In-Reply-To: <449fb880e94d478fb35e01da93c5b1fa1732f7d8.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Don.Brace@microchip.com; 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR11MB3477;6:j/k8FzMv6mnDqqE21uhsJbzI0kv+UBus8dDdgcm257yAkCGLEuQfEj6CrN18gV+xnmw1S+P/CnjcUgzrDJxC389a14OKbALmeyQ3T+nNKfKJk9dhJPflYgDk9A72xhOzaoMl3Ak0cB0VtvfIGnejcUU45PMIqzI0qoL6mdAK+ztxjli15/qFpc5c71A6obQRISShBvGDLgJPsy6QxztLbx4HQKnzNRcoSZ9GSgHiTTZZ09uiTJRjmckppuznlM2X7PAAhOLanbUjYOrh5Pq6dJmtqMYrps1afDrZWdc0bUvbg3EjiNY1wgAv1jTT46qSYYhKMjS2x89VZslBgfhR2KUlkm5U2KWqZ704G+0KBL6vE91kHKz1duyv8fCtiZcoroxR/fjnJKHD4miMvO+gWYO61URufPxAb1Dj7qDGj12/RZisM1ftpJVRDMn5MFek+mEs8nWeT5Ez2W3HMwa9ig==;5:P7fTaMAetmS0yReOCZPuO8OeW8cXmxAiv55YG2bJHDEDo1QANhZkU650BGBP55fUY5I4ndQ/UzXrQDr1gW8taApucVPjBHO4ulNNtMZEefi6AwLGrk1N42OLBM3M/rbMbdGoLL7n6E88ISMkxs1SkY/t+h0YtNhJI6hFn/1b0QQ=;7:DExuPpvBYZBpWMvo+1vOyeHdRVKp6uUxfAqUAaTuFJBlB/g0kjHaElunq2fyCooUfK4Jo4drt3AVl5J6lrDsqRo4nybhu8y2YXb1beS3WX6E3U28XwMMeLE/Jmw64aAbSlID+mBbgYMVPlTGrvSD/Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fd0ac375-52c1-4ec6-51d0-08d6643d31be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB3477;
x-ms-traffictypediagnostic: BYAPR11MB3477:
x-microsoft-antispam-prvs: <BYAPR11MB3477A6BF85D4609219E31516E1BC0@BYAPR11MB3477.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR11MB3477;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB3477;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(13464003)(189003)(199004)(74316002)(55016002)(9686003)(316002)(2906002)(4326008)(110136005)(8676002)(53936002)(8936002)(86362001)(81166006)(81156014)(39060400002)(6436002)(478600001)(66066001)(229853002)(25786009)(72206003)(54906003)(6246003)(14454004)(106356001)(6506007)(53546011)(102836004)(305945005)(256004)(105586002)(33656002)(5660300001)(2501003)(71190400001)(6116002)(99286004)(3846002)(7736002)(26005)(186003)(486006)(68736007)(476003)(76176011)(97736004)(4001150100001)(71200400001)(7696005)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3477;H:BYAPR11MB2855.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7GTFtoZa+e9koi+Pfl0Rs8vxlvD/Yoqm+FEu2sfLaMu2LaGBpondCDA60gaoRVKRNu9v/N0twx6vOYFk+4LScDKXMjqrJx8lG2yZ1GoRrDRMrZpjp3wtQ9TBnl7u2LAr3gh/KM8obBri4tw00EyxgCMOmoMnVKZ503p5Mdz8fu51beLKGiPcRzHnKt9FTkFK6g9bUTwPcBps0s2ufJ+jCF6wcNhWfdwlLcNrsB3i/Lr4oNKIlMHlh6VlpksOt6uN09coJ9jhUgh303n6TIY4ohgQHKU2humDacM/OLIZbklBBz9JDkW8bkiKg44YDDvu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0ac375-52c1-4ec6-51d0-08d6643d31be
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 16:32:10.7981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3477
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEl2YW4gTWlyb25vdiBbbWFpbHRvOm1p
cm9ub3YuaXZhbkBnbWFpbC5jb21dIA0KU2VudDogRnJpZGF5LCBEZWNlbWJlciAxNCwgMjAxOCAy
OjMwIFBNDQpUbzogRG9uIEJyYWNlIC0gQzMzNzA2IDxEb24uQnJhY2VAbWljcm9jaGlwLmNvbT47
IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnDQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgZG9uLmJyYWNlQG1pY3Jvc2VtaS5jb207IGplamJAbGludXgudm5ldC5pYm0uY29tOyBt
YXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbTsgZXNjLnN0b3JhZ2VkZXZAbWljcm9zZW1pLmNvbQ0K
U3ViamVjdDogUmU6IFtQQVRDSCAwLzZdIEFkZCBzdXBwb3J0IG9mIHRoZSBIQkEgbW9kZSBvbiBI
UCBTbWFydCBBcnJheSBQNDEwaSBjb250cm9sbGVycw0KDQpFWFRFUk5BTCBFTUFJTA0KDQoNCk9u
IEZyaSwgMjAxOC0xMi0xNCBhdCAxOTozOCArMDAwMCwgRG9uLkJyYWNlQG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+IE5BS2luZyB0aGlzIHNlcmllcy4NCj4gLSBUaGUgUDQxMCBjb250cm9sbGVycyBk
byBub3QgZnVsbHkgc3VwcG9ydCBIQkEgbW9kZSBhbmQgd2UgZG8gbm90IHN1cHBvcnQgYWRkaW5n
IGl0IHRvIHRoZSBocHNhIGRyaXZlci4NCj4NCg0KQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGUg
b24gd2hhdCBleGFjdGx5IHlvdSBtZWFuIGJ5ICJkbyBub3QgZnVsbHkgc3VwcG9ydCBIQkEgbW9k
ZSI/DQoNCkRvbj4gSEJBIG1vZGUgbWF5IGhhdmUgc3RhcnRlZCBvbiB0aGlzIGNvbnRyb2xsZXIg
ZmFtaWx5LCBidXQgd2FzIG5vdCBmdWxseSBkZXZlbG9wZWQuDQpEb24+IFJlZ2FyZGxlc3Mgb2Yg
dGhlIHNlcnZlciwgSXQncyBub3QgYSBnZW5lcmljIG9mZmVyaW5nIGFuZCBzaG91bGQgbm90IGJl
IGFjY2VwdGVkIGludG8gdGhlIGdlbmVyYWwgZHJpdmVyIHNwYWNlLg0KRG9uPiBBZGRpbmcgdGhp
cyB0byBrZXJuZWwub3JnIG1lYW5zIGl0IHdpbGwgZmluZCBpdHMgd2F5IGludG8gb3RoZXIgTGlu
dXggdmVuZG9ycyBhbmQgd2UgZG8gbm90IHdhbnQgdGhpcyBlaXRoZXIuDQoNCkhCQSBtb2RlIGxv
b2tzIHN1cHBvcnRlZCBvbiBQNDEwaSAoYXQgbGVhc3QgdG8gc29tZSBkZWdyZWUpIGJlY2F1c2U6
DQoqKSBUaGVyZSBpcyBhbiBvZmZpY2lhbCBtZXRob2QgdG8gZW5hYmxlL2Rpc2FibGUgaXQgb24g
dGhlc2UgY29udHJvbGxlcnMuIE9ubHkgZm9yIGl0YW5pdW0tYmFzZWQgc2VydmVycyB1bmZvcnR1
bmF0ZWx5Lg0KKikgVGhpcyBtZXRob2QgaXMgbWVudGlvbmVkIGluIHZhcmlvdXMgZG9jdW1lbnRz
IGZyb20gSFAgcmVnYXJkaW5nIEludGVncml0eSBzZXJ2ZXJzLg0KKikgQ29udHJvbGxlciByZWFj
dHMgb24gdGhlIGNoYW5nZSBvZiBjb3JyZXNwb25naW5nIGJpdCBpbiBudnJhbV9mbGFncyBieSBp
bW1lZGlhdGVseSByZW1vdmluZyBhbnkgY29uZmlndXJlZCBSQUlEIGFycmF5cyBhbmQgYnkgcmVm
dXNpbmcgdG8gY29uZmlndXJlIG5ldyBhcnJheXMuIFdoaWNoIGlzIHRvdGFsbHkgZXhwZWN0ZWQg
Zm9yIEhCQSBtb2RlLg0KKikgSEJBIG1vZGUgd29ya3MgZm9yIG1lIG9uIFA0MTBpIHdpdGggcGF0
Y2hlZCBkcml2ZXIuDQoNCg==
