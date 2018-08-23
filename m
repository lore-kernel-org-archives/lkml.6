Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC285C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F3E2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S2sMHwAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F3E2152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeHWVYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:24:17 -0400
Received: from mail-eopbgr720054.outbound.protection.outlook.com ([40.107.72.54]:27995
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbeHWVYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGgz526WvZ+GzJQO4slrd2ZONz/sR5bLuWsyReU54Pc=;
 b=S2sMHwAZk52JrMLhvgNTBQjzbOoujfKo8L6StdHIxVrcXgCPDw/uHA1nuH7GeU8otDL3EvTrqlInxy83VtUwRLPQVX0N0LueiJ3ykaOBihnPnBml/bIqtPjXMk97MooiwO1hXScVCSFU8596F6hNAkOzidZIfpzFQKctq78IHCY=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2609.namprd12.prod.outlook.com (20.176.176.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Thu, 23 Aug 2018 17:53:25 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::60a7:5c31:8fd7:825d]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::60a7:5c31:8fd7:825d%4]) with mapi id 15.20.1059.023; Thu, 23 Aug 2018
 17:53:25 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if valid
 bits are not set"
Thread-Topic: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if
 valid bits are not set"
Thread-Index: AQHTxTbYl0Ocyw67K0ebLpEvWOkqDaPi53kAgAAAvNCAAAmPAIABK29QgAAfYjCA6fFgAIAAW83g
Date:   Thu, 23 Aug 2018 17:53:25 +0000
Message-ID: <BN7PR12MB25934DE6FCB596E0D9B8066CF8370@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326193052.GJ25548@pd.tnic>
 <DM5PR12MB191603A2AACAE6F7F923C6F3F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180326200742.GF28372@pd.tnic>
 <DM5PR12MB191601AF532C84190049AD04F8AC0@DM5PR12MB1916.namprd12.prod.outlook.com>
 <DM5PR12MB19162C0D9FF144D311ADC22FF8AC0@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180823122410.GA17393@nazgul.tnic>
In-Reply-To: <20180823122410.GA17393@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2609;20:8+53DFNrQgYWmIRcShY7pozkrZZ/ZOrwrKrZ7VvrBjwLHhp54Dm2r5Mg/CmhlmzMGuEnT0k7S7maVg+7bRw8IEYdDz/TpOaZtZya5nFLeJn7jgmAM9Z9oQqr+lP6Tvd5hbyirLc/fKyoxhr5MZTlykjrxWbm1iPTNKXzU9wKWKuWvDFEK50nOOnpp6XeXNMMRF8yXp3Fpop8+8KSmy9SbNPDIEoGSTyvZVIH6mvtNYMHXX1BScahCxnVhfEvyJbe
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1a06e40b-2914-40a7-24c3-08d609215336
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2609;
x-ms-traffictypediagnostic: BN7PR12MB2609:
x-microsoft-antispam-prvs: <BN7PR12MB2609D3B6380618A463D14157F8370@BN7PR12MB2609.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BN7PR12MB2609;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2609;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(13464003)(6436002)(476003)(5660300001)(2906002)(229853002)(6916009)(25786009)(106356001)(105586002)(186003)(7736002)(5250100002)(2900100001)(9686003)(53936002)(55016002)(6506007)(11346002)(86362001)(97736004)(53546011)(446003)(8676002)(102836004)(486006)(305945005)(14444005)(72206003)(6246003)(14454004)(93886005)(74316002)(81156014)(256004)(81166006)(54906003)(8936002)(316002)(99286004)(7696005)(46003)(76176011)(68736007)(4326008)(33656002)(478600001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2609;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GYbrgf2kYOhWtdKUn356TitsWBll/vXjSGQwQ9CIVilTOeNz9zT/Gst66HkVlmrvKYETZqF+a2lyxqRI+L/Ydk4OhFY+SoEfo//m53rlpLo2QVerCLCEmwnHhofwil3c5QUTkMvzzadv3q52JhSfKpcxcrs1OnodY2nbw5KXwF1aV3Gj+c+/Jvli10tn3iYrVOp9+73dqKpbl0VJe2P+EahxKmy5vAO95uhzlztxHcXsaL/qSi5/jnv9o68eQ56HlBMPkN3TpwcRF3E3GU+WsaMX3717K/HFl5xZY7uPARWKrN/oVSYd956xaeFUicwqzpRl6jkgn4vqWegDzndGFY8agBaqXYLWE0F6LfWEpns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a06e40b-2914-40a7-24c3-08d609215336
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 17:53:25.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJl
aGFsZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMywgMjAx
OCA3OjI0IEFNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0K
PiBDYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IHRvbnkubHVja0BpbnRlbC5jb207IHg4NkBrZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8yXSBSZXZlcnQgIng4Ni9tY2UvQU1EOiBDb2xsZWN0IGVycm9yIGluZm8g
ZXZlbiBpZiB2YWxpZA0KPiBiaXRzIGFyZSBub3Qgc2V0Ig0KPiANCj4gUmV2aXZpbmcgYW4gb2xk
IGlzc3VlIHdoaWxlIGNsZWFuaW5nIG15IGluYm94Lg0KPiANCj4gT24gVHVlLCBNYXIgMjcsIDIw
MTggYXQgMDM6NTk6MzdQTSArMDAwMCwgR2hhbm5hbSwgWWF6ZW4gd3JvdGU6DQo+ID4gPiA+IE9u
IE1vbiwgTWFyIDI2LCAyMDE4IGF0IDA3OjU4OjUxUE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdy
b3RlOg0KPiA+ID4gPiA+IFNvIGF0IGEgbWluaW11bSwgd2Ugc2hvdWxkIGFsd2F5cyBzYXZlIGFu
ZCByZXBvcnQgYXMgbXVjaCBhcyB3ZSBjYW4uDQo+ID4gPiA+DQo+ID4gPiA+IE9ubHkgb24gWmVu
IG9yIGFsbCBBTUQgZmFtaWxpZXM/DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSSdsbCBjb25maXJt
IHdpdGggdGhlIEhXIGZvbGtzLiBJIHVuZGVyc3RhbmQgaXQgYXMgYSBjaGFuZ2UgaW4gcGhpbG9z
b3BoeQ0KPiA+ID4gcmF0aGVyIHRoYW4gYSBjaGFuZ2UgaW4gaGFyZHdhcmUuDQo+ID4gPg0KPiA+
DQo+ID4gU28gdGhpcyByZWNvbW1lbmRhdGlvbiBjb3VsZCBhcHBseSB0byBhbGwgZmFtaWxpZXMs
IGJ1dCBpdCdzIG9rYXkgaWYgd2UganVzdA0KPiANCj4gT2ssIHNvIEkgdGhpbmsgd2Ugc2hvdWxk
IGRvIHRoaXMsIHN0aWxsLCBhcyBpdCBpcyBleGFjdGx5IHdoYXQgdGhlDQo+IHJlY29tbWVuZGF0
aW9uIHNheXM6IHJlYWQgdGhlIE1TUnMgZXZlbiBpZiB0aGUgdmFsaWQgYml0cyBhcmUgbm90IHNl
dCBhbmQgaXQNCj4gZG9lc24ndCBzZXQgYW55IFZhbGlkIGJpdHMgdG8gY29uZnVzZSBlcnJvciBo
YW5kbGluZyBkb3duc3RyZWFtLg0KPiANCj4gVGhpcyB3YXkgd2UnbGwgY29sbGVjdCBhbGwgcG9z
c2libGUgaW5mbyBhbmQgdGhlbiBtY2VfYW1kLmMgc2hvdWxkIHN0b3AgbG9va2luZw0KPiBhdCB0
aGUgdmFsaWQgYml0cyB0b28gYW5kIGR1bXAgd2hhdGV2ZXIgaGFzIGJlZW4gbG9nZ2VkLg0KPiAN
Cj4gT2s/DQo+IA0KDQpZZXMsIHRoaXMgc2VlbXMgb2theSB0byBtZS4NCg0KVGhhbmtzLA0KWWF6
ZW4NCg==
