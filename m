Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C7ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9FB20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tCkBtasV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9FB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJ0CJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:09:30 -0400
Received: from mail-eopbgr690051.outbound.protection.outlook.com ([40.107.69.51]:30992
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbeJ0CJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNrfa4ebSpCOz6oEHQUGIDr1mMN8R0RZ2v/U1YO+FcI=;
 b=tCkBtasV1Nf3oiUPREWaxbXrOhKOaKQcBJaXr7Oyy6MTEcmIIzt5P1WjmmYAVfNprh8+NaYtLxumEe8Eh4xd9veT6UpLHuzuMsj4lBcXnWm4pZ7BhxwcPpES4YrRaUzUKlzCdpsz1LMWrO1S7XJVWoX1wOGJ11sAq6SyYN0ir4I=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1244.namprd12.prod.outlook.com (10.168.237.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Fri, 26 Oct 2018 17:30:23 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%3]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 17:30:23 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 00/13] arch/x86: AMD QoS support
Thread-Topic: [PATCH v5 00/13] arch/x86: AMD QoS support
Thread-Index: AQHUZzUuNvwvLZwExEq0GgZvZL3+EKUx1LSA
Date:   Fri, 26 Oct 2018 17:30:23 +0000
Message-ID: <8e9cf809-8827-d4f6-633d-b4212f6cabc4@amd.com>
References: <20181018225124.23043-1-babu.moger@amd.com>
In-Reply-To: <20181018225124.23043-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1244;20:f07hayPONWkYG17vlWkSVSP6WyszI8xA7ZCSq9+cMIPjYDC3jMAroNHg3BmGs91BSuhl/llh5bUJ2j67fXBjH9ajZmzXilPQ5zol0yC3jKK3lcImsCboXrAp4f384V465451kOJ2p1VkcVyIPZLmVItcfkyTJI5Ugn/WWmzAfYFiQ1mWeMMLWCO/S9pQGZ/WgyNYwDpOTO+ogr+lzQGoFw0ropq+2MKC/XTzQ88c28ebBdsmyaxqGvWn6kafXq9B
x-ms-office365-filtering-correlation-id: 89969d4e-6ee7-4551-e1dd-08d63b68b565
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1244;
x-ms-traffictypediagnostic: DM5PR12MB1244:
x-microsoft-antispam-prvs: <DM5PR12MB12447A27855171789582750295F00@DM5PR12MB1244.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(269456686620040)(767451399110)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1244;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1244;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(14444005)(68736007)(86362001)(486006)(76176011)(6486002)(2501003)(229853002)(99286004)(52116002)(53546011)(2906002)(102836004)(6506007)(5250100002)(26005)(386003)(31686004)(81166006)(256004)(36756003)(6512007)(6306002)(7406005)(8936002)(81156014)(97736004)(2201001)(6436002)(7416002)(25786009)(2900100001)(31696002)(966005)(478600001)(71200400001)(105586002)(71190400001)(5660300001)(53936002)(8676002)(305945005)(72206003)(4326008)(66066001)(316002)(110136005)(14454004)(54906003)(6116002)(6246003)(7736002)(186003)(446003)(11346002)(106356001)(476003)(2616005)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1244;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9GP1unSZArEVXtsbPLa1GtPKxRy//1XBiCRB4YTsd8QX9OTFSErJa96qzvJ4HQ9guwrVEYr9V+xXZBPkAHokoMjhZrqdXX170OS/UuBLKLq0Bs/HE50l6KVaTqbQUxA3uI9zHZ9KehOKGb9nrXJRStGIlAKSX1/hyv7qk35gDhppteICTuRE5t+CW+d8X1v4mE5mUgP8rxVLWh4LSTh0ANHfp3xBj1bS2wQksVxY27o6TOLHDHV5zEwaDak0ILvOb+WrB8vrVEn6eKf51hkqWH8947OK+OU+O1fTdJnVEHrzoSY01ytQrvVitVhrOJIXAcyn51Cj7Eben5waqlgzt9dCh9JPf7pav6eA5Wj9TYU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFC4B6D450651645BE58369099D3FE70@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89969d4e-6ee7-4551-e1dd-08d63b68b565
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 17:30:23.6119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzLA0KDQpPbiAxMC8xOC8xOCA1OjUyIFBNLCBNb2dlciwgQmFidSB3cm90ZToNCj4g
VGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBBTUQ2NCBhcmNoaXRlY3R1cmFsIGV4dGVuc2lv
bnMgZm9yIFBsYXRmb3JtDQo+IFF1YWxpdHkgb2YgU2VydmljZS4gVGhlc2UgZXh0ZW5zaW9ucyBh
cmUgaW50ZW5kZWQgdG8gcHJvdmlkZSBmb3IgdGhlDQo+IG1vbml0b3Jpbmcgb2YgdGhlIHVzYWdl
IG9mIGNlcnRhaW4gc3lzdGVtIHJlc291cmNlcyBieSBvbmUgb3IgbW9yZQ0KPiBwcm9jZXNzb3Jz
IGFuZCBmb3IgdGhlIHNlcGFyYXRlIGFsbG9jYXRpb24gYW5kIGVuZm9yY2VtZW50IG9mIGxpbWl0
cyBvbg0KPiB0aGUgdXNlIG9mIGNlcnRhaW4gc3lzdGVtIHJlc291cmNlcyBieSBvbmUgb3IgbW9y
ZSBwcm9jZXNzb3JzLg0KPiANCj4gVGhlIG1vbml0b3JpbmcgYW5kIGVuZm9yY2VtZW50IGFyZSBu
b3QgbmVjZXNzYXJpbHkgYXBwbGllZCBhY3Jvc3MgdGhlDQo+IGVudGlyZSBzeXN0ZW0sIGJ1dCBp
biBnZW5lcmFsIGFwcGx5IHRvIGEgUU9TIGRvbWFpbiB3aGljaCBjb3JyZXNwb25kcyB0bw0KPiBz
b21lIHNoYXJlZCBzeXN0ZW0gcmVzb3VyY2UuICBUaGUgc2V0IG9mIHJlc291cmNlcyB3aGljaCBh
cmUgbW9uaXRvcmVkIGFuZA0KPiB0aGUgc2V0IGZvciB3aGljaCB0aGUgZW5mb3JjZW1lbnQgb2Yg
bGltaXRzIGlzIHByb3ZpZGVkIGFyZSBpbXBsZW1lbnRhdGlvbg0KPiBkZXBlbmRlbnQuIFBsYXRm
b3JtIFFPUyBmZWF0dXJlcyBhcmUgaW1wbGVtZW50ZWQgb24gYSBsb2dpY2FsIHByb2Nlc3NvciBi
YXNpcy4NCj4gVGhlcmVmb3JlLCBtdWx0aXBsZSBoYXJkd2FyZSB0aHJlYWRzIG9mIGEgc2luZ2xl
IHBoeXNpY2FsIENQVSBjb3JlIG1heSBoYXZlDQo+IGluZGVwZW5kZW50IHJlc291cmNlIG1vbml0
b3JpbmcgYW5kIGVuZm9yY2VtZW50IGNvbmZpZ3VyYXRpb25zLg0KPiANCj4gQU1EJ3MgbmV4dCBn
ZW5lcmF0aW9uIG9mIHByb2Nlc3NvcnMgc3VwcG9ydCBmb2xsb3dpbmcgUW9TIHN1Yi1mZWF0dXJl
cy4NCj4gLSBMMyBDYWNoZSBhbGxvY2F0aW9uIGVuZm9yY2VtZW50DQo+IC0gTDMgQ2FjaGUgb2Nj
dXBhbmN5IG1vbml0b3JpbmcNCj4gLSBMMyBDb2RlLURhdGEgUHJpb3JpdGl6YXRpb24gc3VwcG9y
dA0KPiAtIE1lbW9yeSBCYW5kd2lkdGggRW5mb3JjZW1lbnQoQWxsb2NhdGlvbikNCj4gDQo+IFRo
ZSBwdWJsaWMgc3BlY2lmaWNhdGlvbiBmb3IgdGhpcyBmZWF0dXJlIGlzIGF2YWlsYWJsZSBhdA0K
PiBodHRwczovL2RldmVsb3Blci5hbWQuY29tL3dwLWNvbnRlbnQvcmVzb3VyY2VzLzU2Mzc1LnBk
Zg0KPiANCj4gT2J2aW91c2x5LCB0aGVyZSBhcmUgbXVsdGlwbGUgd2F5cyB3ZSBjYW4gZ28gYWJv
dXQgdGhlc2UgY2hhbmdlcy4gV2UgZmVsdA0KPiBpdCBpcyBhcHByb3ByaWF0ZSB0byByZW5hbWUg
YW5kIHJlLW9yZ2FuaXplIHRoZSBjb2RlIGxpdHRsZSBiaXQgYmVmb3JlDQo+IG1ha2luZyB0aGUg
ZnVuY3Rpb25hbCBjaGFuZ2VzLiBUaGUgZmlyc3QgZmV3IHBhdGNoZXMoMS0xMCkgcmVuYW1lcyBh
bmQNCj4gcmUtb3JnYW5pemVzIHRoZSBzb3VyY2VzIGluIHByZXBhcmF0aW9uLiBSZXN0IG9mIHRo
ZSBwYXRjaGVzKDctMTEpIGFkZHMNCj4gc3VwcG9ydCBmb3IgQU1EIFFvUyBmZWF0dXJlcy4NCj4g
DQo+IFBsZWFzZSByZXZpZXcgYW5kIHByb3ZpZGUgbWUgZmVlZGJhY2suDQo+IA0KPiBDaGFuZ2Vz
IGZyb20gdjQgLT4gdjU6DQo+ICBhLiBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBGZW5naHVhIFl1
Lg0KPiAgYi4gVGhlIGZ1bmN0aW9ucyB1cGRhdGVfbWJhX2J3IGFuZCBzZXRfbWJhX3NjIGlzIG5v
dCByZXF1aXJlZCBmb3IgQU1ELg0KPiAgICAgUmVtb3ZlZCBhbGwgdGhlIGNoYW5nZXMgcmVsYXRl
ZCB0byB0aGVzZSBmdW5jdGlvbnMuDQo+IA0KPiBDaGFuZ2VzIGZyb20gdjMgLT4gdjQ6DQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxODEwMTUyMDU1MTQuMjUzODctMS1iYWJ1Lm1v
Z2VyQGFtZC5jb20vDQo+ICBhLiBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBSZWluZXR0ZSBDaGF0
cmUgYW5kIEJvcmlzbGF2IFBldGtvdi4NCj4gIGIuIFJlbW92ZWQgWDg2IGRlcGVuZGFuY3kgZm9y
IENPTkZJR19BTURfUU9TLiBJbXBsaWNpdGx5IGlzIGl0IGFscmVhZHkNCj4gICAgIGRlcGVuZGVu
dCBvbiBYODYuDQo+ICBjLiBVcGRhdGVkIHRoZSBNQUlOVEFJTkVSIGZpbGUgZm9yIG5hbWUgY2hh
bmdlcy4NCj4gIGQuIEFkZHJlc3NlZCBtb3N0IG9mICJjaGVja3BhdGNoLnBsIC0tc3RyaWN0IiBp
c3N1ZXMuDQo+ICBkLiBVcGRhdGVkIERvY3VtZW50YXRpb24veDg2L3Jlc2N0cmxfdWkudHh0KHBy
ZXZpb3VzbHkNCj4gICAgIGludGVsX3JkdF91aS50eHQpIGZpbGUgd2l0aCBBTUQgc3BlY2lmaWMg
ZGV0YWlscy4gQ2hhbmdlZCBmZXcgbmFtZXMNCj4gICAgIHRvIHJlc2N0cmwgZnJvbSBpbnRlbF9y
ZHQuDQo+IA0KPiBDaGFuZ2VzIGZyb20gdjIgLT4gdjM6DQo+ICBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sLzIwMTgxMDExMjAzMjIzLjE4MTU3LTEtYmFidS5tb2dlckBhbWQuY29tLw0KPiAg
YS4gUmViYXNlZCB0aGUgcGF0Y2hlcyBvbiB0b3Agb2YgYmVsb3cgYnJhbmNoIGFzIHN1Z2dlc3Rl
ZCBieSBUaG9tYXMgR2xlaXhuZXIuDQo+ICAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgeDg2L2NhY2hlDQo+ICBiLiBBZGRyZXNzZWQg
Y29tbWVudHMgZnJvbSBSZWluZXR0ZSBDaGF0cmUsIEZlbmdodWEgWXUgYW5kIEJvcmlzbGF2IFBl
dGtvdi4NCj4gIGMuIE1haW4gY2hhbmdlcyBhcmUgcmVsYXRlZCB0byByZW5hbWluZyB0aGUgZmls
ZXMgYW5kIGZ1bmN0aW9ucy4NCj4gICAgIFJlbmFtZWQgZnJvbSBpbnRlbF9yZHQgdG8gbW9yZSBn
ZW5lcmljIHJlc2N0cmwocGF0Y2hlcyAxIHRvIDMpLg0KPiAgZC4gQ29uZmlnIHBhcmFtZXRlciBj
aGFuZ2VkIGZyb20gUExBVEZPUk1fUU9TIHRvIG1vcmUgZ2VuZXJpYyBSRVNDVFJMLg0KPiAgZS4g
Rml4ZWQgbWlub3IgaW5kZW50YXRpb24gaXNzdWVzLg0KPiANCj4gQ2hhbmdlcyBmcm9tIHYxIC0+
IHYyOg0KPiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE4MTAwNTIwNTUxMi4yOTU0
NS0xLWJhYnUubW9nZXJAYW1kLmNvbS8NCj4gIGEuIFJlbW92ZWQgUkZDIGZyb20gc3ViamVjdCBo
ZWFkZXIuIEJhc2VkIG9uIHRoZSBkaXNjdXNzaW9uIHNvIGZhciwgDQo+ICAgICBwbGFuIGlzIHRv
IGdvIGFoZWFkIHdpdGggdGhlc2UgcGF0Y2hlcyBhbmQgZXZlbnR1YWxseSByZS1zdHJ1Y3R1cmUN
Cj4gICAgIHRoZSBjb2RlIHRvIG1ha2UgYXJjaCBhbmQgbm9uLWFyY2ggc2VwYXJhdGUuDQo+ICBi
LiBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBSZWluZXR0ZSBDaGF0cmUgYW5kIEZlbmdodWEgWXUu
DQo+ICBjLiBTZXBhcmF0ZWQgcXVpcmtzIGFuZCBNQkEgZnJvbSByZHQgaW5pdCBjb2RlLiBLZXB0
IHRoZSByZXN0IG9mIHRoZQ0KPiAgICAgY29kZSBhcyBpcy4NCj4gIGQuIEFkZGVkIF9pbnRlbCBz
dWZmaXhlcyBhbGwgdGhlIEludGVsIG9ubHkgY29kZSBqdXN0IGxpa2UgQU1EIGNvZGUuDQo+ICBl
LiBBZGRlZCBvbmUgbW9yZSBwYXRjaCB0byBicmluZyB0aGUgbWFjcm9zIGludG8gaGVhZGVyIGZp
bGUuDQo+ICBmLiBGZXcgbWlub3IgdGV4dCBjaGFuZ2VzLg0KPiANCj4gdjE6DQo+ICBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTgwOTI0MTkxODQxLjI5MTExLTEtYmFidS5tb2dlckBh
bWQuY29tLw0KPiANCj4gDQo+IEJhYnUgTW9nZXIgKDEyKToNCj4gICBhcmNoL3g4NjogU3RhcnQg
cmVuYW1pbmcgdGhlIHJkdCBmaWxlcyB0byBtb3JlIGdlbmVyaWMgbmFtZXMNCj4gICBhcmNoL3g4
NjogUmVuYW1lIHRoZSBSRFQgZnVuY3Rpb25zIGFuZCBkZWZpbml0aW9ucw0KPiAgIGFyY2gveDg2
OiBSZS1hcnJhbmdlIFJEVCBpbml0IGNvZGUNCj4gICBhcmNoL3g4NjogQnJpbmcgYWxsIHRoZSBt
YWNyb3MgdG8gcmVzY3RybC5oDQo+ICAgYXJjaC94ODY6IEludHJvZHVjZSBhIG5ldyBjb25maWcg
cGFyYW1ldGVyIFJFU0NUUkwNCj4gICBhcmNoL3g4NjogVXNlIG5ldyBjb25maWcgcGFyYW1ldGVy
IFJFU0NUUkwgZm9yIGNvbXBpbGF0aW9uDQo+ICAgYXJjaC94ODY6IEluaXRpYWxpemUgdGhlIHJl
c291cmNlIGZ1bmN0aW9ucyB0aGF0IGFyZSBkaWZmZXJlbnQNCj4gICBhcmNoL3g4NjogQnJpbmcg
Y2JtX3ZhbGlkYXRlIGZ1bmN0aW9uIGludG8gdGhlIHJlc291cmNlIHN0cnVjdHVyZQ0KPiAgIGFy
Y2gveDg2OiBJbnRyb2R1Y2UgbmV3IGNvbmZpZyBwYXJhbWV0ZXIgQU1EX1FPUw0KPiAgIGFyY2gv
eDg2OiBJbnRyb2R1Y2UgUU9TIGZlYXR1cmUgZm9yIEFNRA0KPiAgIERvY3VtZW50YXRpb24veDg2
OiBSZW5hbWUgYW5kIHVwZGF0ZSBpbnRlbF9yZHRfdWkudHh0DQo+ICAgTUFJTlRBSU5FUlM6IFVw
ZGF0ZSB0aGUgZmlsZSBhbmQgZG9jdW1lbnRhdGlvbiBuYW1lcyBpbiBhcmNoL3g4Ng0KPiANCj4g
U2hlcnJ5IEh1cndpdHogKDEpOg0KPiAgIGFyY2gveDg2OiBBZGQgQU1EIGZlYXR1cmUgYml0IFg4
Nl9GRUFUVVJFX01CQSBpbiBjcHVpZCBiaXRzIGFycmF5DQo+IA0KPiAgLi4uL3g4Ni97aW50ZWxf
cmR0X3VpLnR4dCA9PiByZXNjdHJsX3VpLnR4dH0gIHwgICA5ICstDQo+ICBNQUlOVEFJTkVSUyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0NCj4gIGFyY2gveDg2L0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxOSArKw0KPiAgLi4uL3tpbnRl
bF9yZHRfc2NoZWQuaCA9PiByZXNjdHJsX3NjaGVkLmh9ICAgIHwgIDI4ICstLQ0KPiAgYXJjaC94
ODYva2VybmVsL2NwdS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgICA2ICstDQo+ICAuLi4v
eDg2L2tlcm5lbC9jcHUve2ludGVsX3JkdC5jID0+IHJlc2N0cmwuY30gfCAxNjggKysrKysrKysr
KysrKysrLS0tDQo+ICAuLi4veDg2L2tlcm5lbC9jcHUve2ludGVsX3JkdC5oID0+IHJlc2N0cmwu
aH0gfCAgMzcgKystLQ0KPiAgLi4uZHRfY3RybG1vbmRhdGEuYyA9PiByZXNjdHJsX2N0cmxtb25k
YXRhLmN9IHwgIDgwICsrKysrKysrLQ0KPiAgLi4ue2ludGVsX3JkdF9tb25pdG9yLmMgPT4gcmVz
Y3RybF9tb25pdG9yLmN9IHwgIDIwICstLQ0KPiAgLi4uZHRfcHNldWRvX2xvY2suYyA9PiByZXNj
dHJsX3BzZXVkb19sb2NrLmN9IHwgICA2ICstDQo+ICAuLi5ja19ldmVudC5oID0+IHJlc2N0cmxf
cHNldWRvX2xvY2tfZXZlbnQuaH0gfCAgIDIgKy0NCj4gIC4uLm50ZWxfcmR0X3JkdGdyb3VwLmMg
PT4gcmVzY3RybF9yZHRncm91cC5jfSB8ICAxNCArLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9z
Y2F0dGVyZWQuYyAgICAgICAgICAgICAgIHwgICA3ICstDQo+ICBhcmNoL3g4Ni9rZXJuZWwvcHJv
Y2Vzc18zMi5jICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCj4gIGFyY2gveDg2L2tlcm5lbC9w
cm9jZXNzXzY0LmMgICAgICAgICAgICAgICAgICB8ICAgNCArLQ0KPiAgaW5jbHVkZS9saW51eC9z
Y2hlZC5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ICAxNiBmaWxlcyBjaGFu
Z2VkLCAzMTcgaW5zZXJ0aW9ucygrKSwgOTUgZGVsZXRpb25zKC0pDQo+ICByZW5hbWUgRG9jdW1l
bnRhdGlvbi94ODYve2ludGVsX3JkdF91aS50eHQgPT4gcmVzY3RybF91aS50eHR9ICg5OSUpDQo+
ICByZW5hbWUgYXJjaC94ODYvaW5jbHVkZS9hc20ve2ludGVsX3JkdF9zY2hlZC5oID0+IHJlc2N0
cmxfc2NoZWQuaH0gKDc3JSkNCj4gIHJlbmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9y
ZHQuYyA9PiByZXNjdHJsLmN9ICg4NSUpDQo+ICByZW5hbWUgYXJjaC94ODYva2VybmVsL2NwdS97
aW50ZWxfcmR0LmggPT4gcmVzY3RybC5ofSAoOTQlKQ0KPiAgcmVuYW1lIGFyY2gveDg2L2tlcm5l
bC9jcHUve2ludGVsX3JkdF9jdHJsbW9uZGF0YS5jID0+IHJlc2N0cmxfY3RybG1vbmRhdGEuY30g
KDg2JSkNCj4gIHJlbmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHRfbW9uaXRvci5j
ID0+IHJlc2N0cmxfbW9uaXRvci5jfSAoOTclKQ0KPiAgcmVuYW1lIGFyY2gveDg2L2tlcm5lbC9j
cHUve2ludGVsX3JkdF9wc2V1ZG9fbG9jay5jID0+IHJlc2N0cmxfcHNldWRvX2xvY2suY30gKDk5
JSkNCj4gIHJlbmFtZSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3tpbnRlbF9yZHRfcHNldWRvX2xvY2tf
ZXZlbnQuaCA9PiByZXNjdHJsX3BzZXVkb19sb2NrX2V2ZW50Lmh9ICg5NSUpDQo+ICByZW5hbWUg
YXJjaC94ODYva2VybmVsL2NwdS97aW50ZWxfcmR0X3JkdGdyb3VwLmMgPT4gcmVzY3RybF9yZHRn
cm91cC5jfSAoOTklKQ0KPiANCg0KRG8geW91IGhhdmUgYW55IGNvbmNlcm5zIHdpdGggdGhlc2Ug
cGF0Y2hlcz8gQ2FuIHRoaXMgYmUgaW5jbHVkZWQgaW4gdGhlDQptYWludGFpbmVycyB0cmVlIGFu
ZCBob3BlZnVsbHkgZ2V0IGludG8gNC4yMT8NCg==
