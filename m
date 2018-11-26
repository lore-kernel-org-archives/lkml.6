Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF85AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5135D2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="k3UbkV6p";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SQlwRk41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5135D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeK0ITE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:19:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbeK0ITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:19:03 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAQLIKJ4005066;
        Mon, 26 Nov 2018 13:23:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zDk1WyIF3PcQBmZqndPCprcP1TjB8AiWDMU4J/WHJI0=;
 b=k3UbkV6pSd5Iqeu7A09tfP05+LsP1JltEZKY3rDRZNqaSOcHWjPUCtgnXnVUfjo6y+fH
 OIBqMrBjGQIQX9KVtg5yjR526mV3o4Zqs0guksprGbIjZgjIQgDvXNQTcSCqvfrC7O/f
 O6HD2TCOPJ6cCcn6go+n7dmZFpO9JK/nYgM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p0rjp8141-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Nov 2018 13:23:22 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 26 Nov 2018 13:23:13 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 26 Nov 2018 13:23:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDk1WyIF3PcQBmZqndPCprcP1TjB8AiWDMU4J/WHJI0=;
 b=SQlwRk41heidtk6y9MWNYOlBwRTzbaEGh7m3Q3duOhUySGPOV3fxsvf+sIjl6xf7bTCWurukmVc5tF5tlI6MSQY0WxX7hciCKjLy6WZ18IbDVWCXEEMtXDYkh7hbub3ng7/mCTqv4efwGA3h4AuP3vOLN+b4Z/sDNISqc2aCePQ=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1637.namprd15.prod.outlook.com (10.175.119.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Mon, 26 Nov 2018 21:23:11 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::19df:d934:b961:5442]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::19df:d934:b961:5442%5]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 21:23:11 +0000
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
Thread-Index: AQHUgRCoGYkM0A+mg0yjPgjXvLLIkqVa+TkAgAca/wA=
Date:   Mon, 26 Nov 2018 21:23:10 +0000
Message-ID: <D0F6A4CE-9BBB-45E2-8915-D02438FBFAB8@fb.com>
References: <20181120203516.3460764-1-vijaykhemka@fb.com>
 <20181121.165244.777667590099933299.davem@davemloft.net>
In-Reply-To: <20181121.165244.777667590099933299.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::7:41c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1637;20:ZSe/lvUzaBpjxfJrzW/q6wv01EgOyGF3HdjKnGOfSDKDjovmDTO0yiL/DvGSyS8iJ7ip9GX1xbBCs9GKj4LgtD81uSOzWPJ8MAAw6/7+WYebFNqzgfFlFrarGbDNBVsQdOQJ7mXtxetw5tQCI4dyyD2gz5X5mIKWQTxdtCQj9+k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4affa4b2-77a8-43e3-601d-08d653e55e17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1637;
x-ms-traffictypediagnostic: CY4PR15MB1637:
x-microsoft-antispam-prvs: <CY4PR15MB1637C0F8C79AD7870002BF27DDD70@CY4PR15MB1637.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231443)(11241501185)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1637;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1637;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(36756003)(6436002)(54906003)(6486002)(316002)(97736004)(6506007)(6116002)(2906002)(11346002)(6246003)(53936002)(6512007)(102836004)(25786009)(14454004)(2616005)(5660300001)(486006)(4326008)(33656002)(83716004)(71200400001)(71190400001)(76176011)(305945005)(7736002)(106356001)(8936002)(186003)(68736007)(105586002)(256004)(86362001)(82746002)(6916009)(81166006)(81156014)(478600001)(99286004)(8676002)(476003)(446003)(46003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1637;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Arjy3oPWARfcW5JNXB6Rb37GWjT9zqwggQOlOAKiTAAJj4NMOpj2Moy8aNHTxTuNfmJkhTMbY6Vy7irKokc0jN583/qhzdWAbXcqsKNXQjXqZ++tlFz2y49bTMLj3YdYT7cbAv9W++zXz/GFKEuLqTfoSBdtasafwJLLbrlt/Tu3wqGjSRFrlfqXUR3RJv7elnHDxH1OpYvDaQeuRq10sHd9i5J86rdP568h8Q7ss9lA1eP/gPD8fYH1/F70tL1AmekX61zHAlQjHgxpMZnXUXvfl731g6TLWvibeEkEeT5rN3DxF8ZOaLu/8xzwBn1XlJlslYKHLOTMyrldKTiA592I1+5H/aW3UMV7fFKAOtI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE53CB4067D0B24387EE590E79B9170D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4affa4b2-77a8-43e3-601d-08d653e55e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 21:23:10.8608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1637
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIERhdmlkLA0KSSB3aWxsIGZpeCB0aGlzIGFuZCB1cGxvYWQgbmV4dCB2ZXJzaW9uLg0K
DQpSZWdhcmRzDQotVmlqYXkNCg0K77u/T24gMTEvMjEvMTgsIDQ6NTUgUE0sICJEYXZpZCBNaWxs
ZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0PiB3cm90ZToNCg0KICAgIEZyb206IFZpamF5IEtoZW1r
YSA8dmlqYXlraGVta2FAZmIuY29tPg0KICAgIERhdGU6IFR1ZSwgMjAgTm92IDIwMTggMTI6MzU6
MTYgLTA4MDANCiAgICANCiAgICA+ICtzdGF0aWMgaW50IG5jc2lfb2VtX2dtYV9oYW5kbGVyX21s
eChzdHJ1Y3QgbmNzaV9jbWRfYXJnICpuY2EpDQogICAgPiArew0KICAgID4gKwl1bnNpZ25lZCBj
aGFyIGRhdGFbTkNTSV9PRU1fTUxYX0NNRF9HTUFfTEVOXTsNCiAgICA+ICsJaW50IHJldCA9IDA7
DQogICAgPiArDQogICAgPiArCW5jYS0+cGF5bG9hZCA9IE5DU0lfT0VNX01MWF9DTURfR01BX0xF
TjsNCiAgICA+ICsNCiAgICA+ICsJbWVtc2V0KGRhdGEsIDAsIE5DU0lfT0VNX01MWF9DTURfR01B
X0xFTik7DQogICAgPiArCSoodW5zaWduZWQgaW50ICopZGF0YSA9IG50b2hsKE5DU0lfT0VNX01G
Ul9NTFhfSUQpOw0KICAgIA0KICAgICdkYXRhJyBpcyBub3QgbmVjZXNzYXJpbHkgYWxpZ25lZCBv
biBhbiB1bnNpZ25lZCBpbnQgYm91bmRhcnkuDQogICAgDQogICAgQnV0IHNlY29uZCBvZiBhbGwg
eW91IHdhbnQgdG8gdXNlIGEgZml4ZWQgc2l6ZSB0eXBlIGxpa2UgInUzMiIgb3INCiAgICBzaW1p
bGFyIGhlcmUsIG5vdCAidW5zaWduZWQgaW50Ii4NCiAgICANCiAgICBBbHRvZ2V0aGVyLCBzb21l
dGhpbmcgbGlrZToNCiAgICANCiAgICAJdW5pb24gew0KICAgIAkJdTggZGF0YV91OFtOQ1NJX09F
TV9NTFhfQ01EX0dNQV9MRU5dOw0KICAgIAkJdTMyIGRhdGFfdTMyW1tOQ1NJX09FTV9NTFhfQ01E
X0dNQV9MRU4gLyBzaXplb2YodTMyKV07DQogICAgCX0gdTsNCiAgICANCiAgICAJbWVtc2V0KCZ1
LCAwLCBzaXplb2YodSkpOw0KICAgIAl1LmRhdGFfdTMyWzBdID0gbnRvaGwoTkNTSV9PRU1fTUZS
X01MWF9JRCk7DQogICAgCXUuZGF0YV91OFs1XSA9IE5DU0lfT0VNX01MWF9DTURfR01BOw0KICAg
IAl1LmRhdGFfdThbNl0gPSBOQ1NJX09FTV9NTFhfQ01EX0dNQV9QQVJBTTsNCiAgICANCiAgICBJ
ZiB0aGUgcmVzdCBvZiB0aGUgbmNzaSBkcml2ZXIgaGFzIGNydWQgbGlrZSB0aGlzLCBpdCBhbGwg
bmVlZHMNCiAgICB0byBiZSBmaXhlZCB1cCBzaW1pbGFybHkuDQogICAgDQoNCg==
