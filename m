Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B4C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF9F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J8cZsXCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF9F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeJLWNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:13:41 -0400
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:44161
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728860AbeJLWNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgwY8c9xwVg4hfx7d2fEKWUU9vQXQ299Wmh9QNTrJHg=;
 b=J8cZsXCPUPsBVzr7O9MxYb/+XIdfE3VC7Is4pNfJyvdHQPPloh4Mw6H/OMbaCIqef+3wRr99h6nWv0GDa4ZQQFwSNplfEf3Z+Nc+tUW8kUSLxiEp9ax6FGoi37/OISX/UvkPPZhy6mCwb1cpNCQXuX6n+8QN/C6Ze244rbLmKaw=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1659.namprd12.prod.outlook.com (10.172.40.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Fri, 12 Oct 2018 14:40:50 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 14:40:50 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@suse.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
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
Subject: Re: [PATCH v3 09/11] arch/x86: Introduce new config parameter AMD_QOS
Thread-Topic: [PATCH v3 09/11] arch/x86: Introduce new config parameter
 AMD_QOS
Thread-Index: AQHUYaGv1vrx53eHGU6x4h2+Q6V546UamQ+AgAEWzYA=
Date:   Fri, 12 Oct 2018 14:40:50 +0000
Message-ID: <0cf1ea65-0528-b133-2b89-2e04644ea2e6@amd.com>
References: <20181011203223.18157-1-babu.moger@amd.com>
 <20181011203223.18157-10-babu.moger@amd.com> <20181011220255.GB21876@zn.tnic>
In-Reply-To: <20181011220255.GB21876@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0029.namprd02.prod.outlook.com
 (2603:10b6:803:2e::15) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1659;20:w6sB32+RGk7m+GYbUVZ1LWi4nHV+ZXWwIN9EnRqxBxathC9S6u/5SJXXYr1/4W3NoURcjWQTK0cMDz61G5wF4FR4tKM0N1De0D8fT3DYQjgZB5FFGvFle6vvS5E+vTOaXkSpQBd+UXQEgsZeP8QkJFv2UqTku6OF0nwiJlH4PlUyE3rntZl1YTEq8mDYpOZcuBfZjbGgXAf7tSj/yoer3fcEam+WknRU2N7GNRtXzF8P2Vla8cElqZTKQA8mQYiF
x-ms-office365-filtering-correlation-id: aae0f214-ffeb-4049-1be8-08d63050b478
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1659;
x-ms-traffictypediagnostic: DM5PR12MB1659:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB1659F89A6B0B1D09234E533595E20@DM5PR12MB1659.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB1659;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1659;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(346002)(39860400002)(199004)(189003)(305945005)(2900100001)(316002)(25786009)(36756003)(14444005)(53936002)(5660300001)(6916009)(446003)(256004)(2616005)(476003)(76176011)(11346002)(5250100002)(66066001)(6116002)(486006)(3846002)(53546011)(52116002)(99286004)(186003)(8936002)(31696002)(86362001)(81156014)(54906003)(478600001)(105586002)(81166006)(8676002)(2906002)(6506007)(386003)(68736007)(102836004)(26005)(106356001)(229853002)(97736004)(7736002)(71200400001)(14454004)(71190400001)(7416002)(4326008)(72206003)(6512007)(6486002)(31686004)(6436002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1659;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vFE/ACSvVPqwRZBXy6LH+fubu2IuU+CqaE+eCOjQ9pRWFWMmM/opqlIkZE5pXY2s2xMl9lh69zQ3RN9Enc+ZVmhprGvjqsURK4bKCQh+PiCQB14FgMYATs66Lt/5qWTeOfz1dRjzjEkcIps/1uzDpqtIIGU+8S2hn6SNnUJm73ZtvhXI6diYQdUDppkXRvxykfAh/c/InPONJn9Kgod43TbSJwfrFQ3qc8dZMjDCP2FVoxYOqDqMFQs3M+mzv5vM6hVGaWoWOMVrKPgJ6SYG7T2+fr/Tqu/HP+8NdJu+tJONBSBy5ciMEP6Yzp0nEhZ1H+FFpQHB6AonUPCTsyMKdpaAaTbAWZoilTfO2kJz9Zc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <648EA752DE2BF34282A261ACC1F4861C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae0f214-ffeb-4049-1be8-08d63050b478
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 14:40:50.6994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm9yaXMsDQoNCk9uIDEwLzExLzIwMTggMDU6MDIgUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToN
Cj4gT24gVGh1LCBPY3QgMTEsIDIwMTggYXQgMDg6MzM6MzVQTSArMDAwMCwgTW9nZXIsIEJhYnUg
d3JvdGU6DQo+PiBJbnRyb2R1Y2VzIHRoZSBuZXcgY29uZmlnIHBhcmFtZXRlciBBTURfUU9TLiBU
aGlzIHBhcmFtZXRlciB3aWxsIGJlDQo+PiB1c2VkIHRvIGVuYWJsZSBjYWNoZSBhbmQgbWVtb3J5
IGJhbmR3aWR0aCBhbGxvY2F0aW9uIGFuZCBtb25pdG9yaW5nDQo+PiBmZWF0dXJlcyBvbiBBTUQg
cHJvY2Vzc29ycy4gVGhpcyB3aWxsIGVuYWJsZSBjb21tb24gY29uZmlnIHBhcmFtZXRlcg0KPj4g
UkVTQ1RSTCBpZiBzZWxlY3RlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxi
YWJ1Lm1vZ2VyQGFtZC5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL3g4Ni9LY29uZmlnIHwgMTcgKysr
KysrKysrKysrKysrKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9LY29uZmlnIGIvYXJjaC94
ODYvS2NvbmZpZw0KPj4gaW5kZXggOTFhNzAzZWJkYzA0Li41Y2VmNTU5MzVhNWEgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL3g4Ni9LY29uZmlnDQo+PiArKysgYi9hcmNoL3g4Ni9LY29uZmlnDQo+PiBA
QCAtNDU4LDkgKzQ1OCwyNCBAQCBjb25maWcgSU5URUxfUkRUDQo+PiAgDQo+PiAgCSAgU2F5IE4g
aWYgdW5zdXJlLg0KPj4gIA0KPj4gK2NvbmZpZyBBTURfUU9TDQo+PiArCWJvb2wgIkFNRCBRdWFs
aXR5IG9mIFNlcnZpY2Ugc3VwcG9ydCINCj4+ICsJZGVmYXVsdCBuDQo+PiArCWRlcGVuZHMgb24g
WDg2ICYmIENQVV9TVVBfQU1EDQo+IA0KPiBXaHkgdGhlIFg4NiBkZXBlbmRlbmN5IHRvbz8gQ1BV
X1NVUF9BTUQgaXMgeDg2LXNwZWNpZmljIGFuZCBpbmRpcmVjdGx5DQo+IGltcGxpZXMgWDg2LCBJ
J2Qgc2F5Lg0KDQpUaGF0IGlzIGNvcnJlY3QuIENQVV9TVVBfQU1EIGltcGxpY2l0bHkgbWVhbnMg
eDg2Lg0KVG8gYmUgbW9yZSBzcGVjaWZpYywgSSB3aWxsIGNoYW5nZSBpdCB0bw0KImRlcGVuZHMg
b24gWDg2XzY0ICYmIENQVV9TVVBfQU1EIiBhcyB0aGlzIGZlYXR1cmUgaXMgZm9yIFg4Nl82NCBv
bmx5Lg0KVGhhbmtzDQoNCg==
