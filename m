Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506BBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0779620874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VWsnZ+hK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbeLQUJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:09:10 -0500
Received: from mail-eopbgr750054.outbound.protection.outlook.com ([40.107.75.54]:27269
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbeLQUJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQBSP4iOgV46kJok0q4pw1S7ynDDmdyvgMnqrbpfTj0=;
 b=VWsnZ+hKXbtdDDKo8vlgN5BsMno2UEZ0juOILNGZijue4n+tUx/QFAytgBzh/3EuDb+t8GiUcGehRN3DVv+M8azipAmStR1cEtpZNhcmPq3vyAN3BpttJeVZr8/f3eP+NDga27WQpiyTRcZUV20PtWRLkdIESNuyN58+tvNvGks=
Received: from BY2PR12MB0178.namprd12.prod.outlook.com (10.162.82.27) by
 BY2PR12MB0227.namprd12.prod.outlook.com (10.162.83.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 20:09:03 +0000
Received: from BY2PR12MB0178.namprd12.prod.outlook.com
 ([fe80::bd9a:fb2b:f12c:8c81]) by BY2PR12MB0178.namprd12.prod.outlook.com
 ([fe80::bd9a:fb2b:f12c:8c81%8]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 20:09:03 +0000
From:   "Wentland, Harry" <Harry.Wentland@amd.com>
To:     Lyude Paul <lyude@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>, Juston Li <juston.li@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [WIP PATCH 01/15] drm/dp_mst: Remove bogus conditional in
 drm_dp_update_payload_part1()
Thread-Topic: [WIP PATCH 01/15] drm/dp_mst: Remove bogus conditional in
 drm_dp_update_payload_part1()
Thread-Index: AQHUk0wKZw6gfQHxAkeSPHuIogd3dKV960KAgAV214A=
Date:   Mon, 17 Dec 2018 20:09:03 +0000
Message-ID: <1c77ddfa-df9c-8e6f-eb11-1069780360b2@amd.com>
References: <20181214012604.13746-1-lyude@redhat.com>
 <20181214012604.13746-2-lyude@redhat.com>
 <20181214084220.GL21184@phenom.ffwll.local>
In-Reply-To: <20181214084220.GL21184@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To BY2PR12MB0178.namprd12.prod.outlook.com
 (2a01:111:e400:585a::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR12MB0227;20:AOrn7AzF9DKBXOac25yKGuP0z9etoo9dTpHk/2//PEaIf9kCDlxNfSCMzSMG3gv9nqgJ0hJI3gjWq4GyaB3h5y74zqT8GBu8yyeAFVyxXVOifVCVenahKkloZCpCDMfywqOi9A40BIDHd4fqWva1DUnP++ZOK3DFA/bh5uHNOZEJ/ZWS/plpu3Xi72o+VxvkO5icNUvknXxD6H1T6srlPfHRyhDBoUgbGVzGf5Sw2Uu1BE5yYQdIZEs/HHCkKVfT
x-ms-office365-filtering-correlation-id: 28e6b4d9-7f29-4a23-3a06-08d6645b7d58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0227;
x-ms-traffictypediagnostic: BY2PR12MB0227:
x-microsoft-antispam-prvs: <BY2PR12MB0227E01F8E7602EE8F300AD78CBC0@BY2PR12MB0227.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR12MB0227;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0227;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(14454004)(53936002)(58126008)(39060400002)(6246003)(575784001)(102836004)(386003)(6506007)(110136005)(53546011)(478600001)(86362001)(316002)(97736004)(2906002)(229853002)(52116002)(66066001)(2201001)(31696002)(186003)(72206003)(2501003)(25786009)(6486002)(3846002)(6116002)(4001150100001)(106356001)(64126003)(6436002)(105586002)(65956001)(71190400001)(71200400001)(476003)(486006)(446003)(11346002)(2616005)(26005)(76176011)(14444005)(256004)(217873002)(81156014)(31686004)(8936002)(81166006)(8676002)(7416002)(305945005)(36756003)(68736007)(65826007)(99286004)(5660300001)(7736002)(6512007)(65806001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0227;H:BY2PR12MB0178.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EKWt8mR/zw2CIB1sF5sLqW7BZRKcPL9zvYTruElr5LEdOJUZw5Fu3zd3vY/XmnoAGGpdlbAkSKNa7jQcYEr+P+kcAcsLDBnps1cE+vDPt4TkXN//8ogCEp76V8KKNpQIYv3h09eoaSAb6vl7L55Porj67saj79fsddYKK5STJvfDUJcZB98l8iJnjWNCTzflhzu4+PRZGDqvtMaQD/6WnsjGltA3j8Vdu05A6jXWR4+HFWvVj8W9Dcl+Om0u4eWkj31oDbbroXHnSFc/z+ewp3AM+vCy6/gaUcEpTB/tfnmt2/xgXa+dBaDdrblNwKoB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <002FE8D0B2FDB64AA024230F1F72EB76@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e6b4d9-7f29-4a23-3a06-08d6645b7d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 20:09:03.1282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwMTgtMTItMTQgMzo0MiBhLm0uLCBEYW5pZWwgVmV0dGVyIHdyb3RlOg0KPiBPbiBU
aHUsIERlYyAxMywgMjAxOCBhdCAwODoyNTozMFBNIC0wNTAwLCBMeXVkZSBQYXVsIHdyb3RlOg0K
Pj4gVGhlcmUncyBubyByZWFzb24gd2UgbmVlZCB0aGlzLCBpdCdzIGp1c3QgY29uZnVzaW5nIGxv
b2tpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTHl1ZGUgUGF1bCA8bHl1ZGVAcmVkaGF0LmNv
bT4NCj4+IENjOiBKdXN0b24gTGkgPGp1c3Rvbi5saUBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBk
cml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jIHwgNCArLS0tDQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYw0KPj4gaW5kZXggYWQwZmI2ZDAwM2JlLi45YjFiNWM5
YjFmYTAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9n
eS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jDQo+PiBA
QCAtMTg5Niw5ICsxODk2LDcgQEAgaW50IGRybV9kcF91cGRhdGVfcGF5bG9hZF9wYXJ0MShzdHJ1
Y3QgZHJtX2RwX21zdF90b3BvbG9neV9tZ3IgKm1ncikNCj4+ICAJCQlyZXFfcGF5bG9hZC5udW1f
c2xvdHMgPSAwOw0KPj4gIAkJfQ0KPj4gIA0KPj4gLQkJaWYgKG1nci0+cGF5bG9hZHNbaV0uc3Rh
cnRfc2xvdCAhPSByZXFfcGF5bG9hZC5zdGFydF9zbG90KSB7DQo+PiAtCQkJbWdyLT5wYXlsb2Fk
c1tpXS5zdGFydF9zbG90ID0gcmVxX3BheWxvYWQuc3RhcnRfc2xvdDsNCj4+IC0JCX0NCj4+ICsJ
CW1nci0+cGF5bG9hZHNbaV0uc3RhcnRfc2xvdCA9IHJlcV9wYXlsb2FkLnN0YXJ0X3Nsb3Q7DQo+
IA0KPiBFbnRlcnRhaW5pbmchDQo+IA0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRlciA8ZGFu
aWVsLnZldHRlckBmZndsbC5jaD4NCj4gDQoNClJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8
aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCg0KSGFycnkNCg0KPj4gIAkJLyogd29yayBvdXQgd2hh
dCBpcyByZXF1aXJlZCB0byBoYXBwZW4gd2l0aCB0aGlzIHBheWxvYWQgKi8NCj4+ICAJCWlmICht
Z3ItPnBheWxvYWRzW2ldLm51bV9zbG90cyAhPSByZXFfcGF5bG9hZC5udW1fc2xvdHMpIHsNCj4+
ICANCj4+IC0tIA0KPj4gMi4xOS4yDQo+Pg0KPiANCg==
