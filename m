Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B986FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8A620878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d6G6K3pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8A620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJHWE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:04:56 -0400
Received: from mail-eopbgr700062.outbound.protection.outlook.com ([40.107.70.62]:25600
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeJHWE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q34O2GkgDTVkRWqwqQQ+t1GP2XvL7/tVR9XyC4/fo4U=;
 b=d6G6K3pa0cNSdIrylYRzvjSaY1LN3ysO2IGtPCMeWDmlbF0wjOiK8Fkr1OAEDvQyLRwkjgEdFW9QWoOKa7JDhO8PLlV81GXk/ZIMaLT6tOUs6K9jIHZt8mzy3XdW8uE7NXF48U/kMvaGbNpVWvhQ2AWsbkfXAlodePcZWqVdmJc=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2732.namprd12.prod.outlook.com (20.176.118.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Mon, 8 Oct 2018 14:52:46 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7c34:f2e8:a8a9:cab8]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7c34:f2e8:a8a9:cab8%3]) with mapi id 15.20.1185.029; Mon, 8 Oct 2018
 14:52:46 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] KVM: X86: Add missing KVM_AMD dependency
Thread-Topic: [PATCH] KVM: X86: Add missing KVM_AMD dependency
Thread-Index: AQHUXNuvomFZI1DLe0yX5EjqqHuUCqURHf2AgAAWxYCAAAQ3AIABd9eAgAKJSoCAADlQgA==
Date:   Mon, 8 Oct 2018 14:52:46 +0000
Message-ID: <5e1de49e-9ec5-b11b-d38b-845d0274dc03@amd.com>
References: <1538765165-19177-1-git-send-email-linux@roeck-us.net>
 <749a21f9-ad88-af0e-bed7-b505ac57568d@redhat.com>
 <20181005220325.GA24365@roeck-us.net>
 <713d35b9-5dd5-284f-b514-7d2295a2db34@redhat.com>
 <b489282b-912d-e79d-3b7a-77784b8c51c9@roeck-us.net>
 <c7ae3d1a-5ec0-b2bb-b752-44ea99b1fdcd@redhat.com>
In-Reply-To: <c7ae3d1a-5ec0-b2bb-b752-44ea99b1fdcd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0006.namprd04.prod.outlook.com
 (2603:10b6:803:21::16) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2732;20:pBnhkoozwCl2ZEsY7mN+wqWPtEUOfMgnKWhOJu2gZBafA1kjP2RxId+zr+bUUArrcp0SKkp/LOb9qGSB85aWnyr/yx26xYR8J6Q7g24j86wQEvxOAmF3P9i/QoVCfJ63Ymm4GerX338qMTzg7pnhWK3HzrdO3nYqaJnNfNceJreQCkB5Fejigcc+K70/UmBoChvSDsGNezJBznU2z99IvnyrbI4H9076FCvLVkYmDBUBv47JQqLfdcJOadMFv4Jh
x-ms-office365-filtering-correlation-id: 9e5597a9-2103-422a-de55-08d62d2db57c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2732;
x-ms-traffictypediagnostic: DM6PR12MB2732:
x-microsoft-antispam-prvs: <DM6PR12MB27328AC330CA5BC295E1A658E5E60@DM6PR12MB2732.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:DM6PR12MB2732;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2732;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(3846002)(6116002)(446003)(11346002)(53546011)(106356001)(66066001)(486006)(2616005)(476003)(6346003)(102836004)(52116002)(7416002)(99286004)(26005)(186003)(14444005)(68736007)(53936002)(76176011)(7736002)(305945005)(256004)(4326008)(54906003)(2906002)(110136005)(105586002)(6506007)(386003)(14454004)(6436002)(71200400001)(71190400001)(97736004)(81166006)(8936002)(2900100001)(316002)(6486002)(36756003)(8676002)(81156014)(31696002)(6246003)(229853002)(31686004)(6512007)(25786009)(5250100002)(86362001)(93886005)(478600001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2732;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-microsoft-antispam-message-info: cIIbqUMA3xDedW1qimoPQYD4Q90vopRflBJKvWW0YA1LopqgN+Sm2quJAHUJzxNHl32PuALDvpsWEHbrPAj0RTgtjV054/xi81z6xYHijAcLDg1TpFM7jU7Vy4CDMAneeyiyENY5VpLmE5Q1NOnJRdYUwboHptueHsrdktE1uxoWDqDZ/Z3MqTbsrfhQAB4FLLoUxWidQeA/AgtijKp3SwSM/c87flzSxckbs/shoPk8tkjFw1KexttiX6Msbmhpmzy0u4GP6Xv3bo2OdMzgJtuO1YqvWxyVxSBloj6i5PDGnFrjCoYBnFuf2qR3WswMGv6D2wxc92IWm2lVzBcCJpRzYUnQ/PwtV1/K0A9sC0c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4744DD661266F48BF69069D8C06F6C4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5597a9-2103-422a-de55-08d62d2db57c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 14:52:46.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzA4LzIwMTggMDY6MjcgQU0sIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IE9uIDA2
LzEwLzIwMTggMjI6NDMsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+Pj4NCj4+Pj4+IE1heWJlIHRo
aXMgd29ya3MgYXMgd2VsbD/CoCBJIGhhdmVuJ3QgdGVzdGVkIGl0IHlldDoNCj4+Pj4+DQo+Pj4+
IEkgYW0gc3VyZSB0aGVyZSBhcmUgbWFueSBwb3NzaWJsZSBzb2x1dGlvbnMuIEkgd291bGQgcGVy
c29uYWxseQ0KPj4+PiBwcmVmZXIgb25lDQo+Pj4+IHRoYXQgZW5mb3JjZXMgS1ZNX0FNRD1tIHdp
dGggQ1JZUFRPX0RFVl9DQ1BfREQ9bSwgYnV0IHRoYXQgaXMganVzdCBtZS4NCj4+Pg0KPj4+IFdl
bGwsIEtWTV9BTUQ9eSBpcyBhIHJlbGF0aXZlbHkgdW51c3VhbCBjaG9pY2UgdG8gYmVnaW4gd2l0
aC7CoCBUaGUNCj4+DQo+PiBJdCBpcyBjb21tb24gZW5vdWdoIHRoYXQgd2UgYXJlIG5vdCB0aGUg
b25seSBvbmVzIGFmZmVjdGVkLiBBbHNvLCBldmVuIGENCj4+ICJyZWxhdGl2ZWx5IHVudXN1YWwg
Y2hvaWNlIiBzaG91bGQsIGluIG15IG9waW5pb24sIG5vdCByZXN1bHQgaW4gYSBidWlsZA0KPj4g
ZXJyb3IuDQo+IA0KPiBPZiBjb3Vyc2Ugbm90ISAgVGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgdG8g
c29sdmUgaXQgYnkgZGlzYWJsaW5nDQo+IEtWTV9BTURfU0VWICh3aGljaCBpcyB3aGF0IHRoZSBj
dXJyZW50IGNvZGUgYXR0ZW1wdHMgdG8gZG8sIGFuZCBteSBwYXRjaA0KPiBzaG91bGQgZml4IHRo
YXQpIG9yIEtWTV9BTUQgKHlvdXIgcGF0Y2gpLg0KDQoNCklNSE8sIFBhb2xvJ3MgcGF0Y2ggbWFr
ZSBzZW5zZTsgaXQgcmVtb3ZlcyBhbGwgdGhlIFNFViBzcGVjaWZpYyBjb2RlDQp3aGVuIEtWTV9B
TURfU0VWPW4uIEl0IHNhdmVzIH40SyBpbiB0ZXh0IHNlY3Rpb24uDQoNClBhb2xvLA0KDQpEb2Vz
IGl0IG1ha2Ugc2Vuc2UgdG8gbW92ZSBhbGwgdGhlIFNFViBzcGVjaWZpYyBjb2RlIGluIHN2bS1z
ZXYuYyA/DQpJIGFtIGxvb2tpbmcgdG8gYWRkIFNFViBtaWdyYXRpb24gc3VwcG9ydCB2ZXJ5IHNv
b24sIGFuZCBjYW4gc2VlDQpteXNlbGYgYWRkaW5nIG1vcmUgU0VWIGNvbW1hbmQgaGFuZGxpbmcg
d2hpY2ggd2lsbCBncm93IHN2bS5jIGZ1cnRoZXIuDQoNCi1CcmlqZXNoDQo=
