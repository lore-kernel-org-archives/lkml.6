Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3418DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4AC20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="juYfxUD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfA1IE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:04:27 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:50310 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726627AbfA1IE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:04:27 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0S81YPJ015963;
        Mon, 28 Jan 2019 02:04:24 -0600
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by mx0a-00010702.pphosted.com with ESMTP id 2q8mf3mrb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 28 Jan 2019 02:04:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tG1SpUm+YoaIgZ0hhZS9vcx0KhTDnfq9IkasXOQtwU=;
 b=juYfxUD9YJZs8qnQ3ecMADfSExhPvg6/81CBNn5kVCrkhtBBGMW4rCTzdXdRr//V7p3sFyX5u5u65LjaZHutMf1l5y+zAo66nwd8E2mlvtSoIbV91NFBtk9GjfF9pZKVYArZTqzYagbm1IzVJbI0QNu/NMweEZGZxlN10RJfMxk=
Received: from SN6PR04MB5424.namprd04.prod.outlook.com (20.177.254.32) by
 SN6PR04MB4335.namprd04.prod.outlook.com (52.135.72.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Mon, 28 Jan 2019 08:04:20 +0000
Received: from SN6PR04MB5424.namprd04.prod.outlook.com
 ([fe80::74f6:70c7:a55f:385b]) by SN6PR04MB5424.namprd04.prod.outlook.com
 ([fe80::74f6:70c7:a55f:385b%6]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 08:04:20 +0000
From:   Guan Yung Tseng <guan.yung.tseng@ni.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 8250_pci.c: Update NI specific devices class to multi
 serial
Thread-Topic: [PATCH] 8250_pci.c: Update NI specific devices class to multi
 serial
Thread-Index: AQHUrBLua4XTvY1a/UGpfEI1uY0mcaW9BboAgAANV4CAB07e0A==
Date:   Mon, 28 Jan 2019 08:04:20 +0000
Message-ID: <SN6PR04MB5424EDB7FAD4C5045A2B206FC1960@SN6PR04MB5424.namprd04.prod.outlook.com>
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
 <CAHp75VcxtSi64qsK6tHx+vtEeRsX3ZVwfzRYOVuyS=qSTnK0qQ@mail.gmail.com>
 <CAHp75Vd+p8d87v_YEkzMLh8sxmvPYk3XeFdkpsrY_jTsC2zHCQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd+p8d87v_YEkzMLh8sxmvPYk3XeFdkpsrY_jTsC2zHCQ@mail.gmail.com>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [211.25.107.114]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4335;6:9GinCyPnR3KIBjxF+w8yq6bMXRWmyc75Og5desntfZLLRCS8aRJu2WGvyf1zesLMjvVhe/3FJeS0c1WsDlYsSY2zuwBG1nnVLPYH3r+ACUd8LMmy6yblhkxvOmt9G+3Sm2hrPrT5IBsGuVIApbxoNNO8+yJEWoOcdhQtzDpes/jthnCIz4tbzt++ifOoiMIpUPiP65DQu93IoYqyFKQb1mTcfKNT4FJVoXZ1GiQdxg8I1znIS8hkXQ2boF34JYv7B/HV9F1QBCqweZSNdA21FoyZhgG8pH/qUbNb2jLtxLrAtl/cLsfLcPEn3k0qdFjf7w+05pcp7YdADkY7fcD9Q3FDVRD+FQjBP6I6dM958GHN1ptyPYENg9ncmSFFvEsw0c02H9IpncBAhSmH75NxVlFTIuNqoDf34BU5xZnAMpUYdZh8TOceS83h86lfQoZ2fZgFYtiHsgWWkWjEzxxiVQ==;5:v3nlwimA/kGPYaaY3H9+v2xfRN4P5LEGVWueJ7SK0qZajLfpVj0edWCB9KSO1VThQlygbnUKpuBHEu+yfwJJ2f7d/1Fd48jtmbvBBQM+iKFJiI+d6PcAyoO30lWfvwi5pjsELW8sBQlQR2AHskIo/Ow71LD1qVuIZmYAHWdaQcfmEAt4IDwODV3jptvpD+eSFk1rbTKbqNCIjzROHH9vZw==;7:5UPraMFcaZ1R/UeaaGbbpKu6Z3K1UX7tIvRvFufh0UOMZtbM2pVMxCLGR8hjA/xdImHg/h3w9NbWjWFQdxumXzFUJeAXiYTiOacshjVGx/ZJx5O57Sajgnur59X7FJfaf5GhUKND76dHgxSEbm8BOQ==
x-ms-office365-filtering-correlation-id: b38024b1-2cb8-4bb7-7f4c-08d684f7351c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4335;
x-ms-traffictypediagnostic: SN6PR04MB4335:
x-microsoft-antispam-prvs: <SN6PR04MB433511FAD480107F42BD70BBC1960@SN6PR04MB4335.namprd04.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39850400004)(136003)(199004)(189003)(476003)(9686003)(97736004)(66066001)(26005)(6436002)(3846002)(256004)(316002)(55016002)(7696005)(76176011)(486006)(6116002)(6916009)(8936002)(186003)(2906002)(86362001)(71190400001)(71200400001)(105586002)(8676002)(68736007)(53936002)(81156014)(6246003)(106356001)(81166006)(99286004)(39060400002)(14454004)(4326008)(478600001)(7736002)(229853002)(305945005)(11346002)(102836004)(446003)(25786009)(53546011)(74316002)(33656002)(6506007)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4335;H:SN6PR04MB5424.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eo4dJ9UMF/RBGq6NspTduQhzpfRbdmtrgbsFYQIohsjFXnwxlw85/VVHG8ouAhE+ONXZ3bxv+2BC//UT4edjqL3CAxS93tTLtTipkiRRYZDg6IafcERPRNf+ThEu4a5xku9hJUJSrZUUQoKU/Y+lhvlsV6gObf43gw042JCqjv/ijyT/16W+f6pJiWWdnbuq/Z8upfsunx6jOLR3np/H1ngbgfOFuR0Ybr2b0/RU3Xg1ig/VBXcyPpMEqKYnNNQ8jF+sA7JZHxLCb67IKOAWeG4cpevbQZYT14RGmcNPw3hCsLw5f71wwJIDAUdNNg6H9uA7ZsB4/i0TW9gHGUW9Dcj8hfZdOj2H/EKYZ3KltAZQIKtefAs9M1CpI8yKRanykNBsXcu3QkebX26R5wJJfuauvXAo8VDe+BHqcPppyew=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38024b1-2cb8-4bb7-7f4c-08d684f7351c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 08:04:20.1101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4335
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIFdlZCwgSmFuIDIzLCAyMDE5IGF0IDU6MTggUE0gQW5keSBTaGV2Y2hlbmtvIDxhbmR5
LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIE1vbiwgSmFuIDE0LCAy
MDE5IGF0IDQ6MTMgUE0gR3VhbiBZdW5nIFRzZW5nIDxndWFuLnl1bmcudHNlbmdAbmkuY29tPiB3
cm90ZToNCj4gPiA+DQo+ID4gPiBNb2RpZmllZCBOSSBkZXZpY2VzIGNsYXNzIHRvIFBDSV9DTEFT
U19DT01NVU5JQ0FUSU9OX01VTFRJU0VSSUFMLg0KPiA+ID4gVGhlIHJlYXNvbiBvZiBkb2luZyB0
aGlzIGlzIGJlY2F1c2UgYWxsIE5JIG11bHRpIHBvcnQgc2VyaWFsIGNhcmRzIA0KPiA+ID4gdXNl
IFBDSV9DTEFTU19DT01NVU5JQ0FUSU9OX09USEVSIGNsYXNzIGFuZCB0aHVzIGZhaWwgdGhlIA0K
PiA+ID4gc2VyaWFsX3BjaV9pc19jbGFzc19jb21tdW5pY2F0aW9uIHRlc3QgYWRkZWQgaW4gdGhl
IGNvbW1pdCANCj4gPiA+IDdkODkwNWQwNjQwNQ0KPiA+ID4gKCJzZXJpYWw6IDgyNTBfcGNpOiBF
bmFibGUgZGV2aWNlIGFmdGVyIHdlIGNoZWNrIGJsYWNrIGxpc3QiKS4NCj4gPg0KPiA+IEd1YW4s
IGNhbiB5b3UgcHJvdmlkZSBhbiBvdXRwdXQgb2YgdGhlDQo+ID4NCj4gPiBsc3BjaSAtbmsgLXh4
IC12diAtcyA8QkRGPg0KPiA+DQo+ID4gb2YgeW91ciBkZXZpY2UsIHdoZXJlIDxCREY+IGlzIGEg
UENJIGFkZHJlc3MgaW4gYSBmb3JtIG9mIGJ1czpkZXZpY2UuZnVuY3Rpb24/DQo+DQoNCk91dHB1
dCBvZiBsc3BjaSBiZWZvcmUgYXBwbGllZCB0aGUgcGF0Y2gNCg0KYWRtaW5ATkktUFhJZS04ODQw
UXVhZC1Db3JlLTAzMDhENjU3On4jIGxzcGNpIC1uayAteHggLXZ2IC1zIDBkOjBlLjANCjBkOjBl
LjAgMDc4MDogMTA5Mzo3MGU4DQogICAgICAgIFN1YnN5c3RlbTogMTA5Mzo3MGU4DQogICAgICAg
IENvbnRyb2w6IEkvTy0gTWVtLSBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25v
b3AtIFBhckVycisgU3RlcHBpbmcNCi0gU0VSUisgRmFzdEIyQi0gRGlzSU5UeC0NCiAgICAgICAg
U3RhdHVzOiBDYXAtIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+
VEFib3J0LSA8VEFib3J0LSA8TQ0KQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0NCiAgICAgICAg
SW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDEwDQogICAgICAgIFJlZ2lvbiAwOiBNZW1v
cnkgYXQgZmUyMDEwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6
ZT00S10NCjAwOiA5MyAxMCBlOCA3MCA0MCAwMSA4MCAwMiAwMCAwMCA4MCAwNyAxMCAyMCAwMCAw
MA0KMTA6IDAwIDEwIDIwIGZlIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQoy
MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgOTMgMTAgZTggNzANCjMwOiAw
MCAwMCAwMCAwMCBmMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwYSAwMSAwMCAwMA0KDQphZG1pbkBO
SS1QWEllLTg4NDBRdWFkLUNvcmUtMDMwOEQ2NTc6fiMgbHNwY2kgLW5rIC14eCAtdnYgLXMgMGQ6
MGYuMA0KMGQ6MGYuMCAwNzgwOiAxMDkzOjcwZWMNCiAgICAgICAgU3Vic3lzdGVtOiAxMDkzOjcw
ZWMNCiAgICAgICAgQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1X
SU5WLSBWR0FTbm9vcC0gUGFyRXJyKyBTdGVwcGluZw0KLSBTRVJSKyBGYXN0QjJCLSBEaXNJTlR4
LQ0KICAgICAgICBTdGF0dXM6IENhcC0gNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZT
RUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNDQpBYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4
LQ0KICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTENCiAgICAgICAgUmVn
aW9uIDA6IE1lbW9yeSBhdCBmZTIwMDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbZGlz
YWJsZWRdIFtzaXplPTRLXQ0KMDA6IDkzIDEwIGVjIDcwIDQwIDAxIDgwIDAyIDAwIDAwIDgwIDA3
IDEwIDIwIDAwIDAwDQoxMDogMDAgMDAgMjAgZmUgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDANCjIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCA5MyAxMCBl
YyA3MA0KMzA6IDAwIDAwIDAwIDAwIGYwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDBiIDAxIDAwIDAw
DQoNCj4gV2hpbGUgSSdtIHN0aWxsIHdvbmRlcmluZyBvZiB0aGUgYWJvdmUsIGNhbiB5b3UgYWxz
byB0ZXN0IHRoZSBiZWxsb3cgcGF0Y2ggaWYgaXQgZml4ZXMgeW91ciBpc3N1ZT8NCg0KVGhlIHBh
dGNoIGZpeGVzIHRoZSBpc3N1ZS4gVGhlIGRldmljZXMgYmluZCB0byB0aGUgc2VyaWFsIGtlcm5l
bCBkcml2ZXIgc3VjY2Vzc2Z1bGx5Lg0KQmVsb3cgaXMgdGhlIG91dHB1dCBvZiBsc3BjaSAtbmsg
LXh4IC12diAtcyA8QkRGPiBmb3IgdGhlIHNhbWUgZGV2aWNlcyBhZnRlciBJIGFwcGxpZWQgdGhl
IHBhdGNoLg0KDQphZG1pbkBOSS1QWEllLTg4NDBRdWFkLUNvcmUtMDMwOEQ2NTc6fiMgbHNwY2kg
LW5rIC14eCAtdnYgLXMgMGQ6MGUuMA0KMGQ6MGUuMCAwNzgwOiAxMDkzOjcwZTgNCiAgICAgICAg
U3Vic3lzdGVtOiAxMDkzOjcwZTgNCiAgICAgICAgQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3Rl
ci0gU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyKyBTdGVwcGluZw0KLSBTRVJS
KyBGYXN0QjJCLSBEaXNJTlR4LQ0KICAgICAgICBTdGF0dXM6IENhcC0gNjZNSHotIFVERi0gRmFz
dEIyQisgUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNDQpBYm9ydC0g
PlNFUlItIDxQRVJSLSBJTlR4LQ0KICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJ
UlEgMTcNCiAgICAgICAgUmVnaW9uIDA6IE1lbW9yeSBhdCBmZTIwMTAwMCAoMzItYml0LCBub24t
cHJlZmV0Y2hhYmxlKSBbc2l6ZT00S10NCiAgICAgICAgS2VybmVsIGRyaXZlciBpbiB1c2U6IHNl
cmlhbA0KMDA6IDkzIDEwIGU4IDcwIDQyIDAxIDgwIDAyIDAwIDAwIDgwIDA3IDEwIDIwIDAwIDAw
DQoxMDogMDAgMTAgMjAgZmUgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCjIw
OiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCA5MyAxMCBlOCA3MA0KMzA6IDAw
IDAwIDAwIDAwIGYwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDBhIDAxIDAwIDAwDQoNCmFkbWluQE5J
LVBYSWUtODg0MFF1YWQtQ29yZS0wMzA4RDY1Nzp+IyBsc3BjaSAtbmsgLXh4IC12diAtcyAwZDow
Zi4wDQowZDowZi4wIDA3ODA6IDEwOTM6NzBlYw0KICAgICAgICBTdWJzeXN0ZW06IDEwOTM6NzBl
Yw0KICAgICAgICBDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJ
TlYtIFZHQVNub29wLSBQYXJFcnIrIFN0ZXBwaW5nDQotIFNFUlIrIEZhc3RCMkItIERpc0lOVHgt
DQogICAgICAgIFN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNF
TD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE0NCkFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgt
DQogICAgICAgIEludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxOA0KICAgICAgICBSZWdp
b24gMDogTWVtb3J5IGF0IGZlMjAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXpl
PTRLXQ0KICAgICAgICBLZXJuZWwgZHJpdmVyIGluIHVzZTogc2VyaWFsDQowMDogOTMgMTAgZWMg
NzAgNDIgMDEgODAgMDIgMDAgMDAgODAgMDcgMTAgMjAgMDAgMDANCjEwOiAwMCAwMCAyMCBmZSAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KMjA6IDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDkzIDEwIGVjIDcwDQozMDogMDAgMDAgMDAgMDAgZjAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMGIgMDEgMDAgMDANCg0KDQoNCg==
