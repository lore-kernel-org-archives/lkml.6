Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9939C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAEA2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="gTXJFxHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAEA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeIKNsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:48:22 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.213]:58411 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbeIKNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:48:22 -0400
Received: from [67.219.246.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-east-1.aws.symcld.net id C8/E5-25673-9B1879B5; Tue, 11 Sep 2018 08:50:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSaUgUYRjHfXdmZ6dwYhqvRymrjeiA2dyFYiz
  oIIuFCDo+dB+jTrtLu6vsrGX1IaWidFnKTd3cIruMvI+CTOwgYjULrE0wtyTUZcvtUJKKomt2
  xq4vL7/n+f/f/8zz8pAY00+kkEK+U3DYeauWmIibUiM6trXQuzXtcFU65y17jLjOvkKCe9p2l
  uAOlzzXcKffH0Nc8KRfxdWfMC3TGG/6+jXGS+3DKmNLTRFhdJ35gRvHWlLXqreoLfbMnPxdan
  PwTkCV61+aH24eRQXoxZJiNJFk6AiC8guvkFL4ETzuKZQLnL6KwcjV4XGlRAVVxR9xpXiJoO5
  Jp7oYTSAJehb01UZkjqdXQ8hbRERNGD2IYMQfloU4ehsMNlVpFNN26Hv9SKWwAbo+BGQPLgVV
  1Z/DokxJfld/s+xh6CIEjW4yyhPodRDq6ZD7iE6Ez111MmN0EgRDlTIDTcPl9m5M4QQYHvqhV
  vzrIfhlVKP0p8GJWjeu8FQIVLrkMYF2Y9ASDI2bWBgtKxsPWgNvh86oFe5A0Fq5ROF5MPg52i
  cl3gP9ddOVnAoETQ19SPGkQo17AFeEagxujx4lFGEKFJa0opNovu+fIXxSFkbPhca28fYMKHU
  NaHzyu0yGBxUh/DzCa9CCTIfFZHbaeIuV1aelsXq9gV3AGgw6/gCbpcsTWYEXnaxex+8TdeJ+
  W5Y1W2cXnC1IWq/sXHViK6ovNt1DyaRKm0Bds3m3MpMyc7L3m3nRvNORZxXEe2gKSWqBmiStI
  TPZIZiE/N0Wq7Sjv2UgY7XxVGZUpsRc3iZaTIrUhdLJc9UeD0Z+GymTzheucg/G4PYcu5CSRD
  0pkC7Q0QvmPPufuN9bH0BTU+IoFBMTw8TmCg6bxfm/HkFJJNLGUdejKbEWu/PPV6VFlmaJpxq
  6S6M/5OT/SikFqO2iv+PnyrM1D5NPNcYcjTzImHlkM5Oob7+14W7ORub+oZuuRd3pTdzm5K/h
  d9+vDDzPGKobjjWsKp3NhW/NdO59g/VWdOKfPowRgQo0x32jNuHZ8aI3WWnNpSs8y9/u6D2oP
  8ZP9x3surgtwzt/bM/ChuryTavCcxfr1yU99PSIvdO0uGjm9fMwh8j/AuMc9mbwAwAA
X-Env-Sender: hehy1@lenovo.com
X-Msg-Ref: server-25.tower-406.messagelabs.com!1536655790!455281!1
X-Originating-IP: [103.30.234.46]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4330 invoked from network); 11 Sep 2018 08:50:00 -0000
Received: from unknown (HELO mapsmtp01.lenovo.com) (103.30.234.46)
  by server-25.tower-406.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Sep 2018 08:50:00 -0000
Received: from HKGWPEXCH02.lenovo.com (unknown [10.128.62.31]) by mapsmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA384)
         id 5be6_42bc_af1ba10b_9fc3_4856_86cb_c3a4eec3151e;
        Tue, 11 Sep 2018 16:49:48 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (65.55.88.208) by
 HKGWPEXCH02.lenovo.com (10.128.62.31) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 11 Sep 2018 16:49:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0gi+5Cbii7gfz2UrCw048CG53Ug1odQSHIOpAdT2v4=;
 b=gTXJFxHrM0Um7NJqhxDalf4cdTxOl+e0F/LEkxuHODYsCnhZ4lArS+sa5mlH0Vf4zkIy3S0rD72WWslJF8LTbpUt/aGL9DD5/M2SBvdROVcsSrE+NMv7ZeEuIP5wuvcJ3pxRqRy4dXEgx4a3CbQj+BTu/FPBGuavwBC059ohIJM=
Received: from HK0PR03MB3170.apcprd03.prod.outlook.com (52.133.151.140) by
 HK0PR03MB2948.apcprd03.prod.outlook.com (52.133.211.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Tue, 11 Sep 2018 08:49:48 +0000
Received: from HK0PR03MB3170.apcprd03.prod.outlook.com
 ([fe80::102a:649e:6d08:6fbc]) by HK0PR03MB3170.apcprd03.prod.outlook.com
 ([fe80::102a:649e:6d08:6fbc%2]) with mapi id 15.20.1143.010; Tue, 11 Sep 2018
 08:49:47 +0000
From:   Ocean HY1 He <hehy1@lenovo.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ocean He <oceanhehy@gmail.com>
CC:     "zwisler@kernel.org" <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH 0/3] libnvdimm: reset seeds for next
 namespace creation
Thread-Topic: [External]  Re: [PATCH 0/3] libnvdimm: reset seeds for next
 namespace creation
Thread-Index: AQHUSWmC+PH9tsw4x0avwLvSScd8kaTqwZTA
Date:   Tue, 11 Sep 2018 08:49:47 +0000
Message-ID: <HK0PR03MB3170D70900D45B97AAA52E2D89040@HK0PR03MB3170.apcprd03.prod.outlook.com>
References: <1536560508-24564-1-git-send-email-oceanhehy@gmail.com>
 <CAPcyv4hvtL6eu7=c+7GRqpy6TG2w0-mLZi8smdeTjHX3xxnpZw@mail.gmail.com>
In-Reply-To: <CAPcyv4hvtL6eu7=c+7GRqpy6TG2w0-mLZi8smdeTjHX3xxnpZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0PR03MB2948;20:9efMjeF6xw4md64uYCSmBkgOmvsV9NHdb4q1sKAus8Q6IIa2F5ad+Wb53RThsgDVEl/bQ1Yo/OYsdcAhoTlt+B8C48OKw/uGlye0pru7wABMERro9iwNnpGt4W5nXPi67XfXLapq7r1tyuiFuJ70xfZ8VOKrrWvTKuz4Qd4l1W8q/Ksoih3FaooRmD6WLlBZmuhbq8AhAbRBPAZejVd3eDISRooSJ35uevFBYted2scHizDaUPQr8lzsfaRjfwsUjgNeEvuv3JN+h/aVu8gm1+4p7VNzIdnk3GbNlK1FD9RHA1cNdik10RT5mTalgAC9EXJbDBtgRelIXhYZonEGNA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9088e65b-c3fc-43f9-8128-08d617c3878f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HK0PR03MB2948;
x-ms-traffictypediagnostic: HK0PR03MB2948:
x-microsoft-antispam-prvs: <HK0PR03MB2948D3B2DEE262FF36C2EE1B89040@HK0PR03MB2948.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(192374486261705)(9452136761055)(85827821059158)(162533806227266)(163750095850)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:HK0PR03MB2948;BCL:0;PCL:0;RULEID:;SRVR:HK0PR03MB2948;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39850400004)(189003)(199004)(13464003)(229853002)(6246003)(4326008)(6116002)(54906003)(3846002)(81166006)(74316002)(39060400002)(8676002)(2900100001)(81156014)(966005)(316002)(110136005)(7696005)(14454004)(7736002)(305945005)(25786009)(99286004)(478600001)(97736004)(14444005)(256004)(5024004)(2906002)(5250100002)(105586002)(33656002)(86362001)(575784001)(106356001)(66066001)(476003)(9686003)(102836004)(55016002)(26005)(6306002)(11346002)(446003)(486006)(53546011)(5660300001)(186003)(76176011)(6506007)(68736007)(53936002)(8936002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0PR03MB2948;H:HK0PR03MB3170.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (HKGWPEXCH02.lenovo.com: hehy1@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5I8uvjJYN0z+J1NFknhJKSA20QCgyiembmtexu5+IEQyvxNzMjPADn8Ct3UN2hcXYIR1jTFIVNlwk9A7wr8A/PtBVsR60tkzAEcpMHIaOtnsBFk+CZ81PWSwRPeusJr1mjJdQTj7JLv2+J6jxG6czK7C9hcrtMt7B06L/REbYIrriRZFAvLAciUiRaHyPvnqLezBs5UyTLszVFFySaOEIYoTw2B2QwOcZy5vVnMgWY9kjxQai6BuR/ncKzsKy28+xHoaIXaiPhKdp1TZABmNqRLhv2G/Xkw/nKk/kk38TuC6xxanVWIH+Vpfp+xq3RMdnwoZUyl6/ibJW4x3cxlpEakcLDQaNrIaOo61vk3ZvfE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9088e65b-c3fc-43f9-8128-08d617c3878f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 08:49:47.9063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB2948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxMSwg
MjAxOCA4OjUxIEFNDQo+IFRvOiBPY2VhbiBIZSA8b2NlYW5oZWh5QGdtYWlsLmNvbT4NCj4gQ2M6
IHp3aXNsZXJAa2VybmVsLm9yZzsgVmlzaGFsIEwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVs
LmNvbT47IERhdmUgSmlhbmcNCj4gPGRhdmUuamlhbmdAaW50ZWwuY29tPjsgbGludXgtbnZkaW1t
IDxsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnPjsgTGludXgNCj4gS2VybmVsIE1haWxpbmcgTGlz
dCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IE9jZWFuIEhZMSBIZQ0KPiA8aGVoeTFA
bGVub3ZvLmNvbT4NCj4gU3ViamVjdDogW0V4dGVybmFsXSBSZTogW1BBVENIIDAvM10gbGlibnZk
aW1tOiByZXNldCBzZWVkcyBmb3IgbmV4dA0KPiBuYW1lc3BhY2UgY3JlYXRpb24NCj4gDQo+IE9u
IFN1biwgU2VwIDksIDIwMTggYXQgMTE6MjEgUE0sIE9jZWFuIEhlIDxvY2VhbmhlaHlAZ21haWwu
Y29tPiB3cm90ZToNCj4gPiBGcm9tOiBPY2VhbiBIZSA8aGVoeTFAbGVub3ZvLmNvbT4NCj4gPg0K
PiA+IFdoZW4gcG1lbSBuYW1lc3BhY2VzIGNyZWF0ZWQgYXJlIHNtYWxsZXIgdGhhbiBzZWN0aW9u
IHNpemUgdHdpY2UsIHRoZQ0KPiA+IHNlY29uZCBjcmVhdGlvbiB3b3VsZCBmYWlsIGFuZCBtZWFu
d2hpbGUgdGhlcmUgaXMgYSBrZXJuZWwgY2FsbCB0cmFjZQ0KPiA+IHdoaWNoIGNvbWVzIGZyb20g
Y29tbWl0IDE1ZDM2ZmVjZDBiZGM3NTEwYjcwICgibW06IGRpc2FsbG93IG1hcHBpbmdzDQo+IHRo
YXQNCj4gPiBjb25mbGljdCBmb3IgZGV2bV9tZW1yZW1hcF9wYWdlcygpIikuDQo+ID4gICAgICAg
ICAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gPiAgICAgICAgIG5kX3Bt
ZW0gcGZuMS4xOiBDb25mbGljdGluZyBtYXBwaW5nIGluIHNhbWUgc2VjdGlvbg0KPiA+ICAgICAg
ICAgV0FSTklORzogQ1BVOiA4NCBQSUQ6IDUxOTc0IGF0IGtlcm5lbC9tZW1yZW1hcC5jOjE5NA0K
PiBkZXZtX21lbXJlbWFwX3BhZ2VzKzB4NGEwLzB4NGUwDQo+ID4gICAgICAgICBDUFU6IDg0IFBJ
RDogNTE5NzQgQ29tbTogbmRjdGwgS2R1bXA6IGxvYWRlZCBUYWludGVkOiBHIFcgRSA0LjE5LjAt
DQo+IHJjMi0yMy1kZWZhdWx0KyAjMjcNCj4gPiAgICAgICAgIFJJUDogMDAxMDpkZXZtX21lbXJl
bWFwX3BhZ2VzKzB4NGEwLzB4NGUwDQo+ID4gICAgICAgICBDYWxsIFRyYWNlOg0KPiA+ICAgICAg
ICAgIHBtZW1fYXR0YWNoX2Rpc2srMHgzYWIvMHg1ODEgW25kX3BtZW1dDQo+ID4gICAgICAgICAg
bnZkaW1tX2J1c19wcm9iZSsweDY5LzB4MTUwIFtsaWJudmRpbW1dDQo+ID4gICAgICAgICAgcmVh
bGx5X3Byb2JlKzB4MjYyLzB4M2QwDQo+ID4gICAgICAgICAgZHJpdmVyX3Byb2JlX2RldmljZSsw
eDYwLzB4MTIwDQo+ID4gICAgICAgICAgYmluZF9zdG9yZSsweDEwMi8weDE5MA0KPiA+ICAgICAg
ICAgIGtlcm5mc19mb3Bfd3JpdGUrMHgxMDUvMHgxODANCj4gPiAgICAgICAgICBfX3Zmc193cml0
ZSsweDM2LzB4MWEwDQo+ID4gICAgICAgICAgPyBjb21tb25fZmlsZV9wZXJtKzB4NDcvMHgxMzAN
Cj4gPiAgICAgICAgICA/IHNlY3VyaXR5X2ZpbGVfcGVybWlzc2lvbisweDJjLzB4YjANCj4gPiAg
ICAgICAgICB2ZnNfd3JpdGUrMHhhZC8weDFhMA0KPiA+ICAgICAgICAgIGtzeXNfd3JpdGUrMHg1
Mi8weGMwDQo+ID4gICAgICAgICAgZG9fc3lzY2FsbF82NCsweDViLzB4MTgwDQo+ID4gICAgICAg
ICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQ0KPiA+DQo+ID4gSGVy
ZSBpcyBhbiBleGFtcGxlIChzZWN0aW9uIHNpemUgaXMgMTI4TUIpIGJhc2VkIG9uIGtlcm5lbCA0
LjE5LXJjMi4NCj4gPiAgICAgICAgICMgbmRjdGwgY3JlYXRlLW5hbWVzcGFjZSAtciByZWdpb24x
IC1zIDEwMG0gLXQgcG1lbSAtbSBmc2RheA0KPiA+ICAgICAgICAgew0KPiA+ICAgICAgICAgICAi
ZGV2IjoibmFtZXNwYWNlMS4wIiwNCj4gPiAgICAgICAgICAgIm1vZGUiOiJmc2RheCIsDQo+ID4g
ICAgICAgICAgICJtYXAiOiJkZXYiLA0KPiA+ICAgICAgICAgICAic2l6ZSI6Ijk2LjAwIE1pQiAo
MTAwLjY2IE1CKSIsDQo+ID4gICAgICAgICAgICJ1dWlkIjoiZWY5YTA1NTYtYTYxMC00MGI1LThj
NzEtNDM5OTE3NjVhMmNjIiwNCj4gPiAgICAgICAgICAgInJhd191dWlkIjoiMTc3YjIyZTItYjdl
OC00ODJmLWEwNjMtMmI4ZGU4NzZkOTc5IiwNCj4gPiAgICAgICAgICAgInNlY3Rvcl9zaXplIjo1
MTIsDQo+ID4gICAgICAgICAgICJibG9ja2RldiI6InBtZW0xIiwNCj4gPiAgICAgICAgICAgIm51
bWFfbm9kZSI6MQ0KPiA+ICAgICAgICAgfQ0KPiA+ICAgICAgICAgIyBuZGN0bCBjcmVhdGUtbmFt
ZXNwYWNlIC1yIHJlZ2lvbjEgLXMgMTAwbSAtdCBwbWVtIC1tIGZzZGF4DQo+ID4gICAgICAgICBs
aWJuZGN0bDogbmRjdGxfcGZuX2VuYWJsZTogcGZuMS4xOiBmYWlsZWQgdG8gZW5hYmxlDQo+ID4g
ICAgICAgICAgIEVycm9yOiBuYW1lc3BhY2UxLjE6IGZhaWxlZCB0byBlbmFibGUNCj4gPiAgICAg
ICAgIGZhaWxlZCB0byBjcmVhdGUgbmFtZXNwYWNlOiBObyBzdWNoIGRldmljZSBvciBhZGRyZXNz
DQo+ID4NCj4gPiBXaGVuIGFib3ZlIHNlY29uZCBjcmVhdGlvbiBmYWlsdXJlIG9jY3VycywgdGhl
IGV4cGVjdGF0aW9uIGlzIHRvIGRlc3Ryb3kNCj4gPiBuYW1lc3BhY2UxLjAgdG8gY3JlYXRlIGEg
bmV3IG5hbWVzcGFjZSB3aGljaCBzaXplIGlzIGFsaWduZWQgd2l0aCBzZWN0aW9uDQo+ID4gc2l6
ZS4gSG93ZXZlciwgYm90aCBuYW1lc3BhY2Ugc2VlZCBhbmQgcGZuIHNlZWQgaGF2ZSBiZWVuIGNv
bnN1bWVkLA0KPiB0aGUNCj4gPiBuZXcgbmFtZXNwYWNlIGNyZWF0aW9uIHN0aWxsIGZhaWxzLg0K
PiA+ICAgICAgICAgIyBuZGN0bCBkZXN0cm95LW5hbWVzcGFjZSBuYW1lc3BhY2UxLjAgLWYNCj4g
PiAgICAgICAgIGRlc3Ryb3llZCAxIG5hbWVzcGFjZQ0KPiA+ICAgICAgICAgIyBuZGN0bCBjcmVh
dGUtbmFtZXNwYWNlIC1yIHJlZ2lvbjEgLXMgMTI4bSAtdCBwbWVtIC1tIGZzZGF4DQo+ID4gICAg
ICAgICBmYWlsZWQgdG8gY3JlYXRlIG5hbWVzcGFjZTogRGV2aWNlIG9yIHJlc291cmNlIGJ1c3kN
Cj4gPg0KPiA+IFRvIGVuc3VyZSBwZm5fc2VlZC9kYXhfc2VlZCBhbmQgbmFtZXNwYWNlX3NlZWQg
YXJlIGFsd2F5cyByZWFkeSBmb3INCj4gbmV4dA0KPiA+IG5hbWVzcGFjZSBjcmVhdGlvbiwgdGhp
cyBwYXRjaCBzZXQgZW5hYmxlcyBzZWVkIGRldGFjaCBhbmQgcmVzZXQuIEJhY2sgdG8NCj4gPiB0
aGUgZXhhbXBsZSwgdGhlIG5ldyBuYW1lc3BhY2UgY3JlYXRpb24gbmV2ZXIgZmFpbHMgaWYgdGhp
cyBwYXRjaCBzZXQNCj4gPiBhcHBsaWVkLg0KPiA+ICAgICAgICAgIyBuZGN0bCBkZXN0cm95LW5h
bWVzcGFjZSBuYW1lc3BhY2UxLjAgLWYNCj4gPiAgICAgICAgIGRlc3Ryb3llZCAxIG5hbWVzcGFj
ZQ0KPiA+ICAgICAgICAgIyBuZGN0bCBjcmVhdGUtbmFtZXNwYWNlIC1yIHJlZ2lvbjEgLXMgMTI4
bSAtdCBwbWVtIC1tIGZzZGF4DQo+ID4gICAgICAgICB7DQo+ID4gICAgICAgICAgICJkZXYiOiJu
YW1lc3BhY2UxLjAiLA0KPiA+ICAgICAgICAgICAibW9kZSI6ImZzZGF4IiwNCj4gPiAgICAgICAg
ICAgIm1hcCI6ImRldiIsDQo+ID4gICAgICAgICAgICJzaXplIjoiMTI0LjAwIE1pQiAoMTMwLjAy
IE1CKSIsDQo+ID4gICAgICAgICAgICJ1dWlkIjoiMGQwZTc1MDYtZDEwOC00YTg4LTgyNGEtZWRl
ZjI2ZmQwMzk5IiwNCj4gPiAgICAgICAgICAgInJhd191dWlkIjoiZWZlYjk2NDctMTJmNS00NGNk
LThhNTItMmYzYTBkMTQ1ODlhIiwNCj4gPiAgICAgICAgICAgInNlY3Rvcl9zaXplIjo1MTIsDQo+
ID4gICAgICAgICAgICJibG9ja2RldiI6InBtZW0xIiwNCj4gPiAgICAgICAgICAgIm51bWFfbm9k
ZSI6MQ0KPiA+ICAgICAgICAgfQ0KPiA+ICAgICAgICAgIyBuZGN0bCBjcmVhdGUtbmFtZXNwYWNl
IC1yIHJlZ2lvbjEgLXMgMTI4bSAtdCBwbWVtIC1tIGZzZGF4DQo+ID4gICAgICAgICB7DQo+ID4g
ICAgICAgICAgICJkZXYiOiJuYW1lc3BhY2UxLjEiLA0KPiA+ICAgICAgICAgICAibW9kZSI6ImZz
ZGF4IiwNCj4gPiAgICAgICAgICAgIm1hcCI6ImRldiIsDQo+ID4gICAgICAgICAgICJzaXplIjox
MzAwMjM0MjQsDQo+ID4gICAgICAgICAgICJ1dWlkIjoiNjg5ODI4ZGMtODc3OS00MzRkLThlOTMt
MDQwNmQ0ZTFlNTM2IiwNCj4gPiAgICAgICAgICAgInJhd191dWlkIjoiZDg2ZTEwMjUtYzIyNC00
OGI2LWIyYTctNmNjZWYxNTJkNWZkIiwNCj4gPiAgICAgICAgICAgInNlY3Rvcl9zaXplIjo1MTIs
DQo+ID4gICAgICAgICAgICJibG9ja2RldiI6InBtZW0xLjEiLA0KPiA+ICAgICAgICAgICAibnVt
YV9ub2RlIjoxDQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiBUaGUgbW9kZSBkZXZkYXggKC1tIGRl
dmRheCkgaGFzIHRoZSBzYW1lIGlzc3VlLCB0aGlzIHBhdGNoIHNldCBjb3VsZA0KPiA+IGNvdmVy
IGl0Lg0KPiANCj4gVGhpcyBpcyBnb29kIGFuYWx5c2lzLCBidXQgSSBiZWxpZXZlIHRoaXMgaXMg
YmV0dGVyIGZpeGVkIC8gaGFuZGxlZCBpbg0KPiBuZGN0bCBkaXJlY3RseS4gVGhpcyBpcyBqdXN0
IG9uZSBvZiBhIGZldyByZWFzb25zIHRoYXQgbmFtZXNwYWNlDQo+IGNyZWF0aW9uIGNhbiBmYWls
LCBhbmQgaXQgc2hvdWxkIGJlIG5kY3RsJ3Mgam9iIHRvIHJlY292ZXIgZnJvbSBmYWlsZWQNCj4g
Y3JlYXRpb24uIFRoZSBrZXJuZWwgb25seSBwcm92aWRlcyB0aGUgbWVjaGFuaXNtIHRoZSBwb2xp
Y3kgb2Ygd2hhdCB0bw0KPiBkbyB3aXRoIGVycm9ycyBhbmQgaW50ZXJydXB0ZWQgbmFtZXNwYWNl
IGNyZWF0aW9uIGlzIHVwIHRvIHVzZXJzcGFjZS4NCj4gDQpXZWxsLCB0aGFua3MgZm9yIHlvdXIg
cmV2aWV3LiBJIGp1c3Qgc2VuZCBvdXQgdGhlIHBhdGNoIG9mIG5kY3RsIGZvciB0aGlzDQppc3N1
ZSwgcGxlYXNlIGhlbHAgdG8gcmV2aWV3IGFnYWluLiBNYW55IHRoYW5rcyENCmh0dHBzOi8vbGlz
dHMuMDEub3JnL3BpcGVybWFpbC9saW51eC1udmRpbW0vMjAxOC1TZXB0ZW1iZXIvMDE3Nzc4Lmh0
bWwNCg0KT2NlYW4uDQo+IEFsc28sIGluIHRoZSBmdXR1cmUsIHRoZSBwbGFuIGlzIHRvIGFsbG93
IG5hbWVzcGFjZXMgc21hbGxlciB0aGFuIGENCj4gc2VjdGlvbiBzaXplIHdoaWNoIHdpbGwgZml4
IHRoaXMgcGFydGljdWxhciBmYWlsaW5nIGNvbmRpdGlvbg0KPiBwcm9wZXJseS4NCkkgYW0gaW50
ZXJlc3RpbmcgdGhhdCB3aGF0IG1pbmltYWwgc2l6ZSBpcyBhbGxvd2VkIGZvciBuYW1lc3BhY2Ug
Y3JlYXRpb24uDQpJIG5lZWQgdGhpcyB0byBndWlkZSB0aGUgTlZESU1NIGVuYWJsZW1lbnQgb24g
TGVub3ZvIFRoaW5rU3lzdGVtIFNlcnZlcnMuDQoNCkkgc2VlIGZ1bmN0aW9uIG52ZGltbV9uYW1l
c3BhY2VfY29tbW9uX3Byb2JlIHJldHVybiBlcnJvciBpZiBzaXplIGlzIGxlc3MNCnRoYW4gTkRf
TUlOX05BTUVTUEFDRV9TSVpFKGVxdWFscyB0byBQQUdFX1NJWkUpLg0KCXNpemUgPSBudmRpbW1f
bmFtZXNwYWNlX2NhcGFjaXR5KG5kbnMpOw0KCWlmIChzaXplIDwgTkRfTUlOX05BTUVTUEFDRV9T
SVpFKSB7DQoJCWRldl9kYmcoJm5kbnMtPmRldiwgIiVwYSwgdG9vIHNtYWxsIG11c3QgYmUgYXQg
bGVhc3QgJSN4XG4iLA0KCQkJCSZzaXplLCBORF9NSU5fTkFNRVNQQUNFX1NJWkUpOw0KCQlyZXR1
cm4gRVJSX1BUUigtRU5PREVWKTsNCgl9DQoNCkkgYWxzbyBzZWUgZnVuY3Rpb24gbmRfbmFtZXNw
YWNlX3N0b3JlIHJldHVybiBlcnJvciBpZiBzaXplIGlzIGxlc3MgdGhhbiBTWl8xNk0uDQoJaWYg
KF9fbnZkaW1tX25hbWVzcGFjZV9jYXBhY2l0eShuZG5zKSA8IFNaXzE2TSkgew0KCQlkZXZfZGJn
KGRldiwgIiVzIHRvbyBzbWFsbCB0byBob3N0XG4iLCBuYW1lKTsNCgkJbGVuID0gLUVOWElPOw0K
CQlnb3RvIG91dF9hdHRhY2g7DQoJfQ0KDQpPY2Vhbi4NCg==
