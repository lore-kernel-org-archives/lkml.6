Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC20C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C422151C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pb6/o7M0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C422151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJMDrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:47:04 -0400
Received: from mail-eopbgr700070.outbound.protection.outlook.com ([40.107.70.70]:33600
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbeJMDrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZDqmy62GIkG79EPsSSxs7FAoPV8yHIcrTl9geXyJYU=;
 b=pb6/o7M0w/s5V5Lzc20fr+RLqOndYJ65Uk05W21rLjDlNqeoaERirewH5pwHebmfXvllSisN5pu4ShVnwbBqvvAfG8H2ZCSTk5207ldrL7pc69ycYwLy/lqh43/bhosR+xDGcKCDyukxk+vepww+00B87XCkbU+2GOtW9hQ+Whs=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1545.namprd12.prod.outlook.com (10.172.35.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Fri, 12 Oct 2018 20:12:51 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 20:12:51 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
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
Subject: Re: [PATCH v3 02/11] arch/x86: Rename the RDT functions and
 definitions
Thread-Topic: [PATCH v3 02/11] arch/x86: Rename the RDT functions and
 definitions
Thread-Index: AQHUYaGejOimsl+qUkq9JrCRHOwNbqUcA4kAgAAJFwA=
Date:   Fri, 12 Oct 2018 20:12:51 +0000
Message-ID: <b889a84a-8857-2dd3-3fad-1986a3fb47d8@amd.com>
References: <20181011203223.18157-1-babu.moger@amd.com>
 <20181011203223.18157-3-babu.moger@amd.com>
 <80310bdc-9b46-78a5-1920-4d7411348725@intel.com>
In-Reply-To: <80310bdc-9b46-78a5-1920-4d7411348725@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0149.namprd05.prod.outlook.com
 (2603:10b6:803:2c::27) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1545;20:BBgjwhue/lAGtXDKjn8kywKqW1igIeV29J2FL14Lyw6EcGTzaYMupfn3oKrV0m1osYQ/aiTnJTTIgXmeIdFSBPDmFIlegAufclzx0xYG/klQ1CD6gEUW3tgmr26At6+2wZ6NOmFg2Di0Auuwqu/ZVvnySy3sdrxvceq26Ns7ntaZBCc/zUctFiTP9hLKvKqv8eWetcbHH4MiSYbfv45S7HKNAiNr3yTYGlvL9kgwBkKhXYrNIneXGhdUl6dvKBJE
x-ms-office365-filtering-correlation-id: b4dc93c0-17b6-466c-7059-08d6307f164b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1545;
x-ms-traffictypediagnostic: DM5PR12MB1545:
x-microsoft-antispam-prvs: <DM5PR12MB1545A3C590D72E5200CC824895E20@DM5PR12MB1545.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB1545;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1545;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(7416002)(25786009)(2906002)(99286004)(7736002)(386003)(305945005)(26005)(5660300001)(6116002)(256004)(3846002)(6506007)(53546011)(6436002)(186003)(4326008)(2501003)(6246003)(8936002)(36756003)(2900100001)(14454004)(6486002)(11346002)(81166006)(486006)(81156014)(5250100002)(446003)(2616005)(68736007)(476003)(6512007)(66066001)(31686004)(110136005)(76176011)(97736004)(72206003)(229853002)(316002)(106356001)(52116002)(71190400001)(71200400001)(54906003)(8676002)(102836004)(478600001)(86362001)(2201001)(31696002)(105586002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1545;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WUUVTjG/MtmGAfHLJmc5Dh0WIdpXB6NtsNWYCYkp1xvS0ghLYsz7cp9C4F9sONubXuAhC/5sLPtwB12XvY0b2TBMkn3435skQe6gjtwJr1nc2/1WaW+csg1vRZeMC0kt2/0GNbNAxu+KkeBQwH4YTCuubmkp7ssmIx+zxDUasHsn+n2HysQTQJcXIUMyAPaN+FQdgtUNhY7YhJh/4kG5ckTjhkvGcuvcaot18oUI2pyIB5KspYxc3Frwk8oFRcVuYR5IoixXWNahZJ3PfYXejoZM7W4bPxR55JAFyRngNay+B4R5T7wlST/cufi5Dw8kq8Qpq/uGdQcVUd8sdxkN9n/JsYrKqeatwJaX5Po/qGo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <04D0AEF4F75EB7448B2B93AAC39F6122@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dc93c0-17b6-466c-7059-08d6307f164b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 20:12:51.6168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMC8xMi8yMDE4IDAyOjQwIFBNLCBSZWluZXR0ZSBDaGF0cmUgd3JvdGU6DQo+IEhpIEJh
YnUsDQo+IA0KPiBPbiAxMC8xMS8yMDE4IDE6MzMgUE0sIE1vZ2VyLCBCYWJ1IHdyb3RlOg0KPj4g
QEAgLTg4MywyMCArODgzLDIwIEBAIHN0YXRpYyBpbnQgX19pbml0IGludGVsX3JkdF9sYXRlX2lu
aXQodm9pZCkNCj4+ICAJcmR0X29ubGluZSA9IHN0YXRlOw0KPj4gIA0KPj4gIAlmb3JfZWFjaF9h
bGxvY19jYXBhYmxlX3JkdF9yZXNvdXJjZShyKQ0KPj4gLQkJcHJfaW5mbygiSW50ZWwgUkRUICVz
IGFsbG9jYXRpb24gZGV0ZWN0ZWRcbiIsIHItPm5hbWUpOw0KPj4gKwkJcHJfaW5mbygiUkVTQ1RS
TCAlcyBhbGxvY2F0aW9uIGRldGVjdGVkXG4iLCByLT5uYW1lKTsNCj4+ICANCj4+ICAJZm9yX2Vh
Y2hfbW9uX2NhcGFibGVfcmR0X3Jlc291cmNlKHIpDQo+PiAtCQlwcl9pbmZvKCJJbnRlbCBSRFQg
JXMgbW9uaXRvcmluZyBkZXRlY3RlZFxuIiwgci0+bmFtZSk7DQo+PiArCQlwcl9pbmZvKCJSRVND
VFJMICVzIG1vbml0b3JpbmcgZGV0ZWN0ZWRcbiIsIHItPm5hbWUpOw0KPj4gIA0KPiANCj4gSSdt
IHNvcnJ5IC0gSSBrbm93IGl0IHdhcyBtZSB3aG8gc3VnZ2VzdGVkIHRoZSBjaGFuZ2UgdG8gUkVT
Q1RSTCBidXQgSQ0KPiBjbGVhcmx5IGRpZCBub3QgY29uc2lkZXIgdGhlIGZpbmFsIHJlc3VsdCB3
aGljaCBpcyAoZm9yIGV4YW1wbGUpOg0KPiANCj4gcmVzY3RybDogUkVTQ1RSTCAlcyBhbGxvY2F0
aW9uIGRldGVjdGVkDQo+IA0KPiBQZXJoYXBzIHdlIGNvdWxkIGp1c3QgZHJvcCB0aGF0IFJFU0NU
UkwgdGV4dD8NCg0KWWVzLiBXZSBjYW4gZHJvcCBpdC4NCg0KPiANCj4gUmVpbmV0dGUNCj4gDQo=
