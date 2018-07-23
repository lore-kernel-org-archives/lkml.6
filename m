Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166AFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29DA20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sZlNT5DJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29DA20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbeGWLg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:36:28 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:2649
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388083AbeGWLg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14J0O+Fvo+XB+Gn8jJ2MFDRfAJMpjJS8CjQM98wXf6c=;
 b=sZlNT5DJNuVcVK7/mlIWySzELqzoftiMkrb5OpgczakKjXPWG0K9Z4GFJArJ2Wj2wY0A7gzQBEFVSweROY/vimrrKAZQY/tI+Ll+au3DvYdd0bbEpLhhZhDc9tDf7AXr6sPGJ28wE++5pZ2Y6ad/zdxEZPA4gw8tVitpIPKQHTQ=
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com (52.133.39.11) by
 AM0PR0402MB3571.eurprd04.prod.outlook.com (52.133.46.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 10:35:50 +0000
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13]) by AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13%5]) with mapi id 15.20.0973.018; Mon, 23 Jul 2018
 10:35:50 +0000
From:   Pengbo Mu <pengbo.mu@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>, kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [PATCH] usb: dwc3: call set incr burst type func()
Thread-Topic: [PATCH] usb: dwc3: call set incr burst type func()
Thread-Index: AQHUIjYNPC9Ugap3IUCwapLPVjRhAqScYqKAgAAaH9CAABeygIAACIbw
Date:   Mon, 23 Jul 2018 10:35:50 +0000
Message-ID: <AM0PR0402MB37470E11EDEF6DBDC1655725F4560@AM0PR0402MB3747.eurprd04.prod.outlook.com>
References: <1532316853-29184-1-git-send-email-pengbo.mu@nxp.com>
 <201807231412.97HYMoRm%fengguang.wu@intel.com>
 <AM0PR0402MB37475F43B0F16F462F8CD623F4560@AM0PR0402MB3747.eurprd04.prod.outlook.com>
 <87muui46bk.fsf@linux.intel.com>
In-Reply-To: <87muui46bk.fsf@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pengbo.mu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3571;6:OkFFZ4B4s8aH9JpHO35knB/W6UyGBsM/gpxAWwbTf7yvjpl2vt+eZ24vHLTBbpM1pk1DCXjFQ/6ucHTLM81tWny+toZ47qEp0QX2hWomp/quQvenyuzWyS2Aal8lESyULP13/JGdd0ZG3iEqucobUpI2espQ+XD8uy2U+t7BbREhCKUeQJqFMIc7ToBt7rNIqzY2eh4uVRux8ghBisvOwINzJDkZRJBhR6MozOdei+b7Up2l/FdYQNwCoo9ehjAhMABqdOsszMHBhN+QP1RsuMb9vcHjiziyi2xQIZvvaO092k+s7U3+mxWDo/827AxwQiGG933wYEF5P+NM1qqFphUKuin/3QJ1dhZ+AyjkgLOisHygPEwC4Xgpg3B09456xlvP77UxeFRY5+HWE6m/zwcV+HY6eX5jvPpMomzBUvymRlAvy6XjB8Je/rojHFqdYnJz0csmgBLI4ALex2faew==;5:GTg17VtT5wLvO5PTu/z3kftZ4JO36xsS7iTQVetmwLvA9/cTKCzSk5pLrTi7/8HGaAgXCEz20b1Svqcrnd6gfKyqTGsJSfeZ++QJe14r00YPGnzsHvCcReWUB0LHk5hZU2s7VN8WDf7QVC8qXQhMOC4pdicYPW5rZp2ECAEejz8=;7:zpVnyuLGUkZO+NOLSV/V8ia//WBS4DmyJIDHdAEQAf7L+2+UaberRSj0ulSVe4FXeutwFOsnLGSbOTXNA5y61LfGhCHUlIwtbofGWtEfhdYqtyu1OedmZ4zqz77cY6ffrueCqm3t5ALrCQV4tiI9Lf1DgACcd2GduvLlnYBkMt4zlFva7L9xEyRaa0PUWnOWK6f8Kqd5gohcE/yyWU8XGdXApQlQE88lZuJbms5SL9ydwZHWpsSa0ztUPsfBtjwm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6b8feb5e-33a9-44b7-6d8d-08d5f0880f38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3571;
x-ms-traffictypediagnostic: AM0PR0402MB3571:
x-microsoft-antispam-prvs: <AM0PR0402MB357197678E61D5042AE7C6E4F4560@AM0PR0402MB3571.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(84791874153150)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR0402MB3571;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3571;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(396003)(346002)(13464003)(54534003)(199004)(189003)(5660300001)(105586002)(14454004)(478600001)(33656002)(81166006)(8676002)(81156014)(229853002)(8936002)(6436002)(3846002)(4326008)(6116002)(6246003)(97736004)(66066001)(25786009)(99286004)(110136005)(106356001)(93886005)(2906002)(44832011)(186003)(53546011)(6506007)(11346002)(446003)(76176011)(486006)(26005)(7696005)(102836004)(54906003)(476003)(86362001)(305945005)(74316002)(68736007)(55016002)(316002)(9686003)(7736002)(5250100002)(256004)(2900100001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3571;H:AM0PR0402MB3747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g9hbJ2pu75mjPz0zeWv7QYaaCS9gg6Hw1EaENT2s0k99sqZ0vEksxauXUs6NYR7EafILFYjC4Z3jb7/m3E4wW8oYqJFmeyhvhr5YOCcCLcrv8nDV4Vi6Zn2KLkvchJPw9X9MyBDASYq53vz9om8gRhs2csQRoHggzuyhvgoGO2KaK/L5WCqYfFaFABqe3eBCeh5uktZNB6OlEAj/uyq4rXIGF3PbYvRO84qVCQ0UbE3ylQKmNu8i8uyMHOAz40tZvvV/br91L1H+ggyaN/Oz4iXPpR/8Kv8HMonAvvdf0hqLyzu7WdYFy10n89LTtRom0YR2ynTXAvjwhLh0ycZrL+4mElZg14ZVLsBui0BwHy8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8feb5e-33a9-44b7-6d8d-08d5f0880f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 10:35:50.3167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3571
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Um9nZXIgdGhhdC4NCkkgaGF2ZSBzZW50IHRoZSBmdWxsIHNlcmllcy4gUGxlYXNlIHJldmlldy4N
Cg0KVGhhbmtzo6wNClBlbmdibw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEZl
bGlwZSBCYWxiaSBbbWFpbHRvOmJhbGJpQGtlcm5lbC5vcmddIA0KU2VudDogMjAxOMTqN9TCMjPI
1SAxODowNA0KVG86IFBlbmdibyBNdSA8cGVuZ2JvLm11QG54cC5jb20+OyBrYnVpbGQgdGVzdCBy
b2JvdCA8bGtwQGludGVsLmNvbT4NCkNjOiBrYnVpbGQtYWxsQDAxLm9yZzsgR3JlZyBLcm9haC1I
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IFJhbiBXYW5nIDxyYW4ud2FuZ18x
QG54cC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIXSB1c2I6IGR3YzM6IGNhbGwgc2V0IGluY3Ig
YnVyc3QgdHlwZSBmdW5jKCkNCg0KDQpIaSwNCg0KKG5vIHRvcC1wb3N0aW5nKQ0KDQpQZW5nYm8g
TXUgPHBlbmdiby5tdUBueHAuY29tPiB3cml0ZXM6DQo+IEhpLA0KPg0KPiBUaGUgZm9sbG93aW5n
IGlzIG15IGNvbXBpbGUgcmVzdWx0Og0KPiAgIC4uLg0KPiAgIExEIFtNXSAgc291bmQvc29jL2Nv
ZGVjcy9zbmQtc29jLWFrNDYxMy5rbw0KPiAgIExEIFtNXSAgc291bmQvc29jL2dlbmVyaWMvc25k
LXNvYy1hdWRpby1ncmFwaC1jYXJkLmtvDQo+ICAgTEQgW01dICBzb3VuZC9zb2MvZ2VuZXJpYy9z
bmQtc29jLXNpbXBsZS1jYXJkLXV0aWxzLmtvDQo+ICAgTEQgW01dICBzb3VuZC9zb2MvZ2VuZXJp
Yy9zbmQtc29jLXNpbXBsZS1jYXJkLmtvDQo+ICAgTEQgW01dICBzb3VuZC9zb2Mvc2gvcmNhci9z
bmQtc29jLXJjYXIua28NCj4gcmV0OjANCj4gVGhlc2UgcGF0Y2hlcyBhcmUgYmFzZWQgb24gbWFp
bmxpbmUgLCBhbmQgbXkgdmVyc2lvbiBpcyBsaW51eC00LjE4LXJjNS4gTGFzdCB3ZWVrICwgSSBw
dWxsZWQgbXkgdXBzdHJlYW0gYnJhbmNoIHRvIHRoZSBsYXRlc3QuDQo+IEkgZGlkbid0IHNlZSBl
cnJvciBsb2cgaW4gdGhpcyB2ZXJzaW9uLg0KPiBCeSB0aGUgd2F5ICwgdGhpcyBpcyBteSBnaXQg
dHJlZSAtLS0gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2dy
ZWdraC91c2IuZ2l0IC4NCj4gUGxlYXNlIHRlbGwgbWUgd2hpY2ggdHJlZSBjb3VsZCBzdWl0YWJs
eSBkZXZlbG9wIHBhdGNoIGZvciB1cHN0cmVhbS4NCg0KdGhpcyBpcyBhIHJlc3VsdCBvZiB5b3Ug
c2VuZGluZyB0aGlzIHBhdGNoIG91dHNpZGUgb2YgdGhlIHNlcmllcyBpdCBiZWxvbmdzIHRvLiBK
dXN0IHJlc2VuZCB0aGUgZnVsbCBzZXJpZXMgYW5kIHRoaW5ncyBzaG91bGQgYmUgb2theS4gQWxz
bywgYXMgR3JlZyBhbHJlYWR5IG1lbnRpb25lZCwgcGxlYXNlIHdyaXRlIGNoYW5nZWxvZ3MgdGhh
dCBleHBsYWluIFdIWSB0aGUgY2hhbmdlIHdhcyBtYWRlLg0KDQotLQ0KYmFsYmkNCg==
