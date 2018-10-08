Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E2FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6122145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ab8XaCdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6122145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJIAfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:35:51 -0400
Received: from mail-eopbgr680063.outbound.protection.outlook.com ([40.107.68.63]:16288
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbeJIAfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0HzBxZwtxI3tJRYBnK8fAhmQRoI114qLGhe7TlPRsQ=;
 b=ab8XaCdmagEn57H1U2ZDUQJzw6oLUEEK6UZxhMb3nN9nlNScOHKyZy41HXtHwcfTnpv1in1boQlj79PfWUnpzkmdh2xEIk2t6CEAem8W9EFUJOuGT+CYiyE1fqJ2MNZxUDgh8Xsxzt3XLiv6vseKZgAOmON+O/Ic5qwC+OTBdpo=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1684.namprd12.prod.outlook.com (10.172.19.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Mon, 8 Oct 2018 17:22:24 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5826:a5b3:996b:ce05]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5826:a5b3:996b:ce05%12]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 17:22:24 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peng Hao <peng.hao2@zte.com.cn>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
Thread-Topic: [PATCH] amdgpu/gmc : fix compile warning
Thread-Index: AQHUXINz8METxdpO60GfNTlgx6+1AqUQVG0AgASscICAAFz5gIAABCGAgAAGYYCAAB3BgIAAF8yA
Date:   Mon, 8 Oct 2018 17:22:24 +0000
Message-ID: <c6880c5b-e259-4923-8d5a-80c620563398@amd.com>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
 <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com>
 <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: DB6P18901CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:4:16::22) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1684;20:V/mIxMPzlh6PrCKB7NLSJD0fIWBZMLya+VJrKvcLPOKfimLT3u8MyghG35Yp2otyOoYSze92dL9wZcYck8IE2Rlhdz5qyqLBOTMxZSwelYsJotm/KaC+940+BtfqGSWeqsLB3EBtWut3wcZaN4O2aAx3HM0ESwqM9TWJIzQSHgP4lQl48ZhUWppmT+nxm15X2K20DB4Qk/71eTBX6aeJDVkYOMB2N/EFGj9RklcNUWc1Ss7OWmENin11VQKTMiyx
x-ms-office365-filtering-correlation-id: fc606be8-6348-4e42-7433-08d62d429c97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1684;
x-ms-traffictypediagnostic: BN6PR12MB1684:
x-microsoft-antispam-prvs: <BN6PR12MB16843B6E0EAADAD1C4418B2C83E60@BN6PR12MB1684.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991055);SRVR:BN6PR12MB1684;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1684;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(189003)(199004)(52314003)(31686004)(6486002)(966005)(6436002)(72206003)(6116002)(14454004)(186003)(478600001)(65806001)(8936002)(97736004)(65956001)(256004)(14444005)(106356001)(2900100001)(64126003)(105586002)(81156014)(8676002)(81166006)(102836004)(86362001)(54906003)(486006)(31696002)(6512007)(2906002)(53936002)(71190400001)(110136005)(71200400001)(58126008)(6306002)(25786009)(52116002)(2616005)(99286004)(93886005)(476003)(4326008)(446003)(316002)(11346002)(6506007)(76176011)(36756003)(386003)(6246003)(5660300001)(46003)(229853002)(305945005)(65826007)(68736007)(5250100002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1684;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Fs2S4CiBalKCA0p4csl2wanlADII1SuNA9jr1yTUHckdFlsMO1IwKfwQ+jeoQ+hvcY1IHzgKkyJb6ORQoP6qKi0saF7+SLL8VcZM7Xu3q75LFXc3u2AMJTuz0ANOFSjSN8T9zDxBzUTOQdUIvk7F6iW5tHt6w9me4PqrN/CAxj9Q8qgg0tQvQj7/cG5bCSbPBiBcWwiA3fSOV7mJuY2m3Aa4fGGvLF15HGEbJsRS5c0lU596DTGnHxuwzOeb49TopLxujUtJlwFnhwPKL1T6QM6b0F5MYAQ+UpIrVZqC18TccZeaEh/tuTvjliIVBLELcDT0c8+9T1+oJQXGOHQVd8QYwo4Ltr7Xz+tWjtdoLlY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <57AF7688D3F32A4F8E7AB8E29947EC48@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc606be8-6348-4e42-7433-08d62d429c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 17:22:24.5233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDguMTAuMjAxOCB1bSAxNzo1NyBzY2hyaWViIERldWNoZXIsIEFsZXhhbmRlcjoNCj4+Pj4g
T25lIHRoaW5nIEkgZm91bmQgbWlzc2luZyBpbiB0aGUgZGlzY3Vzc2lvbiB3YXMgdGhlIHJlZmVy
ZW5jZSB0byB0aGUNCj4+Pj4gQyBzdGFuZGFyZC4NCj4+Pj4gVGhlIEM5OSBzdGFuZGFyZCBzdGF0
ZXMgaW4gc2VjdGlvbiA2LjcuOCAoSW5pdGlhbGl6YXRpb24pIGNsYXVzZSAxOToNCj4+Pj4gIi4u
LiBhbGwNCj4+Pj4gc3Vib2JqZWN0cyB0aGF0IGFyZSBub3QgaW5pdGlhbGl6ZWQgZXhwbGljaXRs
eSBzaGFsbCBiZSBpbml0aWFsaXplZA0KPj4+PiBpbXBsaWNpdGx5IHRoZSBzYW1lIGFzIG9iamVj
dHMgdGhhdCBoYXZlIHN0YXRpYyBzdG9yYWdlIGR1cmF0aW9uIi4NCj4+Pj4gQ2xhdXNlIDIxIG1h
a2VzIGZ1cnRoZXIgcmVmZXJlbmNlIHRvIHBhcnRpYWwgaW5pdGlhbGl6YXRpb24sDQo+Pj4+IHN1
Z2dlc3RpbmcgdGhlIHNhbWUuIFZhcmlvdXMgb25saW5lIHJlc291cmNlcywgaW5jbHVkaW5nIHRo
ZSBnY2MNCj4+Pj4gZG9jdW1lbnRhdGlvbiwgYWxsIHN0YXRlIHRoZSBzYW1lLiBJIGRvbid0IGZp
bmQgYW55IHJlZmVyZW5jZSB0byBhDQo+Pj4+IHBhcnRpYWwgaW5pdGlhbGl6YXRpb24gd2hpY2gg
d291bGQgbGVhdmUgbWVtYmVycyBvZiBhIHN0cnVjdHVyZQ0KPj4+PiB1bmRlZmluZWQuIEl0IHdv
dWxkIGJlIGludGVyZXN0aW5nIGZvciBtZSB0byB1bmRlcnN0YW5kIGhvdyBhbmQgd2h5DQo+Pj4+
IHRoaXMgZG9lcyBub3QgYXBwbHkgaGVyZS4NCj4+Pj4NCj4+Pj4gSW4gdGhpcyBjb250ZXh0LCBp
dCBpcyBpbnRlcmVzdGluZyB0aGF0IHRoZSBvdGhlciA0OCBpbnN0YW5jZXMgb2YgdGhlDQo+Pj4+
IHsgeyAwIH0gfSBpbml0aWFsaXphdGlvbiBpbiB0aGUgc2FtZSBkcml2ZXIgZG9uJ3QgcmFpc2Ug
c2ltaWxhcg0KPj4+PiBjb25jZXJucywgbm9yIHNlZW1lZCB0byBoYXZlIGNhdXNlZCBhbnkgb3Bl
cmF0aW9uYWwgcHJvYmxlbXMuDQo+Pj4gRmVlbCBmcmVlIHRvIHByb3ZpZGUgcGF0Y2hlcyB0byBy
ZXBsYWNlIHRob3NlIHdpdGggbWVtc2V0KCkuDQo+Pj4NCj4+IE5vdCBtZS4gQXMgSSBzZWUgaXQs
IHRoZSBwcm9ibGVtLCBpZiBpdCBleGlzdHMsIHdvdWxkIGJlIGEgdmlvbGF0aW9uIG9mIHRoZSBD
DQo+PiBzdGFuZGFyZC4gSSBkb24ndCBiZWxpZXZlIGhhY2tpbmcgYXJvdW5kIGJhZCBDIGNvbXBp
bGVycy4gSSB3b3VsZCByYXRoZXINCj4+IGJsYWNrbGlzdCBzdWNoIGNvbXBpbGVycy4NCg0KV2Vs
bCB0aGVuIHlvdSB3b3VsZCBuZWVkIHRvIGJsYWNrbGlzdCBiYXNpY2FsbHkgYWxsIGdjYyB2YXJp
YW50cyBvZiB0aGUgDQpsYXN0IGRlY2FkZSBvciBzby4NCg0KSW5pdGlhbGl6aW5nIG9ubHkga25v
d24gbWVtYmVycyBvZiBzdHJ1Y3R1cmVzIGlzIGEgcGVyZmVjdGx5IHZhbGlkIA0Kb3B0aW1pemF0
aW9uIGFuZCB3ZWxsIGtub3duIGlzc3VlIHdoZW4geW91IHRoZW4gY29tcGFyZSB0aGUgc3RydWN0
dXJlIA0Kd2l0aCBtZW1jcHkoKSBvciB1c2UgdGhlIGJ5dGVzIGZvciBoYXNoaW5nIG9yIHNvbWV0
aGluZyBzaW1pbGFyLg0KDQo+Pj4+IEFueXdheSwgSSBmaXhlZCB1cCB0aGUgY29kZSBpbiBvdXIg
dHJlZSAod2l0aCB7IH0pLCBzbyBJJ2xsIGxlYXZlIGl0DQo+Pj4+IHVwIHRvIHlvdSBmb2xrcyB0
byBkZWNpZGUgd2hhdCBpZiBhbnl0aGluZyB0byBkbyBhYm91dCBpdC4NCj4+PiBXZWxsIGNvbnNp
ZGVyaW5nIHRoZSBrbm93biBwcm9ibGVtcyB3aXRoIHt9IGluaXRpYWxpemF0aW9uIEknbQ0KPj4+
IGNlcnRhaW5seSByZWplY3RpbmcgYWxsIHBhdGNoZXMgd2hpY2ggdHVybnMgbWVtc2V0KCkgaW50
byB7fS4NCj4+Pg0KPj4gUGxlYXNlIHBvaW50IG1lIHRvIHNwZWNpZmljIGluc3RhbmNlcyBvZiB0
aGlzIHByb2JsZW0uDQoNClNlZSBoZXJlIGZvciBhIGdvb2QgZXhhbXBsZSBvZiBob3cgcGVvcGxl
IHRyeSB0byBhdm9pZCBpc3N1ZXM6IA0KaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9tZXNh
L21lc2EvY29tbWl0Lz9pZD05NDIyOTk5ZTQwNDFkNGU5ODRhY2JkMmY0NDgxM2Q1OTI4ZDIwZjE4
DQoNCj4gSSB0aGluayB0aGVyZSBhcmUgYSBudW1iZXIgb2YgcGxhY2VzIGluIERDIChkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkpIHdoZXJlIHdlIGFwcGxpZWQgdGhlIG9yaWdpbmFsIHByb3Bv
c2VkIHNvbHV0aW9uIGJlZm9yZSByZWFsaXppbmcgdGhhdCBpdCB3b3VsZCBvbmx5IGluaXRpYWxp
emUgdGhlIGZpcnN0IGVsZW1lbnQuICBJdCB3b3VsZCBiZSBuaWNlIHRvIGdldCB0aGVtIGZpeGVk
IHVwLg0KDQpZZXMsIGFncmVlLg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gQWxleA0KPg0KDQo=
