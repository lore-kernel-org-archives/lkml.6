Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8362AC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED692098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l6duRm2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED692098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJCWpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:45:30 -0400
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:12236
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbeJCWp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwOhV/9yRnilPDc3SRzWiZHgX3GLlDRwJkdvu2vzOKQ=;
 b=l6duRm2E/FGaK5x/1pUMNEuRJAux8wkNKiPwGR28ICswsSlSaDOpsdECmfmhL5i1vEs9+w6m7hvWKlMIx60fAmBqIA173BmruThbvidI95AovjPbEc32grQfoxuAlsjl0oSOjB45QNk0VDV7yh5JmLvbtq0Q0KKS67hSX5VjhFc=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1787.namprd12.prod.outlook.com (10.175.91.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Wed, 3 Oct 2018 15:56:27 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 15:56:27 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 10/10] arch/x86: Introduce QOS feature for AMD
Thread-Topic: [RFC PATCH 10/10] arch/x86: Introduce QOS feature for AMD
Thread-Index: AQHUVDt7FEaq7WNkoUWHOChzTz42MaUMUqGAgAFoKYA=
Date:   Wed, 3 Oct 2018 15:56:27 +0000
Message-ID: <0d130ed3-a75f-c8b3-195e-a7016a45b1fe@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20180924191841.29111-11-babu.moger@amd.com>
 <20181002182717.GB92941@romley-ivt3.sc.intel.com>
In-Reply-To: <20181002182717.GB92941@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0012.namprd22.prod.outlook.com
 (2603:10b6:301:28::25) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1787;20:F+eTlI+DIUcSq0l8COZicrE0UNOVTwht1L4NmfTM8dMfkvyyY+90yTCKWDtbOniUdmkeUikFG820q5piWq+ltr0LN+axWLJXARGcyjhWNRKwDOGy9upqr0KSk8hi9kHlHswbO5+ygbshziGaKfHPTZmbsPDy0vTtGoJeiDYiw2BB7XRcpOiK8tcW+0xGNdTJb3QerfLgt6HFAkk5JypITKFPhN1b1j0hEEI8S/rvBuYM+YBH0VaPn0lqHcpxczy/
x-ms-office365-filtering-correlation-id: 261c0b1e-6bf5-43b6-3e77-08d62948c6be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1787;
x-ms-traffictypediagnostic: DM5PR12MB1787:
x-microsoft-antispam-prvs: <DM5PR12MB17873DF6D8B992BB4BD720D995E90@DM5PR12MB1787.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR12MB1787;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1787;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(66066001)(6116002)(11346002)(2616005)(14454004)(36756003)(446003)(72206003)(26005)(186003)(256004)(217873002)(4326008)(476003)(25786009)(486006)(478600001)(6246003)(81156014)(8676002)(76176011)(81166006)(5660300001)(102836004)(54906003)(53546011)(7416002)(2906002)(31686004)(386003)(2900100001)(52116002)(6506007)(6916009)(106356001)(6436002)(229853002)(68736007)(3846002)(97736004)(53936002)(316002)(6486002)(71200400001)(5250100002)(7736002)(105586002)(71190400001)(31696002)(86362001)(305945005)(99286004)(6512007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1787;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3Kk7ezP7116sYTvyq8r3ytu4myFEHkEwJfb393YXJMQc/3LOpw6SrqAphYnehXxR/lFl0nyO9QI5ZcND678iqA/RVHa+nCMOWGBr6Mg807NIP7OXUG1OB9mXlD/7+sa/PYROk/gSO3u1vRV/9KVvRbWHYLU9XCvi1vC1JIMlMbZybgReiIkrzrCW/fRBloj33aDK4TtvA/ylAUr09x2U2vW23daWFu03FuI79Xq842IUphW4mBK+OpVnsJGCqWWZfC2p2w0aGCfZhv2GlgWX+dBOCo/dO0KDAdCcx5OWnKZK1vAltrlL7FQBEUGk9qH3IME7Lg3Q3eZNwuep/rZ1W4eLpgsYKcIeeVZjHrfUPVw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2424D748E7C9624098CC667110140039@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261c0b1e-6bf5-43b6-3e77-08d62948c6be
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 15:56:27.2775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzAyLzIwMTggMDE6MjcgUE0sIEZlbmdodWEgWXUgd3JvdGU6DQo+IE9uIE1vbiwg
U2VwIDI0LCAyMDE4IGF0IDA3OjE5OjE2UE0gKzAwMDAsIE1vZ2VyLCBCYWJ1IHdyb3RlOg0KPj4g
IGludCBwYXJzZV9idyh2b2lkICpfYnVmLCBzdHJ1Y3QgcmR0X3Jlc291cmNlICpyLCAgc3RydWN0
IHJkdF9kb21haW4gKmQpOw0KPj4gK2ludCBwYXJzZV9id19hbWQodm9pZCAqX2J1Ziwgc3RydWN0
IHJkdF9yZXNvdXJjZSAqciwgIHN0cnVjdCByZHRfZG9tYWluICpkKTsNCj4gDQo+IFBsZWFzZSBu
b3RlIHRoZSB0eXBlIG9mIF9idWYgaW4gcGFyc2VfYncoKSBpcyBjaGFuZ2VkIGluIGxhdGVzdCBr
ZXJuZWwNCj4gdG8gZml4IHNvbWUgaXNzdWVzLiBQbGVhc2UgZm9sbG93IHRoZSBzYW1lIGRlZmlu
aXRpb24gb2YgcGFyc2VfYncoKSBpbg0KPiBwYXJzZV9id19hbWQoKS4NCg0KWWVzLCBJIG5vdGlj
ZWQgaXQuIFNhdyB0aGUgc2FtZSBpc3N1ZShtYmEgZGF0YSBwYXJzaW5nKSBhbmQgZm91bmQgaXQg
Zml4ZWQNCmluIDQtMTktcmM1LiBXaWxsIHJlLWJhc2UgdG8gdGhlIGxhdGVzdCBrZXJuZWwuDQo+
IA0KPiBUaGFua3MuDQo+IA0KPiAtRmVuZ2h1YQ0KPiANCg==
