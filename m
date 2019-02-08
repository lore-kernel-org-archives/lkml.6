Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155FCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D121121924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yTxeSvjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfBHK04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:26:56 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:26961 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBHK0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:26:55 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="27426744"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 08 Feb 2019 03:26:54 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 8 Feb 2019 03:26:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0gppNkUUic/CHm4Jf5aDzQFGVrSiUa22TsiGG6GuLY=;
 b=yTxeSvjVAasjzsl6G1zC2YLNbMfQ1vIZmw4l0Dv2cu+eObS1JmjUnyexN9x7FFJIy0ooT6FX6x/CD/D5Kv4Llin8JbViegcEJirVvvqytgl8rswrUFiqpZFihCg25ie71URfdQLhM8aWGB8VRLaIl3LuR5/KymgUCscw6tRuU5s=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1825.namprd11.prod.outlook.com (10.175.100.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Fri, 8 Feb 2019 10:26:53 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Fri, 8 Feb 2019
 10:26:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <beanhuo@micron.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <bbrezillon@kernel.org>
Subject: Re: [PATCH] include: mtd: spi-nor: change HWCPAS to HWCAPS
Thread-Topic: [PATCH] include: mtd: spi-nor: change HWCPAS to HWCAPS
Thread-Index: AdS+60iqy/bLyT9iSLSC+lMdoEdfvQArYGaA
Date:   Fri, 8 Feb 2019 10:26:53 +0000
Message-ID: <f167ad30-2a15-e430-1a6e-d1e1ba455b67@microchip.com>
References: <BYAPR08MB45338B3B9FE13B8FB3070789DB680@BYAPR08MB4533.namprd08.prod.outlook.com>
In-Reply-To: <BYAPR08MB45338B3B9FE13B8FB3070789DB680@BYAPR08MB4533.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0041.eurprd09.prod.outlook.com
 (2603:10a6:802:1::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1825;6:oIoqu3IXxi3IcXAuYknrdMmSTlX7B0sV3RaJUDx23tS2wucN6uTPos/IZ3B6MoAg4ExrFRuYb9h5gVGm94h4RNEDl3NA74JACFkLVRaeXSzjPO6G9d/6LNl6sKSOLGofpP1GpS4oBZbhh2/RSVCfe1BqCzDEcoG5wzk/2HcaHqq1RAo+Ilz2H7Sg2vQfa4JsuWPWFfmcGFBYbXqFVVf/+12J5FBbw8KHc62R3BMZI76bgeNfEFV89A1VF/ursSwRi3w8PE904uY76f/A1kh+1hhnIG+ehKUywK6csEYFt6CuSEwsCg9QZmtvUSwIK102fuFFg4pnhfLo7cpkEBvtPXJbvvZvQACzt6oVvdZsJAYYm2sQ8IAaqhy90+lKTIdhE/FKs/E7tRIRmmALWZOvDVtFY+SNeaSGkd5Mzv5AWYAWJpGOBvJBLSUqEjKv4nMdbNsMaVtiCB54F6sSIi0Ycg==;5:q5uevCYoI9TypPiy2KgAQGyLn5BX5aP6f5R2W71Dw8kn3gniNROIEZjj9NyXFDbdMgPVLnQlVH9Z1hXBcUekO7evu+x20KUQI8JghDmRm3/6o0eOWoxI3hJl737pPQJHRrRduKgxn+0Jw/+riSHCnUELYamAT86DlUixRIoKY2HnT16lsbrgI1mjS6aDRfsmz3jIy50T4LYpdwWAbweH3Q==;7:PCbh33/1RiObphktPA7wMsGMnGjKxvOKAdV6nd1NPVW987mpgPEQ36SU8weSATWZ5Os4g6NtlVvR0uFiVnMOULHUGigCXYszBfXS0xm81ZbGQA6+zHtCR+EFnfefK5FN8oOX2TBLi7VUT65hwNiFZQ==
x-ms-office365-filtering-correlation-id: eec59f52-b432-407e-9a5e-08d68daff184
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1825;
x-ms-traffictypediagnostic: BN6PR11MB1825:
x-microsoft-antispam-prvs: <BN6PR11MB18256D174A89DD86F71008E5F0690@BN6PR11MB1825.namprd11.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(8936002)(86362001)(2501003)(68736007)(6116002)(305945005)(7736002)(3846002)(256004)(81166006)(478600001)(14444005)(8676002)(53936002)(81156014)(476003)(31696002)(2906002)(25786009)(6512007)(76176011)(486006)(66066001)(97736004)(446003)(11346002)(52116002)(6246003)(36756003)(99286004)(2616005)(6506007)(386003)(229853002)(14454004)(4326008)(316002)(54906003)(71200400001)(6486002)(53546011)(106356001)(110136005)(6436002)(31686004)(26005)(71190400001)(186003)(105586002)(102836004)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1825;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SutvLkHgwzwpeb7N5Fc5yGA2ArwhMkOzTzsa2wn69oCVQrvb8jng6q1NbXwM3scTfYYYkYND4LmnzGZ+eh1FZTDGpT4OMuXeBvIwFVVFVypWYGH7ggn03fD4xn3Y7UVTw8oWkaVFsjCJHwpoyICD9J6VcGGwlrR7SqxT4QOEQw/IOPjqfjDoAcXxdlI2oM+gxJEe9l8628cgSq3hHw48CdWkDssAuc5kSH8PfHnOor1WrlAfWvmXwqomu9Ri9tm1/Qi9X318llYjGcrB3hKBZfsNjkdFpiUNmVRL7TV+eLOOFuJC+MqMtCLDg5G7BbLmF/f/P+tzD9+TRZ/hGv0DOLCJNMH8PmyhNRybAIgjXvDXpsWb+ELq1OpjDabmJaRavZ8eOWbfdHRsZTIdVzKhTyRqtsln06rWq8knh5azda8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D309B3B340C2848BA8FC6EB9B253756@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eec59f52-b432-407e-9a5e-08d68daff184
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 10:26:51.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1825
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJlYW4sDQoNClNOT1JfSFdDUEFTX1JFQURfT0NUTyB3YXMgcmVuYW1lZCB0byBTTk9SX0hX
Q1BBU19SRUFEX09DVEFMIHBsZWFzZSB1cGRhdGUgeW91cg0KcmVtb3RlIGFuZCBzZW5kIGEgbmV3
IHBhdGNoLg0KDQpUaGUgcGF0Y2ggcHJlZml4IGlzIHdyb25nLCBpdCBzaG91bGQgYmUgcHJlZml4
ZWQgd2l0aCAibXRkOiBzcGktbm9yOiIuIFdoZW4gaW4NCmRvdWJ0LCB5b3UgY2FuIGNoZWNrIGhv
dyB3ZXJlIHByZWZpeGVkIHByZXZpb3VzIHBhdGNoZXMgb24gdGhlIHNhbWUgZmlsZSBieQ0KcnVu
bmluZyBzb21ldGhpbmcgbGlrZToNCg0KZ2l0IGxvZyAtLW9uZWxpbmUgaW5jbHVkZS9saW51eC9t
dGQvc3BpLW5vci5oDQoNCk9uIDAyLzA3LzIwMTkgMDM6NDYgUE0sIEJlYW4gSHVvIChiZWFuaHVv
KSB3cm90ZToNCj4gDQoNClRoaXMgbG9va3MgbGlrZSBhIGJsYW5rIGxpbmUsIGl0J3Mgbm90IG5l
ZWRlZCwgcmVtb3ZlIGl0IHBsZWFzZS4NCj4gTWF5YmUgdGhpcyBpcyB3cm9uZyBhYmJyZXZpYXRp
b24sIGNoYW5nZSBmcm9tIEhXQ1BBUyB0byBIV0NBUFMuDQoNCkluZGVlZCwgaXQgaXMsIHVzZSBp
bXBlcmF0aXZlLCBzb21ldGhpbmcgbGlrZTogIkZpeCB3cm9uZyBhYmJyZXZpYXRpb24sDQpzL0hX
Q1BBUy9IV0NBUFMiDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZWFuIEh1byA8YmVhbmh1b0BtaWNy
b24uY29tPg0KDQpZb3VyIFMtby1iIHRhZyBkb2Vzbid0IG1hdGNoIHRoZSBhdXRob3IgbmFtZSwg
cGxlYXNlIGZpeCB0aGlzIGFzIHdlbGwuDQoNCkNoZWVycywNCnRhDQoNCj4gLS0tDQo+ICBpbmNs
dWRlL2xpbnV4L210ZC9zcGktbm9yLmggfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L210ZC9zcGktbm9yLmggYi9pbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCj4gaW5kZXggZmEy
ZDg5ZS4uNWUxMmJmOSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5o
DQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaA0KPiBAQCAtNDc5LDcgKzQ3OSw3
IEBAIHN0cnVjdCBzcGlfbm9yX2h3Y2FwcyB7DQo+ICAjZGVmaW5lIFNOT1JfSFdDQVBTX1JFQURf
NF80XzQJCUJJVCg5KQ0KPiAgI2RlZmluZSBTTk9SX0hXQ0FQU19SRUFEXzFfNF80X0RUUglCSVQo
MTApDQo+ICANCj4gLSNkZWZpbmUgU05PUl9IV0NQQVNfUkVBRF9PQ1RPCQlHRU5NQVNLKDE0LCAx
MSkNCj4gKyNkZWZpbmUgU05PUl9IV0NBUFNfUkVBRF9PQ1RPCQlHRU5NQVNLKDE0LCAxMSkNCj4g
ICNkZWZpbmUgU05PUl9IV0NBUFNfUkVBRF8xXzFfOAkJQklUKDExKQ0KPiAgI2RlZmluZSBTTk9S
X0hXQ0FQU19SRUFEXzFfOF84CQlCSVQoMTIpDQo+ICAjZGVmaW5lIFNOT1JfSFdDQVBTX1JFQURf
OF84XzgJCUJJVCgxMykNCj4gDQo=
